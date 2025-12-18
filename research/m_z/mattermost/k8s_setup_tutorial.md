# **[Create your own Mattermost instance on Kubernetes in 10 minutes](https://medium.com/@Erez.Tamam/create-your-own-mattermost-instance-on-kubernetes-in-10-minutes-d13f576ed794)**

## references

<https://www.restack.io/docs/mattermost-knowledge-mattermost-kubernetes-operator>

If you don’t know what Mattermost is, it’s a collaboration tool for teams built for developers.

## Deploying Mattermost

You want to try out Mattermost, but dont have sufficent Infrastructure or the time? Here is a guide on how to deploy Mattermost using minikube in five minutes.

Pre-requisites
You’ll need to do the following four things before starting off with minikube:

Enable virtualization in your BIOS. Note that every installation may have a different approach for this.
Install minikube.
Install a supported driver from the minikube site. I used VirtualBox.
Install helm using the supported install method.
Create your own minikube Cluster
In this step we’ll create a minikube cluster in order to have a local Kubernetes installation, and enable ingress on it (so we can access Mattermost later).

minikube start --driver=virtualbox --kubernetes-version 1.23.10 --cpus=6
minikube addons enable ingress
