# Green Blue (Zero Downtime) Deployment

> Simple example of Green Blue (Zero Downtime) version deployment cycle in Kubernetes for web application

## Quick Start

```bash

# Ensure minikue is running as well
minikube status

# Ensure istio is installed as well
# Reference -> https://istio.io/latest/docs/setup/getting-started/

# Ensure helm v3 is installed as well :)
# Reference -> https://helm.sh/docs/intro/install/
brew install helm
 
# Install istio on our minikube cluster
istioctl install

# Build
cd docker
eval $(minikube docker-env)
./build <TAG>
# TAG is the image tag we want to set 

# Deploy
cd ../helm
./deploy <TAG>
# where TAG is the same we use in the build image stage
# Note: you can add --debug --dry-run to debug/dry-run

# Port Fordwarding - note we run it with sudo because we need port 80 :)
sudo kubectl -n istio-system port-forward svc/istio-ingressgateway 80:80

# Go to browser to http://localhost and start chating :)
# if we want to note what is the slot/version running currently, http://localhost/version

Enjoy :-)

```
