# **[What is the difference between application/x-www-form-urlencoded and multipart/form-data OR text/plain?](https://medium.com/@codingscenes/application-x-www-form-urlencoded-and-multipart-form-data-are-two-different-formats-for-3678a10073e9)**

`application/x-www-form-urlencoded` and `multipart/form-data` are two different formats for encoding form data in HTTP requests.

`application/x-www-form-urlencoded` is the default format used by HTML forms. In this format, the data is encoded as key-value pairs separated by `&` characters, with the key and value separated by `=` characters. For example, `key1=value1&key2=value2`. This format is simple and efficient, but it has limitations in terms of the types of data that can be sent.

`multipart/form-data` is a more flexible format that can be used to send binary data, such as files, as well as text data. In this format, the data is divided into multiple parts, each with its own set of headers. Each part is separated by a boundary string, which is specified in the `Content-Type` header. This format is more complex than `application/x-www-form-urlencoded`, but it allows for more types of data to be sent.

In general, you should use `application/x-www-form-urlencoded` for simple text data, such as form fields, and `multipart/form-data` for binary data, such as files.

The text/plain format is used to send plain text data in HTTP requests.

In this format, the data is simply a sequence of characters with no special formatting or encoding. This format is often used for sending simple text data, such as log files or error messages, in HTTP requests.

For example, you could use the text/plain format to send a plain text message in the request body of a POST request:

```python
fetch(‘/api/messages’, {
Smethod: ‘POST’,
headers: {
‘Content-Type’: ‘text/plain’
},
body: ‘Hello, world!’
})
```

In this example, we’re sending the string “Hello, world!” in the request body as plain text. The Content-Type header is set to text/plain to indicate that the data is plain text.

The application/json format is used to send data in JSON (JavaScript Object Notation) format in HTTP requests.

In this format, the data is encoded as a JSON string, which is a lightweight data interchange format that is easy for humans to read and write, and easy for machines to parse and generate. JSON is often used to send structured data, such as objects and arrays, in HTTP requests.

For example, you could use the application/json format to send a JSON object in the request body of a POST request:

```python
fetch(‘/api/users’, {

method: ‘POST’,

headers: {

‘Content-Type’: ‘application/json’

},

body: JSON.stringify({

name: ‘John Doe’,

email: ‘john.doe@example.com’,

age: 30

})

})
```

In this example, we’re sending a JSON object with the name, email, and age properties in the request body as a JSON string. The Content-Type header is set to application/json to indicate that the data is in JSON format.
