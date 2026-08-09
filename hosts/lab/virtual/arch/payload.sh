#!/usr/bin/env bash
set -euo pipefail

sudo chown -R arch: /home/arch

echo "arch ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/arch

mkdir -p ~/.ssh
chmod 700 ~/.ssh
cat <<EOF > ~/.ssh/authorized_keys
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINngwDtUZAiEALEZ1XhPXX221hYqjGSaqWRnvaUnpMXT lewelove@proton.me
EOF
chmod 600 ~/.ssh/authorized_keys

sudo passwd -l root || true
sudo passwd -l arch || true

sudo mkdir -p /etc/ssh/sshd_config.d
sudo bash -c 'cat <<EOF > /etc/ssh/sshd_config.d/10-security.conf
PasswordAuthentication no
KbdInteractiveAuthentication no
AuthenticationMethods publickey
PubkeyAuthentication yes
PermitRootLogin no
EOF'

sudo systemctl restart sshd

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

sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman -Sy --noconfirm \
  base-devel git fish starship eza bat fd ripgrep \
  neovim nodejs npm python gcc make openssh

sudo chsh -s /usr/bin/fish arch

sudo npm install -g pi-coding-agent @mitsuhiko/pi-agent || true

mkdir -p ~/.config
if test ! -d ~/.dotfiles; then
  git clone https://github.com/lewelove/nix-config.git ~/.dotfiles || true
fi

if test -d ~/.dotfiles/dotfiles/.config/fish; then
  ln -sf ~/.dotfiles/dotfiles/.config/fish ~/.config/fish
fi
if test -f ~/.dotfiles/dotfiles/.config/starship.toml; then
  ln -sf ~/.dotfiles/dotfiles/.config/starship.toml ~/.config/starship.toml
fi
