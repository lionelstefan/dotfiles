alias c="clear"
alias x="exit"
alias r="source ~/.zshrc"
alias ll="exa -aFghl --no-icons --group-directories-first --time-style=long-iso"
alias ls="exa -aFghl --no-icons --group-directories-first --time-style=long-iso"
alias zz="z $OLDPWD"
alias vsc="code ."
alias v="nvim"
alias vim="nvim"
alias t="tmux -u -2"
alias tl="tmux list-session"
alias lg="lazygit"
alias ld="lazydocker"
alias tm="tmux"
alias gz="gzip"
alias pip="pip3"
alias rip="rip --graveyard /home/stefanlionel/.local/share/Tras"
alias serve="sudo rr serve -c ./.rr.yaml"
alias npm"/usr/bin/npm"
alias ssh-synergy="ssh -i ~/dflow/DFLOW-Cluster.pem ubuntu@10.1.5.41"
alias gj="git jump"
function ta()
{
  tmux attach-session -t $1
}
function dev()
{
  sudo service php7.3-fpm start
  sudo service nginx start
  sudo service redis-server start
  sudo service elasticsearch start
  sudo service mysql start
}
function serve()
{
  if [ -z $1 ]
  then
    php -S localhost:8000
  else
    php -S localhost:$1
  fi
}
function cat()
{
  batcat $1
}
function f() {
    fff "$@"
    cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}
