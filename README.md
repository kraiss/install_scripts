# Quick local setup

* Install [Homebrew](https://docs.brew.sh/Installation)
* Install Ansible and execute playbook

```sh
brew install ansible
ansible-galaxy collection install community.general
ansible-playbook playbook.yaml -K
```
