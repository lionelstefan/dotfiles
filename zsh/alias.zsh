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
alias gj="git jump"
alias phpdoc="docker run --rm -v $(pwd):/data phpdoc/phpdoc:3"
alias t="vendor/bin/simple-phpunit --testdox --stop-on-error --stop-on-failure"
alias git-pull='~/dotfiles/zsh/safe-git-pull.sh'
alias gfs='git flow feature start '
alias ghs='git flow hotfix start '
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
  bat $1
}
function f() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
function pr()
{
  current_branch=$(git symbolic-ref --short HEAD)
  glab mr create \
    --source-branch "$current_branch" \
    --target-branch "staging" \
    --title "Merge $current_branch into staging" \
    --fill
}
