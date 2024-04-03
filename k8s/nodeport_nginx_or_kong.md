# Nodeport, NGinx, or Kong Ingress

- Kong is an API server and has features such as throttling and IAM and uses the newer K8s Ingress technology.

- NGinx alone can take care of secure TLS certificate connection.  If you use it there is a way to pass-through TCP such as that used by database connections.

- Nodeport can be used to pass-through any TCP data and can be used to access MySQL or other database.

## Load Balancer

The MetalLb Lv 4 Load balancer can pass external network traffic into the K8s cluster to the NGinx ingress controller.  




