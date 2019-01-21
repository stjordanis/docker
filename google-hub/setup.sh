# Sign in to Google Cloud
gcloud auth login

# Initialize
gcloud init

# Set up the cluster
gcloud container clusters create --machine-type n1-standard-2 --num-nodes 2 --zone us-central1-b --cluster-version latest quanteconhub

# Set up the Kubernetes permissions
kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=$(gcloud config get-value account)

# Download Helm
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash

# Initialize Helm
kubectl --namespace kube-system create serviceaccount tiller
kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller --wait

# Some security thing
kubectl patch deployment tiller-deploy --namespace=kube-system --type=json --patch='[{"op": "add", "path": "/spec/template/spec/containers/0/command", "value": ["/tiller", "--listen=localhost:44134"]}]'

# Initialize config.yaml with token
SECRET=$(openssl rand -hex 32)
sed -i "s/SECRET_HERE/${SECRET}/g" config.yaml

# JupyterHub Setup
# Add Helm repo
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update
