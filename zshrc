# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.zplug/init.zsh
export ZSH="/home/bholifie/.oh-my-zsh"
DISABLE_AUTO_TITLE="true"
setopt no_verbose
source <(oc completion zsh)

#ZSH_THEME="oxide"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(zsh-autosuggestions)
plugins+=(zsh-nvm)
source $ZSH/oh-my-zsh.sh
source $HOME/.config/bonfire/env
source $HOME/.config/token/get
source $HOME/.config/spot/env

function wthr() {
  curl wttr.in/hsv
}

function cruftF() { 
  git checkout origin/master -- bundle/metadata/annotations.yaml config/manager/kustomization.yaml config/manifests/bases/clowder.clusterserviceversion.yaml
  rm bundle.Dockerfile
}

getclowderlogs() {
  oc logs -f -n clowder-system ` oc get pods -n clowder-system -o json | jq -r '.items[] | select(.metadata.name | test("clowder-controller-manager-")) | .metadata.name'` | /home/bholifie/git/clowder/parse-controller-logs "$@"
}

minikubeStart() {
  ns=$1

  if [ -z "$ns"]; then 
    echo "No namespace provided, using metaverse as default"
    ns="metaverse"
  fi
  minikube start
  oc project $ns
}

secretDance() {
  oc get secret $1 -o json | jq '.data | map_values(@base64d)'
}

kuttlTest() {
  TAG=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 7 | head -n 1`
  $HOME/git/clowder/build/run_kuttl.sh --test $1
}

appReason() {
  oc get app -o json $1 | jq '.status.conditions[1].reason'
}

contextSwap() {
  minikube kubectl -- config set-context --current --namespace="$1"
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export MENU='fzf'

alias docker=podman
alias dots='cd $HOME/git/dotfiles'
alias ggp='git log --graph --decorate --pretty=oneline --abbrev-commit'
alias dance=secretDance
alias mks='minikubeStart'
alias ytho='appReason'
alias clowdbase='$HOME/utils/clowdbase.sh'
alias evnt="oc get events --sort-by='{.lastTimestamp}'"
alias gst='git status'
alias jot='nvim $HOME/git/notes/jot/jot.md'
alias ktl='kuttlTest'
alias clog="getclowderlogs"
alias cruft='cruftF'
alias bld='$HOME/utils/local_build.sh'
alias cldr='$HOME/utils/rollout_clowder.sh'
alias reload='source ~/.zshrc'
alias gdoc='$HOME/utils/gdoc.sh'
#alias bths='pactl set-card-profile bluez_card.38_18_4C_24_80_FF a2dp_sink'
alias gst='git status "$@"'
alias gco='git checkout "$@"'
alias ns=contextSwap

zplug load

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
