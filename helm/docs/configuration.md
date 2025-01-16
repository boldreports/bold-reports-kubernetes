# Advanced Configuration

## Client Libraries

The following are the client libraries used in Bold Reports.

```console
optionalLibs: 'mysql,oracle,postgresql,snowflake'
```

Read the optional client library license agreement from the following link.

[Consent to deploy client libraries](../docs/consent-to-deploy-client-libraries.md)

If you wish to inlcude only specific client libraries note the optional client libraries from the above link as comma separated names in your values.yaml file.

  ![Client library](/helm/docs/images/client-library.png)

## Persistent Volume

### Name

Persistent volumes were global resources. So if you already have Bold Reports installed in your cluster, then the previous persistent volume name will conflict with current installation. Change this name to avoid conflicts with previous Bold Reports persistent volumes.

By default the persistent volume name used in Bold Reports is `bold-service-fileserver`. 

```console
persistentVolume:
  # persistent volumes were global resources. 
  # so if you already have Bold Reports installed in your cluster, 
  # then the previous persistent volume name will conflict with current installation.
  # Change this name to avoid conflicts with previous Bold Reports persistent volumes.
  name: bold-service-fileserver
```

### Capacity

Generally, a PV will have a specific storage capacity. This is set using the PV's capacity attribute. See the [Kubernetes Resource Model](https://git.k8s.io/community/contributors/design-proposals/scheduling/resources.md) to understand the units expected by capacity.

By default the persistent volume capacity used in Bold Reports is `3Gi`. 

```console
persistentVolume:
  capacity: 3Gi
```

### Persistent volume configuration for each cluster


1. AKS

```console
clusterProvider: aks
    
persistentVolume:
  aks:
    fileShareName: <file_share_name>
    # base64 string
    azureStorageAccountName: <base64_azurestorageaccountname>
    # base64 string
    azureStorageAccountKey: <base64_azurestorageaccountkey>
```

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
       clusterProvider
      </td>
      <td>
       The type of kubernetes cluster provider you are using. In this case the clusterProvider value is <i>aks</i>
      </td>
    </tr>
    <tr>
      <td>
       persistentVolume.aks.fileShareName
      </td>
      <td>
       The <i>File share name</i> of your File share instance.
      </td>
    </tr>
    <tr>
      <td>
       persistentVolume.aks.azureStorageAccountName
      </td>
      <td>
       The <i>base64 encoded storage account name</i> of the File share instance in your storage account.
      </td>
    </tr>
    <tr>
      <td>
       persistentVolume.aks.azureStorageAccountKey
      </td>
      <td>
       The <i>base64 encoded storage account key</i> of the File share instance in your storage account.
      </td>
    </tr>
</table>
<br/>

> **NOTE:** The Azure storage account credentials will be maintained in a secret named `bold-azure-secret`

2. AKS WITH NFS FILESHARE

```console
clusterProvider: aks
    
persistentVolume:
  aks:
    nfs:
      # fileshare name as 'storageaccountname/filesharename'.
      fileShareName: '<storageaccountname/filesharename>'

      # hostname of the fileshare Ex:premiumstorage1234.file.core.windows.net.
      hostName: '<hostname>'
```

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
       clusterProvider
      </td>
      <td>
       The type of kubernetes cluster provider you are using. In this case the clusterProvider value is <i>aks</i>
      </td>
    </tr>
    <tr>
      <td>
       persistentVolume.aks.nfs.fileShareName
      </td>
      <td>
       The <i>Storage account</i> and <i>File share name</i> of your nfs File share instance.
       Ex: Ex:premiumstorage1234/boldreports
      </td>
    </tr>
    <tr>
      <td>
       persistentVolume.aks.nfs.hostName
      </td>
      <td>
       The host name of your nfs fileshare instance.
       Ex: premiumstore12345.file.core.windows.net
      </td>
    </tr>
</table>
<br/>

> **NOTE:** The premium storage account of the NFS fileshare must be within the same subscription as the AKS cluster.

3. EKS

```console
clusterProvider: eks
    
persistentVolume:
  eks:
    efsFileSystemId: <efs_file_system_id>
```

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
       clusterProvider
      </td>
      <td>
       The type of kubernetes cluster provider you are using. In this case the clusterProvider value is <i>eks</i>
      </td>
    </tr>
    <tr>
      <td>
       persistentVolume.eks.efsFileSystemId
      </td>
      <td>
       The <i>File system ID</i> of your EFS file system.
      </td>
    </tr>
</table>
<br/>

4. GKE

```console
clusterProvider: gke
    
persistentVolume:
  gke:
    fileShareName: <file_share_name>
    fileShareIp: <file_share_ip_address>
```
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
       clusterProvider
      </td>
      <td>
       The type of kubernetes cluster provider you are using. In this case the clusterProvider value is <i>gke</i>
      </td>
    </tr>
    <tr>
      <td>
       persistentVolume.gke.fileShareName
      </td>
      <td>
       The <i>File share name</i> of your filestore instance.
      </td>
    </tr>
    <tr>
      <td>
       persistentVolume.gke.fileShareIp
      </td>
      <td>
       The <i>IP address</i> of your filestore instance.
      </td>
    </tr>
</table>
<br/>

5. ACK

````console
clusterProvider: ack

persistentVolume:
  ack:  
    serverName: <host_name_of_mount_target>
    filePath: <file_path_name>
````

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
       clusterProvider
      </td>
      <td>
       The type of kubernetes cluster provider you are using. In this case the clusterProvider value is <i>gke</i>
      </td>
    </tr>
    <tr>
      <td>
       persistentVolume.ack.serverName
      </td>
      <td>
       The <i>File share server name</i> of your filestore instance.
      </td>
    </tr>
    <tr>
      <td>
       persistentVolume.ack.filePath
      </td>
      <td>
       The <i>Mount path</i> of your filestore instance.
      </td>
    </tr>
