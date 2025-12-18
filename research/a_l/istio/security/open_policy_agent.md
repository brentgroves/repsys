# **[Open Policy Agent (OPA)](https://www.openpolicyagent.org/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

![opa](https://www.openpolicyagent.org/img/banner-image-wide.jpg)

Stop using a different policy language, policy model, and policy API for every product and service you use. Use OPA for a unified toolset and framework for policy across the cloud native stack.

Whether for one service or for all your services, use OPA to decouple policy from the service's code so you can release, analyze, and review policies (which security and compliance teams love) without sacrificing availability or performance.

## Declarative Policy

Context-aware, Expressive, Fast, Portable

```opa
ackage kubernetes.admission

import rego.v1

deny contains sprintf("image '%s' comes from untrusted registry", [container.image]) if {
 input.request.kind.kind == "Pod"
 some container in input.request.object.spec.containers
 not startswith(container.image, "hooli.com/")
}
```

**Declarative.** Express policy in a high-level, declarative language that promotes safe, performant, fine-grained controls. Use a language purpose-built for policy in a world where JSON is pervasive. Iterate, traverse hierarchies, and apply 150+ built-ins like string manipulation and JWT decoding to declare the policies you want enforced.

**Context-aware.** Leverage external information to write the policies you really care about. Stop inventing roles that represent complex relationships that years down the road no one will understand. Instead, write logic that adapts to the world around it and attach that logic to the systems that need it.
