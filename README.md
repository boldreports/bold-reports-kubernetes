<a href="https://www.boldreports.com"><img alt="boldreports" width="400" src="https://www.boldreports.com/wp-content/uploads/2019/08/bold-reports-logo.svg"></a>
<br/>
<br/>

[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/boldreports/boldreports-docker?sort=semver)](https://github.com/boldreports/bold-reports-docker/releases)
[![Documentation](https://img.shields.io/badge/docs-help.boldreports.com-blue.svg)](https://help.boldreports.com/enterprise-reporting/)
[![File Issues](https://img.shields.io/badge/file_issues-boldreports_support-blue.svg)](https://www.boldreports.com/support)

# What is Bold Reports

Bold Reports is a powerful business intelligence reporting software that helps you to get meaningful insights from your business data and make better decisions.

It is an end-to-end solution for creating, managing, and sharing interactive business reports that includes a powerful report designer for composing easily.

With deep embedding, you can interact more with your data and get insights directly from your application.

# Bold Reports on Kubernetes

## Prerequisites

The following requirements are necessary to run the Bold Reports solution.

* Kubernetes cluster
* File storage
* Microsoft SQL Server 2012+ | PostgreSQL | MySQL
* Load balancer: [Nginx](https://docs.nginx.com/nginx-ingress-controller/installation/installation-with-manifests/) or [Istio](https://istio.io/latest/docs/setup/getting-started/)
* Web Browser: Microsoft Edge, Mozilla Firefox, and Chrome.

### Deployment Methods

There are two ways to deploy Bold Reports on the Kubernetes cluster with the two types of load balancer. Please refer to the following documents for Bold Reports deployment:

* [Deploy Bold Reports using Ingress Nginx](docs/index.md)
* [Deploy Bold Reports using Istio](istio/README.md)