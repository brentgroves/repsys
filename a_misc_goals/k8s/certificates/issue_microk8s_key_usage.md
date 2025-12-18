# **[root CA certificate does not include key usage extension #4864](https://github.com/canonical/microk8s/issues/4864)**

## issue

```bash
kubectl get all --namespace mysql-operator                            
NAME                                  READY   STATUS             RESTARTS        AGE
pod/mysql-operator-7cbc8bd94d-v2n9k   0/1     CrashLoopBackOff   8 (3m10s ago)   27m

kubectl logs mysql-operator-7cbc8bd94d-v2n9k --namespace=mysql-operator
[2025-04-01 22:22:07,482] kopf._core.reactor.o [ERROR   ] Request attempt #8/9 failed; will retry: GET <https://10.152.183.1:443/apis> -> ClientConnectorCertificateError(ConnectionKey(host='10.152.183.1', port=443, is_ssl=True, ssl=True, proxy=None, proxy_auth=None, proxy_headers_hash=None), SSLCertVerificationError(1, '[SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: CA cert does not include key usage extension (_ssl.c:1020)'))
```

## Summary

The root CA certificate that is generated does not have the keyUsage defined (see <https://github.com/canonical/microk8s/blob/master/microk8s-resources/actions/common/utils.sh#L689>)

```bash
    # Generate apiserver CA
    if ! [ -f ${SNAP_DATA}/certs/ca.crt ]; then
        "${SNAP}/openssl.wrapper" req -x509 -new -sha256 -nodes -days 3650 -key ${SNAP_DATA}/certs/ca.key -subj "/CN=10.152.183.1" -out ${SNAP_DATA}/certs/ca.crt
    fi

    # Generate front proxy CA
    if ! [ -f ${SNAP_DATA}/certs/front-proxy-ca.crt ]; then
        "${SNAP}/openssl.wrapper" req -x509 -new -sha256 -nodes -days 3650 -key ${SNAP_DATA}/certs/front-proxy-ca.key -subj "/CN=front-proxy-ca" -out ${SNAP_DATA}/certs/front-proxy-ca.crt
    fi
```

an example CA cert extension has:

## start_here
