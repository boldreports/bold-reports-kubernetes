# Bold Reports on On-Premise Kubernetes Cluster

For fresh installation, continue with the following steps to deploy Bold Reports application in your On-Premise machine kubernetes cluster.

1. Download the following files for Bold Reports deployment in On-Premise.

    * `namespace.yaml`
    * `log4net_config.yaml`
    * `pvclaim_onpremise.yaml`
    * `deployment.yaml`
    * `hpa.yaml`
    * `service.yaml`
    * `ingress.yaml`    
    
2. Create a folder in your machine to store the shared folders for applications usage.

   Ex: `D://app/shared`

3. Open **pvclaim_onpremise.yaml** file, downloaded in **Step 1** .Replace the shared folder path in your host machine to the `<local_directory>` place in the file. You can also change the storage size in the YAML file.

    Ex: D://app/shared -> /run/desktop/mnt/host/**d/app/shared**
    
    ![Pvclaim_onpremise File Changes](images/onpremise_pvclaim.png)

4. Deploy the latest Nginx ingress controller to your cluster using the following command.

    ```sh
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.41.2/deploy/static/provider/cloud/deploy.yaml
    ```

5. Map the DNS to your machine IP address, in which you want to access the application.

6. Navigate to the folder where the deployment files were downloaded from Step 1.

7. Run the following command to create the namespace for deploying Bold Reports.

    ```sh
    kubectl apply -f namespace.yaml
    ```
	
8. Run the following command to create the configmap.

	```sh
	kubectl apply -f log4net_config.yaml
	```

9. Open the **ingress.yaml** file. Uncomment the host value and replace your DNS hostname with `example.com` and save the file.

10. If you have the SSL certificate for your DNS and need to configure the site with your SSL certificate, run the following command to create a TLS secret with your SSL certificate.

    ```sh
   kubectl create secret tls boldreports-tls -n bold-services --key <key-path> --cert <certificate-path>
    ```

11. Now, uncomment the `tls` section and replace your DNS hostname with `example.com` in ingress spec and save the file.

    ![Ingress File Changes](images/ingress_yaml.png)

12. Open the **deployment.yaml** file from the downloaded files in **Step 1**. Replace your DNS in `<application_base_url>` place.
    
    Ex: `http://example.com`, `https://example.com`

    ![Deployment File Changes](images/deployment_yaml.png)
	
13. Read the optional client library license agreement from the following link.
    
    [Consent to deploy client libraries](../docs/consent-to-deploy-client-libraries.md)
	
14. Note the optional client libraries from the above link as comma separated names and replace it in `<comma_separated_library_names>` place. Save the file after the required values has been replaced.

![deployment.yaml](images/deployment_yaml.png) 

15. Now, run the following commands one by one:

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
    kubectl apply -f ingress.yaml
    ```

16. Wait for some time till the Bold Reports On-Premise application deployed to your On-Premise Kubernetes cluster.

17. Use the following command to get the pods status.

     ```sh
    kubectl get pods -n bold-services
    ```    
    ![Pods Status](images/pod_status.png)

18. Use your DNS hostname to access the application in the browser.

19. Configure the Bold Reports On-Premise application startup to use the application. Please refer the following link for more details on configuring the application startup.

    https://help.boldreports.com/enterprise-reporting/administrator-guide/application-startup/