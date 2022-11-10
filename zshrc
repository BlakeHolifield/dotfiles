# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.zplug/init.zsh
export ZSH="/home/bholifie/.oh-my-zsh"
export EDITOR="nvim"
DISABLE_AUTO_TITLE="true"
fpath=(~/.zsh/oc $fpath)
autoload -U compinit
compinit -i

#ZSH_THEME="oxide"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(zsh-autosuggestions oc git)
plugins+=(zsh-nvm)

source $ZSH/oh-my-zsh.sh
source $HOME/.config/bonfire/env
source $HOME/.config/token/get
source $HOME/.config/spot/env

if [ -f `which powerline-daemon` ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bash/powerline.sh
fi

function wthr() {
    curl wttr.in/hsv
}

function bootstrapRepo() {
  cd $HOME/git
  REPO_URL=$1
  git clone $REPO_URL
  cd $HOME/git/`echo $REPO_URL | cut -d/ -f2 | cut -d. -f1`
}


function go_test() {
  go test $* | sed ''/PASS/s//$(printf "\033[32mPASS\033[0m")/'' | sed ''/SKIP/s//$(printf "\033[34mSKIP\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[31mFAIL\033[0m")/'' | GREP_COLOR="01;33" egrep --color=always '\s*[a-zA-Z0-9\-_.]+[:][0-9]+[:]|^'
}

getclowderlogs() {
    oc logs -f -n clowder-system ` oc get pods -n clowder-system -o json | jq -r '.items[] | select(.metadata.name | test("clowder-controller-manager-")) | .metadata.name'` | /home/bholifie/git/clowder/parse-controller-logs "$@"
}

clowdLog() {
    oc logs -f -n clowder-system ` oc get pods -n clowder-system -o json | jq -r '.items[] | select(.metadata.name | test("clowder-controller-manager-")) | .metadata.name'`
}

minikubeStart() {
    ns=$1
    
    if [ -z "$ns"]; then
        echo "No namespace provided, using boot as default"
        ns="boot"
    fi
    minikube start
    oc project $ns
}

secretDance() {
    oc get secret $1 -o json | jq '.data | map_values(@base64d)'
}

clowderBuild() {
    TAG=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 7 | head -n 1`
    CLOWDER_BUILD_TAG=$TAG make deploy-minikube-quick
}

kuttlTest() {
    $HOME/git/clowder/build/run_kuttl.sh --test $1
}

appReason() {
    oc get app -o json $1 | jq '.status.conditions[1].reason'
}

contextSwap() {
    minikube kubectl -- config set-context --current --namespace="$1"
}

makeAndGo() {
  mkdir $1 && cd $1
}

getKCEphSecret() {
   NSP=$(oc project | cut -d " " -f 3 | tr -d '"')
   dance env-$NSP-keycloak
}

connectBt() {
  bluetoothctl connect $1
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export MENU='fzf'

alias docker=podman
alias bootstrap=bootstrapRepo
alias kc='getKCEphSecret'
alias dots='cd $HOME/git/dotfiles'
alias ggp='git log --graph --decorate --pretty=oneline --abbrev-commit'
alias dance='secretDance'
alias mks='minikubeStart'
alias ytho='appReason'
alias yj='jobYaml'
alias yp='podYaml'
alias clowdbase='$HOME/utils/clowdbase.sh'
alias fullstack='$HOME/utils/fullstack.sh'
alias evnt="oc get events --sort-by='{.lastTimestamp}'"
alias gst='git status'
alias jot='nvim $HOME/git/notes/jot/jot.md'
alias ktl='kuttlTest'
alias cbld='clowderBuild'
alias clog="getclowderlogs"
alias clg="clowdLog"
alias cruft='cruftF'
alias bld='$HOME/utils/local_build.sh'
alias cldr='$HOME/utils/rollout_clowder.sh'
alias reload='source ~/.zshrc'
alias gdoc='$HOME/utils/gdoc.sh'
alias mkg='makeAndGo'
alias gst='git status "$@"'
alias gco='git checkout "$@"'
alias ns=contextSwap
alias gt=go_test
alias bt=bluetoothctl
alias gti='git "$@"'
alias hac='code $HOME/workspaces/hac.code-workspace'
alias int='code $HOME/app-interface'
alias wss='code $HOME/git/dynamic-browser-events'

zplug load

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# added by travis gem
[ ! -s /home/bholifie/.travis/travis.sh ] || source /home/bholifie/.travis/travis.sh

[[ -s "/home/bholifie/.gvm/scripts/gvm" ]] && source "/home/bholifie/.gvm/scripts/gvm"
