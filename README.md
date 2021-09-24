# Kubernetes resource deployment using Terraform

Deploys multiple Kubernetes Resouces in k8s Minikube cluster using Terraform

The Resources that will be deployed from this repository are:

- Namespace
- Service Account
- Cluster Role
- Role ^
- Cluster Role Binding
- Role Binding
- Config Map ^
- Secret
- Storage Class ^
- Persistent Volume ^
- Persistent Volume Claim (Release/Recreate Issue)
- Pod ^
- Replication Controller ^
- Deployment ^
- Service ^
- Ingress

^ - Some attributes don't respond to lifecycle.ignore_changes; only option is to refresh state file; "terraform apply -refresh-only --auto-approve"

### Minikube Configuration using Terraform

- Refer [minikube_install.sh](https://github.com/sarubhai/install-demo-minikube) to install & configure a Minikube k8s Node for demo.
- kubectl config view
- copy the config content, along with ca.crt, client.crt & client.key to your loacl machine
- modify the kubernetes config file in local machine accordingly

### Prerequisite

Terraform is already installed in local machine.

## Usage

- Clone this repository
- Add the below variable values

### terraform.tfvars

```
config_path = "/Users/John/.minikube/config"

config_context = ""

hostname = "minikube"
```

- Change other variables in variables.tf file if needed
- terraform init
- terraform plan
- terraform apply -auto-approve -refresh=false
- Login to minikube_server_ip with user as ubuntu
- Use minikube & kubectl

### Some Commands

#### Minikube

- minikube version
- minikube status
- minikube addons list

#### Kubectl

- kubectl version -o json
- kubectl config view
- kubectl cluster-info
- kubectl get nodes
- kubectl get namespaces
- kubectl get serviceaccounts
- kubectl get secrets
- kubectl get deployments -n generic-ns
- kubectl get services -n generic-ns
- kubectl get ingress -n generic-ns
- kubectl create -f ingress.yaml
- kubectl get ingress -n generic-ns
- kubectl get persistentvolumes
- kubectl get persistentvolumeclaims -n generic-ns
