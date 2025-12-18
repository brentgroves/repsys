# **[Authenticating and Authorizing end-users with Istio and Auth0](https://auth0.com/blog/securing-kubernetes-clusters-with-istio-and-auth0/)**

**[Current Status](../../repsys/development/status/weekly/current_status.md)**\
**[Research List](../../repsys/research/research_list.md)**\
**[Back Main](../../repsys/README.md)**

## Note

I'm going to try to use the current version of K8s and Istio instead of the ones described in this document.

## references

- **[Small Step](https://smallstep.com/docs/step-cli/#examples-that-dont-require-step-ca)**
- **[Istio > Supported Kubernetes releases](https://istio.io/latest/docs/releases/supported-releases/)**
- **["Learn Istio - How to Manage, Monitor, and Secure your services."](https://www.freecodecamp.org/news/learn-istio-manage-microservices/)**
- **[Github](https://github.com/auth0-blog/istio-auth0-integration)**
- **[killercoda](https://killercoda.com/kubernetes)**
- **[k8s providers](https://medium.com/@emilmatyjaszewski/top-4-cheapest-managed-kubernetes-providers-in-2024-fa2776906266)**
![np](https://cdn.prod.website-files.com/65a5be30bf4809bb3a2e8aff/65de6a24f3bc7cfdb5711e46_ethernet2.jpeg)

Learn how Istio secures service-to-service traffic for your Kubernetes clusters and how to integrate with Auth0 for securing end-user traffic.

## Preface

Security is the most crucial aspect to get right in every application. Failing to secure your apps and the identity of your users can be very expensive. Moreover, it can make customers and investors lose faith in your ability to deliver high-quality services. Therefore, it's of paramount importance to strictly follow standards and best practices when developing an application. Luckily, big vendors like Auth0, Microsoft, Facebook, and Google can simplify this task by working as the identity providers of your apps. These companies, alongside increased security, also enable users to quickly log in to your apps without having to create yet another set of credentials.

Authentication and authorization are more complex for microservice architectures, as they require implementation on every service. The scenario can become even more problematic if you use different stacks to build these microservices. For each stack, you would have a different set of best practices and libraries to use (probably even write), increasing the surface area of possible bugs and consuming company resources that could be invested in providing business value.

To solve this problem, you will learn about Istio and how to integrate it with Auth0. As you will see, by using one of the **[authentication features provided by Istio](https://istio.io/docs/concepts/security/#authentication)**, you can easily avoid this problem and secure your applications without code changes.

## Prerequisites

Before learning about Istio and how to use it, you need to get your hands on a Kubernetes cluster with admin access. Next, you will need kubectl, the Kubernetes command-line tool, to interact with the cluster. To install kubectl, head over to the official documentation and follow the instructions for your operating system.

In this article, we use Kubernetes In Docker, known as kind. Still, you can use any other local Kubernetes distribution such as Docker-Desktop (installation and usage), Rancher Desktop, or Minikube.

To install kind, follow the installation instructions in the **[Kind Quick Start](../../../repsys/k8s/kind/kind-quick_start.md)**.

## Deleting a Cluster 🔗︎

If you created a cluster with kind create cluster then deleting is equally simple:

```bash
kind delete cluster
```

## Creating a cluster with kind

After installing kind, you can create a Kubernetes cluster with the following command:

```bash
kind create cluster --image=kindest/node:v1.31.2
Creating cluster "kind" ...
 ✓ Ensuring node image (kindest/node:v1.31.2) 🖼 
 ✓ Preparing nodes 📦  
 ✓ Writing configuration 📜 
 ✓ Starting control-plane 🕹️ 
 ✓ Installing CNI 🔌 
 ✓ Installing StorageClass 💾 
Set kubectl context to "kind-kind"
You can now use your cluster with:

kubectl cluster-info --context kind-kind

Thanks for using kind! 😊
```

This command pulls a container image with the Kubernetes version 1.23.1 and runs it on your container runtime. For example, if you are on Docker, you can see the running container by executing:

```bash
# The docker ps command only shows running containers by default. To see all containers, use the --all (or -a ) flag.
docker ps
CONTAINER ID   IMAGE                  COMMAND                  CREATED         STATUS         PORTS                       NAMES
c96bfb745119   kindest/node:v1.31.2   "/usr/local/bin/entr…"   2 minutes ago   Up 2 minutes   127.0.0.1:37287->6443/tcp   kind-control-plane
```

Note: In this article, we use Kubernetes version 1.23. Istio 1.14 is compatible with versions 1.20 and onwards. To learn about the supported releases of Kubernetes, check the official docs at **[Istio > Supported Kubernetes releases](https://istio.io/latest/docs/releases/supported-releases/)**.

- **Istio version 1.24 supports K8s version 1.31**

## Introduction to Istio

When building and managing microservice-based applications, a myriad of complexities arise: you need to handle service discovery, load balancing, application resilience, and hardware utilization, to name just a few. So when Google introduced Kubernetes, which solves these complexities, it garnered a wide adoption by all cloud computing service providers.

However, Kubernetes lacks solutions to other problems faced when adopting microservices:

- **Traffic management:** retries, circuit breaking, load balancing, complex routing patterns, and so on
- **Security:** authentication of services and end-users, encryption of traffic in transit, and access control
- **Observability:** tracing requests, metrics, and access logs

The above features can be achieved at the application layer by simply adding more code to the application. For example, to add resiliency and circuit breaking, you can use **[resilience4j](https://resilience4j.readme.io/docs)**.

However, a service mesh implements the capabilities mentioned above at the platform layer. For example, Istio injects a sidecar alongside each service and enables complex routing capabilities, generates metrics for observability, and so on.

Note: A sidecar, in this context, is a container that is added to your pods. Istio uses these containers to intercept inbound and outbound traffic of your application and enhance it with its features.

This article covers a slice of the security capabilities of Istio and shows integration with Auth0. For a more elaborate introduction, check out my article **["Learn Istio - How to Manage, Monitor, and Secure your services."](https://www.freecodecamp.org/news/learn-istio-manage-microservices/)** To truly master it, check out the book **[Istio in Action](https://www.manning.com/books/istio-in-action?utm_source=rinor&utm_medium=affiliate&utm_campaign=book_posta2_istio_9_30_18&a_aid=rinor&a_bid=9f6a70f3)**, written by Christian Posta and me.

## Installing and configuring Istio

**Note:** Instead of these instructions for installing Istio I used **[these](../../../repsys/k8s/istio-install.md)**

istioctl is a CLI tool with many utilities, one of those being installing Istio in clusters. For example, execute the command below to install Istio.

```bash
istioctl install --set profile=demo -y
✔ Istio core installed ⛵️                                 
✔ Istiod installed  🧠                                                                              ✔ Egress gateways installed  🛫                                                                              ✔ Ingress gateways installed 🛬                                                                              ✔ Installation complete   
```

The command might take several minutes as it awaits all pods to be up and running. After it completes, print the deployed pods with the command below.

```bash
kubectl get pods -n istio-system
NAME                                   READY   STATUS    RESTARTS   AGE
istio-egressgateway-84bfcbdd68-7njl9   1/1     Running   0          6m18s
istio-ingressgateway-dd9f7f444-nd6fh   1/1     Running   0          6m18s
istiod-b877844fb-pnsgw                 1/1     Running   0          6m35s
```

The listed components are:

- Istio egress gateway: used for securing egress traffic.
- Istio ingress gateway: the ingress point of traffic coming from the public network and into your cluster.
- Istiod: Istio's control plane that configures the service proxies.

**Note:** At the time of writing, the latest Istio version to reach General Availability is 1.14.0 and that is the version used when the article was written. You can try newer versions if you like, but these are not guaranteed to work equally.

In the next section, you will get an application up and running that later we will secure using Istio and Auth0.

## Deploying the Book Info Application

The Book Info is a sample application composed of four separate microservices and displays information about books, similar to a single catalog entry of an online book store. It is composed of the following microservices:

- The productpage microservice queries the details and reviews services to populate the page with book information.
- The details microservice has details about the book.
- The reviews microservice has reviews about the book. It queries the ratings microservice.
- The ratings microservice has book rating information that accompanies a book review.

The figure below illustrates how these microservices are organized and how they communicate:

![bi](https://images.ctfassets.net/23aumh6u8s0i/5bntomnAEO0IItacoOtFDi/856ced74cba338875a3870c0df7f074b/bookinfo-app.png)

To get the configuration to deploy the services and the Istio configuration that we will use in this article, you need to clone the following **[repository:](https://github.com/auth0-blog/istio-auth0-integration)**

```bash
pushd .
cd ~/src/repsys/k8s
# clone the repo
git clone https://github.com/auth0-blog/istio-auth0-integration.git

# change directory to it
cd istio-auth0-integration
```

After that, create and label the namespace where you will deploy your services.

```bash
kubectl create ns demo
kubectl label namespace demo istio-injection=enabled
```

By labeling the namespace with istio-injection=enabled, pods that are deployed into it will get Istio's sidecar automatically injected. Next, deploy the sample application by executing the following command from the istio-auth0-integration directory:

```bash
pushd .
cd ~/src/repsys/k8s/istio-auth0-integration
scc.sh kind.yaml kind-kind 
kubectl config set-context $(kubectl config current-context) --namespace=demo
kubectl apply -f platform/kube/bookinfo.yaml
service/details created
serviceaccount/bookinfo-details created
deployment.apps/details-v1 created
service/ratings created
serviceaccount/bookinfo-ratings created
deployment.apps/ratings-v1 created
service/reviews created
serviceaccount/bookinfo-reviews created
deployment.apps/reviews-v1 created
deployment.apps/reviews-v2 created
deployment.apps/reviews-v3 created
service/productpage created
serviceaccount/bookinfo-productpage created
deployment.apps/productpage-v1 created
```

Although this command finishes quite fast, Kubernetes might need several minutes to run all the pods. You can wait for all pods to be running with the command below:

```bash
# https://kubernetes.io/docs/reference/kubectl/generated/kubectl_wait/
kubectl wait pods --for condition=Ready --timeout -1s --all
pod/details-v1-67894999b5-j9wll condition met
pod/productpage-v1-7bd5bd857c-w46dg condition met
pod/ratings-v1-676ff5568f-2zl29 condition met
pod/reviews-v1-f5b4b64f-8dnzt condition met
pod/reviews-v2-74b7dd9f45-4q6gh condition met
pod/reviews-v3-65d744df5c-9wwx5 condition met
```

After the pods are ready, verify that all have the sidecar injected:

```bash
kubectl get pods
NAME                              READY   STATUS    RESTARTS   AGE
details-v1-67894999b5-j9wll       2/2     Running   0          7m3s
productpage-v1-7bd5bd857c-w46dg   2/2     Running   0          7m1s
ratings-v1-676ff5568f-2zl29       2/2     Running   0          7m3s
reviews-v1-f5b4b64f-8dnzt         2/2     Running   0          7m2s
reviews-v2-74b7dd9f45-4q6gh       2/2     Running   0          7m2s
reviews-v3-65d744df5c-9wwx5       2/2     Running   0          7m2s
```

In the READY column, each row shows the value 2/2, meaning that the sidecar container is injected alongside the application container by Istio.

## Routing traffic to services through the Istio Gateway

A best practice to control ingress traffic (incoming traffic) is to use the Istio Ingress Controller and configure it using the Gateway resource. The controller was installed during Istio installation. It positions itself at the edge of the cluster, ensuring Istio's features (like monitoring, tracing, traffic management, and security) get enforced in the incoming traffic to your cluster.

The Gateway custom resource definition configures the ingress gateway to admit traffic. For example, for the Book Info application, you will want to expose port 80 for HTTP traffic, achieved with the Gateway definition below:

```bash
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1
kind: Gateway
metadata:
  name: bookinfo-gateway
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "*"
EOF
```

The above definition will apply only to workloads matching the selector. And the selector istio: ingressgateway matches only for the default ingress gateway setup during the Istio installation.

Apply it to the cluster by executing the command below:

```bash
# I changed the istio version to v1
# run from the istio-auth0-integration directory
pushd .
cd ~/src/repsys/k8s/istio-auth0-integration
kubectl apply -f networking/bookinfo-gateway.yaml
gateway.networking.istio.io/bookinfo-gateway created
```

And with that, the Istio ingress gateway admits traffic on port 8080 for any host.

## Defining a virtual service for your application

After admitting traffic in your cluster, you need to configure the ingress gateway to route the traffic to your services. You do that using the VirtualService resource.

The following snippet defines a virtual service with explicit rules that tell your gateway to route incoming traffic with the listed paths to the productpage service:

```yaml
kubectl apply -f - <<EOF
apiVersion: networking.istio.io/v1
kind: VirtualService
metadata:
  name: bookinfo
spec:
  hosts:
  - "*"
  gateways:
  - bookinfo-gateway
  http:
  - match:
    - uri:
        exact: /productpage
    - uri:
        exact: /login
    - uri:
        exact: /logout
    - uri:
        exact: /callback
    - uri:
        prefix: /api/v1/products
    - uri:
        prefix: /static/
    route:
    - destination:
        host: productpage
        port:
          number: 9080
EOF
```

Each of these endpoints exposes essential functionality, the key ones being:

**/productpage:** This is the main endpoint you will consume in your browser. It renders the book info application.
**/login:** After you integrate Auth0 in your app, this endpoint will redirect users to the Auth0 login page so they can sign in or sign up.
**/logout:** This is the endpoint for users to log out from your app.
**/callback:** This is the endpoint that Auth0 uses to send your users back to your app after the user signs in. On which occasion your application receives a code that it exchanges for the access token.

This virtual service definition is already contained in the GitHub repository and you can apply it by executing the following command:

```bash
# run from the istio-auth0-integration directory
pushd .
cd ~/src/repsys/k8s/istio-auth0-integration
kubectl apply -f networking/bookinfo-virtualservice.yaml
virtualservice.networking.istio.io/bookinfo created
```

After running this command, you will be able to use your application. For example, when using a managed Kubernetes solution such as AKS, GKE, or EKS, you will get a public IP address that you can find out by printing the services as follows:

```bash
kubectl get svc -n istio-system -l istio=ingressgateway
NAME                   TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)                                                                      AGE
istio-ingressgateway   LoadBalancer   10.96.20.134   <pending>     15021:32564/TCP,80:31067/TCP,443:32190/TCP,31400:32692/TCP,15443:30233/TCP   81m
```

In the case of kind it will print the following:

```bash
NAME                   TYPE           CLUSTER-IP   EXTERNAL-IP
istio-ingressgateway   LoadBalancer   10.96.0.62   <pending>
```

The output shows status for the External IP is `<pending>`, and that won't change because kind doesn't assign IP addresses to Kubernetes services.

For this demonstration, we can simply port-forward Istio's ingress gateway to our local environment as shown below:

```bash
kubectl port-forward -n istio-system svc/istio-ingressgateway 8080:80
```

After that, you can access the application by opening a browser at <http://localhost:8080/productpage>, as shown below:

![pp](https://images.ctfassets.net/23aumh6u8s0i/3btETuPyemsPyqXmkOZjDt/d083b322c354f15a9096a5847c78d44f/bookinfo-page.png)

## Encryption of service-to-service traffic

Istio is "secure by default" merely by injecting the sidecar-proxies alongside the apps — all service to service traffic is authenticated and encrypted.

The control plane mints a certificate for each proxy. You can find it in its configuration.

Note: To execute the commands below, you need two command-line tools: jq for processing JSON and step for inspecting certificates.

```bash
istioctl proxy-config all deploy/productpage-v1 -o json | \
  jq -r '.. |."secret"? | select(.name == "default")'
```

The above command prints the certificate used by productpage to mutually authenticate with other workloads within the mesh.

Note: Istio implements the Secure Production Identity Framework For Everyone (abbr. SPIFFE) to define identity to workloads within the mesh. The SPIFFE specification defines the SPIFFE ID to communicate identity between workloads. Learn more about The **[SPIFFE Identity and Verifiable Identity Document](https://github.com/spiffe/spiffe/blob/main/standards/SPIFFE-ID.md)**.

The SPIFFE ID is encoded within the certificate, which contains the namespace and service account of the workload. You can print the SPIFFE ID with the command below:

```bash
# istioctl proxy-config all deploy/productpage-v1 -o json | grep secret
#    "dynamic_active_secrets": [
#      "secret": {
#      "secret": {
istioctl proxy-config all deploy/productpage-v1 -o json | \
  jq -r '.. |."secret"?' | \
  jq -r 'select(.name == "default")' | \
  jq -r '.tls_certificate.certificate_chain.inline_bytes' | \
  base64 -d - | step certificate inspect
  ```

Recursively descends ., producing every value. This is the same as the zero-argument recurse builtin (see below). This is intended to resemble the XPath // operator. Note that ..a does not work; use .. | .a instead. In the example below we use .. | .a? to find all the values of object keys "a" in any object found "below" ..

This is particularly useful in conjunction with path(EXP) (also see below) and the ? operator.

```bash
Command jq '.. | .a?'
Input [[{"a":1}]]
Output 1
```

The SPIFFE ID of the workload is encoded into the Subject Alternative Name, as shown below:

```bash
# output is redacted
    X509v3 Subject Alternative Name: critical
        URI:spiffe://cluster.local/ns/demo/sa/bookinfo-productpage
```

By adopting Istio, all traffic within the mesh is encrypted (using the minted certificates that we printed out earlier). This protects our data from getting sniffed and prevents person-in-the-middle attacks. As a result, even if gaining access to any of the machines or networking devices, attackers won't be able to read the traffic going back and forth.

Additionally, because services mutually authenticate using the issued certificates, you can further improve security by defining the minimum access for each service using AuthorizationPolicies.

Note: Service-to-service authorization is not in the scope of this article. However, if you are interested to know more, Istio has a **[quick example](https://istio.io/latest/docs/tasks/security/authorization/authz-http/)** to get you started and you’ll find detailed descriptions in the **[AuthorizationPolicy API reference](https://istio.io/latest/docs/reference/config/security/authorization-policy/)**.

## Authenticating and Authorizing Users

To implement access control policies for the services, we need to initially redirect the user to Auth0 for authentication and then configure the services with policies that allow or reject requests based on the user permissions.

The figure below visualizes what user permissions are required for them to access the services:

- The productpage service is accessible by any user.
- The reviews service is accessible by identities with the read:book-reviews permission.
- The details service is accessible only by identities with the  read:book-details permission.
- The ratings service has no policies applied; however, you might want to do that as an exercise.

![ap](https://images.ctfassets.net/23aumh6u8s0i/2XxzzDDf9m8pnRM0jbIDj1/da13b8cf3f4e552f6dca10a42e5d12bc/access-control-per-service.png)

From the users' perspective, we have:

- Moderators have the highest access and they can access every service.
- Users can access only the product page and the details service
- Unauthenticated users can access the productpage. Unauthenticated access to the productpage is essential to trigger the authentication flow.

## Setting up the Auth0 application

Let's start to configure Auth0 to authenticate users for our services. First, you need to **[sign up for a free Auth0 account](https://auth0.com/signup)** (or you can use an existing one if you already have it).

After signing up, you will have to go to your Auth0 dashboard and create a new Auth0 Application. You can do that by going to the Applications page of your dashboard and by clicking on the Create Application button. When you click on this button, Auth0 will show you a dialog where you will have to input two things:

Application Name: You can use anything here to identify your application (e.g., "Auth0 Istio Sample").
Application Type: As the product page is a classic web application (i.e., it is not a single-page app nor a native app), you will have to choose Regular Web Applications.

Then, when you click on Create, Auth0 will redirect you to the Quick Start tab of your new application. From there, you can go to the Settings tab and change two fields on it:

**Allowed Callback URLs:** Through this field, you will white label a URL that Auth0 will call after your users authenticate. Here, you can insert <http://localhost:8080/callback>.
**Allowed Logout URLs:** Through this field, you will white label a URL that Auth0 will call after your users log out. Here, you can insert <http://localhost:8080/productpage>.

If you have a publicly accessible IP address, make sure that you replace localhost:8080 with the ingress gateway IP address while updating these fields, then hit the Save Changes button on the bottom of the Settings page.

![au](https://images.ctfassets.net/23aumh6u8s0i/1TRSv1Cl2xShZk7cnS5jVt/8ab44d5ce97e83e08d34d7c76c486f70/manage-app-auth0.png)

## Registering the API in Auth0

In addition to the application, you will need to register an API on the Auth0 dashboard. For this purpose, head to the APIs section of your dashboard and click on Create API. When you do so, Auth0 will show you a form where you will have to input the following:

- A Name for your API: You can use something like "Auth0 Istio Sample" again.
- An Identifier for your API: You can use a URI like <https://bookinfo.io>. It doesn't have to be a valid URL. Nothing will call it as such.
- A Signing Algorithm: Make sure you use RS256 for this field.

After creating the API you are redirected to its configuration page. On this page, we will configure the API to add permissions to the access token after a user logs in. Follow these steps:

1. Switch to the Settings tab and scroll down to RBAC Settings.
2. Enable both the Enable RBAC and Add Permissions in the Access Token options.
Then, scroll to the bottom of the page and click Save.
Next, switch to the Permissions tab and add the following two permissions:

| Permission        | Description       |
|-------------------|-------------------|
| read:book-details | Read book details |
| read:book-reviews | Read book reviews |

The result should look as shown in the image below:

![ap](https://images.ctfassets.net/23aumh6u8s0i/4uZTknOHCi4iXIZLPps93O/da0071717aba4e573fb243c8aea9f63f/api-permissions.png)

## Defining roles and assigning permissions

You can assign permissions directly to users. However, a better practice is to define roles that group a set of permissions. When a user is assigned a role, they will inherit the same set of permissions.

To define roles, navigate to the **[Roles section of your dashboard](https://manage.auth0.com/#/roles)**, and create the following two roles:

| Role      | Description  |
|-----------|--------------|
| moderator | Moderator    |
| user      | Regular user |

After creating those roles, add the permissions listed in the table below to each one. You can do it by clicking the role and heading to the Permissions tab:

| Role      | Permissions                         |
|-----------|-------------------------------------|
| user      | read:book-details                   |
| moderator | read:book-details read:book-reviews |
