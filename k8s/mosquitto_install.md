# **[Mosquitto MQTT broker in Kubernetes](https://www.enabler.no/en/blog/mosquitto-mqtt-broker-in-kubernetes)**

**[Report System Install](./report-system-install.md)**\
**[Current Status](../development/status/weekly/current_status.md)**\
**[Back to Main](../README.md)**

## references

- **[JavaScript Client Library for node.js and browsers](https://github.com/mqttjs/MQTT.js)**
- **[JavaScript Web Browser Client](http://www.steves-internet-guide.com/mqtt-websockets/)**
- **[Eclipse Mosquitto](https://mosquitto.org/)**
- **[Somebody's K8s config files](https://github.com/abalage/mosquitto-mqtt-k8s/blob/main/base/mosquitto.conf)**
- **[MQTT WebSocket JavaScript Client library in Browser](http://www.steves-internet-guide.com/using-javascript-mqtt-client-websockets/)**
- **[Many MQTT tutorials](http://www.steves-internet-guide.com/)**
- **[Another K8s MQTT guide](https://www.enabler.no/en/blog/mosquitto-mqtt-broker-in-kubernetes)**

Venturing into the world of deploying an MQTT broker in Kubernetes can lead you to some intriguing challenges, especially when compared to the more traditional tasks of serving webpages or APIs

1. Unlike HTTP-based services, MQTT is served over TCP. Consequently, some common ingress solutions, such as ingress-nginx, do not natively support serving TCP traffic. We'll explore how we could bypass this limitation.
2. Ensuring secure communication between the MQTT broker and clients is crucial. However, manually creating and managing SSL certificates can be a tedious process. We'll demonstrate an automated method for managing SSL certificates, making your MQTT communication secure and worry-free

## Certificate

First things first, let's generate the certificate we want to use. The "de facto standard" for this task is cert-manager, and we'll use a cert-manager-generated certificate in the same way we do with other ingress-generated certificates. This ensures the certificate stays up-to-date.
