# Python Prometheus client library

## references

<https://prometheus.github.io/client_python/>

## Summary

Summaries track the size and number of events.

```python
from prometheus_client import Summary
s = Summary('request_latency_seconds', 'Description of summary')
s.observe(4.7)    # Observe 4.7 (seconds in this case)
```

There are utilities for timing code:

```python
@s.time()

def f():
  pass



with s.time():
  pass
```

The Python client doesn’t store or expose quantile information at this time.

## Histogram

Histograms track the size and number of events in buckets. This allows for aggregatable calculation of quantiles.

```python
from prometheus_client import Histogram

h = Histogram('request_latency_seconds', 'Description of histogram')

h.observe(4.7)    # Observe 4.7 (seconds in this case)
```

The default buckets are intended to cover a typical web/rpc request from milliseconds to seconds. They can be overridden by passing buckets keyword argument to Histogram

```python
@h.time()
def f():
  pass



with h.time():
  pass
```
