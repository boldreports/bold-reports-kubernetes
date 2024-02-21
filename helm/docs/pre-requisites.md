# Deployment Pre-requisites

## File Storage

* [Azure Kubernetes Service (AKS)](#aks-file-storage)
* [Amazon Elastic Kubernetes Service (EKS)](#eks-file-storage)
* [Google Kubernetes Engine (GKE)](#gke-file-storage)

### AKS File Storage

#### SMB

1. Create a File share instance in your storage account and note the File share name to store the shared folders for application usage.

2. Encode the storage account name and storage key in `base64` format.

For encoding the values to base64 please run the following command in powershell

```console
[System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("<plain-text>"))
```

![File Share details](images/aks-file-storage.png)

#### NFS

1. Create an NFS file share instance within your premium storage account. Take note of the storage account and file share name, as these will be used to store shared folders for application usage.

2. Identify the hostname in the properties of the file share. Make a note of the hostname as illustrated in the image below.

   ![File Share details](images/nfs-hostname.png)

> **NOTE:** The premium storage account of the NFS fileshare must be within the same subscription as the AKS cluster.

### EKS File Storage

1. Deploy the EFS CSI Driver to your cluster and create an Amazon Elastic File System (EFS) volume to store the shared folders for application usage by following the below link.

   https://docs.aws.amazon.com/eks/latest/userguide/efs-csi.html 

2. Note the **File system ID** after creating EFS file system.

![AWS EFS](images/aws-efs.png)

### GKE File Storage

1. Create a Google filestore instance to store the shared folders for application usage.

   https://console.cloud.google.com/filestore 

2. Note the **File share name** and **IP address** after creating filestore instance.

![File Share details](images/gke_file_share_details.png)


## Create and connect a cluster

* [Azure Kubernetes Service (AKS)](#aks-cluster)
* [Amazon Elastic Kubernetes Service (EKS)](#eks-cluster)
* [Google Kubernetes Engine (GKE)](#gke-cluster)

### AKS Cluster

1. Create a Kubernetes cluster in Microsoft Azure Kubernetes Service (AKS) to deploy Bold Reports.
   https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough-portal

2. Connect to your Amazon EKS cluster.
   https://aws.amazon.com/premiumsupport/knowledge-center/eks-cluster-connection/

### EKS Cluster

1. Create an Amazon EKS cluster and [node group](https://docs.aws.amazon.com/eks/latest/userguide/eks-compute.html) to deploy Bold Reports.

   https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html 

2. Connect to your Amazon EKS cluster.
   https://aws.amazon.com/premiumsupport/knowledge-center/eks-cluster-connection/

 ### GKE Cluster

1. Create a Kubernetes cluster in Google Cloud Platform (GCP) to deploy Bold Reports.

   https://console.cloud.google.com/kubernetes 

2. Connect with your GKE cluster.

   https://cloud.google.com/kubernetes-engine/docs/quickstart
 
## Load Balancing

Currently we have provided support for `Nginx` and `Istio` as Load Balancers in Bold Reports. By default Nginx is used as reverse proxy for Bold Reports.

### Ingress-Nginx

If you need to configure Bold Reports with Ingress, [Install Nginx ingress controller](https://kubernetes.github.io/ingress-nginx/deploy/) in your cluster please refer below and run the command accordingly.

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
       EKS Cluster
      </td>
      <td>
       kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/aws/deploy.yaml 
      </td>
    </tr>
    <tr>
      <td>
       GKE Cluster
      </td>
      <td>
       kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/cloud/deploy.yaml
      </td>
    </tr>
</table>
<br/>

### Istio Ingress Gateway

If you need to configure Bold Reports with Istio, 

1. Please update the Loadbalancer type to `istio` in values.yaml file. 

   ![Istio-Ingress](/helm/docs/images/istio-config.png)

 
2. [Install Istio ingress gateway](https://istio.io/latest/docs/setup/install/) in your cluster please refer to the corresponing reference links

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
       EKS Cluster
      </td>
      <td>
       https://aws.amazon.com/blogs/opensource/getting-started-istio-eks/
      </td>
    </tr>
    <tr>
      <td>
       GKE Cluster
      </td>
      <td>
      https://cloud.google.com/istio/docs/istio-on-gke/installing
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