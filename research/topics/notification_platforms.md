# **[OSS Notification Platforms](https://novu.co/)**

**[Current Status](../../development/status/weekly/current_status.md)**\
**[Research List](../../research/research_list.md)**\
**[Back Main](../../README.md)**

## How should we notify a customer there report is finished?

How should we notify a customer there report is finished?

We used a **[websocket](https://www.pubnub.com/guides/websockets/)** in the tool tracker from the browser to a REST server but authenticating the user to the websocket was never implemented and there doesn't seem to be a simple secure way of knowing who is connecting to the websocket.

Stumbled across **[Novu](https://novu.co/)** which is the first open-source notification infrastructure that manages all forms of communication from email to SMS, Push notifications, etc.

**[Web push](../a_l/application_architecture/web_push.md)** notifications are notifications that can be sent to a user via desktop and mobile web. These alert-style messages slide in at the top or bottom right-hand corner of a desktop screen, depending on the operating system, or appear on a mobile device in a manner nearly identical to push notifications delivered from apps. Website push notifications are delivered on a user’s desktop or mobile screen whenever their browser is open — whether or not the user is on the website.

## Summary

Use HTTP2 push notifications because there is a industry standard way of knowing who you are sending messages to.

## Novu

- **[novu](https://novu.co/)**
- **[example](https://dev.to/novu/how-to-add-in-app-notifications-to-any-web-app-1b4n)**

## **[notifyone](https://medium.com/@prashantmishra_61952/introducing-notifyone-the-ultimate-open-source-notification-system-c9aeb81ba292)**

## **[k8s notification manager](https://github.com/kubesphere/notification-manager)**
