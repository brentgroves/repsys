# **[Kubectl Rollout Restart: 3 Ways to Use It](https://www.loft.sh/blog/kubectl-rollout-restart-3-ways-to-use-it)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[kubectl rollout restart](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_rollout/kubectl_rollout_restart/)**

## **[Synopsis](https://kubernetes.io/docs/reference/kubectl/generated/kubectl_rollout/kubectl_rollout_restart/)**

Restart a resource.

Resource rollout will be restarted.

```bash
kubectl rollout restart RESOURCE
```

## Examples

```bash
# Restart all deployments in the test-namespace namespace
kubectl rollout restart deployment -n test-namespace

# Restart a deployment
kubectl rollout restart deployment/nginx

# Restart a daemon set
kubectl rollout restart daemonset/abc

# Restart deployments with the app=nginx label
kubectl rollout restart deployment --selector=app=nginx
```

## **[Kubectl Rollout Restart:3 Ways to Use It](https://www.loft.sh/blog/kubectl-rollout-restart-3-ways-to-use-it)**

- Kubectl rollout restart is a useful feature for updating running pods in a StatefulSet without disrupting availability.
- It can be used to deploy new applications, prevent StatefulSets from exceeding limits, and maintain a reliable environment.
- The process involves making changes to the code base, building and pushing a new docker image, and updating deployment config.
- Rollout restart can be used to restart pods one at a time in a deployment, ensuring a smooth update process.
- Third-party tools and front ends can enhance the functionality of kubectl rollout restart for more complex scenarios.

When working with kubectl and rolling out a new app version, you need to know what to do when it breaks. Taking a step back, an update is a big deal for any production deployment. You might look for a way to keep your deployments on track without having to do anything. You need to leverage kubectl rollout restart because of its ability to orchestrate a successful rolling update without disrupting existing infrastructure.

Kubectl rollout restart is one of those newer Kubernetes features that make life easier for those managing clusters at scale. If you're unfamiliar with it, this post will show you what it is and how to use it.

## Understanding the Purpose of Kubectl Rollout Restart

A rollout restart is a way to update running pods in a StatefulSet with new or updated configuration without disrupting the availability of running pods or services.

Kubectl rollout restart is what'll help solve this problem while keeping things stable. One of the most significant advantages of kubectl rollout restart is that it works as intended even in a turbulent environment. Managing dynamic environments allows managers to continue making out-of-the-box changes without worrying about downtime.

Kubectl rollout restart makes it simple to implement updates without a complete reboot in the middle of an environment. You can include the command in a scheduled job, making it easier to automate, which can be great for sporadic deployments.

## Exploring the Functionality of Rollout Restart in kubectl

Rollout Restart in kubectl:

- Rollout Process: It involves gradually recreating pods in a step-by-step manner.
- kubectl Rollout Restart Command: This command is a part of kubectl that initiates a new rollout process.
- Functionality: It allows for the management of various aspects of a rollout, with the restart command specifically used to trigger the start of a new rollout.

## Step-by-Step Guide on How to Utilize Kubectl Rollout Restart

Because kubectl rollout restart operates at a cluster level, it doesn't need to interact directly with any pods. This means you don't have to worry about modifying or destroying existing pods before beginning the update process. The process works by installing a new pod version and deploying it across your cluster, two significant advantages over rolling updates on a pod level.

While the process is simple to execute, it isn't always easy to know which step to take. In this area, kubectl rollout restart can be a little confusing. But just as with any complex feature, there can be slight differences between versions and implementations. For this reason, I'd like to walk through typical kubectl rollout restart scenarios. Most of the time, all you'll need to do is follow these steps:

- Make changes to your code base.
- Build and push a new docker image.
- Update your deployments config to use the new image.
- Run kubectl rollout restart on the deployment in question.

Let's say you have a deployment named my-nginx with two replicas. The image it's running is nginx:1.7.9, and you just pushed a new image named nginx:1.7.10 to your docker registry.

To update your deployment to use the new image, run:

```bash
kubectl set image deployment/my-nginx nginx=nginx:1.7.10 
```

This will update the deployment to use the new image.

Next, you'll need to rollout restart the deployment for the changes to take effect:

```bash
kubectl rollout restart deployment/my-nginx 
```

This will kill and restart your pods, causing them to pull and use the new image.

If there are any issues with the new image, you can always rollback to the previous image:

```bash
kubectl rollout undo deployment/my-nginx 
```
