# Ansible-PVE-Win11-Playbook
Playbook for autounattend Win11 install on Proxmox V9. This will be a complete template to build Windows Server Templates on Proxmox, deploy them and then configure them using the premise of infrastructure as code (IaC).

Its an addapted version from Clay Shekleton's Ansible Windows https://github.com/clayshek/ans-pve-win-templ  to work with Windows 11 and unattend-generator from Schneegans https://github.com/cschneegans/unattend-generator


## Summary

Ansible playbook to create Windows templates for Proxmox (PVE) based lab environment (somewhat customized for mine, but easy enough to tweak), prepped for further Ansible automation. Tested with Proxmox v9.0.11 & Ansible 2.15.13.

### Goals:
- Create a base Windows 11 template image for [Proxmox VE](https://www.proxmox.com/en/proxmox-ve)
- Start with only a base ISO from Microsoft (no other components like MDT necessary)
- Apply necessary [VirtIO drivers](https://docs.fedoraproject.org/en-US/quick-docs/creating-windows-virtual-machines-using-virtio-drivers/index.html#virtio-win-direct-downloads) (to run on Proxmox/KVM) during Windows Setup
- Pre-configure Windows image for Ansible to allow for further downstream configuration
- Allow for minor customization to image via variables passed to either AutoUnattend.xml file, or to qemu provisioner (ex: name, resource specs, admin password, time zone, Windows image version, etc)
- Sysprep and templatize the image

## Usage

- Modify variables in vars.yml as appropriate
- Populate proxmox hosts in inventory.yml with the PVE hosts on which to create a template VM. If using shared storage, this only needs to be one host. 
- For secure vars (passwords) in both inventory.yml & vars.yml, as alternative to clear text, use Ansible Vault or pass variables on command line to ansible-playbook.

`ansible-playbook -i inventory.yml --ask-vault-pass playbook.yml`

## Requirements

- Windows 11 ISO available to Proxmox node(s). Update 'os_iso_location' in vars.yml to reflect the location of the PVE storage and ISO file name.
- Additional VirtIO drivers added (/drivers/virtio folder) if necessary. Repo includes VirtIO SCSI, NIC (NetKVM), Balloon drivers and qemu guest agent.
- Genisoimage installed on Proxmox host (present by default)
