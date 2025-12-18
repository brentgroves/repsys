# **[Web Push Notifications Explained](https://www.airship.com/resources/explainer/web-push-notifications-explained/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## referenences

- **[push notification application server](https://github.com/appleboy/gorush)**
- **[good tutorial](https://dev.to/oluwatobi_/sending-notifications-in-your-web-apps-3iof)**
- **[web push example](https://github.com/pirminrehm/service-worker-web-push-example)**
- **[web push](https://github.com/SherClockHolmes/webpush-go)**

- **[tutorial](https://dev.to/sanjampreetsingh/step-by-step-guide-to-setting-up-push-notifications-in-nodejs-backend-configuration-53gn)**

## What Are Web Push Notifications?

Web push notifications are notifications that can be sent to a user via desktop and mobile web. These alert-style messages slide in at the top or bottom right-hand corner of a desktop screen, depending on the operating system, or appear on a mobile device in a manner nearly identical to push notifications delivered from apps. Website push notifications are delivered on a user’s desktop or mobile screen whenever their browser is open — whether or not the user is on the website.

## The Difference Between Web Push Notifications & App Push Notifications

All that’s required to send web push notifications is to implement web push code snippets on a website. This means that brands that don’t have apps can leverage many of the benefits of push notifications (real-time, personalized, in-the-moment communications) even if they don’t have an app. App push notifications are sent via code installed in an app. (Learn more about push notifications from apps on our Push Notifications Explained page.)

## The Anatomy of a Web Push Notification

![wp](https://www.airship.com/wp-content/uploads/2017/12/WN-Mobile-Desktop-Combo-1024x710.jpg)
Right: Example of a web push notification on a desktop device (Macbook with a Chrome browser version 58 or older). Left: Example of a web notification delivered to an Android mobile device. Website push notifications include the following elements:

- **Notification title:** Some brands simply use their name here.
- **Notification content:** The message sent. Character count varies between browsers and operating systems. Shorter is better.
- **Notification URL:** The domain sending the web notification.
- **Notification icon:** This can be a logo or any image.
- **Browser icon:** The logo of the browser sending the notification. This can not be altered or removed.
- **Notification image** (known as “big image” or “large image”): Some browsers and operating systems support the inclusion of a large image in the web notification in addition to the notification icon.
- **Buttons:** You can add one or two buttons to your web push notification. Examples of button actions are links to a specific URL or opting a user in or out of a subscription list.

## How Web Push Notifications Work

Any company with a website can send web push notifications after installing code (a web-based SDK from a web push service) on its website. No app is required. For users, clicking or tapping on a web push notification takes the visitor to a pre-set URL determined by the brand.

## Benefits of Web Push Notifications

Web push notifications offer various benefits that can enhance your overall marketing strategy and help you connect with your audience meaningfully. Some of these benefits include:

- **Higher conversion rates:** Browser push notifications can be targeted to segmented audiences, making consumers feel cared about and leading to higher conversions.
- **Increased web traffic:** Since these messages reach clients when they aren’t on a website, the notification encourages them to return to the site, increasing visitor traffic.
- **Opt-in-based:** Users must choose to receive desktop and mobile webpush notifications so brands can trust their messages are being sent to an audience that is generally interested in their content or offerings.
- **Personalization:** When the browser notifications are personalized based on user preferences and past website interactions, users are more likely to engage because they feel seen by the brand.
- **Real-time engagement:** Notifications are delivered in real time, not just when users are on a website or app. This means audiences are instantly contacted and informed about important news, limited-time offers and more.

Works without an app: With mobile web push notifications, users don’t need to download or install an app, meaning brands without a dedicated mobile presence can still reach their audiences easily.

## The Web Notification Opt-In Process

Browser notifications are a permission-based marketing channel. Before receiving a web push, users have to opt in to receive them. The opt-in prompt comes from the user’s web browser. This prompt is called a browser-level opt-in prompt or browser-based prompt. Brands can handle the opt-in process and the timing of the opt-in ask in different ways.

![opt](https://www.airship.com/wp-content/uploads/2019/04/example-of-web-push-notification-opt-in-chrome-with-soft-ask.png)

In this image captured on a Chrome browser, the brand has created a “soft ask” for web push opt-in — the yellow bar at the top. If a user indicates in the soft ask that they’d like to receive web push notifications, then the browser-based prompt — the white box in the upper left — is displayed. The user must opt-in to the browser-based prompt to receive web notifications.

## Using a “Soft Ask” Opt-In

Some brands choose to display the “soft ask” before displaying the browser prompt. The soft opt-in conveys why a user would want to opt in to receive desktop push notifications. If a visitor says “yes” to the soft ask, then the brand will display the opt-in prompt from the browser itself.

This can be more effective for securing an opt-in than just showing the browser prompt without any additional context. For other brands, skipping the soft ask and just displaying the browser-based opt-in works as well or better. (Note: the soft ask is not a replacement for the browser-based prompt. Users must opt-in through the browser-based prompt even if they are first presented with a soft ask.

## Choosing the Timing for Opt-In Prompts

The timing of showing the opt-in varies by brand as well. Some choose to wait until a web visitor has visited a certain number of pages before offering the web push notification opt-in — whether they use a soft ask or the browser-based opt-in prompt.

Others offer the opt-in upon arrival to the site. Note that some browsers have begun requiring a user gesture (e.g., clicking a button) before the browser prompt can be shown, so brands should consider this when planning when and how they present the opt-in to their website visitors. With both the opt-in process and timing, it’s important for brands to experiment to see what approach and timing work best for getting the opt-in.

## Technical Requirements for Implementing Web Push Notifications

Brands wanting to implement web push notifications typically work with a web push service. For brands implementing the Airship’s Web Notification service, implementation requires:

- HTTPS (secure) website — or, if the website is HTTP, a brand can create one HTTPS page to handle web push registration and proxy push requests. This is known as an HTML bridge.
- Installation of 2-3 files on its website, including a javascript snippet, a push-worker.js file to be added to its service worker and an additional file called a secure bridge domain for customers who are on HTTP websites.
- If executing a “soft ask,” development of a soft ask registration prompt.

## Browsers and Devices That Support Web Push Notifications

### Browsers

Chrome, Firefox, Opera and Safari currently support web push notifications. Supported browsers vary by vendor. Notifications vary in appearance between browsers and operating systems. Some notifications use native notification centers, others don’t.

### Devices

Web push notifications work on any computer or laptop running a supported browser, whether PC or Mac. Apple added Safari support for web push in iOS & iPadOS 16.4. To use web notifications on iOS/iPadOS devices, Apple first requires a user to save the website to their home screen as a web app. Android mobile devices do support mobile web push notifications for users running Chrome, Firefox and Opera.

## Types of Messages Brands Are Sending With Web Push Notifications

For notification-style messages, brands most often send notes that fall into one of the following categories:

- **Transactional:** Confirmation of important transactions (e.g., purchase, shipping, delivery, requesting service reviews, etc.)
- **Educational:** Educating the audience about key events, products or offerings
- **Promotional:** Promoting special offers or limited-time opportunities to drive conversions
- **Lifecycle:** Welcoming new or returning visitors, incentivizing first purchase, encouraging a deeper exploration of the website, thanking social advocates and retargeting campaigns
