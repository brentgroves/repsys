# **[Stop Using the Wrong CNI in 2025: Flannel vs Calico vs Cilium](https://blog.devops.dev/stop-using-the-wrong-cni-flannel-vs-calico-vs-cilium-in-2025-c11b42ce05a3)**

When I first built my Kubernetes cluster, I didn’t even think about the CNI.

I just wanted pods to talk to each other.

So I went with the default, Flannel. It worked. It was simple. And for a while, I thought that was enough.

But then I wanted to do more: enforce network policies, add encryption, and actually see what was happening inside my cluster’s network. Suddenly, I realized something: your choice of CNI isn’t just about connecting pods, it defines what your Kubernetes cluster can actually do.

Press enter or click to view image in full size

If you’re running Kubernetes in 2025, choosing the right CNI is one of the most important (and most overlooked) decisions you’ll make. Let’s break down the three most popular options — Flannel, Calico, and Cilium — and see what they bring to the table, with step‑by‑step installation instructions for each.

## Flannel: The Safe Default

No, Charmed Kubernetes does not use Flannel by default; it uses Calico as the default Container Network Interface (CNI). While Flannel is available as an option for Charmed Kubernetes, it is not the default CNI.

![i1](https://miro.medium.com/v2/resize:fit:720/format:webp/1*dCXQC-bCfT5lnNQNz7mFbA.png)**

Most people meet Flannel by accident: it’s the default in lightweight Kubernetes distributions. And honestly? That’s its biggest strength. Flannel just works. You install your cluster and, like magic, pods can talk. No complex setup, no tuning, no headaches.

But the simplicity comes with trade‑offs. Flannel doesn’t support network policies, doesn’t encrypt traffic, and offers no real observability. It’s great for a small lab cluster where you just need connectivity, but you’ll quickly hit its limits if you want to set up production‑like workloads or practice security‑minded setups.

If all you’re doing is experimenting with Kubernetes basics, Flannel is fine. But if you want to level up? You’ll need more.

How to install Flannel:

If you’re using K3s, Flannel comes preinstalled. To make it explicit:

`curl -sfL <https://get.k3s.io> | INSTALL_K3S_EXEC="--flannel-backend=vxlan" sh -`

For kubeadm or other distros, simply apply the Flannel manifest:

kubectl apply -f <https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml>

## Calico: The Step Up

Press enter or click to view image in full size

![i1](https://miro.medium.com/v2/resize:fit:720/format:webp/1*7iw7_Z3yRe7CwexLI_ooig.png)

Calico was my first real upgrade.

It felt like moving from a toy network to something that could handle real‑world complexity. Suddenly, I could define network policies, “this service can talk to that one, but not the other”, and enforce them at scale.

It’s clear why Calico is so popular: it scales well, supports multiple backends like VXLAN or BGP, works across on‑prem, cloud, and hybrid setups, and integrates smoothly with existing networks. Its fine‑grained access controls make it a solid choice for anyone wanting more than basic connectivity.

That said, it lacks the deep observability of Cilium, and encryption isn’t enabled out of the box. While WireGuard is supported, setup is manual, and seamless encryption is only included in the enterprise edition. You’ll get policy enforcement, but not a real-time view of traffic.

One thing I updated after a helpful comment from
Steve Atkinson
: If you’re using MetalLB to expose LoadBalancer services in your homelab, the cleanest setup is to let Calico handle BGP while keeping MetalLB in Layer 2 mode, where it announces IPs over the local network via ARP. This avoids conflicts and works reliably, even in more advanced or hybrid environments.

For anyone who wants to practice production‑style security setups or run a serious homelab, Calico is a great choice.

## How to install Calico

First, disable Flannel (or any default CNI):

`curl -sfL <https://get.k3s.io> | INSTALL_K3S_EXEC="--flannel-backend=none --disable-network-policy" sh -`

Then apply the official Calico manifest:

`kubectl apply -f <https://docs.projectcalico.org/manifests/calico.yaml`

## Cilium: The Upgrade Your Cluster Actually Needs

![i](https://miro.medium.com/v2/resize:fit:720/format:webp/1*vyWKP1SQXC-GMvuW6jlEfA.png)

And then there’s Cilium.

Switching to Cilium was like flipping a light switch in my cluster. Suddenly, networking wasn’t just functional, it was observable, secure, and programmable in ways I hadn’t seen before.

Built on eBPF (a high‑performance kernel technology), Cilium rethinks how Kubernetes networking works. Instead of relying on iptables or kube-proxy hacks, Cilium injects logic directly into the kernel, giving you visibility and control at the lowest level, without compromising speed.

## Here’s what makes Cilium stand out

- Real-time observability with Hubble
- API-aware network policies at Layer 7 (not just IP/port-based)
- Built-in encryption using WireGuard
- Service mesh capabilities like mTLS and traffic splitting, without sidecars
- Multi-cluster connectivity with ClusterMesh
- Native service routing with eBPF (no kube-proxy required)

Let’s break down how Cilium takes your networking to the next level, and how to enable each feature, step by step.

## Installing Cilium

First, disable any existing CNI (like Flannel):

`curl -sfL <https://get.k3s.io> | INSTALL_K3S_EXEC="--flannel-backend=none --disable-network-policy" sh -`

Add the Cilium Helm repo and install:

```bash
helm repo add cilium <https://helm.cilium.io/>
helm install cilium cilium/cilium --version 1.15.0 --namespace kube-system
```

## API‑Aware Network Policies

Instead of just saying “allow traffic on port 80,” you can write policies like “only allow GET requests to /healthz from this service.” That’s real, application‑level security.

Enable L7 policy enforcement:

```bash
helm upgrade cilium cilium/cilium \
  --namespace kube-system \
  --reuse-values \
  --set policyEnforcementMode=always
```

Create a sample HTTP‑aware policy:

```bash
apiVersion: cilium.io/v2
kind: CiliumNetworkPolicy
metadata:
  name: backend-allow-healthz
spec:
  endpointSelector:
    matchLabels:
      app: backend
  ingress:
    - fromEndpoints:
        - matchLabels:
            app: frontend
      toPorts:
        - ports:
            - port: "80"
              protocol: TCP
          rules:
            http:
              - method: "GET"
                path: "/healthz"
```

## kubectl apply -f backend-policy.yaml

Transparent Encryption
Your pods might be talking to each other over your LAN, but who else can listen? Cilium solves this by letting you encrypt all pod-to-pod traffic using WireGuard, directly in the kernel. No VPN sidecars, no manual tunneling.

```bash
helm upgrade cilium cilium/cilium \
  --namespace kube-system \
  --reuse-values \
  --set encryption.enabled=true \
  --set encryption.type=wireguard
```

## Hubble: Real‑Time Observability

Hubble gives you a live view of how traffic moves through your cluster. You get service graphs, flow logs, DNS tracing, and more.

```bash
cilium hubble enable
cilium hubble port-forward &
```

Then open <http://localhost:12000> to explore your cluster traffic in real time

## Service Mesh Features, Without the Sidecars

When people talk about a service mesh like Istio or Linkerd, they usually mean:

- mTLS for encrypting service-to-service traffic
- Traffic routing for canary or blue-green deployments
- Detailed observability of service calls

Traditionally, this requires sidecars (tiny proxies in every pod), which add complexity and overhead. Cilium does it differently. Using eBPF in the kernel, it delivers:

- Built-in mTLS
- L7-aware traffic routing (e.g., “send 20% of /checkout to v2”).
- Hubble-powered observability.

Enable it:

```yaml
helm upgrade cilium cilium/cilium \
  --namespace kube-system \
  --reuse-values \
  --set ingressController.enabled=true
```

## Multi-Cluster Networking with ClusterMesh

One of Cilium’s most powerful features is how easily it connects multiple clusters, as if they were one.

Want your homelab to talk to your cloud Kubernetes cluster? No VPNs. No DNS hacks. Just seamless pod-to-pod communication.

What do you need?

At least one reachable node per cluster, either:

- Public IPs,
- Behind NAT (port‑forward a node or use Tailscale/Zerotier).

Example: Connecting Two Clusters (Homelab + Cloud)

Let’s say you have:

- Cluster A (homelab): Context = homelab
- Cluster B (cloud): Context = cloud

### Step 1: Enable ClusterMesh on both clusters

- cilium clustermesh enable --context homelab
- cilium clustermesh enable --context cloud

### Step 2: Connect them

`cilium clustermesh connect --context homelab --destination-context cloud`

### Step 3: Verify the connection

`cilium clustermesh status --context homelab`

Now pods in homelab can talk to pods in cloud securely over WireGuard tunnels.

This is why Cilium feels less like a CNI and more like a Kubernetes networking platform. It gives you the tools to practice real‑world security, observability, and service‑to‑service management, even in a home setup.

## Which One Should You Use?

Here’s my advice:

- If you just need connectivity in a small cluster: Stick with Flannel.
- If you want something secure and production‑like, without going too far down the rabbit hole: Calico gives you a solid, safe setup.
- But if you want the most powerful, modern, and future‑proof networking stack for Kubernetes: Cilium is the clear winner.
