# **[⎈ A Hands-On Guide to Kubernetes RBAC With a User Creation 🛠️](https://medium.com/@muppedaanvesh/a-hand-on-guide-to-kubernetes-rbac-with-a-user-creation-%EF%B8%8F-1ad9aa3cafb1)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

a Kubernetes cluster, managing access control is crucial for maintaining security and ensuring that only authorized users have access to resources. Kubernetes RBAC (Role-Based Access Control) provides a powerful mechanism for controlling access to Kubernetes resources based on roles and permissions.

In this article, we’ll explore Kubernetes RBAC in detail, covering its components, how to define roles and permissions, best practices, and advanced examples.

![rbac](https://miro.medium.com/v2/resize:fit:720/format:webp/1*9Mu6GHHpxX4KgA9vdaTXKQ.gif)

## reference

<https://stackoverflow.com/questions/57004093/how-to-retrieve-current-user-granted-rbac-with-kubectl>
<https://stackoverflow.com/questions/51238988/how-to-check-whether-rbac-is-enabled-using-kubectl>

```bash
# if RBAC is enabled you should see the API version .rbac.authorization.k8s.io/v1.
kubectl api-versions
kubectl get roles -n rabbitmq-system
NAME                                    CREATED AT
rabbitmq-cluster-leader-election-role   2024-09-05T21:54:01Z

kubectl get role $ADMIN -o yaml
```
