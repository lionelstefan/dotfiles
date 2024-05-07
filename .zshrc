# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

source ~/dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/dotfiles/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/zsh/z.sh
source ~/dotfiles/zsh/alias.zsh

export PATH=~/.npm-global/bin:$PATH
export TERM=xterm-256color

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt beep notify
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/stefanlionel/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
source ~/dotfiles/zsh/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#SSH AGENT
eval `ssh-agent > /dev/null`

agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
	ssh-add ~/.ssh/github
	ssh-add ~/.ssh/git_incenter
	ssh-add ~/.ssh/gitlab_lionelstefan
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/stefanlionel/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

#graveyard
export GRAVEYARD="/home/stefanlionel/.local/share/Trash"

# homebrew
export PATH="/home/stefanlionel/homebrew/bin:$PATH"
export PATH="/home/stefanlionel/homebrew/sbin:$PATH"
export HOMEBREW_PREFIX="/home/stefanlionel/homebrew";
export HOMEBREW_CELLAR="/home/stefanlionel/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/home/stefanlionel/homebrew";
export PATH="/home/stefanlionel/homebrew/bin:/home/stefanlionel/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/home/stefanlionel/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/home/stefanlionel/homebrew/share/info:${INFOPATH:-}";
export PRETTIERD_DEFAULT_CONFIG="/home/stefanlionel/dotfiles/formatter_config/prettierd/.prettierrc";

#NVIM
export GIT_EDITOR="nvim"

#GOLANG
export GOPATH=$HOME/go/packages
export GOROOT=$HOME/go
export GOPROXY=direct
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH="$HOME/.local/bin:$PATH"
export PATH=/usr/lib/cargo/bin/coreutils:$PATH
