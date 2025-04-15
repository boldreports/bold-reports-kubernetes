# Deploy Bold Reports using Helm

This chart installs [Bold Reports](https://www.boldreports.com/) on Kubernetes. You can create Kubernetes cluster on either cloud or on-premise infrastructure. Please follow the below documentation for Bold Reports deployment in a specific cloud and on-premise environments.
    
## Deployment prerequisites

* [Install Helm](https://helm.sh/docs/intro/install/) to deploy Bold Reports using Helm.
* [Install kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)
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
boldreports/boldreports   9.1.7           9.1.7         Make bolder business decisions with complete reporting solutions...
```

_See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation._

## Install Chart

For Helm chart, you'll need to craft a `values.yaml`.

* For `EKS` please download the values.yaml file [here](https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/master/helm/custom-values/eks-values.yaml).
* For `AKS` please download the values.yaml file [here](https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/master/helm/custom-values/aks-values.yaml).
* For `GKE` please download the values.yaml file [here](https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/master/helm/custom-values/gke-values.yaml).
* For `ACK` please download the values.yaml file [here](https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/master/helm/custom-values/ack-values.yaml)

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
       '<i>mysql,oracle,postgresql,snowflake</i>'<br/>
       Please refer to <a href='docs/configuration.md#client-libraries'>Optional Client Libraries</a> section to know more.
      </td>
    </tr>
    <tr>
      <td>
       clusterProvider
      </td>
      <td>
       The type of kubernetes cluster provider you are using.<br/>
       The recommended values are '<i>eks,aks,gke</i>'
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
    <tr>
      <td>
       tolerationEnable: false<br />
       tolerations:
       </td>
      <td>
       Tolerations allow the pods to be scheduled into nodes with matching taints. Set this to true if you use tolerations in your cluster. If you need more than one toleration, you can add multiple tolerations below.
      </td>
    </tr>
    <tr>
      <td>
       nodeAffinityEnable: false<br />
       nodeAffinity:
      </td>
      <td>
       Node affinity ensures that the pods are scheduled into nodes with matching labels. Set this to true if you use node affinity in your cluster.
      </td>
    </tr>
    <tr>
      <td>
         podAffinityEnable: false
      </td>
      <td>
        Pod affinity ensures that the pods are scheduled into nodes with matching pods. Set this to true if you use pod affinity in your cluster
      </td>
    </tr>
    <tr>
      <td>
         podAntiAffinityEnable: false
      </td>
      <td>
        Pod anti-affinity ensures that the pods are not scheduled into nodes with matching pods. Set this to true if you use pod anti-affinity in your cluster.
      </td>
    </tr>
</table>
<br/>

## Environment variables for configuring Application Startup in backend

The following environment variables are optional. If not provided, a manual Application Startup configuration is needed.

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
       licenseKey
      </td>
      <td>
       License key of Bold Reports
      </td>
    </tr>
    <tr>
      <td>
       email *
      </td>
      <td>
       It should be a valid email.
      </td>
    </tr>
    <tr>
      <td>
       password *
      </td>
      <td>
       It should meet our password requirements. <br /> <br />Note: <br />Password must meet the following requirements. It must contain,At least 6 characters, 1 uppercase character, 1 lowercase character, 1 numeric character, 1 special character
      </td>
    </tr>
    <tr>
      <td>
       dbType *
      </td>
      <td>
       Type of database server can be used for configuring the Bold Reports.<br/><br />The following DB types are accepted:<br />1. mssql – Microsoft SQL Server/Azure SQL Database<br />2. postgresql – PostgreSQL Server<br />3. mysql – MySQL/MariaDB Server
      </td>
    </tr>
    <tr>
      <td>
       dbHost *
      </td>
      <td>
       Name of the Database Server
      </td>
    </tr>
    <tr>
      <td>
       dbPort
      </td>
      <td>
       The system will use the following default port numbers based on the database server type.<br />PostgrSQL – 5432<br />MySQL -3306<br /><br />Please specify the port number for your database server if it is configured on a different port.<br /><br />For MS SQL Server, this parameter is not necessary.
      </td>
    </tr>
    <tr>
      <td>
       dbUser *
      </td>
      <td>
       Username for the database server.
      </td>
    </tr>
    <tr>
      <td>
       dbPassword *
      </td>
      <td>
       The database user's password
      </td>
    </tr>
    <tr>
      <td>
       dbName
      </td>
      <td>
       If the database name is not specified, the system will create a new database called bold-services.<br /><br />If you specify a database name, it should already exist on the server.
      </td>
    </tr>
    <tr>
      <td>
       maintenanceDB
      </td>
      <td>
       For PostgreSQL DB Servers, this is an optional parameter.<br />The system will use the database name `postgres` by default.<br />If your database server uses a different default database, please provide it here.
      </td>
    </tr>
    <tr>
      <td>
       dbAdditionalParameters
      </td>
      <td>
       If your database server requires additional connection string parameters, include them here.<br /><br />Connection string parameters can be found in the official document.<br />My SQL: https://dev.mysql.com/doc/connector-net/en/connector-net-8-0-connection-options.html<br />PostgreSQL: https://www.npgsql.org/doc/connection-string-parameters.html<br />MS SQL: https://docs.microsoft.com/en-us/dotnet/api/system.data.sqlclient.sqlconnection.connectionstring<br /><br /><b>Note:</b> A semicolon(;) should be used to separate multiple parameters.
      </td>
    </tr>
    <tr>
      <td>
       dbSchema
      </td>
      <td>
       A database schema defines the structure, organization, and constraints of data within a database, including tables, fields, relationships, and indexes<br /><br />In MSSQL, the default schema is dbo.<br />
       In PostgreSQL, the default schema is public.<br /><br />
       Both schemas contain tables and other database objects by default.
      </td>
    </tr>
</table>
<br/>

## Environment variables for configuring Branding in backend

The following environment variables are optional. If they are not provided, Bold Reports will use the default configured values.

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
       mainLogo
      </td>
      <td>   
       This is header logo for the applicationand the preferred image size is 40 x 40 pixels.
      </td>
    </tr>
    <tr>
      <td>
       loginLogo
      </td>
      <td>     
       This is login logo for the application and the preferred image size is 200 x 40 pixels.
      </td>
    </tr>
    <tr>
      <td>
       emailLogo
      </td>
      <td>     
       This is email logo, and the preferred image size is 200 x 40 pixels.
      </td>
    </tr>
    <tr>
      <td>
       favicon
      </td>
      <td>     
       This is favicon and the preferred image size is 40 x 40 pixels. 
      </td>
    </tr>
    <tr>
      <td>
       footerLogo
      </td>
      <td>     
       This is powered by logo and the preferred size is 100 x 25 pixels.
       <br />
       <br />
       <b>Note:</b><br/>• All the branding variables are accepted as URL.<br/>• <b>Ex:</b> https://example.com/loginlogo.jpg <br/>• <b>Image type:</b> png, svg, jpg, jpeg.<br/>• If you want to use the custom branding, provide the value for all branding variables If all variable values are given, application will use the branding images, otherwise it will take the default logos. 
      </td>
    </tr>
    <tr>
      <td>
       siteName
      </td>
      <td>
      This is organization name.     
      <br />
       If the value is not given, the site will be deployed using the default name.
      </td>
    </tr>
    <tr>
      <td>
       siteIdentifier
      </td>
      <td>     
       This is site identifier, and it will be the part of the application URL.
      <br />
      If the value is not given, the site will be deployed using the default value.
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
