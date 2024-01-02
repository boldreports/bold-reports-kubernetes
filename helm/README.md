# Deploy Bold Reports using Helm

This chart installs [Bold Reports](https://www.boldreports.com/) on Kubernetes. You can create Kubernetes cluster on either cloud or on-premise infrastructure. Please follow the below documentation for Bold Reports deployment in a specific cloud and on-premise environments.
    
## Deployment prerequisites

* [Install Helm](https://helm.sh/docs/intro/install/) to deploy Bold Reports using Helm.
* [File Storage](docs/pre-requisites.md#file-storage)
* [Create and connect a cluster](docs/pre-requisites.md#create-a-cluster)
* [Load Balancing](docs/pre-requisites.md#load-balancing)

> **Note:** Note the [Ingress IP address](docs/pre-requisites.md#get-ingress-ip) to use it while crafting values.yaml when installing Bold Reports with helm chart.

## Get Repo Info

1. Add the Bold Reports helm repository

```console
helm repo add boldreports https://boldreports.github.io/bold-reports-kubernetes
helm repo update
```

2. View charts in repo

```console
helm search repo boldreports

NAME            CHART VERSION   APP VERSION     DESCRIPTION
boldreports/boldreports   5.3.8           5.3.8         Make bolder business decisions with complete reporting solutions...
```

_See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation._

## Install Chart

For Helm chart, you'll need to craft a `values.yaml`.

* For `EKS` please download the values.yaml file [here](https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/v5.3.8/helm/custom-values/eks-values.yaml).
* For `AKS` please download the values.yaml file [here](https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/v5.3.8/helm/custom-values/aks-values.yaml).

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
       namespace
      </td>
      <td>
       The namespace in which the Bold Reports resources will be dpleoyed in the kubernetes cluster.<br/>
       The default namespace is <i>bold-services</i>
      </td>
    </tr>
    <tr>
      <td>
       appBaseUrl *
      </td>
      <td>
       Domain or <a href='docs/pre-requisites.md#get-ingress-ip'>Ingress IP address</a> with http/https protocol. Follow the <a href='docs/configuration.md#ssl-termination'>SSL Termination</a> to configure SSL certificate for https protocol after deploying Bold Reports in your cluster.
      </td>
    </tr>
    <tr>
      <td>
       optionalLibs
      </td>
      <td>
       These are the client libraries used in Bold Reports by default.<br/>
       '<i>mysql,oracle,npgsql</i>'<br/>
       Please refer to <a href='docs/configuration.md#client-libraries'>Optional Client Libraries</a> section to know more.
      </td>
    </tr>
    <tr>
      <td>
       clusterProvider
      </td>
      <td>
       The type of kubernetes cluster provider you are using.<br/>
       The recommended values are '<i>eks,aks</i>'
      </td>
    </tr>
    <tr>
      <td>
       persistentVolume *
      </td>
      <td>
       Please refer to <a href='docs/configuration.md#persistent-volume'>this</a> section to know more on how to set Persistant Volumes for Bold Reports.
      </td>
    </tr>
    <tr>
      <td>
       loadBalancer
      </td>
      <td>
       Currently we have provided support for Nginx and Istio as Load Balancers in Bold Reports. Please refer to <a href='docs/configuration.md#load-balancing'>this</a> section for configuring Load balancer for Bold Reports.
      </td>
    </tr>
    <tr>
      <td>
       autoscaling
      </td>
      <td>
       By default autoscaling is enabled in Bold Reports. Please refer to <a href='docs/configuration.md#auto-scaling'>this</a> section to configure autoscaling in Bold Reports.
      </td>
    </tr>
</table>
<br/>

> **Note:** Items marked with `*` are mandatory fields in values.yaml

Run the following command to delpoy Bold Reports in your cluster.

```console
helm install [RELEASE_NAME] boldreports/boldreports -f [Crafted values.yaml file]
```
Ex:  `helm install boldreports boldreports/boldreports -f my-values.yaml`

Refer [here](docs/configuration.md) for advanced configuration including SSL termination, optional client libraries, etc.

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

## Upgrade

Run the following command to get the latest version of Bold Reports helm chart.

```console
helm repo update
```

Run the below command to apply changes in your Bold Reports release or upgrading Bold Reports to latest version.

```console
helm upgrade [RELEASE_NAME] boldreports/boldreports -f [Crafted values.yaml file]
```

Ex:  `helm upgrade boldreports boldreports/boldreports -f my-values.yaml`

## Uninstall Chart

```console
helm uninstall [RELEASE_NAME]
```
Ex:  `helm uninstall boldreports`

This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

## Application Startup

Configure the Bold Reports On-Premise application startup to use the application. Please refer the following link for more details on configuring the application startup.
    
https://help.boldreports.com/enterprise-reporting/administrator-guide/application-startup/
