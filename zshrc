export ZSH="/home/bholifie/.oh-my-zsh"

ZSH_THEME="oxide"

plugins=(zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

alias notes='cd /home/bholifie/.notable/notes'
alias iusr='cd /home/bholifie/git/app-interface/data/teams/insights/users'
alias plan='./home/bholifie/scripts/planner/dist/linux-unpacked/planner'
alias docker=podman

function grb() {
  BRANCH = "$1"
  git checkout master
  git pull
  git checkout $BRANCH 
  git rebase master
  git push -f origin $BRANCH 
}

function sync() {
  git checkout master
  git pull upstream master
  git push origin master
}

function weather() {
  curl wttr.in/hsv
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
