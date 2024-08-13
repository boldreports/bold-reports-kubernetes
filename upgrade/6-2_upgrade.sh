#!/usr/bin/env bash
# Copyright (c) Syncfusion Inc. All rights reserved.
#

while [ $# -gt 0 ]; do
  case "$1" in
    --version=*)
      version="${1#*=}"
      ;;
    --namespace=*)
      namespace="${1#*=}"
      ;;
	--application_base_url=*)
      application_base_url="${1#*=}"
      ;;
	--tls_secret_name=*)
      tls_secret_name="${1#*=}"
      ;;
    --optional_libs=*)
      optional_libs="${1#*=}"
      ;;
	--environment=*)
      environment="${1#*=}"
      ;;
    --load_balancer=*)
      load_balancer="${1#*=}"
      ;;
    --ingress_name=*)
      ingress_name="${1#*=}"
      ;;
	--pvc_name=*)
      pvc_name="${1#*=}"
	  ;;
    *)
  esac
  shift
done

[ -n "$version" ] || read -p 'Enter the version to upgrade: ' version

if [ -z "$version" ]
then
	echo "Version is empty."
else	
	if [ -z "$namespace" ]
	then
		namespace="default"
	fi

    if [ -z "$ingress_name" ]
	then
		ingress_name="boldreports-ingress"
	fi

	if [ -z "$pvc_name" ]
	then
		pvc_name="bold-services-fileserver-claim"
	fi

	if [ -z "$tls_secret_name" ]
	then
		tls_secret_name="boldreports-tls"
	fi
	
	if [[ "$version" == *"6.2.32_08122024_releasetesting"* ]]
	then
		[ -n "$application_base_url" ] || read -p 'Enter the application_base_url: ' application_base_url
		
		dns_name=$(echo $application_base_url | sed -e 's|^[^/]*//||' -e 's|/.*$||')

		if [ ! -d "boldreports_6-2" ]; then mkdir boldreports_6-2; fi
		
		# Downloading deployment files.."
		if [ ! -f "boldreports_6-2/hpa.yaml" ]; then curl -o boldreports_6-2/hpa.yaml https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/upgrade/6-2_upgrade/hpa.yaml; fi
		if [ ! -f "boldreports_6-2/hpa_gke.yaml" ]; then curl -o boldreports_6-2/hpa_gke.yaml https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/upgrade/6-2_upgrade/hpa_gke.yaml; fi
		if [ ! -f "boldreports_6-2/service.yaml" ]; then curl -o boldreports_6-2/service.yaml https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/upgrade/6-2_upgrade/service.yaml; fi
		if [ ! -f "boldreports_6-2/deployment.yaml" ]; then curl -o boldreports_6-2/deployment.yaml https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/upgrade/6-2_upgrade/deployment.yaml; fi
		if [ ! -f "boldreports_6-2/ingress.yaml" ]; then curl -o boldreports_6-2/ingress.yaml https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/upgrade/6-2_upgrade/ingress.yaml; fi
		if [ ! -f "boldreports_6-2/destination_rule.yaml" ]; then curl -o boldreports_6-2/destination_rule.yaml https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/upgrade/6-2_upgrade/destination_rule.yaml; fi
		if [ ! -f "boldreports_6-2/istio_gateway.yaml" ]; then curl -o boldreports_6-2/istio_gateway.yaml https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/upgrade/6-2_upgrade/istio_gateway.yaml; fi
		if [ ! -f "boldreports_6-2/log4net_config.yaml" ]; then curl -o boldreports_6-2/log4net_config.yaml https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/upgrade/6-2_upgrade/log4net_config.yaml; fi
		
		# deployment file changes changes
		sed -i "s/<namespace>/$namespace/g" boldreports_6-2/hpa.yaml
		sed -i "s/<namespace>/$namespace/g" boldreports_6-2/hpa_gke.yaml
		sed -i "s/<namespace>/$namespace/g" boldreports_6-2/service.yaml
		sed -i "s/<namespace>/$namespace/g" boldreports_6-2/deployment.yaml
        sed -i "s/<namespace>/$namespace/g" boldreports_6-2/istio_gateway.yaml
		sed -i "s/<namespace>/$namespace/g" boldreports_6-2/destination_rule.yaml
        sed -i "s/<namespace>/$namespace/g" boldreports_6-2/ingress.yaml
		sed -i "s/<namespace>/$namespace/g" boldreports_6-2/log4net_config.yaml
        sed -i "s/<ingress_name>/$ingress_name/g" boldreports_6-2/ingress.yaml
		sed -i "s/<image_tag>/$version/g" boldreports_6-2/deployment.yaml
		sed -i "s/<pvc_name>/$pvc_name/g" boldreports_6-2/deployment.yaml
		sed -i "s,<application_base_url>,$application_base_url,g" boldreports_6-2/deployment.yaml
		sed -i "s/<comma_separated_library_names>/$optional_libs/g" boldreports_6-2/deployment.yaml

		# applying new changes to cluster
		kubectl apply -f boldreports_6-2/service.yaml
		kubectl apply -f boldreports_6-2/deployment.yaml
		kubectl apply -f boldreports_6-2/log4net_config.yaml
		
		if [[ "$environment" == *"GKE"* ]]
		then
			kubectl apply -f boldreports_6-2/hpa_gke.yaml
		else
			kubectl apply -f boldreports_6-2/hpa.yaml
		fi

		# Extract the protocol and domain from the URL
		protocol=$(echo "$application_base_url" | awk -F: '{print $1}')

		# Function to check if a string is an IP address
		is_ip() {
		  [[ $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
		}

		if [[ "$load_balancer" == *"ingress"* ]]
		then
        	# Check if application_base_url is an IP address
			if is_ip "$dns_name"; then
		  		kubectl apply -f boldreports_6-2/ingress.yaml
			else
		  		# Update the Ingress file based on the protocol
		  		if [ "$protocol" == "http" ]; then
					sed -i -e "s|^ *- #host: <dns_name>|  - host: $dns_name|" "boldreports_6-2/ingress.yaml"
		    		kubectl apply -f boldreports_6-2/ingress.yaml
		  		elif [ "$protocol" == "https" ]; then
		    		sed -i -e "s|^ *# tls|  tls|" "boldreports_6-2/ingress.yaml"
		    		sed -i -e "s|^ *# - hosts:|  - hosts:|" "boldreports_6-2/ingress.yaml"
		    		sed -i -e "s|^ *# - <dns_name>|    - $dns_name|" "boldreports_6-2/ingress.yaml"
		    		sed -i -e "s|^ *# secretName: <tls_secret_name>|    secretName: $tls_secret_name|" "boldreports_6-2/ingress.yaml"
		    		sed -i -e "s|^ *- #host: <dns_name>|  - host: $dns_name|" "boldreports_6-2/ingress.yaml"
		    		kubectl apply -f boldreports_6-2/ingress.yaml
		  		fi
			fi
		else
			kubectl apply -f boldreports_6-2/istio_gateway.yaml
			kubectl apply -f boldreports_6-2/destination_rule.yaml
		fi
	fi
fi