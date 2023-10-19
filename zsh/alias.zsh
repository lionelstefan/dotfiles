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
