# **[To force delete a custom resource](https://dev.to/mxglt/k8s-forcefully-delete-resources-4jlp)**

follow these steps :
Edit the Object : kubectl edit customresource/name.
Remove finalizer parameter.
Delete the object : kubectl delete customresource/name.

kubectl patch -n mysql-operator pod mysql-operator-7cbc8bd94d-skbnb --patch '{"metadata":{"finalizers":[]}}'

kubectl apply -f <https://raw.githubusercontent.com/mysql/mysql-operator/trunk/deploy/deploy-operator.yaml>

kubectl delete pods mysql-operator-7cbc8bd94d-skbnb --grace-period=0 --force
