# Global Topology,Resource Allocations and Network Design

## Overview

This document outlines the architectural blueprint, physical/virtal hardware boundaries, and global network schema for the entire lab environment. It establishes the foundational baseline required to ensure performance optimization and predictable routing behaviours before any induvidual operating system is deployed.

## Objectives

* Isolate the Linux servers from the physical host's physical network.

* Centralize routing and firewall control through pfSense

* Separate adminstrative access from server workloads.

* Restrict traffic betwen network segments.

* Provide a reproducible environment for learning linux adminstration,

## Logical Architecture

Below is the structural breakdown of the environment's network zones.

(Insert Diagram Here)

# Hypervisor Configuration & Hardware Specs

The environment is hosted on QEMU/KVM managed via virt-manager running on top of Debain 13. 

### Host Hardware Baseline

* **CPU:** Intel i7-4790 (4 Core, 8 Threads)

* **RAM:**  16GB DDR3

* **Storage:** 1 TB SATA SSD

* **Network:** Wried connection from Cudy WR1200 router receiving internet from a huawei pocket router.

### Resource Allocation Matrix

| VM ID | Machine Name   | OS             | vCPUs | RAM | Storage | Primary Network Bridge   | Purpose                            |
| ----- | -------------- | -------------- | ----- | --- | ------- | ------------------------ | ---------------------------------- |
| 100   | fw-pfsense     | pfSense 2.7.2  | 1     | 1GB | 20GB    | pfwan (WAN), pflan (LAN) | Firewall and router                |
| 101   | mgnt-box       | Debian 13      | 1     | 2GB | 20GB    | pflan                    | Administration and troubleshooting |
| 102   | devops-box     | Debian 13      | 2     | 4GB | 40GB    | pflan                    | Orchestration and deployment       |
| 103   | alma-server-01 | AlmaLinux 10.2 | 1     | 2GB | 40GB    | pflan                    | Enterprise Linux Adminstration     |
| 104   | app-node-01    | Debian 13      | 1     | 2GB | 40GB    | pflan                    | Applications                       |

# Network Design

## VLAN Design

| VLAN     | Name          | Subnet       | Gateway   | Purpose                                                         |
| -------- | ------------- | ------------ | --------- | --------------------------------------------------------------- |
| untagged | Bootstrap LAN | 10.0.0.0/24  | 10.0.0.1  | Initial setup and migration                                     |
| 10       | Management    | 10.0.10.0/24 | 10.0.10.1 | Administration                                                  |
| 20       | DevOps        | 10.0.20.0/24 | 10.0.20.1 | Automation CI/CD and development operations                     |
| 30       | Servers       | 10.0.30.0/24 | 10.0.30.1 | Debian, RHEL* and Alma server workloads                         |
| 40       | DMZ           | 10.0.40.0/24 | 10.0.40.1 | Public facing services needing more restricted network boundary |
| 50       | Testing       | 10.0.50.0/24 | 10.0.50.1 | Isolated testing and experimenting                              |

## Static IP Address assignment

| Device                        | VLAN      | IP Address |
| ----------------------------- | --------- | ---------- |
| fw-pfsense                    | Bootstrap | 10.0.0.1   |
|                               |           |            |
| mgnt-box                      | 10        | 10.0.10.10 |
| -- pfsense management gateway | 10        | 10.0.10.1  |
| devops-box                    | 20        | 10.0.20.10 |
| --pfsense devops gateway      | 20        | 10.0.20.1  |
| alma-server-01                | 30        | 10.0.30.10 |
| -- pfsense server gateway     | 30        | 10.0.30.1  |

## Security Controls

- Isolaed lab networks.

- Segmented management and server traffic.

- Restricted inter-VLAN communication.

- SSH-based remote administration

- Host-level firewall configuration.

- Verfiication of allowed and denied traffic.
