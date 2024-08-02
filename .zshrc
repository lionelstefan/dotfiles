source ~/dotfiles/zsh/z.sh
source ~/dotfiles/zsh/alias.zsh

source ~/dotfiles/zsh/zsh-256color/zsh-256color.plugin.zsh
source ~/dotfiles/zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/dotfiles/zsh/zsh-completions/zsh-completions.plugin.zsh
source ~/dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source ~/dotfiles/zsh/alwaysontop/alwaysontop.sh

export PATH=~/.npm-global/bin:$PATH
export TERM=xterm-256color

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt beep notify
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/lionelstefan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#SSH AGENT
eval `ssh-agent > /dev/null`

agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [[ $agent_run_state = 1 ]]; then
	ssh-add ~/.ssh/bitbucket_dflow
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/lionelstefan/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

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
export PRETTIERD_DEFAULT_CONFIG="/home/lionelstefan/dotfiles/formatter_config/prettierd/.prettierrc";

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
export PATH="/mnt/c/Users/StefanLionelSuwito/scoop/apps/win32yank/current:$PATH"
export PATH=/usr/lib/cargo/bin/coreutils:$PATH
export PATH="$PATH:$HOME/.config/composer/vendor/bin"

#GLOBAL
export EDITOR="nvim"
export FFF_HIDDEN=1

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
