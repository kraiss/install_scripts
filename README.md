# Fedora @ Kelkoo Group

```sh
git clone git@github.com:kraiss/install_scripts.git kraiss
sudo dnf install ansible -y
ansible-playbook setup.yaml -K
# At Kelkoo
source .kelkoorc; switch_mvn 3.9.4
```

## Still manually for now

```sh
# Generate ssh
ssh-keygen -t ed25519 -C "pierrick.rassat"

# Generate gpg
gpg --full-generate-key
gpg --list-secret-keys --keyid-format=long
gpg --armor --export <key>

# Make zsh default shell
chsh -s $(which zsh)
```
