# **[Run the Istio ingress gateway with TLS termination and TLS passthrough](https://www.danielstechblog.io/run-the-istio-ingress-gateway-with-tls-termination-and-tls-passthrough/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

The Istio ingress gateway supports two modes for dealing with TLS traffic: TLS termination and TLS passthrough.

Running Istio with TLS termination is the default and standard configuration for most installations. Incoming TLS traffic is terminated at the Istio ingress gateway level and then sent to the destination service encrypted via mTLS within the service mesh.

Having the TLS passthrough configured the Istio ingress gateway passing through the TLS traffic directly to the destination service which then does the TLS termination.

Are both modes supported at the same time with the default ingress gateway configuration?

Sure, and that is today’s topic in this blog post.

## Configuration – Istio ingress gateway

Our starting point is a standard Istio installation and ingress gateway configuration doing the TLS termination on port 443 for our wildcard domain configuration.

```yaml
apiVersion: install.istio.io/v1alpha1
kind: IstioOperator
metadata:
  namespace: istio-system
  name: istiocontrolplane
spec:
  components:
    base:
      enabled: true
    cni:
      enabled: true
    ingressGateways:
      - enabled: true
        name: istio-ingressgateway
        k8s:
          hpaSpec:
            minReplicas: 2
          overlays:
            - apiVersion: v1
              kind: Service
              name: istio-ingressgateway
              patches:
                - path: spec.ports
                  value:
                    - name: status-port
                      port: 15021
                      targetPort: 15021
                      protocol: TCP
                    - name: http2
                      port: 80
                      targetPort: 8080
                      protocol: TCP
                    - name: https
                      port: 443
                      targetPort: 8443
                      protocol: TCP
    pilot:
      enabled: true
      k8s:
        hpaSpec:
          minReplicas: 2
  meshConfig:
    accessLogFile: "/dev/stdout"
    accessLogEncoding: "JSON"
  values:
    global:
      istiod:
        enableAnalysis: true
    cni:
      excludeNamespaces:
        - istio-system
        - kube-system
    pilot:
      env:
        PILOT_ENABLE_STATUS: true
    sidecarInjectorWebhook:
      rewriteAppHTTPProbe: true
```

```yaml
apiVersion: networking.istio.io/v1beta1
kind: Gateway
metadata:
  name: azst-aks-gateway
  namespace: istio-config
spec:
  selector:
    istio: ingressgateway # use Istio default gateway implementation
  servers:
    - hosts:
        - "*.danielstechblog.de"
      port:
        number: 80
        name: http
        protocol: HTTP
      tls:
        httpsRedirect: true
    - hosts:
        - "*.danielstechblog.de"
      port:
        number: 443
        name: https
        protocol: HTTPS
      tls:
        mode: SIMPLE
        credentialName: istio-ingress-cert
```

Besides that, we want to have a dedicated port on the Istio ingress gateway for TLS traffic which is passed through the destination service.

The first step onto that path is the adjustment of the Istio configuration itself adding another port mapping on the HTTPS port 8443.

```yaml
apiVersion: install.istio.io/v1alpha1
kind: IstioOperator
metadata:
  namespace: istio-system
  name: istiocontrolplane
spec:
  ...
    ingressGateways:
      - enabled: true
        name: istio-ingressgateway
        k8s:
          hpaSpec:
            minReplicas: 2
          overlays:
            - apiVersion: v1
              kind: Service
              name: istio-ingressgateway
              patches:
                - path: spec.ports
                  value:
                    - name: status-port
                      port: 15021
                      targetPort: 15021
                      protocol: TCP
                    - name: http2
                      port: 80
                      targetPort: 8080
                      protocol: TCP
                    - name: https
                      port: 443
                      targetPort: 8443
                      protocol: TCP
                    - name: tls-passthrough
                      port: 10443
                      targetPort: 8443
                      protocol: TCP
```

After rolling out this change we take the next configuration step adjusting the Istio gateway configuration

```yaml
apiVersion: networking.istio.io/v1beta1
kind: Gateway
metadata:
  name: azst-aks-gateway
  namespace: istio-config
spec:
  selector:
    istio: ingressgateway # use Istio default gateway implementation
  servers:
    - hosts:
        - "*.danielstechblog.de"
      port:
        number: 80
        name: http
        protocol: HTTP
      tls:
        httpsRedirect: true
    - hosts:
        - "*.danielstechblog.de"
      port:
        number: 443
        name: https
        protocol: HTTPS
      tls:
        mode: SIMPLE
        credentialName: istio-ingress-cert
    - hosts:
        - "*.tls.danielstechblog.de"
      port:
        number: 10443
        name: tls-passthrough
        protocol: TLS
      tls:
        mode: PASSTHROUGH
```

An important note here regarding the hosts parameter, you shall not use the same wildcard domain configuration as for your TLS Termination. Either use a wildcard subdomain or a full FQDN configuration.

If you want TLS termination and TLS passthrough on port 443 at the same time, you must configure the hosts parameter with full FQDNs instead of using a wildcard domain configuration. Same counts towards for the virtual services configuration then.

The Istio ingress gateway itself is instructed by the protocol and tls mode parameters whether it does or does not TLS termination. If set to TLS and PASSTHROUGH, as in our case, the ingress gateway passes through the TLS traffic to the destination service.

## Configuration – Istio virtual service

Now everything is prepared moving onto the Istio virtual service configuration routing the traffic to our service, which is the NGINX example from the Istio docs.

-> https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-sni-passthrough/

```yaml
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: nginx
  namespace: istio-config
spec:
  hosts:
    - nginx.tls.danielstechblog.de
  gateways:
    - azst-aks-gateway
  tls:
    - match:
        - port: 10443
          sniHosts:
            - nginx.tls.danielstechblog.de
      route:
        - destination:
            host: my-nginx.nginx.svc.cluster.local
            port:
              number: 443
```

Instead of configuring an http match we are going to configure a tls match for the virtual service. The tls match requires the port and sniHosts parameter. In our case the port is 10443 and the sniHosts our FQDN.

After rolling out the virtual service configuration we call the NGINX service. For comparison I deployed an additional small web service written in go showing the standard TLS termination.

As seen in the screenshot below the certificate used by the Istio ingress gateway is issued by Let’s Encrypt.

![app](https://www.danielstechblog.io/wp-content/uploads/2022/01/istiotlstermination01-300x168.png)

For the TLS passthrough example a self-signed certificate was generated. Those self-signed certificates are marked as unsecure as seen below.

![unsigned](https://www.danielstechblog.io/wp-content/uploads/2022/01/istiotlstermination02-300x168.png)

![more](https://www.danielstechblog.io/wp-content/uploads/2022/01/istiotlstermination03-300x168.png)

## Summary
Depending on what configuration you would like to use you can have TLS termination and TLS passthrough on port 443 which requires FQDNs instead of a wildcard domain configuration. The latter one must use another port mapping when you want to have TLS passthrough beside the default TLS termination on port 443 with a wildcard domain configuration.

The sample templates can be found on my GitHub repository.

-> https://github.com/neumanndaniel/kubernetes/tree/master/istio-tls-passthrough

