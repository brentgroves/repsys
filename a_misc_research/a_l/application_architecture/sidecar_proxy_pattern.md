# **[Sidecar Proxy Pattern - The Basis Of Service Mesh](https://iximiuz.com/en/posts/service-proxy-pod-sidecar-oh-my/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## references

- **[sidecar proxy](https://iximiuz.com/en/posts/service-proxy-pod-sidecar-oh-my/)**

## How services talk to each other?

Imagine you're developing a service... For certainty, let's call it A. It's going to provide some public HTTP API to its clients. However, to serve requests it needs to call another service. Let's call this upstream service - B.

![talk](https://iximiuz.com/service-proxy-pod-sidecar-oh-my/10-service-a-service-b.png)

Obviously, neither network nor service B is ideal. If service A wants to decrease the impact of the failing upstream requests on its public API success rate, it has to do something about errors. For instance, it could start retrying failed requests.

![retry](https://iximiuz.com/service-proxy-pod-sidecar-oh-my/20-service-a-service-b-with-retries.png)

Implementation of the retry mechanism requires some code changes in the service A, but the codebase is fresh, there are tons of advanced HTTP libraries, so you just need to grab one... Easy-peasy, right?

Unfortunately, this simplicity is not always the case. Replace service A with service Z that was written 10 years ago in some esoteric language by a developer that already retired. Or add to the equitation services Q, U, and X written by different teams in three different languages. As a result, the cumulative cost of the company-wide retry mechanism implementation in the code gets really high...

![mech](https://iximiuz.com/service-proxy-pod-sidecar-oh-my/30-service-qux-service-b.png)

But what if retries are not the only thing you need? Proper request timeouts have to be ensured as well. And how about distributed tracing? It'd be nice to correlate the whole request tree with the original customer transaction by propagating some additional HTTP headers. However, every such capability would make the HTTP libraries even more bloated...

## What is a sidecar proxy?

Let's try to go one level higher... or lower? 🤔

In our original setup, service A has been communicating with service B directly. But what if we put an intermediary infrastructure component in between those services? Thanks to containerization, orchestration, devops, add a buzz word of your choice here, nowadays, it became so simple to configure infrastructure, that the cost of adding another infra component is often lower than the cost of writing application code...

![what](https://iximiuz.com/service-proxy-pod-sidecar-oh-my/40-service-a-sidecar-service-b.png)

For the sake of simplicity, let's call the box enclosing the service A and the secret intermediary component a server (bare metal or virtual, doesn't really matter). And now it's about time to introduce one of the fancy words from the article's title. Any piece of software running on the server alongside the primary service and helping it do its job is called a sidecar. I hope, the idea behind the name is more or less straightforward here.

But getting back to the service-to-service communication problem, what sidecar should we use to keep the service code free of the low-level details such as retries or request tracing? Well, the needed piece of software is called a service proxy. Probably, the most widely used implementation of the service proxy in the real world is envoy.

The idea of the service proxy is the following: instead of accessing the service B directly, code in the service A now will be sending requests to the service proxy sidecar. Since both of the processes run on the same server, the loopback network interface (i.e. 127.0.0.1 aka localhost) is perfectly suitable for this part of the communication. On every received HTTP request, the service proxy sidecar will make a request to the upstream service using the external network interface of the server. The response from the upstream will be eventually forwarded back by the sidecar to the service A.

I think, at this time, it's already obvious where the retry, timeouts, tracing, etc. logic should reside. Having this kind of functionality provided by a separate sidecar process makes enhancing any service written in any language with such capabilities rather trivial.

Interestingly enough, that service proxy could be used not only for outgoing traffic (egress) but also for the incoming traffic (ingress) of the service A. Usually, there is plenty of cross-cutting things that can be tackled on the ingress stage. For instance, proxy sidecars can do SSL termination, request authentication, and more. A detailed diagram of a single server setup could look something like that:

![sss](https://iximiuz.com/service-proxy-pod-sidecar-oh-my/50-single-host-sidecar.png)

Probably, the last fancy term we are going to cover here is a pod. People have been deploying code using virtual machines or bare metal servers for a long time... A server itself is already a good abstraction and a unit of encapsulation. For instance, every server has at least one external network interface, a network loopback interface for the internal IPC needs, and it can run a bunch of processes sharing access to these communication means. Servers are usually addressable within the private network of the company by their IPs. Last but not least, it's pretty common to use a whole server for a single purpose (otherwise, maintenance quickly becomes a nightmare). I.e. you may have a group of identical servers running instances of service A, another group of servers each running an instance of service B, etc. So, why on earth would anybody want something better than a server?

Despite being a good abstraction, the orchestration overhead servers introduce is often too high. So people started thinking about how to package applications more efficiently and that's how we got containers. Well, probably you know that Docker and container had been kind of a synonym for a long time and folks from Docker have been actively advocating for "a one process per container" model. Obviously, this model is pretty different from the widely used server abstraction where multiple processes are allowed to work side by side. And that's how we got the concept of pods. A pod is just a group of containers sharing a bunch of namespaces. If we now run a single process per container all of the processes in the pod will still share the common execution environment. In particular, the network namespace. Thus, all the containers in the pod will have a shared loopback interface and a shared external interface with an IP address assigned to it. Then it's up to the orchestration layer (say hi to Kubernetes) how to make all the pods reachable within the network by their IPs. And that's how people reinvented servers...

So, getting back to all those blue boxes enclosing the service process and the sidecar on the diagrams above - we can think of them as being either a virtual machine, a bare metal server, or a pod. All three of them are more or less interchangeable abstractions.

To summarize, let's try to visualize how the service to service communication could look like with the proxy sidecars:

![vis](https://iximiuz.com/service-proxy-pod-sidecar-oh-my/60-service-to-service-topology.png)

## Sidecar proxy example (practical part)

Since the only way to really understand something is to write a blog post about it implement it yourself, let's quickly hack a **[demo environment](https://github.com/iximiuz/envoy-playground)**.

The code of the service A is relatively straightforward. It's just a simple HTTP server that makes a call to its upstream service B on every client request. Depending on the response from the upstream, A returns either an HTTP 200 or HTTP 500 to the client.

```golang
package main

// ...

var requestCounter = prometheus.NewCounterVec(
    prometheus.CounterOpts{
        Name: "service_a_requests_total",
        Help: "The total number of requests received by Service A.",
    },
    []string{"status"},
)

func handler(w http.ResponseWriter, r *http.Request) {
    resp, err := httpGet(os.Getenv("UPSTREAM_SERVICE"))
    if err == nil {
        fmt.Fprintln(w, "Service A: upstream responded with:", resp)
        requestCounter.WithLabelValues("2xx").Inc()
    } else {
        http.Error(w, fmt.Sprintf("Service A: upstream failed with: %v", err.Error()),
            http.StatusInternalServerError)
        requestCounter.WithLabelValues("5xx").Inc()
    }
}

func main() {
    // init prometheus /metrics endpoint

    http.HandleFunc("/", handler)
    log.Fatal(http.ListenAndServe(
        os.Getenv("SERVICE_HOST")+":"+os.Getenv("SERVICE_PORT"), nil))
}
```

Notice that instead of hard-coding, we use SERVICE_HOST and SERVICE_PORT env variables to specify the host and port of the HTTP API endpoint. It'll come in handy soon. Additionally, the code of the service relies on the UPSTREAM_SERVICE env variable when accessing the upstream service B.

To get some visibility, the code is instrumented with the primitive counter metric service_a_requests_total that gets incremented on every incoming request. We will use an instance of prometheus service to scrape the metrics exposed by the service A.

The implementation of the upstream service B is trivial as well. It's yet another HTTP server. However its behavior is rather close to a static endpoint.

```golang
package main

// ...

var ERROR_RATE int

var (
    requestCounter = prometheus.NewCounterVec(
        prometheus.CounterOpts{
            Name: "service_b_requests_total",
            Help: "The total number of requests received by Service B.",
        },
        []string{"status"},
    )
)

func handler(w http.ResponseWriter, r *http.Request) {
    if rand.Intn(100) >= ERROR_RATE {
        fmt.Fprintln(w, "Service B: Yay! nounce", rand.Uint32())
        requestCounter.WithLabelValues("2xx").Inc()
    } else {
        http.Error(w, fmt.Sprintf("Service B: Ooops... nounce %v", rand.Uint32()),
            http.StatusInternalServerError)
        requestCounter.WithLabelValues("5xx").Inc()
    }
}

func main() {
    // set ERROR_RATE
    // init prometheus /metrics endpoint

    http.HandleFunc("/", handler)

    // Listen on all interfaces
    log.Fatal(http.ListenAndServe(":"+os.Getenv("SERVICE_PORT"), nil))
}
```

Probably the only interesting part here is ERROR_RATE. The service is designed to fail requests with some constant rate, i.e. if ERROR_RATE is 20, approximately 20% of requests will fail with HTTP 500 status code. As with the service A, we will use prometheus to scrape basic usage statistics, see the counter service_b_requests_total.

Now it's time to launch the services and wire them up together. We are going to use podman to build and run services. Mostly because unlike Docker, podman supports the concept of pods out of the box. Heck, look at its name, it's PODman 🐵

We will start from creating the service B since it's a dependency of the service A. Clone the demo repository and run the following commands from its root (a Linux host with installed podman is assumed):
