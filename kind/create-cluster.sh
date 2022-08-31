#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

kind create cluster  --config=$SCRIPTPATH/kind.yaml --name=argo-workflow
kubectl cluster-info --context kind-kind
kubectl config set-context --current --namespace=argocd
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2

kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

kubectl create namespace argo-rollouts
kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml

#kubectl port-forward svc/argocd-server -n argocd 8080:443
#http://localhost:8080
kubectl create ns argo
kubectl apply -n argo -f https://raw.githubusercontent.com/argoproj/argo-workflows/stable/manifests/quick-start-postgres.yaml

#kubectl -n argo port-forward deployment/argo-server 2746:2746
#https://localhost:2746

kubectl get configmap -n argo  workflow-controller-configmap -o yaml | sed 's/docker/k8sapi/' | kubectl apply -f -

kubectl apply -f $SCRIPTPATH/kubeseal

echo -n MYSECRET | kubectl create secret generic secret --dry-run=client --from-file=secret=/dev/stdin -o json | kubeseal > secret.yaml

./$SCRIPTPATH/ecr-secret.sh

kubectl apply -f $SCRIPTPATH/../argo


argocd repo add git@github.com:GabrielDyck/argo-cd-example.git --ssh-private-key-path ~/.ssh/id_ed25519

#kind load docker-image $AWS-ACCOUNT.dkr.ecr.us-east-1.amazonaws.com/argo-hello-world:v0.0.22-release.0  --name argo-workflow
#kind load docker-image $AWS-ACCOUNT.dkr.ecr.us-east-1.amazonaws.com/argo-hello-world:v0.0.23-release.0  --name argo-workflow