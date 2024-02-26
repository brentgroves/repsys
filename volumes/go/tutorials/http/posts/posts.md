# Go: **[How to send POST HTTP requests with a JSON body](https://www.practical-go-lessons.com/post/go-how-to-send-post-http-requests-with-a-json-body-cbhvuqa220ds70kp2lkg)**

Go has a built-in library to deal with http. It has inside a client (to send request) and a server (to receive requests).

Suppose you want to run this request: POST https://example.com/teacher.

With the following JSON body:

```json
{
  "id": "42",
  "firstname": "John",
  "lastname": "Doe"
}
```



