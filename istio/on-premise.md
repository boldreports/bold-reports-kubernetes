# Bold Reports on On-Premise Kubernetes Cluster

For fresh installation, continue with the following steps to deploy Bold Reports application in your On-Premise machine kubernetes cluster.

1. Download the following files for Bold Reports deployment in On-Premise.

    * [namespace.yaml](https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/v4.2.52/deploy/namespace.yaml)
    * [log4net_config.yaml](https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/v4.2.52/deploy/log4net_config.yaml)
    * [pvclaim_onpremise.yaml](https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/v4.2.52/deploy/pvclaim_onpremise.yaml)
    * [deployment.yaml](https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/v4.2.52/deploy/deployment.yaml)
    * [hpa.yaml](https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/v4.2.52/deploy/hpa.yaml)
    * [service.yaml](https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/v4.2.52/deploy/service.yaml)
    * [istio_gateway.yaml](https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/v4.2.52/deploy/istio_gateway.yaml)
    * [destination_rule.yaml](https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/v4.2.52/deploy/destination_rule.yaml)
    
2. Create a folder in your machine to store the shared folders for applications usage.

   Ex: `D://app/shared`

3. Open **pvclaim_onpremise.yaml** file, downloaded in **Step 1** .Replace the shared folder path in your host machine to the `<local_directory>` place in the file. You can also change the storage size in the YAML file.

    Ex: D://app/shared -> /run/desktop/mnt/host/**d/app/shared**
    
    ![Pvclaim_onpremise File Changes](/docs/images/onpremise_pvclaim.png)

4. Install istio ingress gateway in your AKS cluster by following the below link,
https://docs.microsoft.com/en-us/azure/aks/servicemesh-istio-install

5. Wait and get istio ingress gateway externa IP using the following command.

```sh
kubectl -n istio-system get service istio-ingressgateway -o 
jsonpath='{.status.loadBalancer.ingress[0].ip}'.
```

6. If you have a DNS to map with the application, then you can continue with the following steps, else skip to Step 16. If you do not have the DNS and want to use the application, then you can use the istio ingress gateway externa IP address which you got from above step.

7. Map istio ingress gateway external ip to your DNS record.

8. Open **istio_gateway.yaml** file downloaded from **Step 1**.

9. Remove the line * from hosts, uncomment the next line and replace your DNS hostname with example.com and save the file.

![Replace DNS Host Name](images/dns-hostname.png) 

10. If you have the SSL certificate for your DNS and need to configure the site with your SSL certificate, follow the below step or you can skip to **Step 13**.

11. Run the following command to create a TLS secret with your SSL certificate.

```sh
kubectl create secret tls boldreports-tls -n boldreports--key <key-path> --cert <certificate-path>
```

12.	Now, uncomment the following section in istio_gateway.yaml file and replace your DNS hostname with example.com and save the file.

![Uncomment the section](images/uncomment-section.png)

13. Open the **deployment.yaml** file from the downloaded files in **Step 1**. Replace your DNS in `<application_base_url>` place.
    
    Ex: `http://example.com`, `https://example.com`

    ![Deployment File Changes](/docs/images/deployment_yaml.png)
	
14. Read the optional client library license agreement from the following link.
    
    [Consent to deploy client libraries](../docs/consent-to-deploy-client-libraries.md)
	
15. Note the optional client libraries from the above link as comma separated names and replace it in `<comma_separated_library_names>` place. Save the file after the required values has been replaced.

![deployment.yaml](/docs/images/deployment_yaml.png) 

16. Now, run the following commands one by one:

    ```sh
    kubectl apply -f pvclaim_onpremise.yaml
    ```

    ```sh
    kubectl apply -f deployment.yaml
    ```

    ```sh
    kubectl apply -f hpa.yaml
    ```

    ```sh
    kubectl apply -f service.yaml
    ```

    ```sh
    kubectl apply -f istio_gateway.yaml
    ```

    ```sh
    kubectl apply -f destination_rule.yaml
    ```

17.	If you face any error while applying the hpa.yaml, try to use hpa_gke.yaml. The hpa_gke.yaml does not contain scaledown behavior which will not support in some clusters.

18. Wait for some time till the Bold Reports On-Premise application deployed to your On-Premise Kubernetes cluster.

19. Use the following command to get the pods status.

     ```sh
    kubectl get pods -n bold-services
    ```    
    ![Pods Status](/docs/images/pod_status.png)

20. Use your DNS hostname to access the application in the browser.

21. Configure the Bold Reports On-Premise application startup to use the application. Please refer the following link for more details on configuring the application startup.

    https://help.boldreports.com/enterprise-reporting/administrator-guide/application-startup/