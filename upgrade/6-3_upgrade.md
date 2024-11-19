# Upgrading Bold Reports to latest version

This section explains how to upgrade Bold Reports to latest version in your Kubernetes cluster. You can refer to the features and enhancements from this [Release Notes](https://www.boldreports.com/release-history/embedded-reporting).


## Backup the existing data
Before upgrading the Bold Reports to latest version, make sure to take the backup of the following items.

* Files and folders from the shared location, which you have mounted to the deployments by persistent volume claims (pvclaim_*.yaml).

* Database backup - Take a backup of Database, to restore incase if the upgrade was not successful or if applications are not working properly after the upgrade.


## Proceeding with upgrade
Bold Reports updates the database schema of your current version to the latest version. The upgrade process will retain all the resources and settings from the previous deployment.

You can download the upgrade script from this [link](https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/master/upgrade/6-3_upgrade.sh) or use the below command.

```sh
curl -o upgrade.sh https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/master/upgrade/6-3_upgrade.sh
```

Run the following command to execute the shell script to upgrade Bold Reports.

```sh
./upgrade.sh --version="<image_tag>" --namespace="<namespace>" --application_base_url="<application_base_url>" --optional_libs="<comma_separated_library_names>" --tls_secret_name="<tls_secret_name>" --environment="<your_kubernetes_environment>" --load_balancer="<your_load_balancer_type>" --ingress_name="<ingress_name>" --pvc_name="<pvc_name>"
```


> **INFO:** 
> 1. You can ignore `--ingress_name`,`--tls_secret_name` and `--pvc_name` arguments from the above upgrade command if you are using custom names for ingress,tls secret and pvc.
> 2. You can also ignore `--optional_libs` argument if not needed.

<table>
    <tr>
      <td>
       version
      </td>
      <td>
      Image tag of the current version, which you are going to upgrade.
      </td>
    </tr>
    <tr>
      <td>
       namespace (optional)
      </td>
      <td>
       namespace in which your existing Bold Reports application was running. </br>
       Default value: <i>default</i>
      </td>
    </tr>
    <tr>
      <td>
       application_base_url
      </td>
      <td>
       Application base URL of your Bold Reports Deployment.
      </td>
    </tr>
    <tr>
      <td>
       comma_separated_library_names (optional)
      </td>
      <td>
       Comma seperated optional libraries. </br>
       Default value is <i>null</i>
      </td>
    </tr>
    <tr>
      <td>
       tls_secret_name (optional)
      </td>
      <td>
       Secret name created for tls. </br>
       Default value: <i>boldreports-tls</i>
      </td>
    </tr>
    <tr>
      <td>
       environment
      </td>
      <td>
       Cloud Provider you chose for host the application in the kubernetes
      </td>
    </tr>
    <tr>
      <td>
       load_balancer
      </td>
      <td>
       Type of load balancer which is using in existing Bold Reports application was running. 
      </td>
    </tr>
    <tr>
      <td>
       ingress_name (optional)
      </td>
      <td>
       If you are using custom name for ingress. Give the name of the ingress which is using in existing ingress file. </br>
       Default value: <i>boldreports-ingress</i>
      </td>
    </tr>
    <tr>
      <td>
       pvc_name (optional)
      </td>
      <td>
       If you are using custom name for persistent volume claim. Give the name of the PVC which is using existing pvc file. </br>
       Default value: <i>bold-services-fileserver-claim</i>
      </td>
    </tr>
</table>

If you are upgrading the bold reports application from v5.3 or below, then you need to enable puppeteer. Please refer [this](/docs/enable-puppeteer-when-upgrading-lower-version-to-v5.4.20.md) documentation for enabling puppeteer.