# **[End-User-Authentication with Istio & Keycloak](https://medium.com/@engin.gungor14/end-user-authentication-with-istio-keycloak-b7f10965b691)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## Authentication

![istio_auth](https://miro.medium.com/v2/resize:fit:720/format:webp/1*LIQdkxR6kHsd7ahY7-sVfw.png)**

Managing AuthN & AuthZ is one of the challenging topics.However, With Cloud Native approach could be handle this kind of issue with tools. Those tools also improves security of App. Today, we are deploy basic application and we would secure it with Istio. Let’s start.

## Keycloak Deployment & Configuration

Firstly we will configure auth provider. Keycloak is open source identity and access management solution.

You could deploy Keycloak with the following YAML file for development purposes. (Not highly available). I also configured YAML for specific namespace property for deployment and I exposed the service as a NodePort.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: keycloak
  namespace: kc-sample
  labels:
    app: keycloak
spec:
  ports:
  - name: http
    port: 8080
    targetPort: 8080
    nodePort: 30034
  selector:
    app: keycloak
  type: NodePort
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: keycloak
  namespace: kc-sample
  labels:
    app: keycloak
spec:
  replicas: 1
  selector:
    matchLabels:
      app: keycloak
  template:
    metadata:
      labels:
        app: keycloak
    spec:
      containers:
      - name: keycloak
        image: quay.io/keycloak/keycloak:16.0.0
        env:
        - name: KEYCLOAK_USER
          value: "admin"
        - name: KEYCLOAK_PASSWORD
          value: "admin"
        - name: PROXY_ADDRESS_FORWARDING
          value: "true"
        ports:
        - name: http
          containerPort: 8080
        - name: https
          containerPort: 8443
        readinessProbe:
          httpGet:
            path: /auth/realms/master
            port: 8080
```

Also, you could configure YAML for your environment. Let's reach the Keycloak Administration Console and configure it according to your needs. Credentials are defined in the YAML file as an “admin:admin”.

```http://<MASTER_IP>:30034```

Firstly let’s create a new realm. Definition of realm by Keycloak is:

A realm manages a set of users, credentials, roles, and groups. A user belongs to and logs into a realm. Realms are isolated from one another and can only manage and authenticate the users that they control.

![add_realm](https://miro.medium.com/v2/resize:fit:640/format:webp/1*0wSI2Q8eGSo1oTk7PqkE6w.png)

![add](https://miro.medium.com/v2/resize:fit:640/format:webp/1*6shCwgegNub1JjNeG08NQg.png)

After creation of realm we should create client. Client definition according to Keycloak;

Clients are entities that can request Keycloak to authenticate a user. Most often, clients are applications and services that want to use Keycloak to secure themselves and provide a single sign-on solution. Clients can also be entities that just want to request identity information or an access token so that they can securely invoke other services on the network that are secured by Keycloak.

![client](https://miro.medium.com/v2/resize:fit:720/format:webp/1*JRddJxU7ZlMF3ncfZWjFCw.png)
