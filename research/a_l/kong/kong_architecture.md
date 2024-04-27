# Kong Architecture

## references

<https://intverse.medium.com/kong-api-gateway-k8s-architecture-5597570da34a>

<https://docs.konghq.com/gateway-operator/latest/reference/custom-resources/>

## Background

Kong is an open-source API gateway built for modern architectures such as microservices, serverless, and cloud-native applications. To support these architectures, Kong offers a cloud-native architecture that is designed to be highly scalable, resilient, and extensible.

Kong can be deployed on Kubernetes using the Kong Ingress Controller. This allows Kong to be integrated into a Kubernetes cluster, making it easier to manage traffic and policies for microservices.

Here are the key components of a cloud-native Kong architecture:

1. Kong Gateway: The Kong Gateway is the core component of the architecture. It is responsible for routing and managing traffic to and from microservices, and for enforcing security and other policies such as rate limiting, authentication, and authorization.
2. Plugins: Kong offers a wide range of plugins that can be used to extend the functionality of the gateway and service mesh. These plugins can be used to add features such as logging, authentication, monitoring, analytics, caching, and transformation.
3. Kong Manager: Kong Manager is a web-based GUI that can be used to manage the Kong Gateway. It provides a dashboard for monitoring traffic, configuring plugins, and managing services.
4. Datastore: Kong uses a data store to store configuration information such as services, routes, and plugins. It supports multiple data stores such as PostgreSQL, Cassandra, and MySQL.

Kong K8s Deployment Architecture:

