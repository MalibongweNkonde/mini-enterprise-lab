#!/bin/bash

echo "automating temp brdige and vlan creation"

echo "temp bridge:"
sudo ip link add br-vlan type bridge
sudo ip link set dev br-vlan up

echo "enable vlan filtering:"
sudo ip link set dev br-vlan type bridge vlan_filtering 1
vlan=$(sudo /usr/sbin/bridge vlan show | grep br-vlan)
echo "$vlan"


#attach temp vlan trunk to pfsense
cat > /tmp/pfsense-trunk.xml <<'EOF'
<interface type='bridge'>
  <mac address='52:54:00:10:00:01'/>
  <source bridge='br-vlan'/>
  <model type='virtio'/>
  <vlan trunk='yes'>
    <tag id='10'/>
    <tag id='20'/>
    <tag id='30'/>
    <tag id='40'/>
    <tag id='50'/>
  </vlan>
</interface>
EOF
#check it pfsense is running
sudo virsh list --all | grep fw-pfsense
# attach trunk to pfsense
sudo virsh attach-device fw-pfsense /tmp/pfsense-trunk.xml --live
