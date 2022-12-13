# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
zstyle :compinstall filename '/home/lionelstefan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/lionelstefan/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# homebrew
export PATH="/home/lionelstefan/homebrew/bin:$PATH"

# java
# export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
# export PATH="$PATH:$JAVA_HOME/bin"

#android
# export ANDROID_SDK_ROOT="/home/lionelstefan/Android"
# export ANDROID_HOME="/home/lionelstefan/Android"

# export PATH="$PATH:$ANDROID_SDK_ROOT/plaftorm-tools"
# export PATH="$PATH:$ANDROID_HOME/bin"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)
export ADB_SERVER_SOCKET=tcp:$WSL_HOST:5037

#wslhostpatcher
# /mnt/c/wsl/wslhostpatcher/WSLHostPatcher.exe

#set MACHINE IP ADDRESS (WIFI) FOR EXPO
# export REACT_NATIVE_PACKAGER_HOSTNAME=$(netsh.exe interface ip show address "Wi-Fi" | grep 'IP Address' | sed -r 's/^.*IP Address:\W*//')

#rhromedriver
export PATH="$PATH:/usr/bin/chromedriver"

#xclip
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
