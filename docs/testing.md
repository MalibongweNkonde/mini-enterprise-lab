# Testing

## Objective

I will document temporary changes, testing new features before implimenting them and documenting them officially 

## VLAN Trunk Implementation

### Objective

Build and verify 802.1Q VLAN trunk between pfsense and the Debian 13 host while preserving the existing management connection.

#### Planned VLANs

| VLAN | Name       | Subnet       | pfSense Gateway |
| ---- | ---------- | ------------ | --------------- |
| 10   | Management | 10.0.10.0/24 | 10.0.10.1       |
| 20   | DevOps     | 10.0.20.0/24 | 10.0.20.1       |
| 30   | Servers    | 10.0.30.0/24 | 10.0.30.1       |
| 40   | DMZ        | 10.0.40.0/24 | 10.0.40.1       |
| 50   | Testing    | 10.0.50.0/24 | 10.0.50.1       |

#### Environment

Host: Debian 13

Virtualisation: KVM/QEMU with libvirt

libvirt version: 11.3.0

Linux Bridge Utility: 6.15.0

Firewall: pfSenes

Management VM: mgnt-box

#### Existing Network - Recovery Path

| Componet             | Connection     | Purpose                        |
| -------------------- | -------------- | ------------------------------ |
| pfSense WAN          | pfwan / virbr1 | WAN connectivity               |
| pfSense existing LAN | pflan / virbr2 | Existing LAN and recovery path |
| mgnt-box NIC         | pflan / virbr2 | Current management access      |

Exisiting bootstrap LAN: 10.0.0.0/24

Existing pfSense LAN address: 10.0.0.1

The existing connection must remain available until the VLAN 10 management path is tested successfully.

#### Temporary Trunk Setup

A temp Linux bridge named br-vlan was created on the Debian host. See [host-system](./docs/host-system.md) for a more detailed explaination and documentation.

#### Configuring Management first. On the web interface:

Interfaces &rarr; Assignments &rarr; VLANs and add a VLAN

    Parent Interface: vtnet2
    VLAN Tag: 10  
    Description: MGNT_VLAN10

#### Assign VLAN 10 as a pfsense interface:

Go to Interfaces &rarr; Assignments &rarr; Available network ports and select the newly created interface.

Click on the newly assigned interface and configure it as follows:

    Enable: Checked
    Description: MGNT_VLAN10
    IPv4 Configuration: Static
    IPv4 Address: 10.0.10.1/24

#### Enable DHCP for Management:

Go to Services &rarr; DHCP Server and open the MGNT_VLAN10 tab.

Enable DHCP and set the range to:

    Range: 10.0.0.10 - 10.0.0.50
    Gateway: 10.0.0.1
    DNS: 10.0.0.1



#### Verified Results

- [x] br-vlan created and brought up

- [x] VLAN filtering enabled

- [x] Default PVID set to 0

- [x] Temporary pfSense NIC attached to br-lan

- [x] pfSense idenitied the new NIC as vtnet2

- [x] Linux bridge displayed VLAN membership for VLANs 10, 20, 30, 40 and 50 on the new virtual NIC.

- [x] Existing WAN and LAN connections remain present during these steps.

#### Not Yet Verified

- [ ] VLAN 10 interfae configured in pfSense.

- [ ] VLAN 10 gateway configured as 10.0.10.1/24

- [ ] DHCP on VLAN 10 tested.

- [ ] Management VM obtains a VLAN 10 address.

- [ ] Manangement Vm can reach 10.0.10.1.

- [ ] pfSense web interface accessible over VLAN 10.

- [ ] VLAN 20, 30, 40, and 50 tested.

- [ ] Recovery procedure tested.

#### Change and Recovery  notes

The original pflan network and existing pfSense LAn interfaces are being  retained as a recovery path.

The new trunk NIC and br-lan were created for testing. They shall not be treated as persistent unitl their configuration has been  saved and verified.

Before removing or changing the existng LAN connectino, veirdy that management acess works VLAN 10 and that pfSense configuration backups are available.
