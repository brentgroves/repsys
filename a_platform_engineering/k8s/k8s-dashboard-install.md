# Enable the K8s dashboard

microk8s enable dashboard

## If RBAC is NOT enabled - Not recommended

If RBAC is not enabled access the dashboard using the token retrieved with:

kubectl describe secret -n kube-system microk8s-dashboard-token

Use this token in the https login UI of the kubernetes-dashboard service.

## If RBAC is enabled - Recommended

In an RBAC enabled setup (microk8s enable RBAC) you need to create a user with restricted
permissions as shown in:
<https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md>

microk8s enable dns
Addon core/dns is already enabled
microk8s enable helm3
Addon core/helm3 is already enabled
microk8s enable rbac
Enabling RBAC

## Add sample user for RBAC access to the Kubernetes dashboard

<https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/README.md>

<https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md>

### create namespace

```bash
kubectl create namespace kubernetes-dashboard

```

### create a user

```bash

# set k8s context 
scc.sh reports5.yaml microk8s

pushd /home/brent/src/reports/k8s/rbac

kubectl apply -f ./dashboard-adminuser.yaml         
serviceaccount/admin-user created
kubectl get serviceaccount --namespace kubernetes-dashboard

kubectl apply -f ./cluster-admin-binding.yaml 
clusterrolebinding.rbac.authorization.k8s.io/admin-user created
kubectl get clusterrole  | grep cluster-admin

kubectl get clusterrolebinding
kubectl get clusterrolebinding  | grep admin-user

kubectl apply -f ./admin-user-secret.yaml
kubectl get serviceaccount --namespace kubernetes-dashboard

```

## Getting a TEMPORARY Bearer Token for ServiceAccount

Now we need to find the token we can use to log in. Execute the following command:

kc -n kubernetes-dashboard create token admin-user

eyJhbGciOiJSUzI1NiIsImtpZCI6Il9uTUVVWWlqUkZJOWlnZmlWaDB0TW51UFRWNXZNem1oaDZ0dVVMREx0cjgifQ.eyJhdWQiOlsiaHR0cHM6Ly9rdWJlcm5ldGVzLmRlZmF1bHQuc3ZjIl0sImV4cCI6MTY5NjExMDA4MSwiaWF0IjoxNjk2MTA2NDgxLCJpc3MiOiJodHRwczovL2t1YmVybmV0ZXMuZGVmYXVsdC5zdmMiLCJrdWJlcm5ldGVzLmlvIjp7Im5hbWVzcGFjZSI6Imt1YmVybmV0ZXMtZGFzaGJvYXJkIiwic2VydmljZWFjY291bnQiOnsibmFtZSI6ImFkbWluLXVzZXIiLCJ1aWQiOiJiMWM4MGVjNy04ZmFhLTRjNzUtYmMxNS0xODhiMGI0ODJkYmUifX0sIm5iZiI6MTY5NjEwNjQ4MSwic3ViIjoic3lzdGVtOnNlcnZpY2VhY2NvdW50Omt1YmVybmV0ZXMtZGFzaGJvYXJkOmFkbWluLXVzZXIifQ.hz7EdRJeE0Z9rVquaOhIWHc-q0ngqnnpKRtpGutQj1UDhqulptEMG_8Dhnl-EKi_s0jgIxq-4zgAZwdJJCrvERVJXWsfLLyLXcF8SjZQxzf5QL22cx5QRnI7TVCiDkAsu2Ok5Z8i1wctKOPRt_BHB4Hn_fKrLoF2nUYCNtItzRb70qEW7NmU1zlM4VhroA2kjNZNuttTfrN7NrTVNEyilDiCzPeHn-py8Tx8mhy3u5r-MQdEfH5Mc6HEwTj0cueKbi9AQpUk8J1BFlLyBpsoPhWlsxzEDjyGE5ovCYHtEE0NyCgMFn94XYueiChWWrfUA4G0Suc_FrwNvSzh45BrUg

## Getting a long-lived Bearer Token for ServiceAccount

<https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#manually-create-a-long-lived-api-token-for-a-serviceaccount>

We can also create a token with the secret which bound the service account and the token will be saved in the Secret:

admin-user-secret.yaml

After Secret is created, we can execute the following command to get the token which saved in the Secret:

kubectl get secret admin-user -n kubernetes-dashboard -o jsonpath={".data.token"} | base64 -d

<https://172.20.88.65:30587/>
eyJhbGciOiJSUzI1NiIsImtpZCI6Il9uTUVVWWlqUkZJOWlnZmlWaDB0TW51UFRWNXZNem1oaDZ0dVVMREx0cjgifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlcm5ldGVzLWRhc2hib2FyZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJhZG1pbi11c2VyIiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImFkbWluLXVzZXIiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiJiMWM4MGVjNy04ZmFhLTRjNzUtYmMxNS0xODhiMGI0ODJkYmUiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZXJuZXRlcy1kYXNoYm9hcmQ6YWRtaW4tdXNlciJ9.eSB-41atSvuQOb27CP18uAdJOAlOBu7a4NUQQT85bsRnSWEeW0aE29yEAwyBN5Zkwtjw8gPIaykiaNz4E1cm_F3B8cJRGSjxK3y2lJMiGWXN4Crh516PCQbouqTD6ZDsT2YSz3n4R_tsyhSOgtQGCP7_Dxp7sGhqhApz1ji9YT6pb8F8BGs7ZcKr1NHT-N1nJRhSsUtGIQU2I1Gcgn8lB4lf3XpLDO4hNoRp-riKYn9_SzA_EeJ4alcB4psBjMsmQptcuzdWheD426x8A3eRJSuJ0IBY5Qvc9q_m4PY0W81FXmZJTgJ-smOrsifN0cnE1QCmKI4c6IFyYKzv6I9Zrg

Check Kubernetes docs for more information about long-lived API tokens for a ServiceAccount.

Accessing Dashboard
Now copy the token and paste it into the Enter token field on the login screen.
Access the Dashboard
The Microk8s dashboard isn’t exposed externally by default. To access it, we’ll use a secure channel called a Kubernetes proxy. Run the following command:

microk8s dashboard-proxy
or

## change svc to nodeport

So you don't have to keep running the dashboard-proxy you can change the service from clusterip to nodeport

<https://medium.com/@satyakommula/deploy-kubernetes-dashboard-with-nodeport-382f447d2ff8>
kubectl get svc kubernetes-dashboard -n kube-system
NAME                   TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
kubernetes-dashboard   ClusterIP   10.152.183.19   <none>        443/TCP   22h

kubectl patch service kubernetes-dashboard -n kube-system -p '{"spec": {"type": "NodePort"} }'
service/kubernetes-dashboard patched

kubeclt get svc kubernetes-dashboard -n kube-system
NAME                   TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)         AGE
kubernetes-dashboard   NodePort   10.152.183.19   <none>        443:30587/TCP   22h

## access dashboard using nodeport svc

<https://172.20.88.65:30587>

kubectl describe svc kubernetes-dashboard -n kube-system
