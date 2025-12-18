
# **[Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/)**

**[Report System Install](../../../../research_list.md)**\
**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../../README.md)**

## references

- **[Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/)**
- **[](https://kubernetes.io/docs/concepts/security/pod-security-standards)**

 **[Pod Security Policies](https://overcast.blog/mastering-kubernetes-pod-security-policies-psp-d28c0ce0634d)**

## Pod Security Admission

FEATURE STATE: Kubernetes v1.25 [stable]
The Kubernetes Pod Security Standards define different isolation levels for Pods. These standards let you define how you want to restrict the behavior of pods in a clear, consistent fashion.

Kubernetes offers a built-in Pod Security admission controller to enforce the Pod Security Standards. Pod security restrictions are applied at the namespace level when pods are created.

Built-in Pod Security admission enforcement\
This page is part of the documentation for Kubernetes v1.31. If you are running a different version of Kubernetes, consult the documentation for that release.

Pod Security levels\
Pod Security admission places requirements on a Pod's Security Context and other related fields according to the three levels defined by the Pod Security Standards: privileged, baseline, and restricted. Refer to the **[Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards)** page for an in-depth look at those requirements.

| Mode    | Description                                                                                                                           |
|---------|---------------------------------------------------------------------------------------------------------------------------------------|
| enforce | Policy violations will cause the pod to be rejected.                                                                                  |
| audit   | Policy violations will trigger the addition of an audit annotation to the event recorded in the audit log, but are otherwise allowed. |
| warn    | Policy violations will trigger a user-facing warning, but are otherwise allowed.                                                      |

A namespace can configure any or all modes, or even set a different level for different modes.

For each mode, there are two labels that determine the policy used:

```yaml
# The per-mode level label indicates which policy level to apply for the mode.
#
# MODE must be one of `enforce`, `audit`, or `warn`.
# LEVEL must be one of `privileged`, `baseline`, or `restricted`.
pod-security.kubernetes.io/<MODE>: <LEVEL>

# Optional: per-mode version label that can be used to pin the policy to the
# version that shipped with a given Kubernetes minor version (for example v1.31).
#
# MODE must be one of `enforce`, `audit`, or `warn`.
# VERSION must be a valid Kubernetes minor version, or `latest`.
pod-security.kubernetes.io/<MODE>-version: <VERSION>
```

Check out **[Enforce Pod Security Standards with Namespace Labels](https://kubernetes.io/docs/tasks/configure-pod-container/enforce-standards-namespace-labels)** to see example usage.
