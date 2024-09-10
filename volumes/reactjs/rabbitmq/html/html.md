# **[html test](https://cloudamqp.github.io/amqp-client.js/)**

## install

```bash
npm install @cloudamqp/amqp-client --save
```

Start node with --enable-source-maps to get proper stacktraces as the library is transpiled from TypeScript.

## Example usage

Using AMQP in Node.js:

```javascript

import { AMQPClient } from '@cloudamqp/amqp-client'

async function run() {
  try {
    const amqp = new AMQPClient("amqp://localhost")
    const conn = await amqp.connect()
    const ch = await conn.channel()
    const q = await ch.queue()
    const consumer = await q.subscribe({noAck: true}, async (msg) => {
      console.log(msg.bodyToString())
      await consumer.cancel()
    })
    await q.publish("Hello World", {deliveryMode: 2})
    await consumer.wait() // will block until consumer is canceled or throw an error if server closed channel/connection
    await conn.close()
  } catch (e) {
    console.error("ERROR", e)
    e.connection.close()
    setTimeout(run, 1000) // will try to reconnect in 1s
  }
}

run()
```

## WebSockets

This library can be used in the browser to access an AMQP server over WebSockets. For servers such as RabbitMQ that doesn't (yet?) support WebSockets natively a WebSocket TCP relay have to be used as a proxy. More information can be found in this blog post.

For web browsers a compiled and rolled up version is available at <https://github.com/cloudamqp/amqp-client.js/releases>.

Using AMQP over WebSockets in a browser:

```html
<!DOCTYPE html>
<html>
  <head>
    <script type=module>
      import { AMQPWebSocketClient } from './js/amqp-websocket-client.mjs'

      const textarea = document.getElementById("textarea")
      const input = document.getElementById("message")

      const tls = window.location.protocol === "https:"
      const url = `${tls ? "wss" : "ws"}://${window.location.host}`
      const amqp = new AMQPWebSocketClient(url, "/", "guest", "guest")

      async function start() {
        try {
          const conn = await amqp.connect()
          const ch = await conn.channel()
          attachPublish(ch)
          const q = await ch.queue("")
          await q.bind("amq.fanout")
          const consumer = await q.subscribe({noAck: false}, (msg) => {
            console.log(msg)
            textarea.value += msg.bodyToString() + "\n"
            msg.ack()
          })
        } catch (err) {
          console.error("Error", err, "reconnecting in 1s")
          disablePublish()
          setTimeout(start, 1000)
        }
      }

      function attachPublish(ch) {
        document.forms[0].onsubmit = async (e) => {
          e.preventDefault()
          try {
            await ch.basicPublish("amq.fanout", "", input.value, { contentType: "text/plain" })
          } catch (err) {
            console.error("Error", err, "reconnecting in 1s")
            disablePublish()
            setTimeout(start, 1000)
          }
          input.value = ""
        }
      }

      function disablePublish() {
        document.forms[0].onsubmit = (e) => { alert("Disconnected, waiting to be reconnected") }
      }

      start()
    </script>
  </head>
  <body>
    <form>
      <textarea id="textarea" rows=10></textarea>
      <br/>
      <input id="message"/>
      <button type="submit">Send</button>
    </form>
  </body>
</html>
```
