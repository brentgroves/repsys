# **[Secret discovery service (SDS)](https://www.envoyproxy.io/docs/envoy/latest/configuration/security/secret)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

TLS certificates, the secrets, can be specified in the bootstrap.static_resource **[secrets](https://www.envoyproxy.io/docs/envoy/latest/api-v3/config/bootstrap/v3/bootstrap.proto#envoy-v3-api-field-config-bootstrap-v3-bootstrap-staticresources-secrets)**. But they can also be fetched remotely by secret discovery service (SDS).

The most important benefit of SDS is to simplify the certificate management. Without this feature, in k8s deployment, certificates must be created as secrets and mounted into the proxy containers. If certificates are expired, the secrets need to be updated and the proxy containers need to be re-deployed. With SDS, a central SDS server will push certificates to all Envoy instances. If certificates are expired, the server just pushes new certificates to Envoy instances, Envoy will use the new ones right away without re-deployment.

If a listener server certificate needs to be fetched by SDS remotely, it will NOT be marked as active, its port will not be opened before the certificates are fetched. If Envoy fails to fetch the certificates due to connection failures, or bad response data, the listener will be marked as active, and the port will be open, but the connection to the port will be reset.
