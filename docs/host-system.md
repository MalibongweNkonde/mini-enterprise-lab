# Host System Documentation

## Objective

Documenting changes and things that are done on the host system for the lab to work properly 

### Configuration backups

For now I am using 10.0.0.10 on the mgnt-box for setting up pfSense and I cannot enable VLAN filtering just yet and an icorrect configuration could lock me out of pfSense.

I'm creating xml backups of pfwan, pflan, fw-pfsense and mgnt-box configurations on my host mahine.

![pfwan XML backup](/home/bonga/Documents/labs/mini-enterprise-lab/screenshots/host-system/Screenshot%20From%202026-10-23%2015-28-02.png)

The same backup was performed for the rest of the listed items..

Commands: 

    

```
mkdir labs-backups

sudo virsh net-dumpxml pfwan > labs-backups/pfwan.xml

sudo virsh net-dumpxml pflan > labs-backups/pflan.xml

sudo virsh dumpxml fw-pfsense > labs-backups/fw-pfsense.xml

sudo virsh dumpxml debian12 > labs-backups/debian12.xml
```
