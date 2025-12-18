# **[How to implement a work/job queue with Redis](https://quarkus.io/blog/redis-job-queue/)**

**[Back to Research List](../../../research//research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

## references

- **[python work queue](https://github.com/MeVitae/redis-work-queue/blob/main/README.md)**
- **[golang work queue](https://pkg.go.dev/github.com/mevitae/redis-work-queue/go)**

## intro

In how to **[cache with Redis](https://quarkus.io/blog/redis-api-intro/)**, we implemented a simple cache backed by Redis.
That’s just one use case of Redis. Redis is also used as a messaging server to implement the processing of background jobs or other kinds of messaging tasks. This post explores implementing this pattern with Quarkus and the new Redis data source API.

## Job Queues and Supes

A job queue is a data structure storing execution requests. Job dispatchers submit the tasks they want to execute in that data structure. On the other side, job consumers poll the requests and execute them.

![jobs](https://quarkus.io/assets/images/posts/redis-job-queue/pattern.png)

There are plenty of variants of that pattern, so let’s focus on the following application. We have an application managing heroes and villains. The application offers the possibility to simulate a fight between a random hero and a random villain. The fight simulation is delegated to fight simulators, applications dedicated to that task.

![dom](https://quarkus.io/assets/images/posts/redis-job-queue/application.png)

In this context, the main application submits the fight request to the job queue. Then, the fight simulators poll the submitted fight request and execute them.

The fight outcomes are communicated using another Redis feature: pub/sub communication. The simulators send the outcome to a channel consumed by the application. The application then broadcasts these outcomes to a web page.

This post only discusses the interaction with Redis. The rest of the application is straightforward and just uses RESTEasy Reactive and Hibernate ORM with Panache. You can find the full code of the application on <https://github.com/cescoffier/quarkus-redis-job-queue-demo>.

## Submitting jobs

The first task is to model the job queue. We are using a Redis list to store the FightRequest.

```java
package me.escoffier.quarkus.redis.fight;

public record FightRequest(String id, Hero hero, Villain villain) {

}
```
