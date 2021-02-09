function dots
  cd $HOME/git/dotfiles
end

function obsv
  cd $HOME/app-interface/data/services/observability/namespaces
end

function lh
  ls -lah
end

function wthr
  curl wttr.in
end

function rules
  cd $HOME/app-interface/resources/insights-prod/prometheus
end

function docker
  podman $argv
end

function kttl
   cd $HOME/git/clowder
   make deploy-minikube
   kubectl kuttl test --config bundle/tests/scorecard/kuttl/kuttl-test.yaml --crd-dir config/crd/bases/ bundle/tests/scorecard/kuttl/ --test $argv[1]
end
