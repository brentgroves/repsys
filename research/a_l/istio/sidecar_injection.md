# **[Sidecar Injection](https://istio.io/latest/docs/setup/additional-setup/sidecar-injection/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## Installing the Sidecar

In order to take advantage of all of Istio’s features, pods in the mesh must be running an Istio sidecar proxy.

The following sections describe two ways of injecting the Istio sidecar into a pod: enabling automatic Istio sidecar injection in the pod’s namespace, or by manually using the istioctl command.

When enabled in a pod’s namespace, automatic injection injects the proxy configuration at pod creation time using an admission controller.

Manual injection directly modifies configuration, like deployments, by adding the proxy configuration into it.

If you are not sure which one to use, automatic injection is recommended.

## Automatic sidecar injection

Sidecars can be automatically added to applicable Kubernetes pods using a **[mutating webhook admission controller](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/)** provided by Istio.

While admission controllers are enabled by default, some Kubernetes distributions may disable them. If this is the case, follow the instructions to **[turn on admission controllers](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#how-do-i-turn-on-an-admission-controller)**.

## Which plugins are enabled by default?

To see which admission plugins are enabled:

```bash
kube-apiserver -h | grep enable-admission-plugins
```

### **[microk8s way](https://microk8s.io/docs/configuring-services)**

```bash
cat /var/snap/microk8s/current/args/kube-apiserver
--cert-dir=${SNAP_DATA}/certs
--service-cluster-ip-range=10.152.183.0/24
--authorization-mode=RBAC,Node
--service-account-key-file=${SNAP_DATA}/certs/serviceaccount.key
--client-ca-file=${SNAP_DATA}/certs/ca.crt
--tls-cert-file=${SNAP_DATA}/certs/server.crt
--tls-private-key-file=${SNAP_DATA}/certs/server.key
--tls-cipher-suites=TLS_AES_128_GCM_SHA256,TLS_AES_256_GCM_SHA384,TLS_CHACHA20_POLY1305_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256,TLS_ECDHE_RSA_WITH_3DES_EDE_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305,TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256,TLS_RSA_WITH_3DES_EDE_CBC_SHA,TLS_RSA_WITH_AES_128_CBC_SHA,TLS_RSA_WITH_AES_128_GCM_SHA256,TLS_RSA_WITH_AES_256_CBC_SHA,TLS_RSA_WITH_AES_256_GCM_SHA384
--kubelet-client-certificate=${SNAP_DATA}/certs/apiserver-kubelet-client.crt
--kubelet-client-key=${SNAP_DATA}/certs/apiserver-kubelet-client.key
--secure-port=16443
--etcd-servers="unix://${SNAP_DATA}/var/kubernetes/backend/kine.sock:12379"
--allow-privileged=true
--service-account-issuer='https://kubernetes.default.svc'
--service-account-signing-key-file=${SNAP_DATA}/certs/serviceaccount.key
--event-ttl=5m
--profiling=false

# Enable the aggregation layer
--requestheader-client-ca-file=${SNAP_DATA}/certs/front-proxy-ca.crt
--requestheader-allowed-names=front-proxy-client
--requestheader-extra-headers-prefix=X-Remote-Extra-
--requestheader-group-headers=X-Remote-Group
--requestheader-username-headers=X-Remote-User
--proxy-client-cert-file=${SNAP_DATA}/certs/front-proxy-client.crt
--proxy-client-key-file=${SNAP_DATA}/certs/front-proxy-client.key
#~Enable the aggregation layer
--enable-admission-plugins=EventRateLimit
--admission-control-config-file=${SNAP_DATA}/args/admission-control-config-file.yaml
--kubelet-certificate-authority=${SNAP_DATA}/certs/ca.crt
--kubelet-preferred-address-types=InternalIP,Hostname,InternalDNS,ExternalDNS,ExternalIP
```

You can go to /var/snap/microk8s/current/args/kube-apiserver then you can add the PodNodeSelector admission controller.
Ex.
--enable-admission-plugins=PodNodeSelector

From there you can apply the admission controller manifest as described here.
<https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#podnodeselector>

```

In Kubernetes 1.31, the default ones are:

CertificateApproval, CertificateSigning, CertificateSubjectRestriction, DefaultIngressClass, DefaultStorageClass, DefaultTolerationSeconds, LimitRanger, MutatingAdmissionWebhook, NamespaceLifecycle, PersistentVolumeClaimResize, PodSecurity, Priority, ResourceQuota, RuntimeClass, ServiceAccount, StorageObjectInUseProtection, TaintNodesByCondition, ValidatingAdmissionPolicy, ValidatingAdmissionWebhook
