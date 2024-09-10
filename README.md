# Fedora

```sh
git clone git@github.com:kraiss/install_scripts.git kraiss
sudo dnf install ansible -y
ansible-playbook fedora-playbook.yaml -K
```

# MAC OS

* Install [Homebrew](https://docs.brew.sh/Installation)
* Install Ansible and execute playbook

```sh
brew install ansible
ansible-galaxy collection install community.general
ansible-playbook macos-playbook.yaml -K
```

# TODO manually for now

```sh
ssh-keygen -t ed25519 -C "pierrick.rassat"
gpg --full-generate-key
gpg --list-secret-keys --keyid-format=long
gpg --armor --export <key>
```