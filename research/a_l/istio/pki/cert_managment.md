# **[How Are Certificates Managed in Istio?](https://tetrate.io/blog/how-are-certificates-managed-in-istio/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[Using your own PKI](https://tetrate.io/blog/istio-trust/)**

## How to Incorporate Istio into the PKI Certificate Trust Chain

Before using Istio, enterprises usually have their own internal public key infrastructure . How can Istio be incorporated into the PKI certificate trust chain?

Istio has built-in certificate management functions that can be used out of the box. When Istio is started, it will create a self-signed certificate for istiod as the root certificate for all workloads in the mesh. The problem with this is that the built-in root certificate cannot achieve mutual trust between meshes if you have multiple meshes. The correct approach is not to use Istio’s self-signed certificate, but to incorporate Istio into your certificate trust chain and integrate Istio into your PKI, creating an intermediate certificate for each PKI mesh. In this way, two meshes have a shared trust root and can achieve mutual trust between meshes.

Integrate the Istio mesh into your internal PKI certificate trust chain by creating an intermediate CA, as shown in Figure 4.
