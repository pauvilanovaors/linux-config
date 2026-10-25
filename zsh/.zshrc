# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zoxide
eval "$(zoxide init zsh)"

# fzf
source /usr/share/doc/fzf/examples/key-bindings.zsh
export PATH="$HOME/.local/bin:$PATH"

# opencode
export PATH=/home/pau/.opencode/bin:$PATH

# ROS 2
source /opt/ros/lyrical/setup.zsh

# ROS 2 CLI completion
eval "$(register-python-argcomplete ros2)"

# npm global packages (eas-cli, etc.)
export PATH="$HOME/.npm-global/bin:$PATH"

export EDITOR='nvim'

##################### Aliases #####################

# zoxide: jump to frecent dirs by substring, falls back to real cd for literal paths
alias cd='z'

# Clipboard (xclip under X11/XWayland; also what tmux's OSC52 copy lands on)
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias cpwd="pwd | tr -d '\n' | pbcopy && echo 'pwd copied to clipboard'"

# fzf with a bat preview (Debian/Ubuntu ships bat as `batcat`)
alias fzf="fzf --preview 'batcat --style=numbers --color=always --line-range=:500 {}'"
alias fzf_vim="fzf --preview 'batcat --style=numbers --color=always --line-range=:500 {}' --bind 'enter:execute(nvim {})'"
alias fzfc="fzf | xargs realpath | xclip -selection clipboard"

# Tmux
alias tn='tmux new-session -A -s "$(basename "$PWD")"'
# Session switcher built on fzf-tmux (no sesh dependency) — pairs with ~/.config/tmux/tmux.conf
ts() {
  local session
  session=$(tmux list-sessions -F '#{session_name}' 2>/dev/null | fzf-tmux -p 60%,40%) || return
  if [[ -n "$TMUX" ]]; then
    tmux switch-client -t "$session"
  else
    tmux attach -t "$session"
  fi
}
###################################################
