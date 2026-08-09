# Arch VM Installation

## Clean Slate

From the `lab` host:

```sh
# Stop the service from `lab` host and delete the old image
sudo systemctl stop arch-vm.service
rm -f ~/virtual/arch/arch.qcow2

# Download clean slate one
./fetch-image.sh

# Restart the VM service
sudo systemctl restart arch-vm.service
```

```sh
# Password SSH into a running VM
ssh -p 2222 arch@127.0.0.1

# And set up key-only access
mkdir -p ~/.ssh && chmod 700 ~/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINngwDtUZAiEALEZ1XhPXX221hYqjGSaqWRnvaUnpMXT lewelove@proton.me" > ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

sudo passwd -l arch
sudo passwd -l root

sudo mkdir -p /etc/ssh/sshd_config.d
echo -e "PasswordAuthentication no\nKbdInteractiveAuthentication no\nPubkeyAuthentication yes\nPermitRootLogin no" | sudo tee /etc/ssh/sshd_config.d/10-security.conf

sudo systemctl restart sshd

exit
```

## Programs Installation

From `home` machine:

```sh
ssh arch-vm
```

```sh
# Set up the proxy
sudo bash -c 'cat <<EOF >> /etc/environment
http_proxy=http://10.0.2.2:20171
https_proxy=http://10.0.2.2:20171
all_proxy=socks5://10.0.2.2:20170
HTTP_PROXY=http://10.0.2.2:20171
HTTPS_PROXY=http://10.0.2.2:20171
ALL_PROXY=socks5://10.0.2.2:20170
EOF'

export http_proxy="http://10.0.2.2:20171"
export https_proxy="http://10.0.2.2:20171"
```

```sh
# Install programs
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman -Sy --noconfirm \
  base-devel git fish starship eza bat fd ripgrep \
  neovim bun npm nodejs

# Set up fish shell
sudo chsh -s /usr/bin/fish arch
exit
```

```sh
# Enter back
ssh arch-vm
```