</table>
<br/>

## Load Balancing

### Ingress-Nginx

By default Nginx is used as reverse proxy for Bold Reports. To configure load balancing in Bold Reports take a look at the below snipet. 

```console
loadBalancer:
  type: nginx
```

The default `ingressClassName` is `nginx`. Please refer [here](https://kubernetes.io/docs/concepts/services-networking/ingress/#deprecated-annotation) for more details.

```console
loadBalancer:
  # For Kubernetes >= 1.18 you should specify the ingress-controller via the field ingressClassName
  # See https://kubernetes.io/blog/2020/04/02/improvements-to-the-ingress-api-in-kubernetes-1.18/#specifying-the-class-of-an-ingress
  # ingressClassName: nginx
```

### Istio Ingress Gateway

If you need to configure Bold Reports with Istio then you can change the value as `istio` in your configuration like below.

```console
loadBalancer:
  type: istio
```
### Kong-API Ingress

If you need to configure Bold Reports with Kong Api Gateway then you can change the value as `kong` in your configuration like below:

```console
loadBalancer:
  type: kong
```

### sticky session

You can change the affinityCookieExpiration time. The default value is 600s.

```console
loadBalancer:
  affinityCookie:
    enable: true
    affinityCookieExpiration: 600
```

### SSL Configuration

If you have the SSL certificate for your DNS and need to configure the site with your SSL certificate, just pass your DNS with `https` protocol to `appBaseUrl`, by doing this it will automatically enable SSL in both Ingress and Istio.

> **NOTE:**  You have to create the TLS Secret with name `bold-tls` or else change the secret name in your values.yaml

Run the following command to create a TLS secret with your SSL certificate.

```console
# Nginx Ingress and Kong-API-Gateway Ingress
kubectl create secret tls bold-tls -n bold-services --key <key-path> --cert <certificate-path>

# Istio
kubectl create secret tls bold-tls -n istio-system --key <key-path> --cert <certificate-path>
```

### Map multiple domains

You can map mutiple domains in both Ingress Nginx and Istio like below. While mapping multiple domains you have to include the `appBaseUrl` in any of the matching host array.

For multiple domain scenerio the `singleHost` secret will not be considered, you have to mention your secret inside `multipleHost` section.

`Ingress Nginx`

```console
loadBalancer:
  singleHost:
    secretName: bold-tls

  multipleHost:
    hostArray:
      - hosts: 
          - cd1.abc.com
          - cd2.abc.com
        secretName: tls-secret1
      - hosts: 
          - cd1.xyz.com
          - cd2.xyz.com
        secretName: tls-secret2
```

`Istio Ingress Gateway`

```console
loadBalancer:
  singleHost:
    secretName: bold-tls

  multipleHost:
    hostArray:
      - hosts: 
          - cd1.abc.com
          - cd2.abc.com
        secretName: tls-secret
```

### Nginx Annotation Configuration

By default, the necessary annotations are already included in the Nginx Ingress file. If you need to add annotations based on your specific use case, you can specify them in the values.yaml file in the key:value format. Refer to the example below:

```
  nginxIngressAnnotations:
    # Enter annotations here for adding annotations in nginx ingress
    # Example:
    #cert-manager.io/cluster-issuer: letsencrypt-prod
    #nginx.ingress.kubernetes.io/rewrite-target: /
```

This configuration allows you to tailor the behavior of the Nginx Ingress Controller to meet your requirements by adding appropriate annotations.

## Auto Scaling

By default autoscaling is enabled in Bold Reports, to disable autoscaling please set `autoscaling.enabled=false`.

```console
autoscaling:
  enabled: true
  targetCPUUtilizationPercentage: 80
  targetMemoryUtilizationPercentage: 80
  behavior:
    stabilizationWindowSeconds: 60
    podsValue: 1
    podsPeriodSeconds: 60
    percentValue: 10
    percentPeriodSeconds: 60
```

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
       autoscaling.enabled
      </td>
      <td>
       By default the autoscaling will be enabled. turn this to <i>false</i> to disable the autoscaling functionality.
      </td>
    </tr>
    <tr>
      <td>
       autoscaling.targetCPUUtilizationPercentage
      </td>
      <td>
       The CPU utilization is the average CPU usage of a all pods in a deployment across the last minute divided by the requested CPU of this deployment.
      </td>
    </tr>
    <tr>
      <td>
       autoscaling.targetMemoryUtilizationPercentage
      </td>
      <td>
       With this metric the HPA controller will keep the average utilization of the pods in the scaling target at the value mentioned (80%). Utilization is the ratio between the current usage of resource to the requested resources of the pod.
      </td>
    </tr>
    <tr>
      <td>
       autoscaling.behavior.stabilizationWindowSeconds
      </td>
      <td>
       The stabilization window is used by the autoscaling algorithm to consider the computed desired state from the past to prevent scaling. By default the value is 60 to provide a custom downscale stabilization window of 1 minute.
      </td>
    </tr>
    <tr>
      <td>
       autoscaling.behavior.podsValue<br/>
       autoscaling.behavior.podsPeriodSeconds
      </td>
      <td>
       This policy (Pods) allows 1 replicas to be scaled down in one minute.
      </td>
    </tr>
    <tr>
      <td>
       autoscaling.behavior.percentValue<br/>
       autoscaling.behavior.percentPeriodSeconds
      </td>
      <td>
       This policy (Percent) allows at most 10% of the current replicas to be scaled down in one minute.
      </td>
    </tr>
</table>
<br/>
