# **[Kubernetes Service Account: What It Is and How to Use It](https://www.loft.sh/blog/kubernetes-service-account-what-it-is-and-how-to-use-it)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

Kubernetes provides a few authentication and authorization methods. It comes with a built-in account management solution, but it should be integrated with your own user management system like Active Directory or LDAP. User management is one thing, but there is also a whole additional layer of non-human access. Think about CI/CD access to the cluster, pods-to-pods communication, or pods to Kubernetes API authentication. For these use cases, Kubernetes offers so-called "service accounts," and in this post, you'll learn what they are and how to use them.

## What Are Kubernetes Service Accounts?

Whenever you access your Kubernetes cluster with kubectl, you are authenticated by Kubernetes with your user account. User accounts are meant to be used by humans. But when a pod running in the cluster wants to access the Kubernetes API server, it needs to use a service account instead. Service accounts are just like user accounts but for non-humans.

## Why Do Kubernetes Service Accounts Exist?

Why do Kubernetes Service Accounts exist? The simple answer is because pods are not humans, so it's good to have a distinction from user accounts. It's especially important for security reasons. Also, once you start using an external user management system with Kubernetes, it becomes even more important since all your users will probably follow typical <firstname.lastname@your-company.com> usernames.

But, you may wonder, why would pods inside the Kubernetes cluster need to connect to the Kubernetes API at all? Well, there are multiple use cases for it. The most common one is when you have a CI/CD pipeline agent deploying your applications to the same cluster. Many cloud-native tools also need access to your Kubernetes API to do their jobs, such as logging or monitoring applications.

## Default Service Account

You now know what service accounts are and why would you need one. Let's discuss how to use them. The first thing you need to know is that you have probably already used service accounts even if you never configured any. That's because Kubernetes comes with a predefined service account called "default." And by default, every created pod has that service account assigned to it. Let's validate that. I'll create a simple nginx deployment:

```bash
kubectl create deployment nginx1 --image=nginx deployment.apps/nginx1 created 
```

Now, let's see the details of the deployed pod:

```bash
kubectl get pods 
NAME READY STATUS RESTARTS AGE 
nginx1-585f98d7bf-84rxg 1/1 Running 0 12s 

kubectl get pod nginx1-585f98d7bf-84rxg -o yaml 

apiVersion: v1 kind: Pod metadata: (...) spec: containers: - image: nginx (...) serviceAccount: default serviceAccountName: default
```

## OK, What Does It Mean?

So, it turns out that your pods have the default service account assigned even when you don't ask for it. This is because every pod in the cluster needs to have one (and only one) service account assigned to it. What can your pod do with that service account? Well, pretty much nothing. That default service account doesn't have any permissions assigned to it.

We can validate that as well. Let's get into our freshly deployed nginx pod and try to connect to a Kubernetes API from there. For that, we'll need to export a few environment variables and then use the curl command to send an HTTP request to the Kubernetes API.

```bash
# Export the internal Kubernetes API server hostname 
$ APISERVER=https://kubernetes.default.svc # Export the path to ServiceAccount mount directory 
$ SERVICEACCOUNT=/var/run/secrets/kubernetes.io/serviceaccount # Read the ServiceAccount bearer token 
$ TOKEN=$(cat ${SERVICEACCOUNT}/token) # Reference the internal Kubernetes certificate authority (CA) 
$ CACERT=${SERVICEACCOUNT}/ca.crt # Make a call to the Kubernetes API with TOKEN 
$ curl --cacert ${CACERT} --header "Authorization: Bearer ${TOKEN}" -X GET ${APISERVER}/api/v1/namespaces/default/pods { "kind": "Status", "apiVersion": "v1", "metadata": {}, "status": "Failure", "message": "pods is forbidden: User \"system:serviceaccount:default:default\" cannot list resource \"pods\" in API group \"\" in the namespace \"default\"", "reason": "Forbidden", "details": { "kind": "pods" }, "code": 403 }#
```

