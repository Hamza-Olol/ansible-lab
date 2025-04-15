### Ansible lab

# pre req
using terraform to deploy a remote vm

# workflow (WIP)
create a virtual env to store installed modules

```python3 -m venv ansible ```

source ansible_venv/bin/activate
deactivate

used homebrew to install pipx on mac
brew install pipx

pipx install ansible


do this again in docker container to mimick linux env

create an ini file which will act as an inventory of your managed nodes
touch inventory.ini

Verify your inventory.
ansible-inventory -i inventory.ini --list

Ping the myhosts group in your inventory.
ansible myhosts -m ping -i inventory.ini --private-key <pem key> -u <username>

add `behavioral inventory parameters` to the inventory ini
<host_ip> ansible_user=<host_username> ansible_ssh_private_key_file=<path_to_private_key_file>
then run:
ansible myhosts -m ping -i inventory.ini

create a playbook yaml file to define what to do with your inventory (hosts) in the .ini file (inventory files can also be in yaml)
touch playbook.yaml

check playbook with the inventory file applying the script
ansible-playbook --check playbook.yaml -i inventory.ini

run playbook
ansible-playbook playbook.yaml -i inventory.ini