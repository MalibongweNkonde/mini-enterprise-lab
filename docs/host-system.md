# Host System Documentation

## Objective

Documenting changes and things that are done on the host system for the lab to work properly 

### Configuration backups

For now I am using 10.0.0.10 on the mgnt-box for setting up pfSense and I cannot enable VLAN filtering just yet and an icorrect configuration could lock me out of pfSense.

I'm creating xml backups of pfwan, pflan, fw-pfsense and mgnt-box configurations on my host mahine.

![pfwan XML backup](../screenshots/host-system/Screenshot%20From%202026-10-23%2015-28-02.png)

The same backup was performed for the rest of the listed items..

Commands: 

```
mkdir labs-backups

sudo virsh net-dumpxml pfwan > labs-backups/pfwan.xml

sudo virsh net-dumpxml pflan > labs-backups/pflan.xml

sudo virsh dumpxml fw-pfsense > labs-backups/fw-pfsense.xml

sudo virsh dumpxml debian12 > labs-backups/debian12.xml
```

## VLAN Setup.

We create a temp bridge that for now will not survive a reboot, for testing purposes.

Commands:

    sudo ip link add br-vlan type bridge
    sudo ip link set dev br-vlan up
    ip -d link show br-vlan

![br-vlan](../screenshots/host-system/Screenshot%20From%202026-10-23%2015-53-58.png)

The bridge now exists. We then enable VLAN filtering:

Commands:

    sudo ip link set dev br-vlan type bridge vlan_filtering 1
    sudo /usr/sbin/bridge vlan show

![br-vlan appears untagged](../screenshots/host-system/Screenshot%20From%202026-10-23%2015-57-55.png)

The bridge is now configured correctly with 802.1Q VLAN filtering enabled.

## Attach a temporary VLAN trunk to pfSense

### Create the interface definition.

Command:

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

This  defines a trunk that carries 5 VLANs as outlined on the topology document, in the VLAN design section.

### Attach it to the running VM

Command:

    sudo virsh attach-device fw-pfsense /tmp/pfsense-trunk.xml --live

![Device Attached successfully](../screenshots/host-system/Screenshot%20From%202026-10-23%2016-26-44.png)

The live bridge appears to be attached.

### Identifying NIC in pfSense

Command:

    ifconfig -a

Run this command inside the pfsense web interface through:

Diagnostics &rarr; Command Prompt.

![Inside pfSense](../screenshots/host-system/Screenshot%20From%202026-10-23%2016-40-04.png)

We see vtnet2 show up with the MAC address 52:54:00:10:00:01, the same address from our other screenshots.
