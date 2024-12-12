# **[Fortio](https://github.com/fortio/fortio)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

Fortio (Φορτίο) started as, and is, Istio's load testing tool and later (2018) graduated to be its own project.

Fortio is also used by, among others, **[Meshery](https://docs.meshery.io/extensibility/load-generators)**.

Fortio runs at a specified query per second (qps) and records a histogram of execution time and calculates percentiles (e.g., p99 i.e., the response time such as 99% of the requests take less than that number (in seconds, SI unit)). It can run for a set duration, for a fixed number of calls, or until interrupted (at a constant target QPS, or max speed/load per connection/thread).

The name fortio comes from Greek φορτίο which means load/burden.

Fortio is a fast, small (4Mb Docker image, minimal dependencies), reusable, embeddable go library as well as a command line tool and server process, the server includes a simple web UI and REST API to trigger run and see graphical representation of the results (both a single latency graph and a multiple results comparative min, max, avg, qps and percentiles graphs).

Fortio also includes a set of server side features (similar to httpbin) to help debugging and testing: request echo back including headers, adding latency or error codes with a probability distribution, TCP echoing, TCP proxying, HTTP fan out/scatter and gather proxy server, gRPC echo/health in addition to HTTP, etc...

Fortio is quite mature and very stable with no known major bugs (lots of possible improvements if you want to contribute though!), and when bugs are found they are fixed quickly, so after 1 year of development and 42 incremental releases, we reached 1.0 in June 2018.

Fortio components can be used a library even for unrelated projects, for instance the stats, or fhttp utilities both client and server. A recent addition is the new jrpc JSON Remote Procedure Calls library package (docs).

Fortio components can be used a library even for unrelated projects, for instance the stats, or fhttp utilities both client and server. A recent addition is the new jrpc JSON Remote Procedure Calls library package (docs).

We also have moved some of the library to their own toplevel package, like:

Dynamic flags: fortio.org/dflag
Logger: fortio.org/log - now using structured JSON logs for servers (vs text for CLIs) since fortio 1.55 / log 1.4. In color since fortio 1.57 / log 1.6.
Version helper: fortio.org/version
CLI helpers integrating the above to reduce toil making new tools fortio.org/cli and servers fortio.org/scli for arguments, flags, usage, dynamic config, etc...
If you want to connect to fortio using HTTPS and fortio to provide real TLS certificates, or to multiplex gRPC and regular HTTP behind a single port, check out Fortio Proxy.

If you want fortio to generate detailed Open Telemetry traces use Fortiotel.

We also have moved some of the library to their own toplevel package, like:

## Installation

We publish a multi architecture Docker image (linux/amd64, linux/arm64, linux/ppc64le, linux/s390x) fortio/fortio.

For instance:

```bash
docker run -p 8080:8080 -p 8079:8079 fortio/fortio server & # For the server
docker run fortio/fortio load -logger-force-color http://www.google.com/ # For a test run, forcing color instead of JSON log output
```

You can install from source:

Install go (golang 1.18 or later)
`go install fortio.org/fortio@latest`
you can now run fortio (from your gopath bin/ directory, usually ~/go/bin)
