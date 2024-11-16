# **[Kubectl Proxy](https://www.loft.sh/blog/kubectl-get-context-its-uses-and-how-to-get-started)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## What Is Kubectl Config

The kubectl utility is a command line interface (CLI) for interacting with Kubernetes. You can use it to manage Kubernetes resources such as pods, services, and deployments. To install kubectl, you simply need the run the commands as per the **[installation guide](https://kubernetes.io/docs/tasks/tools/#kubectl)**.

If you're new to Kubernetes, the following resources can help you learn about the platform and how to get started. The **[Kubernetes documentation](https://kubernetes.io/docs/home/)** is a comprehensive resource that covers all aspects of Kubernetes. It includes conceptual guides, installation instructions, and usage examples.

The kubectl config file is a configuration file that stores all the information necessary to interact with a Kubernetes cluster. It contains the following information:

- The name of the Kubernetes cluster
- The location of the Kubernetes API server
- The credentials (username and password) for authenticating with the Kubernetes API server
- The names of all contexts defined in the cluster

In the next sections, we'll focus on one particular use case of the kubectl command: managing Kubernetes contexts.

## Viewing the Kubernetes Configuration

To view the config file, you can use the following command:

```bash
kubectl config view 
```

The output of this command is shown below.

![cv](https://cdn.prod.website-files.com/65a5be30bf4809bb3a2e8aff/65de78011d29efa6c76d0827_codeblock7.png)

Figure: The output of kubectl config view command

As you can see, this Kubernetes config file contains information about the clusters, contexts, and users that kubectl can access.

- The apiVersion defines the version of the config file.
- The clusters section contains information about the Kubernetes clusters that kubectl can access.
- The contexts section contains information about the contexts that kubectl can access.
- The current-context field specifies the context that kubectl is currently using.
- The users section contains information about the users that kubectl can access.

A Kubernetes context is a group of access parameters that define which cluster you're interacting with, which user you're using, and which namespace you're working in. It's helpful if you need to access different clusters for different purposes or if you want to limit your access to certain parts of a cluster. For example, if you have multiple Kubernetes clusters, each with its own set of users and permissions, you can use kubectl config use-context to switch between them.

## How To Use Kubernetes Contexts

The `kubectl config get-contexts` is a command that retrieves information about the current Kubernetes context. This command is part of the kubectl utility, which interacts with Kubernetes clusters. When you first install Kubernetes, a default context is created for you. This context points to a local Kubernetes cluster running on your development machine. If you want to work with multiple Kubernetes clusters, you can create additional contexts.

## Finding the Current Context in Kubectl

To find the current context, you can simply run the following command:

```bash
kubectl config current-context 
```

It will print the name of the current context in kubectl. The screenshot below shows the output.

![cc](https://cdn.prod.website-files.com/65a5be30bf4809bb3a2e8aff/65de78011d29efa6c76d0818_codeblock6.png)

Figure: The output of kubectl config current-context command

You can switch between these contexts by using the kubectl config use-context command. You can create additional contexts if you want to work with multiple Kubernetes clusters. For example, you might have a context for each of the following:

- Your local Kubernetes cluster
- A staging Kubernetes cluster
- A production Kubernetes cluster

## Listing Kubernetes Contexts

As I mentioned above, the kubectl config get-contexts command can be used to list all of the available Kubernetes contexts. To do this, simply run the following command in the terminal window:

```bash
kubectl config get-contexts 
```

It will print out a list of all the available contexts in your Kubernetes configuration as well as the currently active context. By default, the active context is marked with an asterisk.

![gc](https://cdn.prod.website-files.com/65a5be30bf4809bb3a2e8aff/65de78011d29efa6c76d0811_codeblock5.png)

Figure: The output of kubectl config get-contexts command

By default, Kubernetes uses the default context. However, you can create and use multiple contexts if you have multiple Kubernetes clusters.

## Viewing Kubernetes Context Information

In addition to listing the available contexts, the `kubectl get context` command can also be used to view information about a specific context. To do this, simply specify the name of the context you want to view:

`kubectl get context staging`

Replace `<contextname>` with the name of the context you want to switch to. For example, if you're going to switch to the _staging context, you would type the following:

`kubectl get context staging`

It will print out information such as the cluster name, username of the author or creator, and namespace for the specified context.

![gc](https://cdn.prod.website-files.com/65a5be30bf4809bb3a2e8aff/65de78011d29efa6c76d080e_codeblock4.png)

Figure: The output of the kubectl config get-contexts command

## Creating a new Context

The kubectl config set-context command is used to create a new context in a kubeconfig file.

```bash
kubectl config set-context <context-name> --namespace=<namespace-name> --user=<user-name> --cluster=<cluster-name> 
```

Here `<context-name>` is the new context you want to create, `<namespace-name>` is the namespace that this context should point to, `<user-name>` is the user that you want to authenticate as, and `<cluster-name>` is the name of the Kubernetes cluster.

For example, the following command will create a new context named staging that points to a staging Kubernetes cluster:

```bash
kubectl config set-context staging --cluster=staging --namespace=staging --user=staging-admin 
```

The output of the above command is shown below:

![sc](https://cdn.prod.website-files.com/65a5be30bf4809bb3a2e8aff/65de78011d29efa6c76d07fc_codeblock.png)

Figure: The output of the kubectl config use-context command

As you can see, the command above switched the current context to a context named staging. You can verify this by running the kubectl config current-context as in the above screenshot.

## Best Practices When Using 'kubectl config set-context'

Switching between contexts is common when working with Kubernetes. You can set aliases for your most frequently used contexts to make it easier. For example, you could define an alias in your ~/.bashrc file or your shell configuration file as shown below.

```bash
alias k8s-prod='kubectl config use-context production' 
```

This is a simple way to shorten the command you would use to switch to the production context. After that, instead of typing the complete command, you can just type in the command k8s-prod to switch to the production context.

![sc](https://cdn.prod.website-files.com/65a5be30bf4809bb3a2e8aff/65de78011d29efa6c76d07f9_switching.png)

## Deleting a Kubernetes Context

The kubectl delete context command is used to delete an existing context from a kubeconfig file. This command has the following syntax:

```bash
kubectl config delete-context <context-name> 
```

Here is the name of the context that you want to delete.

For example:

`kubectl config delete-context demo`

The above command will delete the context named demo from the current Kubernetes configuration. The below screenshot shows the output.

![dc](https://cdn.prod.website-files.com/65a5be30bf4809bb3a2e8aff/65de78011d29efa6c76d0824_codeblock3.png)

Figure: The output of kubectl config delete-context command

## Conclusion

In this article, we covered the kubectl command line tool. We started by showing you the kubectl config get-contexts command. This command is used to list and view Kubernetes contexts. Next, we looked at the kubectl config set-context command. This command allows you to switch between Kubernetes contexts. Next, we looked at the kubectl config create-context command. This command allows you to create custom contexts in your kubeconfig file. Finally, we looked at how to delete a context using the kubectl config delete-context command.

As you can see, the kubectl command is a versatile tool that can be used in many ways. Whether you're looking to list, view, or switch between Kubernetes contexts, this command has you covered. To get the complete list of options for this command, take a look at the official reference for this tool and start using it today!
