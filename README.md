# ansible-upgrade
*Easily upgrade LXC containers with Ansible*

## Structure
```shell
.
├── ansible.cfg       # Ansible configuration
├── collect-hosts.sh  # BASH script that creates a JSON with all running LXC containers
├── group_vars
│   └── lxc.yaml      # Common settings applied to all containers
├── README.md         # This file
└── upgrade-lxc.yaml  # Ansible playbook to update packages and reboot the container
                      # if the kernel is upgraded
```

## Requirements
- Ansible 2.14+  
- Python 3.8+ on control node  
- SSH access to all LXC containers

## Usage

```shell
# Upgrade all machines
ansible-playbook upgrade-lxc.yaml

# Upgrade a specific container 
ansible-playbook upgrade-lxc.yaml --limit 10.0.0.10  
```

## Example output
```
PLAY [Upgrade all LXC containers] ***********************************************************

TASK [Gathering Facts] **********************************************************************
ok: [10.0.0.10]

TASK [Update package cache] *****************************************************************
ok: [10.0.0.10]

TASK [Upgrade all packages] *****************************************************************
ok: [10.0.0.10]

TASK [Reboot container if kernel updated] ***************************************************
skipping: [10.0.0.10]

PLAY RECAP **********************************************************************************
10.0.0.10                : ok=3    changed=0    unreachable=0    failed=0    skipped=1

```

## Future improvements
-	[ ] Add support for dry-run mode (`--check`)  
- [ ] Add notifications on playbook completion  
- [ ] Add rollback option in case of failed upgrades  
