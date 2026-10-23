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
    IP Address: Unassigned
    DHCP range: Unassigned

# Installation Process

## Step 1 - Create Virtual Machine

ISO:

    Link for exact pfsense version found here: [pfsense](htts://archive.org/details/pfsense-ce-2.7.2-release-amd64_202507)

![ISO selection](../screenshots/pfsense/Screenshot%20From%202026-10-21%2019-58-44.png)

RAM and vCPU allocation:

![RAM and CPU](../screenshots/pfsense/Screenshot%20From%202026-10-21%2020-02-31.png)
Network Adapters:

![Network Adpaters](../screenshots/pfsense/Screenshot%20From%202026-10-21%2019-57-07.png)

## Step 2 - Installation of pfSense

Installation steps:

1. Boot rfom pfsense ISO after adding both virtual networks from the "Add Harware" menu option. 

2. Accept license agreements and select install option.

3. Choose file system.

4. Reboot after installation

### Step 3 - Interface Assignment after installation.

It recognised both interfaces:

![interfaces recognised](../screenshots/pfsense/Screenshot%20From%202026-10-21%2020-06-24.png)

I then assigned the interfaces as follows:

    WAN: vtnet0 (pfwan)
    LAN: vtnet1 (pflan)

![assigning interfaces](../screenshots/pfsense/Screenshot%20From%202026-10-21%2020-08-32.png)

Both networks netorwks were assigned IPs as follows:

    vtnet0: 192.168.100.240/24 (virtual WAN network)
    vtnet1: 192.168.1.1/24 (Static IP)

![Default IP assignment](../screenshots/pfsense/Screenshot%20From%202026-10-21%2020-09-36.png)

I changed the IP adrress of the vtnet1 to a more cleaner nd easier to read one:

    vtnet1: 192.168.1.1/24 to 10.0.0.1/24
    DHCP range: 10.0.0.10 - 10.0.0.50

![IP change](../screenshots/pfsense/Screenshot%20From%202026-10-21%2020-20-28.png)

# Firewall Configuration

## Default Rules

| Interface | Rule                      | Purpose                     |
| --------- | ------------------------- | --------------------------- |
| LAN       | Allow LAN to Any          | VMs can access the internet |
| WAN       | Block unsolicited traffic | Protect internal network    |

(insert Screenshot)

# DHCP Configuration

    Range: 10.0.0.10 - 10.0.0.50
    Gateway: 10.0.0.1
    DNS: 10.0.0.1

(Inset Screenshot)

# VLAN Configuration

## Interfaces

| Interface | VLAN | Gateway |
| --------- | ---- | ------- |
| LAN       |      |         |
|           |      |         |
|           |      |         |
|           |      |         |
|           |      |         |
|           |      |         |
|           |      |         |

![Interface Assignment]()

# Testing

## Connectivity Tests

Conduncting tests to confirm if pfsense can allocate IPs dynamically and if devices connected behind pfsense can access the internet.

### pfSense Internet Test

Testing Diagnostics &rarr; Ping

    Target: 8.8.8.8

![Ping Successful](/home/bonga/Documents/labs/mini-enterprise-lab/screenshots/pfsense/Screenshot%20From%202026-10-23%2015-05-19.png)

### LAN Device Test

From mgnt-box: 

    Can reach router
    ping: 10.0.0.1
    
    Internet Test
    ping: google.com

![Successful DNS resolution](/home/bonga/Documents/labs/mini-enterprise-lab/screenshots/management/Screenshot%20From%202026-10-23%2015-01-13.png)

# Challenges Encountered

## Issue 1

#### Symptom:

- iproute2 is installed on host but running command "bridge vlan show" says result not found.

#### Cause:

Running the commands shows us that 'bridge' is on the system. It just isn't on the my user's PATH.

    command -v ip
    command -v bridge
    dpkg -L iproute2 | grep '/bridge$'
    ls -l /usr/sbin/bridge /sbin/bridge 2>/dev/null

#### Resolution:

Running this command produces the desired result listing on bridges

    sudo /usr/sbin/bridge vlan show


