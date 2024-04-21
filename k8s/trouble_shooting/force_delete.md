# **[To force delete a custom resource](https://dev.to/mxglt/k8s-forcefully-delete-resources-4jlp)**
follow these steps :
Edit the Object : kubectl edit customresource/name.
Remove finalizer parameter.
Delete the object : kubectl delete customresource/name.