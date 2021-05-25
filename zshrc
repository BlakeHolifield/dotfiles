export ZSH="/home/bholifie/.oh-my-zsh"
DISABLE_AUTO_TITLE="true"
setopt no_verbose

#ZSH_THEME="oxide"
ZSH_THEME="half-life"

plugins=(zsh-autosuggestions)
plugins+=(zsh-nvm)
source $ZSH/oh-my-zsh.sh

function wthr() {
  curl wttr.in/hsv
}

function clogF() {
   oc logs -f -n clowder-system `oc get pods -n clowder-system -o json | jq -r 'select(.items[].status.phase=="Running") .items[].metadata.name'` | /home/bholifie/git/clowder/parse-controller-logs
}

function clogOldF() {
   oc logs -f -n clowder-system `oc get pods -n clowder-system -o json | jq -r 'select(.items[].status.phase=="Running") .items[].metadata.name'`
}

function cruftF() {
  git checkout origin/master -- bundle/metadata/annotations.yaml config/manager/kustomization.yaml config/manifests/bases/clowder.clusterserviceversion.yaml
  rm bundle.Dockerfile
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias docker=podman
alias dots='cd $HOME/git/dotfiles'
alias ggp='git log --graph --decorate --pretty=oneline --abbrev-commit'
alias secret-dance="oc get secret $argv[1] -o json | jq '.data | map_values(@base64d)'"
alias clowdbase='$HOME/utils/clowdbase.sh'
alias evnt="oc get events --sort-by='{.lastTimestamp}'"
alias gst='git status'
alias jot='nvim $HOME/git/notes/jot/jot.md'
alias clog='clogF'
alias clog_old='clogOldF'
alias cruft='cruftF'
alias reload='source ~/.zshrc'
