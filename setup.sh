#!/usr/bin/env bash
# Symlinks this repo's dotfiles into place and fetches the external themes/plugins
# the configs depend on. Idempotent: safe to re-run after `git pull`.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d%H%M%S)"

link() {
  local src="$REPO_DIR/$1" dest="$HOME/$2"
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    mkdir -p "$BACKUP_DIR"
    mv "$dest" "$BACKUP_DIR/$(basename "$dest")"
    echo "backed up existing $dest -> $BACKUP_DIR/"
  fi
  ln -sfn "$src" "$dest"
  echo "linked $dest -> $src"
}

link zsh/.zshrc .zshrc
link zsh/.p10k.zsh .p10k.zsh
link bash/.bashrc .bashrc
link kitty/kitty.conf .config/kitty/kitty.conf
link tmux/tmux.conf .config/tmux/tmux.conf
link git/.gitconfig .gitconfig
link nvim/init.lua .config/nvim/init.lua
link nvim/lazy-lock.json .config/nvim/lazy-lock.json

[ -d "$HOME/powerlevel10k" ] || git clone --depth 1 https://github.com/romkatv/powerlevel10k.git "$HOME/powerlevel10k"
[ -d "$HOME/.config/kitty/kitty-themes" ] || git clone --depth 1 https://github.com/dexpota/kitty-themes.git "$HOME/.config/kitty/kitty-themes"
[ -d "$HOME/.config/tmux/tpm" ] || git clone --depth 1 https://github.com/tmux-plugins/tpm.git "$HOME/.config/tmux/tpm"

cat <<'EOF'

Done. Make sure these packages are installed: zsh, kitty, tmux, nvim, git, fzf, zoxide, xclip.
If zsh isn't your login shell yet: chsh -s "$(command -v zsh)"
Start tmux and press prefix+I (Ctrl+Space, then I) once to have TPM fetch the tmux plugins.
Start nvim once to have lazy.nvim fetch the plugins pinned in nvim/lazy-lock.json.
EOF
