# Deployment Prerequisites

* [Install Kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) to deploy Bold Reports using kubectl.
* [File Storage](pre-requisites.md#file-storage)
* [Create and connect a cluster](pre-requisites.md#create-and-connect-a-cluster)
* [Load Balancing](pre-requisites.md#load-balancing)

# Deploy Bold Reports using kubectl

[Bold Reports](https://www.boldreports.com/) can be deployed manually on Kubernetes cluster. You can create Kubernetes cluster on cloud cluster providers (GKE, AKS, and EKS). After completing cluster creation, connect to it and you can download the configuration files [here](/deploy). This directory includes configuration YAML files, which contains all the configuration settings needed to deploy Bold Reports on Kubernetes cluster. The following links explain Bold Reports Kubernetes deployment in a specific cloud and on-premise environments.

* [Google Kubernetes Engine (GKE)](google-gke.md)
* [Amazon Elastic Kubernetes Service (EKS)](amazon-eks.md)
* [Azure Kubernetes Service (AKS)](microsoft-aks.md)

# Upgrade Bold Reports

If you are upgrading Bold Reports to 4.2.85, please follow the steps in this [link](/upgrade/4-2_upgrade.md).