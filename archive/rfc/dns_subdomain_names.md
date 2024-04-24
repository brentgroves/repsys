# DNS Subdomain Names

Most resource types require a name that can be used as a DNS subdomain name as defined in RFC 1123. This means the name must:

contain no more than 253 characters
contain only lowercase alphanumeric characters, '-' or '.'
start with an alphanumeric character
end with an alphanumeric character

## references

<https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#dns-subdomain-names>

<https://datatracker.ietf.org/doc/html/rfc1123>

## 1.  INTRODUCTION

   This document is one of a pair that defines and discusses the
   requirements for host system implementations of the Internet protocol
   suite.  This RFC covers the applications layer and support protocols.
   Its companion RFC, "Requirements for Internet Hosts -- Communications
   Layers" [INTRO:1] covers the lower layer protocols: transport layer,
   IP layer, and link layer.
