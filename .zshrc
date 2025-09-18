export EDITOR=nvim
export VISUAL=nvim
export TERM="xterm-256color"
export FORCE_COLOR=1
export FFF_HIDDEN=1

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1

# ─────────────────────────────────────────────────────────────
# Zinit Plugin Manager (bootstrapped)
# ─────────────────────────────────────────────────────────────
# Zinit core
if [[ -f "$HOME/.local/share/zinit/zinit.git/zinit.zsh" ]]; then
  source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
  autoload -Uz _zinit
  (( ${+_comps} )) && _comps[zinit]=_zinit
else
  echo "Zinit not found at ~/.local/share/zinit/zinit.git/zinit.zsh — please install it."
fi

# ─────────────────────────────────────────────────────────────
# Zinit Annexes (required for some advanced features)
# ─────────────────────────────────────────────────────────────
zinit light-mode for \
  zdharma-continuum/zinit-annex-as-monitor \
  zdharma-continuum/zinit-annex-bin-gem-node \
  zdharma-continuum/zinit-annex-patch-dl \
  zdharma-continuum/zinit-annex-rust

# ─────────────────────────────────────────────────────────────
# Zsh Plugins (via Zinit)
# ─────────────────────────────────────────────────────────────

# Load Powerlevel10k theme
zinit ice depth=1

# Core zsh functionality (history, completion)
zinit snippet OMZL::history.zsh
zinit snippet OMZL::completion.zsh

# Autosuggestions (start the plugin after load)
# zinit wait lucid \
#   atload"_zsh_autosuggest_start" \
#   for zsh-users/zsh-autosuggestions

# zsh-completions (needs blockf and reinstall on update)
zinit wait lucid \
  blockf atpull'zinit creinstall -q .' \
  for zsh-users/zsh-completions

# Other plugins (optional lazy loading)
zinit wait lucid for \
  joshskidmore/zsh-fzf-history-search \
  chrissicool/zsh-256color \
  Valiev/almostontop

zinit ice wait lucid
zinit snippet OMZP::git

zinit ice as"command" from"gh-r" \
  atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
  atpull"%atclone" src"init.zsh"

zinit wait lucid for \
  atload"eval \"\$(zoxide init zsh)\"" \
  ajeetdsouza/zoxide

zinit light-mode for \
  Schniz/fnm

zinit light starship/starship

# Fast syntax highlighting (should load last for best effect)
# zinit wait lucid light-mode \
#         atinit"zicompinit; zicdreplay" \
#         for zdharma-continuum/fast-syntax-highlighting

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

source ~/dotfiles/.env_secrets


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
    ssh-add ~/.ssh/pertama_gitlab ~/.ssh/github_lionelstefan ~/.ssh/github_stefan-dev
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add ~/.ssh/pertama_gitlab ~/.ssh/github_lionelstefan ~/.ssh/github_stefan-dev
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

# ELASTIC BEANSTAL
export PATH="$HOME/.ebcli-virtual-env/bin:$PATH"

#BIOME
start_biome_quiet() {
  ( nohup biome start --config-path ~/dotfiles/nvim/linter_formatter_config/biome > /dev/null 2>&1 & disown ) > /dev/null 2>&1
}
start_biome_quiet

if command -v fnm &>/dev/null; then
  eval "$(fnm env --shell zsh)"  # quiet, no "Using Node" spam
fi

# Aliases (local snippet)
source ~/dotfiles/zsh/alias.zsh
