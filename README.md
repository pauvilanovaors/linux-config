# linux-config

Personal dotfiles: kitty, zsh (+ powerlevel10k), bash, tmux, git, nvim.

## Usage

```sh
git clone <this-repo-url> ~/Project/linux-config
cd ~/Project/linux-config
./setup.sh
```

Symlinks each file into `$HOME`, backing up anything already there, and
clones the external deps the configs reference (powerlevel10k,
dexpota/kitty-themes, tmux-plugins/tpm).

Packages expected on the machine: `zsh`, `kitty`, `tmux`, `nvim`, `git`, `fzf`, `zoxide`, `xclip`.

After running `setup.sh`:
- Start tmux and press `prefix+I` (`Ctrl+Space` then `I`) once to have TPM fetch its plugins.
- Start nvim once to have `lazy.nvim` fetch the plugins pinned in `nvim/lazy-lock.json`.
