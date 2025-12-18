# Helm

**[K8s menu](./mend)**\
**[Current Status](../a_status/detailed_status.md)**\
**[Back to Main](../README.md)**

## References

<https://helm.sh/docs/intro/install/>

## From Apt (Debian/Ubuntu)

Members of the Helm community have contributed a Helm package for Apt. This package is generally up to date.

```bash
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
# a password is required but prompt not shown
sudo apt install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt update
sudo apt install helm
```

GPG (GNU Privacy Guard) is a free, open-source implementation of the OpenPGP standard, used for encrypting and signing data and communications, offering secure communication and data integrity through public-private key cryptography.

Recall that with textbook RSA, we choose two large primes p and q and let n = p *q. We then chose an e such that gcd(e, phi(n)) = 1, where phi(n) = (p-1)(q-1). The public key is (e, n). Now find d such that e* d ≡ 1 mod phi(n). The private key is (d, n).

In the context of GnuPG (GPG), a .asc file represents an ASCII-armored signature or key, a plain text format used for storing and distributing digital signatures or public keys.

Public Keys: It can also hold a public key, which is used to verify signatures and encrypt data.
