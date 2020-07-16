echo 'Now input your GitHub username: '
read GHUSER
helm repo add fluxcd https://charts.fluxcd.io
kubectl apply -f https://raw.githubusercontent.com/fluxcd/helm-operator/master/deploy/crds.yaml
kubectl create namespace flux
helm upgrade -i flux fluxcd/flux --set git.url=git@github.com:${GHUSER}/flux-get-started --namespace flux
helm upgrade -i helm-operator fluxcd/helm-operator --set git.ssh.secretName=flux-git-deploy --namespace flux --set helm.versions=v3

kubectl -n flux rollout status deployment/flux
echo SSH KEY:
fluxctl identity --k8s-fwd-ns flux