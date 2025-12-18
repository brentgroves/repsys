# Bash looping

```bash
for from in "foo" "bar" "legacy"; do for to in "foo" "bar" "legacy"; do kubectl exec "$(kubectl get pod -l app=curl -n ${from} -o jsonpath={.items..metadata.name})" -c curl -n ${from} -- curl "http://httpbin.${to}:8000/ip" -s -o /dev/null -w "curl.${from} to httpbin.${to}: %{http_code}\n"; done; done
```
