# CTRL + Arrow Keys
bindkey '\e[1;5C' forward-word       # Ctrl + Right
bindkey '\e[1;5D' backward-word      # Ctrl + Left
bindkey '\e[1;5A' up-line-or-history # Ctrl + Up
bindkey '\e[1;5B' down-line-or-history # Ctrl + Down

# ALT + Arrow Keys (Some terminals may send different codes; adjust if needed)
bindkey '\e[1;3C' forward-word       # Alt + Right
bindkey '\e[1;3D' backward-word      # Alt + Left
bindkey '\e[1;3A' up-line-or-history # Alt + Up
bindkey '\e[1;3B' down-line-or-history # Alt + Down

source ~/dotfiles/zsh/alias.zsh

source ~/dotfiles/zsh/zsh-256color/zsh-256color.plugin.zsh
source ~/dotfiles/zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/dotfiles/zsh/zsh-completions/zsh-completions.plugin.zsh
source ~/dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source ~/dotfiles/zsh/zsh-fzf-history-search/zsh-fzf-history-search.zsh
source ~/dotfiles/zsh/almostontop/almostontop.plugin.zsh

source ~/dotfiles/.env_secrets

export EDITOR=nvim
export VISUAL=nvim
export TERM=xterm-256color
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt beep notify
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/lionelstefan/.zshrc'

# Use a cached compdump
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache
autoload -Uz compinit && compinit -C
# End of lines added by compinstall

#SSH AGENT
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add ~/.ssh/pertama_gitlab ~/.ssh/github_lionelstefan
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add ~/.ssh/pertama_gitlab ~/.ssh/github_lionelstefan
fi

unset env
#SSH AGENT END

export PATH=~/.npm-global/bin:$PATH

# fnm
FNM_PATH="/home/lionelstefan/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/lionelstefan/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

# pnpm
export PNPM_HOME="/home/lionelstefan/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

#biome
biome start --config-path /home/lionelstefan/dotfiles/nvim/linter_formatter_config/biome

#graveyard
export GRAVEYARD="/home/lionelstefan/.local/share/Trash"

# homebrew
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export PATH="/home/linuxbrew/.linuxbrew/sbin:$PATH"
export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew";
export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar";
export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew";
export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin${PATH+:$PATH}";
export MANPATH="/home/linuxbrew/.linuxbrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:${INFOPATH:-}";

# prettier
export PRETTIERD_DEFAULT_CONFIG="/home/lionelstefan/dotfiles/formatter_config/prettierd/.prettierrc";
#prettier-end

# GIT
export GIT_HTTP_LOW_SPEED_LIMIT=0
export GIT_HTTP_LOW_SPEED_TIME=999999

#NVIM
export GIT_EDITOR="nvim"

#GOLANG
export GOPATH=$HOME/go/packages
export GOROOT=$HOME/go
export GOPROXY=direct
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/nvim-linux64/bin:$PATH"
export PATH="$HOME/.local/uctags-2024.07.11-linux-x86_64/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH=/usr/lib/cargo/bin/coreutils:$PATH
export PATH="$PATH:$HOME/.config/composer/vendor/bin"

#MASON NEOVIM
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin"

#GLOBAL
export EDITOR="nvim"
export FFF_HIDDEN=1

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"