![](https://miro.medium.com/v2/resize:fit:720/format:webp/1*DKzuMtpQmbxEd_-kRyQ8iA.png)

<https://docs.konghq.com/gateway-operator/latest/reference/custom-resources/>

## Kong Ingress Controller

The Kong Ingress Controller is a Kubernetes-native solution that enables the use of the Kong API Gateway to manage inbound traffic to Kubernetes services. In other words, it allows Kong to act as a Kubernetes Ingress Controller.

The Kubernetes Ingress Controller is a resource that manages external access to Kubernetes services. It allows external clients to access services within the Kubernetes cluster. The Kong Ingress Controller leverages this resource to manage inbound traffic and route it to the appropriate Kubernetes service.

When a client makes a request to an API hosted on the Kubernetes cluster, the request is received by the Kong Ingress Controller, which routes the request to the appropriate Kubernetes service based on the routing rules defined in the Kong API Gateway. These rules can be based on a variety of factors, including the URL path, HTTP headers, or client IP address.

The Kong Ingress Controller provides several benefits over the standard Kubernetes Ingress resource. These include:

1. **Advanced traffic management:** Kong provides advanced traffic management features such as load balancing, caching, rate-limiting, and circuit breaking that can be used to optimize and secure traffic to Kubernetes services.
2. **API Management:** Kong provides a comprehensive API management platform that includes features such as authentication, authorization, and analytics, which can be used to manage and secure APIs.
3. **Plugin architecture:** Kong provides a flexible plugin architecture that allows developers to extend the functionality of the API Gateway to meet their specific requirements.
4. **Community support:** Kong has a large and active community that provides resources, knowledge, and support for users of the Kong Ingress Controller.

## Kong Database Requirements

When deploying Kong on Kubernetes, there are several options for the database architecture, depending on the specific requirements and constraints of the deployment. Here are some of the most common database architectures for Kong on Kubernetes:

1. PostgreSQL: PostgreSQL is a popular open-source relational database that is often used as the backend database for Kong. PostgreSQL provides strong data consistency and durability and can handle large amounts of data and high transaction rates.
2. Cassandra: Cassandra is a popular NoSQL database that is often used as the backend database for Kong. Cassandra provides high availability and scalability, making it a good choice for deployments that require high throughput and low latency.
3. MySQL: MySQL is another popular open-source relational database that can be used as the backend database for Kong. MySQL provides good performance and scalability and is often used in environments where it is already in use.
4. AWS RDS: AWS RDS is a managed database service that provides easy deployment and management of relational databases such as PostgreSQL and MySQL. Kong can be configured to use AWS RDS as the backend database, providing a highly available and scalable solution.
5. **Google Cloud SQL:** Google Cloud SQL is a similar managed database service to AWS RDS that provides easy deployment and management of relational databases such as PostgreSQL and MySQL. Kong can be configured to use Google Cloud SQL as the backend database, providing a highly available and scalable solution.

## Kong Cert Manager Support

Kong provides support for Cert Manager when deploying on Kubernetes. Cert Manager is a popular Kubernetes add-on that automates the management and issuance of TLS certificates from various certificate authorities such as Let’s Encrypt.

Here are some of the key features and benefits of using Cert Manager with Kong:

1. Automatic TLS certificate management: Cert Manager automates the management and issuance of TLS certificates, eliminating the need for manual certificate management
2. Certificate issuance from multiple certificate authorities: Cert Manager supports certificate issuance from multiple certificate authorities such as Let’s Encrypt, Venafi, and HashiCorp Vault.
3. Integration with Kong: Cert Manager integrates with Kong to automatically provision TLS certificates for HTTPS traffic, enabling secure communication between clients and Kong.
4. Automatic certificate renewal: Cert Manager automatically renews TLS certificates before they expire, ensuring that HTTPS traffic is always secure.
5. Customizable certificate policies: Cert Manager provides customizable policies for managing TLS certificates, such as certificate expiration, revocation, and renewal.
6. Secure communication between services: Cert Manager enables secure communication between services by automatically issuing and renewing TLS certificates for services deployed on Kubernetes.

## Kong Secrets Management Support

Kong provides support for Vault when deploying on Kubernetes. Vault is a popular secrets management tool that enables secure storage and access to sensitive data such as API keys, passwords, and certificates.

Here are some of the key features and benefits of using Vault with Kong:

1. Centralized secrets management: Vault provides a centralized location for storing and managing secrets, enabling secure access and distribution of sensitive data across different services and applications.
2. Integration with Kong: Kong integrates with Vault to securely store and access secrets such as API keys, passwords, and certificates, enabling secure communication between clients and Kong.
3. Dynamic secrets: Vault supports dynamic secrets that are generated on-demand and have a limited life span, providing an additional layer of security and reducing the risk of credential theft.
4. Secure access control: Vault provides fine-grained access control to secrets, allowing developers to specify which services and applications have access to which secrets.
5. Audit trails: Vault provides comprehensive audit trails of all secret access, enabling security teams to monitor and detect any unauthorized access or activity.
6. Integration with Kubernetes: Vault integrates with Kubernetes to provide seamless secrets management for services deployed on Kubernetes, including automatic renewal of certificates.

## Kong GitOps Support

Kong provides GitOps support for managing the deployment and configuration of the Kong API Gateway on Kubernetes. GitOps is a modern approach to managing infrastructure and application deployments, where the desired state of the infrastructure and applications is defined in a Git repository and changes are automatically applied to the environment through a continuous delivery pipeline.

## GitOps Support

Here are some of the key GitOps features provided by Kong:

1. Declarative Configuration: Kong provides a declarative configuration approach to defining the desired state of the API Gateway, which can be version-controlled and managed using Git. This makes it easy to manage and track changes to the configuration of the API Gateway over time.
2. GitOps Operator: Kong provides a GitOps operator that can be used to manage the deployment and configuration of the Kong API Gateway on Kubernetes. The operator monitors the Git repository for changes to the configuration and automatically applies them to the API Gateway.
3. Continuous Delivery Pipeline: Kong provides integration with popular continuous delivery tools such as Jenkins and GitLab, allowing developers to automatically deploy and configure the Kong API Gateway as part of their application deployment pipeline.
4. Rollback and Rollout: Kong’s GitOps support includes rollback and rollout functionality, allowing developers to easily revert to previous versions of the API Gateway configuration in case of issues or errors.
5. Collaboration: Kong’s GitOps support enables collaboration between teams, making it easy to manage and track changes to the configuration of the API Gateway across multiple environments and teams.

## Kong Observability

Kong provides several observability features that can be used to monitor and analyze the performance of the Kong API Gateway when deployed on Kubernetes. Here are some of the key observability features provided by Kong:

1. Metrics: Kong exposes a range of metrics that can be used to monitor the performance of the API Gateway. These metrics can be accessed via Prometheus or other monitoring solutions, and include information such as request rate, latency, and error rates.
2. Tracing: Kong supports distributed tracing using tools such as Jaeger and Zipkin. This enables developers to trace requests through the entire request lifecycle, from the client to the backend service, and identify any performance issues or errors.
3. Logging: Kong provides detailed logs that can be used to troubleshoot issues and gain insights into API traffic. These logs can be sent to centralized logging solutions such as Elasticsearch, Splunk, or Logstash.
4. Alerting: Kong supports alerting based on metrics and logs. Developers can configure alerts to notify them when certain metrics or events occur, such as when the error rate exceeds a certain threshold.
5. Dashboard: Kong provides a built-in dashboard that displays key metrics and information about the API Gateway, such as request rate, latency, and error rates. This can be used to quickly identify performance issues and gain insights into API traffic.
6. Custom plugins: Kong provides a plugin architecture that allows developers to create custom plugins to collect and analyze observability data. This enables developers to create custom metrics, logs, and dashboards to gain deeper insights into API traffic.
