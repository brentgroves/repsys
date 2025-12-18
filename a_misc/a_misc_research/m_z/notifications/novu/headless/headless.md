# **[Headless](https://docs.novu.co/inbox/headless/get-started)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../../research/research_list.md)**\
**[Back Main](../../../../../README.md)**

## references

- **[Novu example](https://dev.to/novu/how-to-add-in-app-notifications-to-any-web-app-1b4n)**

## Headless Inbox

A lightweight, standalone package for building custom in-app notification interfaces with Novu, providing essential functionalities and flexibility.

The headless version of Novu’s notification library package provides users with a lightweight solution for integrating notification functionality into their web applications. With just the essential API methods, users can easily incorporate our notification system into any framework or vanilla JavaScript project, without being constrained by our default UI or dependencies. The SDK includes real-time notifications through a WebSocket connection and can be safely used across web browsers.

​

## Get Started

1. Installation

    ```bash
    npm install @novu/js
    ```

2. Import Package

    ```node
    import { Novu } from "@novu/js";
    ```

3. Initialize Session

    import { Novu } from "@novu/js";

    const novu = new Novu({
    subscriberId: "SUBSCRIBER_ID",
    applicationIdentifier: "APPLICATION_IDENTIFIER",
    });

4. Fetch Notifications

const response = await novu.notifications.list({
  limit: 30,
});

const notifications = response.data.notifications

5. Display notifications in your UI.

## Realtime Notifications

Events are emitted when notifications are received, and when the unread notificatons count changes. novu.on() is used to listen to these events.

novu.on("notifications.notification_received", (data) => {
  console.log("new notification =>", data);
});

novu.on("notifications.unread_count_changed", (data) => {
  console.log("new unread notifications count =>", data);
});
​
