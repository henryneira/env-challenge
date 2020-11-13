#!/bin/sh

set -e

minikube start -p walmart --memory 4g --cpus 2

kubectl apply -f namespaces.yaml

helm repo add concourse https://concourse-charts.storage.googleapis.com/
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://charts.helm.sh/stable

helm repo update

helm install concourse concourse/concourse -f concourse.yaml -n concourse --version 14.2.0
helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring --version 11.1.1
