# Troubleshooting

## mgnt-box not receiving IP from pfSense

I attached a second network adapter (a live adapter) to test if VLAN 10 DHCP and routing work without risking my access to pfSense through pflan (10.0.0.1)

### Symptom:

    mgnt-box not receiving IP from pfSense    

![mgnt not receiving IP](../screenshots/host-system/Screenshot%20From%202026-10-28%2017-57-04.png)

- Manually assigning an address did not resolve the issue.

- Logs shoed that 'enp7s0' was repeatedly attempting DHCP but receiving no usable IPv4 lease.

- Capturing traffic with tcpdump on the host machine, listening on vtnet4 and requesting DHCP on mgnt-box. Requests are going out but no replies appear on the listening machine.

### Cause:

Network not set up correctly and firewall rules.

### Resolution:

I removed all IPs attached to  enp7s0:

    sudo ip addr flush dev enp7s0

Configured interface to receive temporary IP from DHCP:

     sudo dhclient enp7s0

I then receive an IP '10.0.10.100/24' which is in the range that was set up in pfSense.

I then created a firewall rule for MGNT_VLAN10:

    Action: Pass
    Interace: MGNT_VLAN10
    Address Family: IPv4
    Protocol: ICMP
    ICMP Subtypes: Any
    Source: Any
    Destination: Any

![pfSense reachable](/home/bonga/Documents/labs/mini-enterprise-lab/screenshots/host-system/Screenshot%20From%202026-10-28%2021-45-18.png)


