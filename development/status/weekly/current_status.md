# Status

**[All Status](../weekly/status_list.md)**\
**[Back to Main](../../../README.md)**

## NEXT

- **[Go Backend with IAM](../../../../go_zit_backend/README.md#next)**\
Read more about how to generate a key file.

- **[Go Frontend with IAM](../../../research/m_z/zitadel/zitadel_article.md)**\
Research Zitadel IAM

- **[Go web app in Docker](https://semaphoreci.com/community/tutorials/how-to-deploy-a-go-web-application-with-docker)**

- Verify TB Power BI report runs from alb-utl and add it to repsys volume/powerbi dir.
- **[Test k8s.io from within Cluster](https://github.com/kubernetes/client-go/blob/master/examples/in-cluster-client-configuration/main.go)**
  - read database passwords from k8s secret and write to k8s log.
- Remove password from mutex tutorial.

- **[Out-of-Cluster K8s API access](https://github.com/kubernetes/client-go/blob/master/examples/out-of-cluster-client-configuration/README.md)**

## Project List

- **[Report System](../../../projects/report_system/report_system.md)**
- **[Observability System](../../../projects/observability_system/observability_system.md)**
- Mean Time to Failure

## Development

- **[Setup Development System](../../report_system/setup_dev_system/setup_dev_system.md)**
- **[All Software MindMap](../../report_system/all_sw_mindmap.md)**
- **[All Software Gantt](../../report_system/all_sw_gantt.md)**
- **[Report Creation Sequence Diagram](../../report_system/report_creation_sequece_diagram.md)**
- **[Trial Balance Runner Flow Chart](../../report_system/trial_balance_runner_flow_chart.md)**
- **[Task List](../../report_system/task_list.md)**
- **[Requester Mockup](../../report_system/requester_mockup/requester_mockup.md)**

## IT Admin

- **[PKI](../../../it_admin/pki/pki_menu.md)**

## Tutorials

- **[Go Tutorials](../../../volumes/go/tutorials/tutorial_list.md)**
- **[Zitadel with Go (Backend)](../../../volumes/go/tutorials/zitadel/backend/backend.md)**
- **[Zitadel with Go (Frontend)](../../../volumes/go/tutorials/zitadel/frontend/frontend.md)**
- **[Handling Mutexes in Distributed Systems with Redis and Go](../../../volumes/go/tutorials/redis_sentinel/mutex/tutorial_redis_mutex_go.md)**
- **[In-Cluster K8s API access](../../../volumes/go/tutorials/k8s/in_cluster_client_configuration/in-cluster-client-configuration.md)**
- **[Out-of-Cluster K8s API access](../../../volumes/go/tutorials/k8s/out-of-cluster-client-configuration/out-of-cluster-client-configuration.md)**

- **[Containerize your Go app and use semaphore for CI/CD.](../../../volumes/go/tutorials/docker/go_web_docker/go_web_docker.md)**

- **[Handling Mutexes in Distributed Systems with Redis and Go](../../../volumes/go/tutorials/redis_sentinel/mutex/tutorial_redis_mutex_go.md)**
- **[In-Cluster K8s API access](../../../volumes/go/tutorials/k8s/in_cluster_client_configuration/in-cluster-client-configuration.md)**
- **[Out-of-Cluster K8s API access](../../../volumes/go/tutorials/k8s/out-of-cluster-client-configuration/out-of-cluster-client-configuration.md)**

## Research

- **[Research List](../../../research/research_list.md)**\
A list of all research for repsys.

- IAM
  - **[Token Sharing Approaches](./a_l/iam/token_sharing_approaches.md)**

  - ![](https://curity.io/images/resources/architect/api-security/token-sharing/mesh.svg)

    If your system is high in the API security maturity model you most probably use access tokens to authorize access to your endpoints. Access tokens that your API receives are tailored for the use with the given endpoint - they will have a concrete set of scopes and claim values. But as shown above, your API most probably will talk to different services which may or may not be part of the same domain or even company. This means that the API will have to share the token it received with the other services it needs to access. There are different ways in which such token can be shared:

- **[Continuous Integration and Continuous Delivery(CI/CD)](../../../research/a_l/continuous_integration_and_delivery/continuous_integration_and_delivery.md)**
Semaphore lets you test and deploys code at the push of a button with hosted continuous integration and delivery. After you push code to GitHub, it quickly runs your tests on a platform with first-class Docker support and 100+ tools preinstalled.

- **[Zitadel](../../../research/m_z/zitadel/zitadel_article.md)**\
ZITADEL is an open source, cloud-native Identity and Access Management solution (IAM) that provides various security mechanisms to secure applications and services. It uses a range of different authorization strategies, including Role-Based Access Control (RBAC) and Delegated Access.

- **[Juju](../../../research/a_l/juju/tutorial.md)**\
  Juju provides a declarative and model-driven way to install, provision, maintain, update, upgrade, and integrate applications on and across Kubernetes containers, Linux containers, virtual machines, and bare metal machines, on public or private cloud.

- **[Mattermost](../../../research/m_z/mattermost/mattermost.md)** \
  Mattermost is an open-source, self-hostable online chat service with file sharing, search, and integrations. It is designed as an internal chat for organisations and companies, and mostly markets itself as an open-source alternative to Slack and Microsoft Teams. Wikipedia

- **[Minio Object Storage](../../../research/m_z/minio/minio.md)**\
  Object storage is accessed via a REST API call. Using POST, PUT, GET to an HTTP endpoint, you can create, read, update and delete (the famous CRUD operations) your blobs of data.
