# Global Topology, Network Design and Resource Allocations

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

## Hypervisor Configuration & Hardware Specs

The environment is hosted on QEMU/KVM managed via virt-manager running on top of Debain 13. 

### Host Hardware Baseline

* **CPU:** Intel i7-4790 (4 Core, 8 Threads)

* **RAM:**  16GB DDR3

* **Storage:** 1 TB SATA SSD

* **Network:** Wried connection from Cudy WR1200 router receiving internet from a huawei pocket router.

### Resource Allocation Matrix

| VM ID | Machine Name | OS               | vCPUs | RAM | Storage | Primary Network Bridge   | Purpose                            |
| ----- | ------------ | ---------------- | ----- | --- | ------- | ------------------------ | ---------------------------------- |
| 100   | fw-pfsense   | pfSense 2.7.1    | 1     | 1GB | 20GB    | pfwan (WAN), pflan (LAN) | Firewall and router                |
| 101   | mgmt-box     | Debian 13        | 1     | 2GB | 20GB    | pflan                    | Administration and troubleshooting |
| 102   | devopsVM     | Debian 13        | 2     | 4GB | 40GB    | pflan                    | Orchestration and deployment       |
| 103   | alma-server  | Alma Server 10.2 | 1     | 2GB | 40GB    | pflan                    | Enterprise Linux Adminstration     |
| 104   | app-node-01  | Debian 13s       | 1     | 2GB | 40GB    | pflan                    | Applications                       |

## VLAN Design



## IP Addressing


