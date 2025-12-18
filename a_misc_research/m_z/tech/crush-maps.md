# Crush Maps

<https://docs.ceph.com/en/quincy/rados/operations/crush-map/>

The CRUSH algorithm computes storage locations in order to determine how to store and retrieve data. CRUSH allows Ceph clients to communicate with OSDs directly rather than through a centralized server or broker. By using an algorithmically-determined method of storing and retrieving data, Ceph avoids a single point of failure, a performance bottleneck, and a physical limit to its scalability.
