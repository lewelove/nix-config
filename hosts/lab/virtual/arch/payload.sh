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
