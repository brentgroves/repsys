# **[Service Workers API](https://developer.mozilla.org/en-US/docs/Web/API/Service_Worker_API)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

Service workers essentially act as proxy servers that sit between web applications, the browser, and the network (when available). They are intended, among other things, to enable the creation of effective **offline** experiences, intercept network requests, and take appropriate action based on whether the network is available, and update assets residing on the server. They will also allow access to push notifications and background sync APIs.

## Service worker concepts and usage

A service worker is an event-driven **[worker](https://developer.mozilla.org/en-US/docs/Web/API/Worker)** registered against an origin and a path. It takes the form of a JavaScript file that can control the web page/site that it is associated with, intercepting and modifying navigation and resource requests, and caching resources in a very granular fashion to give you complete control over how your app behaves in certain situations (the most obvious one being when the network is not available).

Service workers run in a worker context: they therefore have no DOM access and run on a different thread to the main JavaScript that powers your app. They are non-blocking and designed to be fully asynchronous. As a consequence, APIs such as synchronous XHR and Web Storage can't be used inside a service worker.

Service workers can't import JavaScript modules dynamically, and import() will throw if it is called in a service worker global scope. Static imports using the import statement are allowed.

Service workers only run over HTTPS, for security reasons. Most significantly, HTTP connections are susceptible to malicious code injection by man in the middle attacks, and such attacks could be worse if allowed access to these powerful APIs. In Firefox, service worker APIs are also hidden and cannot be used when the user is in private browsing mode.

The Worker interface of the Web Workers API represents a background task that can be created via script, which can send messages back to its creator.

Creating a worker is done by calling the Worker("path/to/worker/script") constructor.

Workers may themselves spawn new workers, as long as those workers are hosted at the same origin as the parent page.

Note that not all interfaces and functions are available to web workers. See Functions and classes available to Web Workers for details.
