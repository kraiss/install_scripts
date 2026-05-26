# Fedora @ Kelkoo Group

```sh
git clone git@github.com:kraiss/install_scripts.git kraiss
sudo dnf install ansible -y
ansible-playbook setup.yaml -K

# At Kelkoo
source .kelkoorc; switch_mvn 3.9.4
```

## Still manually for now

### Generate ssh key

```sh
ssh-keygen -t ed25519 -C "pierrick.rassat"
```

### Generate gpg key

```sh
gpg --full-generate-key
gpg --list-secret-keys --keyid-format=long
gpg --armor --export <key>
```

### Make zsh the default shell

```sh
chsh -s $(which zsh)
```

### Resize LV - for dist upgrades mostly

```sh
# you can use "sudo parted" with "print free" to check free disk
lvdisplay
lvextend -L +2G /dev/Volume00/tmp
resize2fs /dev/Volume00/tmp
```

### Claude onboarding

#### MCP

```sh
# SourceBot - Generate key then mcp add
firefox https://sourcebot.kelkoo.net/~/settings/apiKeys
claude mcp add --transport http kelkoo_sourcebot --scope user https://sourcebot.kelkoo.net/api/mcp --header "Authorization: Bearer API_SECRET_KEY"

# Atlassian

claude mcp add --scope user --transport sse atlassian https://mcp.atlassian.com/v1/sse
```
