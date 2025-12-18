# **[](https://learn.microsoft.com/en-us/fabric/workload-development-kit/workload-environment)**

## Introducing workloads

11/03/2024
This chapter introduces the key components of our system and provides an overview of the architecture. These components work together to create a robust and flexible platform for your development needs. Let’s delve into these components and their roles within our architecture.

## Fabric workload architecture

Some of the key aspects of the Fabric workload architecture are:

It handles data processing, storage, and management. It validates Microsoft Entra ID tokens before processing them and interacts with external Azure services, such as Lakehouse.

The workload Frontend (FE) offers a user interface for job creation, authoring, management, and execution.

User interactions via the FE initiate requests to the BE, either directly or indirectly via the Fabric Backend (Fabric BE).

For more detailed diagrams depicting the communication and authentication of the various components, see the Backend authentication and authorization overview and the Authentication overview diagrams.

## Frontend (FE)

The frontend serves as the base of the user experience (UX) and behavior, operating within an iframe in the Fabric portal. It provides the Fabric partner with a specific user interface experience, including an item editor. The extension client SDK equips the necessary interfaces, APIs, and bootstrap functions to transform a regular web app into a Micro Frontend web app that operates seamlessly within the Fabric portal.

## Backend (BE)

The backend is the powerhouse for data processing and metadata storage. It employs CRUD operations to create and manage workload items along with metadata, and executes jobs to populate data in storage. The communication bridge between the frontend and backend is established through public APIs.

The workloads can run in two environments: local and cloud. In local (devmode), the workload runs on the developer's machine, with API calls managed by the DevGateway utility. This utility also handles workload registration with Fabric. In cloud mode, the workload runs on the partner services, with API calls made directly to an HTTPS endpoint.

Development environment
Dev mode workload package: When building the backend solution in Visual Studio, use the Debug build configuration to create a BE NuGet package, which can be loaded in to the Fabric tenant using the DevGateway application.

![i1](https://learn.microsoft.com/en-us/fabric/workload-development-kit/media/workload-environment/developer-mode-diagram.png#lightbox)

Workload examples
In this section, you can find a few examples of use cases to help you understand the potential applications of Fabric workloads. These examples are just a few of the many unique use cases that can be tailored to meet the specific needs of your organization. The versatility of workloads allows for a wide range of possibilities, enabling you to create solutions that are perfectly suited to your operational requirements. We encourage you to explore and experiment with different configurations to discover the full potential of what workloads can do for your organization.

Data Job - Data jobs are one of the most common scenarios. They involve extracting data from OneLake, performing data operations, and then writing the results back to OneLake. These jobs can be integrated with Fabric’s data scheduling capabilities and executed as background tasks. An example of this type of workload is a data pipelines notebook.

Data store - Workloads that manage and store data. They can provide APIs to query and write data, serving as a robust and flexible data management solution. Examples for this kind of workload include Microsoft Fabric Lakehouse and Cosmos DB.

Data visualization - Data visualization applications that are entirely based on existing Fabric data items. They allow the creation of dynamic and interactive visual representations of your data. Power BI reports and dashboards serve as excellent examples of this type of workload.

Publish to the Workload Hub
After developing your Fabric Workload according to the certification requirement, publish it to the Workload Hub which will allow every Fabric user a chance to easily start a trial experience and then buy your workload. An in-depth description of how to publish the workload can be found here.

Key Considerations for Developing a Fabric Workload
There are several important concepts to understand before beginning development of a Fabric workload:

Native Fabric Experience: Review the Fabric UX system to learn the basics design concepts, all published workloads must comply to these design principles.
Integrate with the Fabric workspace: Your existing data application is required to function in a Fabric workspace, where users create instances of your data application and collaborate with other Fabric users.
Integrate with Fabric as a multitenant application: Your workload is embedded in Fabric but we don't host your code. Fabric exposes APIs to allow the workload to get access to user data, user context and environment information to allow you to map between the customer's environment and your cloud deployment. It's the responsibility of the Workload to comply and attest to industry standards such as GDPR, ISO, SOC 2 etc.
