# **[port/targetport/nodeport](<https://www.bmc.com/blogs/kubernetes-port-targetport-nodeport/>**

- **Port** exposes the Kubernetes service on the specified port within the cluster. Other pods within the cluster can communicate with this server on the specified port.
- **TargetPort** is the port on which the service will send requests to, that your pod will be listening on. Your application in the container will need to be listening on this port also.
- **NodePort** exposes a service externally to the cluster by means of the target nodes IP address and the NodePort. NodePort is the default setting if the port field is not specified.

```yaml
---
apiVersion: v1
kind: Service
metadata:
  name: mssql-service
  namespace: mssql
spec:
  type: NodePort
  selector:
    app: mssql
  ports:
  - protocol: TCP
    # NodePort exposes a service externally to the cluster by means of
    # the target nodes IP address and the NodePort. NodePort is the default setting if the port field is not specified.
    nodePort: 31433
    # Port exposes the Kubernetes service on the specified port within the cluster. Other pods within 
    # the cluster can communicate with this server on the specified port.
    port: 1433
    targetPort: 1433
    # TargetPort is the port on which the service will send requests to, that your pod will be listening on. Your application 
    # in the container will need to be listening on this port also.
```
