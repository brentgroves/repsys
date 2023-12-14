# Shiny

## references

<https://shiny.posit.co/r/getstarted/shiny-basics/lesson7/>
<https://docs.posit.co/shiny-server/#getting-started>
<https://rocker-project.org/images/versioned/shiny.html>
<https://github.com/rocker-org/shiny>

## Is Shiny Server free

You can host your Shiny apps free of charge as long as you have 5 or fewer applications and don't need more than 25 active hours. If you need to scale, the paid plans start at $9 per month

You can now build a useful Shiny app, but can you share it with others? This lesson will show you several ways to share your Shiny apps.

When it comes to sharing Shiny apps, you have two basic options:

Share your Shiny app as R scripts. This is the simplest way to share an app, but it works only if your users have R on their own computer (and know how to use it). Users can use these scripts to launch the app from their own R session, just like you’ve been launching the apps so far in this tutorial.

Share your Shiny app as a web page. This is definitely the most user friendly way to share a Shiny app. Your users can navigate to your app through the internet with a web browser. They will find your app fully rendered, up to date, and ready to go.

Share as R scripts
Anyone with R can run your Shiny app. They will need a copy of your app.R file, as well as any supplementary materials used in your app (e.g., www folders or helpers.R files).

To send your files to another user, email the files (perhaps in a zip file) or host the files online.

Your user can place the files into an app directory in their working directory. They can launch the app in R with the same commands you used on your computer.

## install.packages("shiny")

library(shiny)
runApp("census-app")

## 1 Getting Started

1.1 Introduction
Shiny Server enables users to host and manage Shiny applications on the Internet. Shiny is an R package that uses a reactive programming model to simplify the development of R-powered web applications. Shiny Server can manage R processes running various Shiny applications over different URLs and ports. Using Shiny Server offers a variety of benefits over simply running Shiny in R directly. These features allow the administrator to:

Host multiple applications simultaneously, each at its own URL.
Support web browsers that don't support WebSocket, including Internet Explorer 8 & 9.
Enable system users to develop and manage their own Shiny applications.
Ensure that R processes that crash or are terminated automatically restart for the next user requesting the application.
PRO
This manual describes Shiny Server Professional, which offers, among other things, the following additional features:

Ensure your applications are protected and can only be accessed by specific, authenticated users.
Scale a Shiny application to support many users by empowering a Shiny application to be backed by multiple R Shiny processes simultaneously.
Gain insight into the performance and usage of your Shiny applications by monitoring them using a web dashboard.
Securely encrypt data being sent to and from your applications using SSL.
Understand and manage current and historical application resource utilization to better configure and optimize your applications.
Fine-tune the resources devoted to each user of an application by configuring multi-process Shiny applications based on the number of concurrent sessions.
Monitor the health of your Shiny Server using the health check endpoint.
