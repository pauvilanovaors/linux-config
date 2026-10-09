# linux-config

Personal dotfiles: kitty, zsh (+ powerlevel10k), bash.

## Usage

```sh
git clone <this-repo-url> ~/Project/linux-config
cd ~/Project/linux-config
./setup.sh
```

Symlinks each file into `$HOME`, backing up anything already there, and
clones the two external deps the configs reference (powerlevel10k,
dexpota/kitty-themes).

Packages expected on the machine: `zsh`, `kitty`, `git`, `fzf`, `zoxide`.
