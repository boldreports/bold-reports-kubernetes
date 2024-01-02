<a href="https://www.boldreports.com"><img alt="boldreports" width="400" src="https://www.boldreports.com/wp-content/uploads/2019/08/bold-reports-logo.svg"></a>
<br/>
<br/>

[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/boldreports/bold-reports-kubernetes?sort=semver)](https://github.com/boldreports/bold-reports-kubernetes/releases)
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

There are two ways to deploy Bold Reports on the Kubernetes cluster. Please refer to the following documents for Bold Reports deployment:

* [Deploy Bold Reports using Kubectl](docs/index.md)
* [Deploy Bold Reports using Helm](helm/README.md)

# License

https://www.boldreports.com/terms-of-use/on-premise<br />

The images are provided for your convenience and may contain other software that is licensed differently (Linux system, Bash, etc. from the base distribution, along with any direct or indirect dependencies of the Bold Reports platform).

These pre-built images are provided for convenience and include all optional and additional libraries by default. These libraries may be subject to different licenses than the Bold Reports product.

If you want to install Bold Reports from scratch and precisely control which optional libraries are installed, please download the stand-alone product from boldreports.com. If you have any questions, please contact the Bold Reports team (https://www.boldreports.com/support).

It is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.

## FAQ

[How to auto deploy Bold Reports in Kubernetes cluster?](https://github.com/boldreports/bold-reports-kubernetes/blob/main/docs/bold-reports-auto-deployment.md)

[How to deploy Bold Reports in Elastic Kubernetes Services (EKS) using Application Load Balancer (ALB)?](https://github.com/boldreports/bold-reports-kubernetes/blob/main//docs/FAQ/how-to-deploy-bold-reports-in-eks-using-application-load-balancer.md)