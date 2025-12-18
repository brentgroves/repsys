# **[Deploy Mattermost](https://docs.mattermost.com/install/install-kubernetes.html)**

**[Back to Research List](../../research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

## references

<https://docs.mattermost.com/guides/deployment.html>
<https://docs.mattermost.com/guides/deployment-guides.html>

You can install and deploy a production-ready Mattermost system on a Kubernetes cluster using the Mattermost Kubernetes Operator in practically any environment with less IT overhead and more automation.

You’ll need a Kubernetes cluster running a version that is currently supported with patch releases, Kubernetes CLI kubectl installed on local machine, and a basic understanding of Kubernetes concepts (such as deployments, pods) and actions (such as applying manifests, viewing pod logs). Running Mattermost in Kubernetes requires resources based on your total number of users. See the Mattermost Kubernetes Operator documentation to learn more about the minimum Kubernetes cluster resources Mattermost requires at different scales.

## **[Review Minikube Tutorial](./k8s_setup_tutorial.md)**

## thoughts

- Install Microk8s on repsys12 then  follow this guide to deploy mattermost.
