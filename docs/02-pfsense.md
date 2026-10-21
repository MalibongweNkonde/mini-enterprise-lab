# pfSense Firewall & Network Segmentation Configuration

## Objective

To act as the core edge router and firewall for the infrastructure, enforcing strict network boundaries between zones.

## Ojectives

* 

## Depolyment Details

| Compoment     | Details           |
| ------------- | ----------------- |
| Platform      | Virtual Machine   |
| Host Hardware | Desktop  Computer |
| Hypervisor    | KVM/QEMU          |
| version       | CE 2.7.2          |
| WAN Interface | pfwan (NAT)       |
| LAN Interface | pflan (isolated)  |

# Virtual Machine Configuration

## Hardware Allocation

| Resource         | Allocation |
| ---------------- | ---------- |
| vCPU             | 1          |
| RAM              | 1GB        |
| Storage          | 20GB       |
| Network Adapters | 2          |

### WAN Interface

Configuration:

    Interface: pfwan
    Network: NAT
    IP Address: DHCP

### LAN Interface

Configuration:

    Interface: pflan
    Network: Isolated
    IP Address: 10.0.0.1
    DHCP range: 10.0.0.10 - 10.0.0.50

# Installation Process

## Step 1 - Create Virtual Machine

ISO:

    Link for exact pfsense version found here: [pfsense](htts://archive.org/details/pfsense-ce-2.7.2-release-amd64_202507)

![ISO selection](/home/bonga/Documents/labs/mini-enterprise-lab/screenshots/pfsense/Screenshot%20From%202026-10-21%2019-58-44.png)

RAM and vCPU allocation:

![RAM and CPU](/home/bonga/Documents/labs/mini-enterprise-lab/screenshots/pfsense/Screenshot%20From%202026-10-21%2020-02-31.png)
Network Adapters:

![Network Adpaters](/home/bonga/Documents/labs/mini-enterprise-lab/screenshots/pfsense/Screenshot%20From%202026-10-21%2019-57-07.png)

## Step 2 - Installation of pfSense


