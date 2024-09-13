# **[How to implement a job queue with Redis](https://quarkus.io/blog/redis-job-queue/)**

**[Back to Research List](../../../research//research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

In how to **[cache with Redis](https://quarkus.io/blog/redis-api-intro/)**, we implemented a simple cache backed by Redis.
That’s just one use case of Redis. Redis is also used as a messaging server to implement the processing of background jobs or other kinds of messaging tasks. This post explores implementing this pattern with Quarkus and the new Redis data source API.

## Job Queues and Supes

A job queue is a data structure storing execution requests. Job dispatchers submit the tasks they want to execute in that data structure. On the other side, job consumers poll the requests and execute them.
