# **[tls](https://docs.konghq.com/kubernetes-ingress-controller/3.3.x/guides/services/tls/)**

## TLS Termination / Passthrough

### Gateway API

The Gateway API supports both **[TLS termination](https://gateway-api.sigs.k8s.io/guides/migrating-from-ingress/#tls-termination)** and TLS passthrough. TLS handling is configured via a combination of a Gateway’s listeners[].tls.mode and the attached route type:
