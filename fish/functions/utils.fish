function dots
  cd $HOME/git/dotfiles
end

function lh
  ls -lah
end

function wthr
  curl wttr.in
end

function docker
  podman $argv
end

function kttl
   cd $HOME/git/clowder
   make deploy-minikube
   kubectl kuttl test --config bundle/tests/scorecard/kuttl/kuttl-test.yaml --crd-dir config/crd/bases/ bundle/tests/scorecard/kuttl/ --test $argv[1]
end

function notes
  cd $HOME/git/notes
end

function jot
  nvim $HOME/git/notes/jot/jot.md
end

function td
  nvim $HOME/git/notes/tech-debt/bank.md
end

function ggp
  git log --graph --decorate --pretty=oneline --abbrev-commit
end

function secret-dance
  oc get secret $argv[1] -o json | jq '.data | map_values(@base64d)'
end

function clowdbase
  $HOME/utils/clowdbase.sh
end

function eph
  $HOME/utils/ephemeral-login.sh
end

function evnt
  oc get events --sort-by='{.lastTimestamp}'
end

function clog
    oc logs -f -n clowder-system (oc get pods -n clowder-system -o json | jq -r 'select(.items[].status.phase=="Running") .items[].metadata.name') | /home/bholifie/git/clowder/parse-controller-logs
end

function clogold
    oc logs -f -n clowder-system (oc get pods -n clowder-system -o json | jq -r 'select(.items[].status.phase=="Running") .items[].metadata.name')
end

function cruft
  git checkout origin/master -- bundle/metadata/annotations.yaml config/manager/kustomization.yaml config/manifests/bases/clowder.clusterserviceversion.yaml
  rm bundle.Dockerfile
end
