# Upgrading Bold Reports to latest version

This section explains how to upgrade Bold Reports to latest version in your Kubernetes cluster. You can refer to the features and enhancements from this [Release Notes](https://www.boldreports.com/release-history/embedded-reporting).


## Backup the existing data
Before upgrading the Bold Reports to latest version, make sure to take the backup of the following items.

* Files and folders from the shared location, which you have mounted to the deployments by persistent volume claims (pvclaim_*.yaml).

* Database backup - Take a backup of Database, to restore incase if the upgrade was not successful or if applications are not working properly after the upgrade.


## Proceeding with upgrade
Bold Reports updates the database schema of your current version to the latest version. The upgrade process will retain all the resources and settings from the previous deployment.

You can download the upgrade script from this [link](https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/v7.1.9/upgrade/upgrade.sh) or use the below command.

```sh
curl -o upgrade.sh https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/v7.1.9/upgrade/upgrade.sh
```

Run the following command to execute the shell script to upgrade Bold Reports.

```sh
./upgrade.sh --version="7.1.9" --namespace="bold-services"
```

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
</table>

If you are upgrading the bold reports application from v5.3 or below, then you need to enable puppeteer. Please refer [this](/docs/enable-puppeteer-when-upgrading-lower-version-to-v5.4.20.md) documentation for enabling puppeteer.