## As you can see, the default service account indeed doesn't have many permissions. It's really only there to fulfil the requirement that each pod has a service account assigned to it

## Creating Your Own Service Accounts

So, if you want your pod to actually be able to talk to the Kubernetes API and do something, you have two options. You either need to assign some permissions to the default service account, or you need to create a new service account. The first option is not recommended. In fact, you shouldn't use the default service account for anything. Let's choose the recommended option then, which is creating dedicated service accounts. It's also worth mentioning here that, just like with user access, you should create separate service accounts for separate needs.

The easiest way to create a service account is by executing the kubectl create serviceaccount command followed by a desired service account name.

```bash
kubectl create serviceaccount nginx-serviceaccount serviceaccount/nginx-serviceaccount created 
```

Just like with anything else in Kubernetes, it's worth knowing how to create one using the YAML definition file. In the case of service accounts, it's actually really simple and looks like this:

```yaml
apiVersion: v1 kind: ServiceAccount metadata: name: nginx-serviceaccount 
```

I'll save it as nginx-sa.yaml and apply that simple YAML file using kubectl apply -f nginx-sa.yaml:

```bash
kubectl apply -f nginx-sa.yaml serviceaccount/nginx-serviceaccount created
```

You can see from the output above that a service account was created, but you can double-check that with kubectl get serviceaccounts, or kubectl get as for short.

```bash
$ kubectl get serviceaccounts 
NAME SECRETS AGE 
default 1 3h14m 
nginx-serviceaccount 1 72s 
kubectl get sa 
NAME SECRETS AGE 
default 1 3h14m 
nginx-serviceaccount 1 112s 
```

## Assigning Permissions to a Service Account

OK, you created a new service account for your pod, but by default, it won't do much more than the default service account (called "default") that you saw previously. To change that, you can use the standard Kubernetes role-based access control mechanism. This means that you can either use existing role or create a new one (or ClusterRole) and then use RoleBinding to bind a role with your new ServiceAccount.

For the purpose of the demo, you can assign a built-in Kubernetes ClusterRole called "view" that allows viewing all resources. You then need to create a RoleBinding for your Service Account.

```yaml
kubectl create rolebinding nginx-sa-readonly \ 
--clusterrole=view \ 
--serviceaccount=default:nginx-serviceaccount \
 --namespace=default 
```

Now, any pod using the new ServiceAccount should be able to view all resources in the default namespace. To validate that, you can perform the same test you did earlier, but first you need to assign that ServiceAccount to your nginx pod.

## Specifying ServiceAccount For Your Pod

As mentioned previously, if you don't specify any service account for your pod, it will be assigned a "default" service account. You just created a new service account for your needs, so you'll want to use that one instead. For that, you need to pass the service account name as the value for serviceAccountName key in a spec section of your deployment definition file.

```yaml
apiVersion: apps/v1 kind: Deployment metadata: name: nginx1 labels: app: nginx1 spec: replicas: 2 selector: matchLabels: app: nginx1 template: metadata: labels: app: nginx1 spec: serviceAccountName: nginx-serviceaccount containers: - name: nginx1 image: nginx ports: - containerPort: 80
```

That's it. Now, after applying this definition, you can try to perform the same test as before from within the pod.

```bash
curl --cacert ${CACERT} --header "Authorization: Bearer ${TOKEN}" -X GET ${APISERVER}/api/v1/namespaces/default/pods { "kind": "PodList", "apiVersion": "v1", "metadata": { "resourceVersion": "52233" }, "items": [ { "metadata": { "name": "nginx1-65448895f9-5j6b6", "generateName": "nginx1-65448895f9-", "namespace": "default", "uid": "b09bfa93-a388-4cd9-9495-131f620613d0", "resourceVersion": "49536", (...) 
```

And as expected, now it works fine. If, for any reason, your pods need access to a Kubernetes API, you create a new ServiceAccount for it, then assign a role or ClusterRole to it via RoleBinding, then specify the ServiceAccount name in your deployment.
