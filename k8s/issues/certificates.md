# **[root CA certificate does not include key usage extension](https://github.com/canonical/microk8s/issues/4864)**

Summary
The root CA certificate that is generated does not have the keyUsage defined (see <https://github.com/canonical/microk8s/blob/master/microk8s-resources/actions/common/utils.sh#L689>)

```golang
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

    X509v3 extensions:
        X509v3 Subject Key Identifier: 
            0E:EF:10:1C:40:F6:85:87:76:23:A4:40:C7:D7:73:41:AB:F4:9E:A8
        X509v3 Authority Key Identifier: 
            0E:EF:10:1C:40:F6:85:87:76:23:A4:40:C7:D7:73:41:AB:F4:9E:A8
        X509v3 Basic Constraints: critical
            CA:TRUE

Python 3.13 now has:

Changed in version 3.13: The context now uses **[VERIFY_X509_PARTIAL_CHAIN](https://docs.python.org/3/library/ssl.html#ssl.VERIFY_X509_PARTIAL_CHAIN)** and **[VERIFY_X509_STRICT](https://docs.python.org/3/library/ssl.html#ssl.VERIFY_X509_STRICT)** in its default verify flags.

An example error, when running kopf via python 3.13, sees:

```bash
[2025-02-11 21:16:16,609] kopf._core.reactor.o [ERROR ] Request attempt #9/9 failed; escalating: GET https://10.152.183.1:443/api -> ClientConnectorCertificateError(ConnectionKey(host='10.152.183.1', port=443, is_ssl=True, ssl=True, proxy=None, proxy_auth=None, proxy_headers_hash=None), SSLCertVerificationError(1,
'[SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: CA cert does not include key usage extension (_ssl.c:1028)'))
```

In order to workaround this issue, the strict setting must be removed in order to establish an SSL connection to microk8s with the CA certificate, which is not ideal (there could be multiple packages, for example, kopf, kubernetes client, etc), and less secure.

## What Should Happen Instead?

Generate a CA certificate with keyUsage defined.

Is there another way to update the openssl.cnf file and its defaults? I see in:

<https://github.com/canonical/microk8s/blob/master/microk8s-resources/wrappers/openssl.wrapper#L9C1-L10C1>

and it refers to
`export OPENSSL_CONF="${SNAP}/etc/ssl/openssl.cnf"`

however, I don't believe this is a file that users can update/modify.

In case anyone else hits this, I resolved it by creating and installing a CA:

```bash
# copied both our root certificate and private key to ca.crt and ca.key on k8s node.

sudo ls -al /var/snap/microk8s/7964/certs-backup/certs/ca.crt
verified the old cert had no key usage data


cd ~
microk8s.refresh-certs cadir
sudo microk8s.refresh-certs cadir
Validating provided certificates
Taking a backup of the current certificates under /var/snap/microk8s/7964/certs-backup/
Installing provided certificates
Signature ok
subject=C = GB, ST = Canonical, L = Canonical, O = Canonical, OU = Canonical, CN = 127.0.0.1
Getting CA Private Key
Creating new kubeconfig file
Restarting service kubelite.
Restarting service cluster-agent.

    The CA certificates have been replaced. Kubernetes will restart the pods of your workloads.
    Any worker nodes you may have in your cluster need to be removed and re-joined to become
    aware of the new CA.

cat /var/snap/microk8s/current/certs/ca.crt
# check it at https://crt.sh/lintcert
# certificate was replaced.
cat /var/snap/microk8s/current/certs/ca.key
# same as our own private key

```

## Replace kubeconf file

```bash
# kubectl patch -n {namespace} deploy {deployment name} --patch '{"metadata":{"finalizers":[]}}'

kubectl patch -n mysql-operator pod mysql-operator-7cbc8bd94d-skbnb --patch '{"metadata":{"finalizers":[]}}'

# kubectl delete -n {namespace} deploy {deployment name}
```
