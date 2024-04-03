# Ingress choices

## references

<https://emrah-t.medium.com/kong-api-gateway-with-microservices-part-i-how-to-install-and-config-kong-on-kubernetes-9e196621d757>

## Kong, NGinx, or nodeport

I believe both can be made to run at the same time but have not tested that.

- **[Kong](./metalb-kong-install.md)** is an API server and has features such as throttling and IAM and uses the newer K8s Ingress technology and is built on top of NGinx. There are **[2 ways to install](./kong/)** this of which the experimental install adds additional functionality and features not a part of the standard install.

- **[NGinx](./metalb-ingress-install.md)** alone can take care of secure TLS certificate connection.  If you use it there is a way to pass-through TCP such as that used by database connections.

- Nodeport can be used to pass-through any TCP data and can be used to access MySQL or other database. Nodeport can be used no matter which Ingress Controller you select.
