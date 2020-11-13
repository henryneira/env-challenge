minikube start
helm repo add concourse https://concourse-charts.storage.googleapis.com/
helm repo update
helm install concourse concourse/concourse -f concourse.yaml    