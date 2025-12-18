# **[Recursive Descent: ..](https://jqlang.github.io/jq/manual/v1.6/#recursive-descent)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

Recursively descends ., producing every value. This is the same as the zero-argument recurse builtin (see below). This is intended to resemble the XPath // operator. Note that ..a does not work; use .. | .a instead. In the example below we use .. | .a? to find all the values of object keys "a" in any object found "below" ..

This is particularly useful in conjunction with path(EXP) (also see below) and the ? operator.

```bash
Command jq '.. | .a?'
Input [[{"a":1}]]
Output 1
```

```bash
# istioctl proxy-config all deploy/productpage-v1 -o json | grep secret
#    "dynamic_active_secrets": [
#      "secret": {
#      "secret": {
istioctl proxy-config all deploy/productpage-v1 -o json | \
  jq -r '.. |."secret"?' | \
  jq -r 'select(.name == "default")' | \
  jq -r '.tls_certificate.certificate_chain.inline_bytes' | \
  base64 -d - | step certificate inspect
  ```
