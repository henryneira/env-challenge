#!/bin/bash

MINIKUBE_INSTANCE=$(minikube profile list | grep walmart)
if [[ -z $MINIKUBE_INSTANCE ]]; then
    echo "🥱  minikube profile walmart doesn't exists. let's create it"
    minikube start -p walmart --memory=4g --cpus=2
fi

kubectl apply -f namespaces.yaml

helm repo add concourse https://concourse-charts.storage.googleapis.com/
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://charts.helm.sh/stable
helm repo add loki https://grafana.github.io/loki/charts

helm repo update

helm upgrade --install concourse concourse/concourse -f concourse.yaml -n concourse --version 14.2.0
helm upgrade --install prometheus prometheus-community/kube-prometheus-stack -n monitoring --version 11.1.1
helm upgrade --install loki loki/loki-stack -n logging --version 2.0.1
