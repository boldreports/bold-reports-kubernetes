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
	
	kubectl set image deployment/id-web-deployment id-web-container=us-docker.pkg.dev/boldreports/multi-container/bold-identity:$version --namespace=$namespace --record 
	kubectl set image deployment/id-api-deployment id-api-container=us-docker.pkg.dev/boldreports/multi-container/bold-idp-api:$version --namespace=$namespace --record 
	kubectl set image deployment/id-ums-deployment id-ums-container=us-docker.pkg.dev/boldreports/multi-container/bold-ums:$version --namespace=$namespace --record 
	kubectl set image deployment/reports-web-deployment reports-web-container=us-docker.pkg.dev/boldreports/multi-container/boldreports-server:$version --namespace=$namespace --record 
	kubectl set image deployment/reports-api-deployment reports-api-container=us-docker.pkg.dev/boldreports/multi-container/boldreports-server-api:$version --namespace=$namespace --record 
	kubectl set image deployment/reports-jobs-deployment reports-jobs-container=us-docker.pkg.dev/boldreports/multi-container/boldreports-server-jobs:$version --namespace=$namespace --record 
	kubectl set image deployment/reports-reportservice-deployment reports-reportservice-container=us-docker.pkg.dev/boldreports/multi-container/boldreports-designer:$version --namespace=$namespace --record 
	kubectl set image deployment/reports-viewer-deployment reports-viewer-container=us-docker.pkg.dev/boldreports/multi-container/boldreports-viewer:$version --namespace=$namespace --record
	kubectl set image deployment/bold-etl-deployment bold-etl-container=us-docker.pkg.dev/boldreports/multi-container/bold-etl:$version --namespace=$namespace --record 	
fi
