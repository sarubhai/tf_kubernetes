# Kubernetes resource deployment using Terraform

Deploys multiple Kubernetes Resouces in k8s Minikube cluster using Terraform

The Resources that will be deployed from this repository are:

- Namespace
- Deployment
- Service
- Ingress
- Service Account & Role Binding

### Minikube Configuration using Terraform

- Refer [https://github.com/sarubhai/aws_vault](https://github.com/sarubhai/aws_vault) repo to auto configure the Minikube k8s Node.

### Prerequisite

Terraform is already installed in local machine.

## Usage

- Clone this repository
- Add the below variable values

### terraform.tfvars

```
config_path = "/Users/John/.minikube/config"

config_context = ""
```

- Change other variables in variables.tf file if needed
- terraform init
- terraform plan
- terraform apply -auto-approve -refresh=false
- Login to minikube_server_ip with user as ubuntu
- Use minikube & kubectl

### Some Commands

#### Minikube

minikube version
minikube status
minikube addons list

#### Kubectl

kubectl version -o json
kubectl config view
kubectl cluster-info
kubectl get nodes
kubectl get namespaces
kubectl get serviceaccounts
kubectl get deployments -n webapp-ns
kubectl get services -n webapp-ns
kubectl get ingress -n webapp-ns
kubectl create -f ingress.yaml
kubectl get ingress -n webapp-ns
