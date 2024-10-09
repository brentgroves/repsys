# **[Spring Boot CI/CD on Kubernetes using Terraform, Ansible and GitHub: Part 1](https://medium.com/@martin.hodges/use-terraform-ansible-and-github-actions-to-automate-running-your-spring-boot-application-on-1fa20d795643)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

Introduction to creating a CI/CD pipeline on Kubernetes in the cloud
This series of articles I take you on a journey to create a Spring Boot application that runs on a Kubernetes cluster. I start by creating the cloud servers you need using Infrastructure as Code tools such as Terraform and Ansible and then build up the layers to complete a CI/CD pipeline, including GitHub and ArgoCD.

## Introduction to the series

In the many years I have been leading software development teams, there is one thing I have noticed:

Software developers never do something more than once. If they have to do it a second time — they automate it!

And so it was when I came to build another Kubernetes cluster. I wanted to automate as much as I could so I could set up and tear down clusters quickly and easily. I decided that I would document my journey for you to follow.

This is not for total beginners.

I have written it for software developers that have at least basic experience with Linux, Java, PostgreSQL, Spring Boot and Git but who may not be familiar with some of the other technology I have mentioned above.
