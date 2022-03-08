alias ll="exa -al --icons"
alias ls="exa -al --icons"
alias zz="z $OLDPWD"
function dev()
{
  sudo service php7.3-fpm start
  sudo service nginx start
  sudo service redis-server start
  sudo service elasticsearch start
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
