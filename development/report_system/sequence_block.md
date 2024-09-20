# Sequence and Block diagram

**[Development Menu](./menu.md)**\
**[Current Status](../status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**

## reference

- **[block](https://mermaid.js.org/syntax/block.html)**

## Block Diagram

```mermaid
block-beta
  columns 5
  a1["Report Requester"] a2<["request via websocket"]>(right) a3[/"{user,reportid,params...}"/]space:2
  space:2 b3<["publish to request topic"]>(down) space:2
  space:2 c3(("MQTT Queue (request topic)")) c4<["subscribe to request"]>(left) c5["Request dispatch daemon"]
  space:4 d6<["publish to AMQP broker"]>(down)
  space:2 e1(("AMQP Report Work Queues")) e4<["publish to report_id work queue"]>(left) e5{"Pick work queue based on reportid"}
  space:2 f1<["subscribe to work queue"]>(up) space:2
  space:2 g1["Unique request_daemon for every report.\n Since using queues scaling possilbe.\n Uses GoRoutines to run ETL scripts.\n(daemon)"] space:2
  space:2 h1<["request_daemon's outputs"]>(down) space:2
  i["The request_daemon only executes ETL scripts.\n It will call other microservices to do any other tasks."]:5  
  space:1 j1<["Email Excel"]>(down) space:1 j4<["Publish Status"]>(down) space:1
space:1 k2["Email Excel (microservice)"] space:1 k4["Report Status (microservice)"] space:1
space:3 l4<["Publish user_id topic"]>(down) space:1
space:3 m4(("MQTT Queue (user_id topic)")) space:1
space:3 n4<["Subscribe user_id topic"]>(down) space:1
space:3 o1["Web Report Request"]

%%  https://designwizard.com/blog/colour-combination/
  classDef Grey fill:#949398FF,color:#F4DF4EFF;  
  classDef RedBlack fill:red,color:black;
  classDef Coral fill:#FC766AFF,color:#5B84B1FF;
  classDef Violet fill:#5F4B8BFF,color:#E69A8DFF;
  classDef Turquoise fill:#42EADDFF,color:#CDB599FF;
  classDef Black fill:#000000FF,color:#FFFFFFFF;  
  classDef Blue fill:#00A4CCFF,color:#F95700FF;
  classDef Mint fill:#00203FFF,color:#ADEFD1FF;
  classDef Lime fill:#D6ED17FF, color:#606060FF;
  classDef Tomato fill:#ED2B33FF, color:#D85A7FFF;
  classDef Forest fill:#2C5F2D, color: #97BC62FF; 
  classDef Royal fill:#00539CFF, color: #EEA47FFF;
%% classDef Title2 fill:#FF99FF00, stroke-width:0, color:grey, font-weight:bold, font-size: 17px;

  class a1,a5,o1  Coral
  class c3,m4,g3 Grey
  class c5 Violet
  class e1 Black
  class e5 Blue
  class g1 Mint
  class i Tomato
  class k2 Lime
  class k4 Forest
  class a3 Royal
```

## Flow Summary

1. Customer requests report from requester web app. 
2. Request published to request topic of MQTT broker.
3. Request dispatch daemon subscribes to request topic.
4. Request daemon pushes new request to appropriate report queue of AMQP broker.
5. First report runner daemon to pull request from queue processes the request.
6. runner daemon calls report status microservice after each ETL script or error to the user's private topic in MQTT broker.
7. runner daemon calls emailer microservice to email Excel file.

## Sequence Diagram

```mermaid
sequenceDiagram
    participant requester as Report Requester
    participant identity as IAM Identity Provider
    participant request_topic as MQTT Request Topic
    participant request_daemon as Request Daemon
    participant work_queue as AMQP Work Queue
    participant runner_daemon as Report Runner Daemon
    participant status_microservice as Status Microservice
    participant userid_topic as MQTT UserID topic
    participant mailer as Mail Service

    Note over requester,request_daemon: The user must be authenticate to submit report requests
    requester->>+identity: Logs in using credentials

    alt Invalid Credentials
        identity->>requester: Invalid credentials
    else Valid Credentials
        identity->>-requester: Successfully logged in

        Note over requester,request_daemon: When the user is authenticated, they can now submit report requests
        requester->>+request_topic: Publish new report request
        request_daemon->>request_topic: Subscribed to report request topic
        request_daemon->>work_queue: Add report request
        runner_daemon->>work_queue: Remove next report request
        runner_daemon->>runner_daemon: Create report (GoRoutines)
        runner_daemon->>status_microservice: Report Status
        status_microservice->>userid_topic: Publish Report Status
        userid_topic->>requester: Subscribed to UserID topic
        requester->>requester: Show report status
        runner_daemon->>mailer: Call Email microservice
        mailer->>mailer: Email Excel file

    end

```

