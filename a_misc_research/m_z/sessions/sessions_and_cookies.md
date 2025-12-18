# **[Session and cookies](https://www.sohamkamani.com/web-security-basics/#sessions-and-cookies)**

## Sessions and Cookies

Irrespective of what type of website you’re making, if authentication is involved, you’ll encounter sessions and cookies.

Every website receives multiple requests from multiple different users. The key problem we’re trying to solve here is: How does the web server know which user is sending each request?

One option is to send information about the user to the browser just as they login. The browser will then store this information, and send it along with every subsequent request so that the server knows where it’s coming from.

The problem with this is that it isn’t secure. Any other browser (perhaps one that the user logged into previously) could also make a request with with this id and compromise the users security.

![alt](https://www.sohamkamani.com/web-security-basics/session-cookie-1.svg)

We need something more temporary

## Session Tokens

It is in our best interest to give as little information about the user to the browser as possible. So, instead of returning identifying information about the authenticated user, we instead return a piece of data called the “session token”.
