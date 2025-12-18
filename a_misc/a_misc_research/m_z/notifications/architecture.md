# **[Architecture](https://notifyone.1mg.com/docs/introduction/components_and_architecture)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## Components And Architecture
NotifyOne uses a highly scalable, fault-tolerant architecture. NotifyOne as been designed to suite the microservices architecture and runs as a group of services that, combined together, work for the best performance.

NotifyOne has been architected keeping in mind the actual production load and deployment strategies. The components have been decoupled keeping in mind the tasks they perform and their scaling needs.

![alt text](image.png)


Amazon **[Simple Queue Service](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/welcome.html)** (SQS) is a managed message queuing service from Amazon Web Services (AWS) that enables users to send, store, and retrieve messages between software components

**[SQS](https://www.geeksforgeeks.org/aws-sqs/)**

- The architecture makes it easy to introduce a new channel or integrate with new providers for existing channels.

- Components like Gateway, Core and Handlers can be scaled independently based on needs.

## Components
It's evident from the architecture diagarm above. the entire NotifyOne system can be been seen as an integration of the below four components -

- **Gateway** - This is a light-weight components that exposes APIs for sending notifications and retriving notification statuses. It works as a single point of contact to the NotifyOne system for the outside world.

- **Core** - This is where the actual magic happens. Core component exposes APIs for app and event management, template creation and editing, template rendering, routing notification request for a channel to the designated handler, logging notification request etc. It also servers as the backend service to the NotifyOne CMS (Admin Panel) system.

- **Handlers** - This component provides integrations with the actual operator gateways like Plivo and SmsCountry for sms, SparkPost and SES for email etc. This component supports multi channel deployment which means handler for each channel can also be deployed as a seprate service. Please refer to the deployment documentation for more detils around how to deploy handlers.

- **CMS** - This is admin panel of our NotifyOne system. It provides event and app management, template management, operator and priority logic configurations, analytics and reporting. A few features (operator and priority logic configurations, analytics and reporting) are currently under development and will be released soon with the futre releases.