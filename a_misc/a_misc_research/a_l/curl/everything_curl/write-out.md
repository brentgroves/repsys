# **[Everything Curl](https://everything.curl.dev/http/response.html#http-response-codes)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## HTTP response codes

An HTTP transfer gets a 3 digit response code back in the first response line. The response code is the server's way of giving the client a hint about how the request was handled.

It is important to note that curl does not consider it an error even if the response code would indicate that the requested document could not be delivered (or similar). curl considers a successful sending and receiving of HTTP to be good.

The first digit of the HTTP response code is a kind of error class:

1xx: transient response, more is coming
2xx: success
3xx: a redirect
4xx: the client asked for something the server could not or would not deliver
5xx: there is a problem in the server
Remember that you can use curl's --write-out option to extract the response code. See the --write-out section.

To make curl return an error for response codes >= 400, you need to use --fail or --fail-with-body. Then curl exits with error code 22 for such occurrences.

## **[Write Out](https://everything.curl.dev/usingcurl/verbose/writeout.html)**

--write-out or just -w for short, outputs text and information after a transfer is completed. It offers a large range of variables that you can include in the output, variables that have been set with values and information from the transfer.

Instruct curl to output a string by passing plain text to this option:

`curl -w "formatted string" http://example.com/`

…and you can also have curl read that string from a given file instead if you prefix the string with '@':

`curl -w @filename http://example.com/`
…or even have curl read the string from stdin if you use '-' as filename:

`curl -w @- http://example.com/`

## Variables

The variables that are available are accessed by writing %{variable_name} in the string and that variable is substituted by the correct value. To output a plain % you write it as %%. You can also output a newline by using \n, a carriage return with \r and a tab space with \t.

As an example, we can output the Content-Type and the response code from an HTTP transfer, separated with newlines and some extra text like this:

```bash
curl -w "Type: %{content_type}\nCode: %{response_code}\n" \
  http://example.com
```

The output is sent to stdout by default so you probably want to make sure that you do not also send the downloaded content to stdout as then you might have a hard time to separate out the data; or use %{stderr} to send the output to stderr.
