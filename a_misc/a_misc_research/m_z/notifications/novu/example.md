# **[How to add In-App notifications to any web app!](https://dev.to/novu/how-to-add-in-app-notifications-to-any-web-app-1b4n)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

## TL;DR

In this article, you'll learn how to add a notification system to any app in just a few simple steps! The primary focus in making this app was to showcase just how simple it is to add notifications to an app.

![a](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Frxhya3tay69e6ixh32i5.png)

![ng](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Ftch0v30va20ixko6ugjb.png)

If you take any modern app, there's a high chance that it would have notifications functionality baked in. And why not!

Notifications make any app better by providing real-time updates and keeping users engaged. They help increase user retention by providing a medium of communication between an app and its users.

If you're reading this article, chances are that you already understand the importance of having notifications in your app and are looking for a way to add a notification system to your app.

Well, you've come to the right place. In this tutorial, we'll have a look at how we can add notifications to any app. Now, writing a custom solution every time you want to add notifications somewhere is cumbersome, I know.

But we'll use a magical tool to help make our jobs easier and believe me, this whole thing will be much simpler than you might think, pinky promise!

How, you ask?

## Enter Novu

Novu helped me solve the biggest problem I had every time I wanted to add notifications to an app - writing a notifications center from scratch.

And even though, I could re-use parts of what I'd written earlier, the unique use cases of each app ensured, I had to make significant changes to my previous system.

With Novu, I could simply grab an API key and use the custom component to add notifications to any web app. PERIOD!

## Novu - Open-source notification infrastructure for developers

Novu is an open-source notification infrastructure for developers. It helps you manage all the product notifications be it an in-app notification (a bell icon like what's there in Facebook), Emails, SMSs, Discord, and what not.

![ne](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Fgln2um5bb2rc96mv7wkg.gif)

I'll be super happy if you check us out on GitHub and give us a star! ❤️
<https://github.com/novuhq/novu>

## Let's write some code

We'll make our app in two stages - backend and front-end. Both will live in separate GitHub repositories and I'll also show you how to deploy both to the web, enabling us to access the app from anywhere.
Let's start with the backend.
