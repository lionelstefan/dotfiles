# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

source ~/dotfiles/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
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
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
	ssh-add ~/.ssh/github
	ssh-add ~/.ssh/git_incenter
	ssh-add ~/.ssh/gitlab_lionelstefan

elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
	ssh-add ~/.ssh/github
	ssh-add ~/.ssh/git_incenter
	ssh-add ~/.ssh/gitlab_lionelstefan
fi

unset env


# if [ ! -S ~/.ssh/ssh_auth_sock ]; then
#   eval `ssh-agent`
#   ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
# fi
# export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
# ssh-add -l > /dev/null || ssh-add ~/.ssh/github
# ssh-add -l > /dev/null || ssh-add ~/.ssh/git_incenter
# ssh-add -l > /dev/null || ssh-add ~/.ssh/gitlab_lionelstefan

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/stefanlionel/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# homebrew
export PATH="/home/stefanlionel/homebrew/bin:$PATH"
export PATH="/home/stefanlionel/homebrew/sbin:$PATH"
export HOMEBREW_PREFIX="/home/stefanlionel/homebrew";
export HOMEBREW_CELLAR="/home/stefanlionel/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/home/stefanlionel/homebrew";
export PATH="/home/stefanlionel/homebrew/bin:/home/stefanlionel/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/home/stefanlionel/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/home/stefanlionel/homebrew/share/info:${INFOPATH:-}";

#xclip
# export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
# export LIBGL_ALWAYS_INDIRECT=1

#GOOGLE_APPLICATION_CREDENTIALS
export GOOGLE_APPLICATION_CREDENTIALS="/mnt/c/wsl/dragon-sea-view/dragon-sea-view-firebase-adminsdk-9omas-edcaca9f42.json"

#NVIM
export GIT_EDITOR="nvim"

#GOLANG
export GOPATH=$HOME/go
export GOPROXY=direct
export PATH="/usr/local/go/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/usr/bin:$PATH"
