# **[How Pods handle problems with containers](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#container-restarts)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

Kubernetes manages container failures within Pods using a restartPolicy defined in the Pod spec. This policy determines how Kubernetes reacts to containers exiting due to errors or other reasons, which falls in the following sequence:

- **Initial crash:** Kubernetes attempts an immediate restart based on the Pod restartPolicy.
- **Repeated crashes:** After the initial crash Kubernetes applies an exponential backoff delay for subsequent restarts, described in restartPolicy. This prevents rapid, repeated restart attempts from overloading the system.
- **CrashLoopBackOff state:** This indicates that the backoff delay mechanism is currently in effect for a given container that is in a crash loop, failing and restarting repeatedly.
- **Backoff reset:** If a container runs successfully for a certain duration (e.g., 10 minutes), Kubernetes resets the backoff delay, treating any new crash as the first one.

In practice, a CrashLoopBackOff is a condition or event that might be seen as output from the kubectl command, while describing or listing Pods, when a container in the Pod fails to start properly and then continually tries and fails in a loop.

In other words, when a container enters the crash loop, Kubernetes applies the exponential backoff delay mentioned in the Container restart policy. This mechanism prevents a faulty container from overwhelming the system with continuous failed start attempts.

The CrashLoopBackOff can be caused by issues like the following:

- Application errors that cause the container to exit.
- Configuration errors, such as incorrect environment variables or missing configuration files.
- Resource constraints, where the container might not have enough memory or CPU to start properly.
- Health checks failing if the application doesn't start serving within the expected time.
- Container liveness probes or startup probes returning a Failure result as mentioned in the probes section.

To investigate the root cause of a CrashLoopBackOff issue, a user can:

- Check logs: Use kubectl logs <name-of-pod> to check the logs of the container. This is often the most direct way to diagnose the issue causing the crashes.
