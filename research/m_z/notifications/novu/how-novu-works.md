# **[What is Novu?](https://docs.novu.co/getting-started/how-novu-works)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[Novu example](https://dev.to/novu/how-to-add-in-app-notifications-to-any-web-app-1b4n)**

## What is Novu

Novu is an open-source notification infrastructure platform that greatly reduces the effort and complexity required to implement notifications your users will love, all without the need to build your own notification system.

We designed Novu with both developers and product teams in mind: it’s easy for developers to implement quickly, and simple for less-technical users to interact with and maintain content with a powerful intuitive dashboard.

Novu functions as an abstraction layer between your application and end users, and manages all aspects of notification workflow logic and delivery provider management.

![d1](https://mintlify.s3.us-west-1.amazonaws.com/novu/getting-started/media-assets/how-novu-works.png)

## How does it work?

Managing notifications across multiple channels is painful. Each notification delivery provider has their own SDK, authentication methods, and API quirks. This complexity dramatically increases as you add additional logic such as delays, digests/batches, or multi-tiered notification approaches.

## Without Novu

- Learn and maintain different codebases for email, SMS, push, and chat providers
- Handle varying API response formats and error patterns
- Keep track of multiple API keys and credentials
- Build abstraction layers to standardize notification logic
- Deal with provider-specific rate limits and quotas
- Maintain separate content formats and hydration methods for each channel and notification type

## API & SDKs

Novu eliminates these headaches with a unified API.

Instead of juggling multiple providers’ APIs and SDKs, you get a single, consistent interface to control all your notification flows.

With Novu

- Trigger notifications across any channel
- Manage subscriber profiles and preferences
- Power real-time notification feeds with our full-stack UI Components libraries
- Handle notification templates and workflows
- And much more.

This is a robust, highly customizable infrastructure layer that sits between your application and the user’s devices and channels.

There are two ways to integrate Novu with your application or website:

- **[Server side](https://docs.novu.co/sdks/overview)**
- **[Direct HTTP requests](https://docs.novu.co/api-reference/overview)**

Every request you make is automatically routed to the correct environment, ensuring clear separation between development and production environments.

## Workflows

Workflows are the core building blocks of Novu’s notification system. They enable you to design sophisticated messaging sequences that can span multiple communication channels like in-app, email, SMS, chat, and push.

Using intuitive logical operators and action steps, you can create dynamic notification paths that automatically adapt based on your end user preferences and behavior.

Every notification in Novu originates from a workflow trigger, making workflows the central orchestration layer for your entire messaging infrastructure.

Whether you need to send a simple welcome email or implement a complex multi-step notification sequence with digests, delays, fallbacks, and conditional logic, workflows provide the foundation for managing these communications effectively.

![wf](https://mintlify.s3.us-west-1.amazonaws.com/novu/getting-started/media-assets/novu-workflow.png)

In the code snippets below, you can see how a workflow trigger API request looks.

```bash
curl -X POST https://api.novu.co/v1/events/trigger \
  -H "Authorization: ApiKey <NOVU_SECRET_KEY>" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "<WORKFLOW_TRIGGER_IDENTIFIER>",
    "to": {
      "subscriberId": "<UNIQUE_SUBSCRIBER_IDENTIFIER>",
      "email": "john@doemail.com",
      "firstName": "John",
      "lastName": "Doe",
      "phone": "+1234567890",
      "avatar": "AVATAR_URL",
    },
    "payload": {
      "name": "Hello World",
      "organization": {
        "logo": "https://happycorp.com/logo.png"
      }
    }
  }'
```  

```go
package main

import (
 "context"
 "fmt"
 novu "github.com/novuhq/go-novu/lib"
 "log"
)

func main() {
 subscriberID := "<UNIQUE_SUBSCRIBER_IDENTIFIER>"
 apiKey := "<NOVU_SECRET_KEY>"
 eventId := "<WORKFLOW_TRIGGER_IDENTIFIER>"

 ctx := context.Background()
 to := map[string]interface{}{
  "lastName":     "Doe",
  "firstName":    "John",
  "subscriberId": subscriberID,
  "email":        "john@doemail.com",
 }

 payload := map[string]interface{}{
  "name": "Hello World",
  "organization": map[string]interface{}{
   "logo": "https://happycorp.com/logo.png",
  },
 }

 data := novu.ITriggerPayloadOptions{To: to, Payload: payload}
 novuClient := novu.NewAPIClient(apiKey, &novu.Config{})

 resp, err := novuClient.EventApi.Trigger(ctx, eventId, data)

 if err != nil {
  log.Fatal("novu error", err.Error())
  return
 }
}
```

## Subscribers

Subscribers are in most cases users in your application who receive notifications through various channels.

The subscriber is identified through one of two methods:

- A subscriberId - this uniquely identifies a specific user in your system (similar to how each user has a unique user_id in a database)
- A topicKey - this represents a channel or category that multiple subscribers can opt into (like a subscription group)
When you trigger workflows to subscribers, Novu maintains a cache of their notification-related data, including:

- Required contact information (email, phone number)
- Profile details (avatar URL)
- Platform-specific tokens (push notifications, webhooks)
- Custom properties (plan type, user role, timezone)

Below is a detailed breakdown of the subscriber object:

```json
{
  // Core Identifiers
    "subscriberId": "UNIQUE_USER_IDENTIFIER_IN_YOUR_SYSTEM",
  "_id": "NOVU_GENERATED_SUBSCRIBER_ID",
  "_organizationId": "NOVU_GENERATED_ORG_ID",
  "_environmentId": "NOVU_GENERATED_ENV_ID",

  // Basic Information
  "firstName": "John",
  "lastName": "Doe",
  "email": "john.doe@org.com",
  "phone": "+98712345670",
  "avatar": "AVATAR_URL",
  "locale": "en_US",
  "avatar": "AVATAR_URL",

  // Custom Data
  "data": {
    "custom_key_1": "custom_value_1",
    "custom_key_2": "custom_value_2"
  },

  // Communication Channels
  "channels": [
    {
      // Firebase Cloud Messaging configuration
      "credentials": {
        "deviceTokens": ["token1", "token2"]
      },
      "_integrationId": "NOVU_GENERATED_INTEGRATION_ID",
      "providerId": "fcm"
    },
    {
      // Discord configuration
      "credentials": {
        "webhookUrl": "URL"
      },
      "_integrationId": "NOVU_GENERATED_INTEGRATION_ID",
      "providerId": "discord"
    }
  ],

  // System Fields
  "deleted": false,
  "createdAt": "2022-10-13T17:40:53.231Z",
  "updatedAt": "2022-10-13T17:41:53.238Z",
  "__v": 0,
  "isOnline": false,
  "lastOnlineAt": "2022-10-13T17:41:53.238Z",
  "id": "NOVU_GENERATED_SUBSCRIBER_ID"
}
```

## Channels

To deliver notifications to subscribers, you need to configure a channel.

A channel in Novu is a configured delivery method for sending notifications to subscribers. Each channel connects to a specific delivery provider that handles the actual notification delivery.

Sending notifications with Novu:

1. Configure one or more channels by selecting and setting up providers

    Novu allows you to set up multiple notification delivery providers and integrate them into your notification workflows.

    Each channel corresponds to a configured provider that you can use to deliver notifications in production.

2. Add these channels to your notification workflows

    Use these channels individually or combine them in workflows for multi-channel notification delivery.

3. Trigger the workflow

    Make an API call or use a cURL command to trigger your workflow to a subscriberId.

    For example, you might configure an email channel using SendGrid as the provider and an SMS channel using Twilio. These channels can be used independently or together in workflows to achieve multi-channel delivery.

Here’s an overview of our supported channels and providers:

- In-app Notifications

    Build native notification experiences with our real-time notification feed API, ready-to-use UI components, and custom integration options for seamless implementation in your application.

    Learn more about **[In-app channel](https://docs.novu.co/integrations/providers/in-app/overview)** →

- Email

    Send emails through leading providers including Amazon SES, Mailersend, Mailgun, Mailjet, Mailtrap, Mandrill, Postmark, Resend, Sendgrid, SMTP, and Sparkpost.

- SMS

    Deliver SMS messages through trusted providers including Africa’s Talking, Amazon SNS, Mailersend, MessageBird, Plivo, Sinch, Telnyx, Twilio, and Vonage.

- Push Notifications

    Send push notifications across major platforms including Apple Push Notification Service for iOS, Expo for React Native, and Firebase Cloud Messaging for Android.

    Learn more about **[Push channel](https://docs.novu.co/integrations/providers/push/overview)** →

- Chat Platforms

    Integrate with popular messaging platforms including Discord, Microsoft Teams, Slack, Telegram, and WhatsApp.

    Learn more about **[Chat channel](https://docs.novu.co/integrations/providers/chat/overview)** →
