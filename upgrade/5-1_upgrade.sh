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
	
	if [[ "$version" == *"5.1"* ]]
	then
		[ -n "$application_base_url" ] || read -p 'Enter the application_base_url: ' application_base_url

		
		dns_name=$(echo $application_base_url | sed -e 's|^[^/]*//||' -e 's|/.*$||')

		if [ ! -d "boldreports_5-1" ]; then mkdir boldreports_5-1; fi
		
		# Downloading deployment files.."
		if [ ! -f "boldreports_5-1/hpa.yaml" ]; then curl -o boldreports_5-1/hpa.yaml https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/master/upgrade/hpa.yaml; fi

		if [ ! -f "boldreports_5-1/hpa_gke.yaml" ]; then curl -o boldreports_5-1/hpa_gke.yaml https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/master/upgrade/hpa_gke.yaml; fi

		if [ ! -f "boldreports_5-1/service.yaml" ]; then curl -o boldreports_5-1/service.yaml https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/master/upgrade/service.yaml; fi

		if [ ! -f "boldreports_5-1/deployment.yaml" ]; then curl -o boldreports_5-1/deployment.yaml https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/master/upgrade/deployment.yaml; fi

		if [ ! -f "boldreports_5-1/ingress.yaml" ]; then curl -o boldreports_5-1/ingress.yaml https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/master/upgrade/ingress.yaml; fi

		if [ ! -f "boldreports_5-1/destination_rule.yaml" ]; then curl -o boldreports_5-1/destination_rule.yaml https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/master/upgrade/destination_rule.yaml; fi

		if [ ! -f "boldreports_5-1/istio_gateway.yaml" ]; then curl -o boldreports_5-1/istio_gateway.yaml https://raw.githubusercontent.com/boldreports/bold-reports-kubernetes/master/upgrade/istio_gateway.yaml; fi
		
		# deployment file changes changes
		sed -i "s/<namespace>/$namespace/g" boldreports_5-1/hpa.yaml
		sed -i "s/<namespace>/$namespace/g" boldreports_5-1/hpa_gke.yaml
		sed -i "s/<namespace>/$namespace/g" boldreports_5-1/service.yaml
		sed -i "s/<namespace>/$namespace/g" boldreports_5-1/deployment.yaml
        sed -i "s/<namespace>/$namespace/g" boldreports_5-1/istio_gateway.yaml
		sed -i "s/<namespace>/$namespace/g" boldreports_5-1/destination_rule.yaml
        sed -i "s/<namespace>/$namespace/g" boldreports_5-1/ingress.yaml
        sed -i "s/<ingress_name>/$ingress_name/g" boldreports_5-1/ingress.yaml
        sed -i "s/<tls_secret_name>/$tls_secret_name/g" boldreports_5-1/ingress.yaml
        sed -i "s/<dns_name>/$dns_name/g" boldreports_5-1/ingress.yaml
		sed -i "s/<image_tag>/$version/g" boldreports_5-1/deployment.yaml
		sed -i "s/<pvc_name>/$pvc_name/g" boldreports_5-1/deployment.yaml
		sed -i "s,<application_base_url>,$application_base_url,g" boldreports_5-1/deployment.yaml
		sed -i "s/<comma_separated_library_names>/$optional_libs/g" boldreports_5-1/deployment.yaml

		# applying new changes to cluster
		kubectl apply -f boldreports_5-1/service.yaml
		kubectl apply -f boldreports_5-1/deployment.yaml
		

		if [[ "$environment" == *"GKE"* ]]
		then
		kubectl apply -f boldreports_5-1/hpa_gke.yaml
		else
		kubectl apply -f boldreports_5-1/hpa.yaml
		fi

		if [[ "$load_balancer" == *"ingress"* ]]
		then
        kubectl delete -f ingress.yaml
		kubectl apply -f boldreports_5-1/ingress.yaml
		else
		kubectl apply -f boldreports_5-1/istio_gateway.yaml
		kubectl apply -f boldreports_5-1/destination_rule.yaml
		fi


	fi
fi