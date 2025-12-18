# **[Site reliability engineering (SRE) teams](https://aws.amazon.com/what-is/sre/#:~:text=Site%20reliability%20engineering%20(SRE)%20teams%20collect%20critical%20information%20that%20reflects,application%20responds%20to%20a%20request.)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## What is site reliability engineering?

Site reliability engineering (SRE) is the practice of using software tools to automate IT infrastructure tasks such as system management and application monitoring. Organizations use SRE to ensure their software applications remain reliable amidst frequent updates from development teams. SRE especially improves the reliability of scalable software systems because managing a large system using software is more sustainable than manually managing hundreds of machines.

## What is monitoring in site reliability engineering?

Monitoring is a process of observing predefined metrics in an application. Developers decide which parameters are critical in determining the application's health and set them in monitoring tools. Site reliability engineering (SRE) teams collect critical information that reflects the system performance and visualize it in charts.

In SRE, software teams monitor these metrics to gain insight into system reliability.

Latency

Latency describes the delay when the application responds to a request. For example, a form submission on a website takes 3 seconds before it directs users to an acknowledgment webpage.

Traffic

Traffic measures the number of users concurrently accessing your service. It helps software teams accordingly budget computing resources to maintain a satisfactory service level for all users.

Errors

An error is a condition where the application fails to perform or deliver according to expectations. For example, when a webpage fails to load or a transaction does not go through, SRE teams use software tools to automatically track and respond to errors in the application.

Saturation

Saturation indicates the real-time capacity of the application. A high level of saturation usually results in degrading performance. Site reliability engineers monitor the saturation level and ensure it is below a particular threshold.
