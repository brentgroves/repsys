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
  a1["Web Report Request"] a2<["request via websocket"]>(right) a3[/"{user,reportid,params...}"/]space:2
  space:2 b3<["publish to request topic"]>(down) space:2
  space:2 c3(("MQTT Queue (request topic)")) c4<["subscribe to request"]>(left) c5["Requester (microservice)"]
  space:4 d6<["publish to AMQP broker"]>(down)
  space:2 e1(("AMQP Report Work Queues")) e4<["publish to report_id work queue"]>(left) e5{"Pick work queue based on reportid"}
  space:2 f1<["subscribe to work queue"]>(up) space:2
  space:2 g1["Unique Runner for every report.\n Since using queues\n scaling possilbe.\n Uses GoRoutines\n to run ETL scripts.\n(microservice)"] space:2
  space:2 h1<["Runner's outputs"]>(down) space:2
  i["The runner only executes ETL scripts.\n It will call other microservices to do any other tasks."]:5  
  space:1 j1<["Email Excel"]>(down) space:1 j4<["Publish Status"]>(down) space:1
space:1 k2["Email Excel (microservice)"] space:1 k4["Publish Status (microservice)"] space:1
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

1. Customer requests a report
2. Request published to request topic of MQTT broker.
3. Requester microservice subscribes to request topic.
4. Requester adds request to unique report queue of AMQP broker.
5. Report runner, 1 or more runners for each possible report.
6. Runner publishes status to the user's private topic.
7. Requester subcribes to logged in user's topic.
8. Requester shows request status
9. Emailer microservice Email's Excel file

## Sequence Diagram

```mermaid
sequenceDiagram
    participant requester as Report Request
    participant identity as Identity Provider
    participant queue as Message Queue
    participant runner as Report Runner

    participant mail as Mail Service
    participant dw as Data Warehouse

    Note over requester,runner: The user must be authenticate to submit report requests
    requester->>+identity: Logs in using credentials

    alt Invalid Credentials
        identity->>requester: Invalid credentials
    else Valid Credentials
        identity->>-requester: Successfully logged in

        Note over requester,runner: When the user is authenticated, they can now submit report requests
        requester->>+queue: Submit new report request
        queue->>runner: Inform report runner
        runner->>dw: Store Report
        par Notifications
            runner->>mail: Email excel
        and Response
            queue-->>-requester: Report Status
        end

    end

```
