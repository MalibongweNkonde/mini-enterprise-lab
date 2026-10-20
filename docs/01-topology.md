# Global Topology & Resource Allocations

## Objective

This document outlines the architectural blueprint, physical/virtal hardware boundaries, and global network schema for the entire lab environment. It establishes the foundational baseline required to ensure performance optimization and predictable routing behaviours before any induvidual operating system is deployed.

## Logical Architecture

Below is the structural breakdown of the environment's network zones.

(Insert Diagram Here)

## Hypervisor Configuration & Hardware Specs

The environment is hosted on QEMU/KVM managed via virt-manager running on top of Debain 13. 

### Host Hardware Baseline

* **CPU:** Intel i7-4790 (4 Core, 8 Threads)

* **RAM:**  16GB DDR3

* **Storage:** 1 TB SATA SSD

### Resource Allocation Matrix

| VM ID | Machine Name | OS            | vCPUs | RAM   | Storage | Primary Network Bridge     |
| ----- | ------------ | ------------- | ----- | ----- | ------- | -------------------------- |
| 100   | fw-pfsense   | pfSense 2.7.1 | 1     | 1.5GB | 20GB    | vtnet0 (WAN), vtnet1 (LAN) |
| 101   | mgmt-box     | Debian        | 1     | 2GB   | 100GB   |                            |
| 102   | devopsVM     | Debian        | 2     | 4GB   | 40GB    |                            |
| 103   | app-node-01  | Debian        | 1     | 2GB   | 40GB    |                            |
| 104   | app-node-02  | Debian        | 1     | 2GB   | 40GB    |                            |

## Global IP & Subnet Schema

## Network Virtual Bridges (VLANs / Virtual Switches)

* **default (WAN):** Pulls an IP via DHCP from the physical home router. 

* **pflan (LAN):**

## Global Infrastructure Prerequisites

Before proceeding with individual operating system deployment, ensure the following prerequisites are met:

1. Virtal Swtiches  ('default', 'pflan') must be created on the hyperviser host with no physical network cards assigned to them. This guarantees full host-only isolation.

2. MAC Addres spaing must be randomised across all hosts to prevent potential ARP conflicts.
