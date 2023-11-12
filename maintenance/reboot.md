# How to Reboot the Report System

## References

**[Kured](https://kured.dev/docs/)**

## Kured

Kured the **[Kubernetes Reboot Daemon](https://kured.dev/docs/)**
Watches for the presence of a reboot sentinel file e.g. /var/run/reboot-required or the successful run of a sentinel command.
Cordons & drains worker nodes before reboot, uncordoning them after.
Utilises a lock in the API server to ensure only one node reboots at a time.
Optionally defers reboots in the presence of active Prometheus alerts or selected pods.
