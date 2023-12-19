# Deployment Pre-requisites

## File Storage

* [Azure Kubernetes Service (AKS)](#aks-file-storage)
* [On-premise](#on-premise-file-storage)


### AKS File Storage

1. Create a File share instance in your storage account and note the File share name to store the shared folders for application usage.

2. Encode the storage account name and storage key in `base64` format.

For encoding the values to base64 please run the following command in powershell

```console
[System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("<plain-text>"))
```

![File Share details](images/aks-file-storage.png)

### On-Premise File Storage

Create a folder in your machine to store the shared folders for application usage.

Ex:  `D://app/shared`

Mention this location in install command as like below,
	
Ex:  `D://app/shared` -> `/run/desktop/mnt/host/d/app/shared`


## Create and connect a cluster

* [Azure Kubernetes Service (AKS)](#aks-cluster)
* [On-premise](#on-premise-cluster)


### AKS Cluster

1. Create a Kubernetes cluster in Microsoft Azure Kubernetes Service (AKS) to deploy Bold BI.
   https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough-portal

2. Connect with your Microsoft AKS cluster.
   https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough-portal#connect-to-the-cluster

### On-Premise Cluster

1. Create a Kubernetes onpremise cluster to deploy Bold BI.

2. Follow the instructions to [Create an On-Premise cluster](https://kubernetes.io/docs/setup/).


## Load Balancing

Currently we have provided support for `Nginx` and `Istio` as Load Balancers in Bold BI. By default Nginx is used as reverse proxy for Bold BI.

### Ingress-Nginx

If you need to configure Bold BI with Ingress, [Install Nginx ingress controller](https://kubernetes.github.io/ingress-nginx/deploy/) in your cluster please refer below and run the command accordingly.

<br/>
<table>
    <tr>
      <td>
       <b>Name</b>
      </td>
      <td>
       <b>Description</b>
      </td>
    </tr>
    <tr>
      <td>
       AKS Cluster
      </td>
      <td>
       kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.41.2/deploy/static/provider/cloud/deploy.yaml
      </td>
    </tr>
    <tr>
      <td>
       OnPremise
      </td>
      <td>
       kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.41.2/deploy/static/provider/cloud/deploy.yaml
      </td>
    </tr>
</table>
<br/>

### Istio Ingress Gateway

If you need to configure Bold BI with Istio, [Install Istio ingress gateway](https://istio.io/latest/docs/setup/install/) in your cluster please refer to the corresponing reference links

<br/>
<table>
    <tr>
      <td>
       <b>Name</b>
      </td>
      <td>
       <b>Description</b>
      </td>
    </tr>
    <tr>
      <td>
       AKS Cluster
      </td>
      <td>
       https://docs.microsoft.com/en-us/azure/aks/servicemesh-istio-install
      </td>
    </tr>
    <tr>
      <td>
       OnPremise
      </td>
      <td>
       https://istio.io/latest/docs/setup/platform-setup/docker/
      </td>
    </tr>
</table>
<br/>

### Get Ingress IP

Run the following command to get the ingress IP address.

```console
# Nginx
kubectl get service/ingress-nginx-controller -n ingress-nginx

# Istio
kubectl get service/istio-ingressgateway -n istio-system
```

Note the ingress `EXTERNAL-IP` address and map it with your DNS. If you do not have the DNS and want to use the application, then you can use the ingress IP address.