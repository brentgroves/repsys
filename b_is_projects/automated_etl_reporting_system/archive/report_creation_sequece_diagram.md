# Report FLow Sequece Diagram

**[Development Menu](./menu.md)**\
**[Current Status](../status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**

## Run TB Report

```mermaid
sequenceDiagram
    participant dan as Dan
    participant req as Requester
    participant red as Redis
    participant run as Runner
    dan->>req: request report
    req->>red: insert TB request
    run->>red: subscribe to TB queue
    loop 
        run->>run: Start TB ETL pipeline
    end

```
