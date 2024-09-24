# **[Private CA](https://istio.io/latest/docs/tasks/traffic-management/ingress/secure-ingress/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## references

<https://istio.io/latest/docs/tasks/traffic-management/ingress/secure-ingress/>
<https://github.com/istio/istio/tree/release-1.23/samples/httpbin>
<https://github.com/istio/istio/issues/29366>

Hi @xulingqing @yangminzhu I have found a solution:
Install Istio 1.9.1 using istio operator
The configuration file (istio-operator) contains

```yaml
apiVersion: install.istio.io/v1alpha1
kind: IstioOperator
metadata:
  namespace: istio-system
  name: example-istiocontrolplane
spec:
  profile: demo
  meshConfig:
    accessLogEncoding: TEXT
    accessLogFile: "/dev/stdout"
    accessLogFormat: ""
    outboundTrafficPolicy:
      mode: REGISTRY_ONLY
  values:
    pilot:
      jwksResolverExtraRootCA: |
        -----BEGIN CERTIFICATE-----
        MIIEKTCCAxGgAwIBAgIUNjT4liTyGcGTewYUb2NZj4oWMGowDQYJKoZIhvcNAQEL
        BQAwgaMxCzAJBgNVBAYTAklUMQ4wDAYDVQQIDAVJdGFseTENMAsGA1UEBwwEUm9t
        ZTEcMBoGA1UECgwTQnVzaWNvIE1pcnRvIFNpbHZpbzETMBEGA1UECwwKTGFib3Jh
        dG9yeTEcMBoGA1UEAwwTQnVzaWNvIE1pcnRvIFNpbHZpbzEkMCIGCSqGSIb3DQEJ
        ARYVbWlydG9idXNpY29AZ21haWwuY29tMB4XDTIxMDIxOTExNDA1N1oXDTMxMDIx
        NzExNDA1N1owgaMxCzAJBgNVBAYTAklUMQ4wDAYDVQQIDAVJdGFseTENMAsGA1UE
        BwwEUm9tZTEcMBoGA1UECgwTQnVzaWNvIE1pcnRvIFNpbHZpbzETMBEGA1UECwwK
        TGFib3JhdG9yeTEcMBoGA1UEAwwTQnVzaWNvIE1pcnRvIFNpbHZpbzEkMCIGCSqG
        SIb3DQEJARYVbWlydG9idXNpY29AZ21haWwuY29tMIIBIjANBgkqhkiG9w0BAQEF
        AAOCAQ8AMIIBCgKCAQEAtt+v2C9p60rx1Q/yOQsgsis/dBNAo4efFlyN0Ibs9ts4
        a0LRQp4EwZpv9+tysVqGZvN4fJ99mdyiJHiFlchMfq4t+OzOHnym7Yi5khHS5/rv
        TwvwD+1igMny1FybVOxSlfdZGF5mhgRFD6mQod/hix5QJgegmygEhj0VV/i2rZhH
        FW0oMR1smLfALQQZhGJ//TgCjNlpK2D6zlxEXIr+QLyAje+kQyyqkJefY/Vggg9m
        gRFV7gu3MKKGE5B+ESfqhZbUqsKz/rsxs2L23Selp3FM+DhKIC8DM06dgAh7DYUQ
        IeIe9HT7+RTTs3KM7ArDXrF+BF+D8O/a4D3YBDhHswIDAQABo1MwUTAdBgNVHQ4E
        FgQUGHqUwQ6vRxvpB7+MCUEAwmUgbtAwHwYDVR0jBBgwFoAUGHqUwQ6vRxvpB7+M
        CUEAwmUgbtAwDwYDVR0TAQH/BAUwAwEB/zANBgkqhkiG9w0BAQsFAAOCAQEAVThR
        2NmNuey07twCW4/B8v6zOCeO/n8Z+waRw1XK9XmA+QPUTi+bLKvfx+7RVgaZD6SR
        EQHMCshGD7In5PbSBsrp6ocmCvcopd2iqvt2GLvJHuZy7hI+RgaMgQo9hhThHf9e
        FoW3C41Mm3ofvUubIKLEFKnCvxOsD+Ayyg69pGwNM+PQK1XvXWWYm8eroPICxriq
        8ULUgAc+leGiHbAKSXGLj6U/njyRzkxAmXzkierT1DFDHa9sZst7nCaSycKY7rBj
        GU2xRTOpYrQHcsaBZBjTT8/ag2IasCzFVeZ5+bMmTaDus5QT3tIubR8ukTx5jf0S
        BiQTL+/xni6Fxkrl3Q==
        -----END CERTIFICATE-----
```

And I installed with:

```bash
kubectl create ns istio-system
kubectl apply -f istio-operator
```

Now I can use the authentication file

```yaml
apiVersion: security.istio.io/v1beta1
kind: RequestAuthentication
metadata:
  name:  m-ra
  namespace: istio-system
spec:
  selector:
    matchLabels:
      istio: ingressgateway
  jwtRules:
  - issuer: "https://k6k.m.net/auth/realms/m-project"
    jwksUri: "https://k6k.m.net/auth/realms/m-project/protocol/openid-connect/certs"
    forwardOriginalToken: true
    outputPayloadToHeader: x-jwt-payload
```
