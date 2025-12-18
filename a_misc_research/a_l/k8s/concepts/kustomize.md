# **[kubectl kustomize

](<https://kubernetes.io/docs/reference/kubectl/generated/kubectl_kustomize/>)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Synopsis

Build a set of **[KRM resources](https://github.com/kubernetes/design-proposals-archive/blob/main/architecture/resource-management.md)** using a 'kustomization.yaml' file. The DIR argument must be a path to a directory containing 'kustomization.yaml', or a git repository URL with a path suffix specifying same with respect to the repository root. If DIR is omitted, '.' is assumed.

```bash
kubectl kustomize DIR [flags]
```

## Examples

```bash
# Build the current working directory
kubectl kustomize
  
# Build some shared configuration directory
kubectl kustomize /home/config/production
  
Build from github
kubectl kustomize https://github.com/kubernetes-sigs/kustomize.git/examples/helloWorld?ref=v1.0.6
