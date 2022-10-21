# Bold Reports on Amazon Elastic Kubernetes Service

For fresh installation, continue with the following steps to deploy Bold Reports On-Premise in Amazon Elastic Kubernetes Service (Amazon EKS).

1. Download the following files for Bold Reports deployment in Amazon EKS:

    * [namespace.yaml](https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/v4.2.52/deploy/namespace.yaml)
    * [log4net_config.yaml](https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/v4.2.52/deploy/log4net_config.yaml)
    * [pvclaim_eks.yaml](https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/v4.2.52/deploy/pvclaim_eks.yaml)
    * [deployment.yaml](https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/v4.2.52/deploy/deployment.yaml)
    * [hpa.yaml](https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/v4.2.52/deploy/hpa.yaml)
    * [service.yaml](https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/v4.2.52/deploy/service.yaml)
    * [istio_gateway.yaml](https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/v4.2.52/deploy/istio_gateway.yaml)
    * [destination_rule.yaml](https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/v4.2.52/deploy/destination_rule.yaml)

2. Create an Amazon EKS cluster and [node group](https://docs.aws.amazon.com/eks/latest/userguide/eks-compute.html) to deploy Bold Reports.

   https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html 

3. Connect to your Amazon EKS cluster.

4. Deploy the EFS CSI Driver to your cluster and create an Amazon Elastic File System (EFS) volume to store the shared folders for application usage by following the below link.

   https://docs.aws.amazon.com/eks/latest/userguide/efs-csi.html 

5. Note the **File system ID** after creating EFS file system.
![AWS EFS](/docs/images/aws-efs.png)

6. Open **pvclaim_eks.yaml** file, downloaded in **Step 1**. Replace the **File system ID** noted in above step to the `<efs_file_system_id>` place in the file. You can also change the storage size in the YAML file. 

![PV Claim](/docs/images/eks_pvclaim.png)

7. Install istio ingress gateway in your AKS cluster by following the below link,
https://docs.microsoft.com/en-us/azure/aks/servicemesh-istio-install

8.	Wait and get istio ingress gateway externa IP using the following command.

```sh
kubectl -n istio-system get service istio-ingressgateway -o 
jsonpath='{.status.loadBalancer.ingress[0].ip}'.
```

9. If you have a DNS to map with the application, then you can continue with the following steps, else skip to Step 16. If you do not have the DNS and want to use the application, then you can use the istio ingress gateway externa IP address which you got from above step.

10.	Map istio ingress gateway external ip to your DNS record.

11.	Open **istio_gateway.yaml** file downloaded from **Step 1**.

12.	Remove the line * from hosts, uncomment the next line and replace your DNS hostname with example.com and save the file.

![Replace DNS Host Name](images/dns-hostname.png) 

13. If you have the SSL certificate for your DNS and need to configure the site with your SSL certificate, follow the below step or you can skip to **Step 16**.

14. Run the following command to create a TLS secret with your SSL certificate.

```sh
kubectl create secret tls bold-tls -n bold-services --key <key-path> --cert <certificate-path>
```

15.	Now, uncomment the following section in istio_gateway.yaml file and replace your DNS hostname with example.com and save the file.

![Uncomment the section](images/uncomment-section.png) 

16. Open the **deployment.yaml** file from the downloaded files in **Step 1**. Replace your DNS or istio ingress gateway externa IP address in `<application_base_url>` place.
    
    Ex:  `http://example.com`, `https://example.com`, `http://<istio_ingress_gateway_externa_IP_address>`

17. Read the optional client library license agreement from the following link.

    [Consent to deploy client libraries](../docs/consent-to-deploy-client-libraries.md)

18. By default all the client libraries will be installed for Bold Reports in Kubernetes. Still you can still overwrite them by mentioning the required libraries as comma seperated like below in the environment variable noted from the above link.

![deployment.yaml](/docs/images/deployment_yaml.png) 

19. Now, run the following commands one by one:

```sh
kubectl apply -f pvclaim_eks.yaml
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

20. If you face any error while applying the hpa.yaml, try to use hpa_gke.yaml. The hpa_gke.yaml does not contain scaledown behavior which will not support in some clusters.

21.	Wait for some time till the Bold Reports On-Premise application deployed to your Amazon EKS cluster. 

22.	Use the following command to get the pods status.

```sh
kubectl get pods -n bold-services
```
![Pod status](/docs/images/pod_status.png) 

23. Wait till you see the applications in running state. Then use your DNS or ingress address you got from **Step 16** to access the application in the browser.

24.	Configure the Bold Reports On-Premise application startup to use the application. Please refer the following link for more details on configuring the application startup.
    
    https://help.boldreports.com/enterprise-reporting/administrator-guide/application-startup/