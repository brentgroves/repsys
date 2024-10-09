# **[Guide to using OpenVPN to access servers in your VPC](https://medium.com/@martin.hodges/automatic-creation-of-kubernetes-cluster-on-binary-lane-747cdd9b9918)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

An OpenVPN server can provide secure access to your cloud servers that are isolated from the Internet

In a **[previous series of articles](https://medium.com/@martin.hodges/use-terraform-ansible-and-github-actions-to-automate-running-your-spring-boot-application-on-1fa20d795643)** I showed you how to create a Kubernetes cluster using Terraform and Ansible on a set of Binary Lane servers. This article looks at how to make this more secure using an OpenVPN server.
