# **[getting started with containerd](https://github.com/containerd/containerd/blob/main/docs/getting-started.md)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Getting started with containerd

### Installing containerd

Option 1: From the official binaries
The official binary releases of containerd are available for the amd64 (also known as x86_64) and arm64 (also known as aarch64) architectures.

Typically, you will have to install runc and **[CNI plugins](https://github.com/containernetworking/plugins/releases)** from their official sites too.

Step 1: Installing containerd
Download the containerd-<VERSION>-<OS>-<ARCH>.tar.gz archive from <https://github.com/containerd/containerd/releases> , verify its sha256sum, and extract it under /usr/local:

```bash
cd ~/Downloads
wget https://github.com/containerd/containerd/releases/download/v1.7.20/containerd-1.7.20-linux-amd64.tar.gz
wget https://github.com/containerd/containerd/releases/download/v1.7.20/containerd-1.7.20-linux-amd64.tar.gz.sha256sum
sha256sum -c containerd-1.7.20-linux-amd64.tar.gz.sha256sum
containerd-1.7.20-linux-amd64.tar.gz: OK

sudo tar Cxzvf /usr/local containerd-1.7.20-linux-amd64.tar.gz
bin/
bin/containerd-shim-runc-v2
bin/containerd-shim
bin/ctr
bin/containerd-shim-runc-v1
bin/containerd
bin/containerd-stress
```

The containerd binary is built dynamically for glibc-based Linux distributions such as Ubuntu and Rocky Linux. This binary may not work on musl-based distributions such as Alpine Linux. Users of such distributions may have to install containerd from the source or a third party package.
musl is an implementation of the C standard library built on top of the Linux system call API, including interfaces defined in the base language standard, POSIX

FAQ: For Kubernetes, do I need to download cri-containerd-(cni-)<VERSION>-<OS-<ARCH>.tar.gz too?

Answer: No.

As the Kubernetes CRI feature has been already included in containerd-<VERSION>-<OS>-<ARCH>.tar.gz, you do not need to download the cri-containerd-.... archives to use CRI.

The cri-containerd-... archives are deprecated, do not work on old Linux distributions, and will be removed in containerd 2.0.

systemd
If you intend to start containerd via systemd, you should also download the containerd.service unit file from <https://raw.githubusercontent.com/containerd/containerd/main/containerd.service> into /usr/local/lib/systemd/system/containerd.service, and run the following commands:

```bash
systemctl daemon-reload
systemctl enable --now containerd
```

## Add crun Public Key to Keyring

## **[how to verify a file with asc signature file](https://www.baeldung.com/linux/verify-file-asc-signature)**

To get started, we’ll first need to ensure that we have the issuer’s public key in our keyring. Information on where to acquire the issuer’s public key will usually be in the same place as the target file. For the most part, this will also include the key’s fingerprint to check against when importing.

If the public key is provided through a file, we can simply download the file and then import it:

```bash
cd ~/Downloads
wget https://github.com/opencontainers/runc/raw/main/runc.keyring
gpg --show-keys --with-fingerprint runc.keyring
pub   rsa4096 2016-06-21 [SC] [expires: 2031-06-18]
      5F36 C6C6 1B54 6012 4A75  F5A6 9E18 AA26 7DDB 8DB4
uid                      Aleksa Sarai <asarai@suse.com>
uid                      Aleksa Sarai <asarai@suse.de>
sub   rsa4096 2016-06-21 [E] [expires: 2031-06-18]

pub   ed25519 2019-06-21 [C]
      C9C3 70B2 46B0 9F6D BCFC  744C 3440 1015 D1D2 D386
uid                      Aleksa Sarai <cyphar@cyphar.com>
sub   ed25519 2019-06-21 [S] [revoked: 2022-09-30]
sub   cv25519 2019-06-21 [E] [revoked: 2022-09-30]
sub   ed25519 2019-06-21 [A] [revoked: 2022-09-30]
sub   ed25519 2022-09-30 [S] [expires: 2030-03-25]
sub   cv25519 2022-09-30 [E] [expires: 2030-03-25]
sub   ed25519 2022-09-30 [A] [expires: 2030-03-25]

pub   rsa2048 2020-04-28 [SC] [expires: 2025-04-18]Releases
You can find official releases of runc on the release page.

All releases are signed by one of the keys listed in the runc.keyring file in the root of this repository.

      C242 8CD7 5720 FACD CF76  B6EA 17DE 5ECB 75A1 100E
uid                      Kir Kolyshkin <kolyshkin@gmail.com>
sub   rsa2048 2020-04-28 [E] [expires: 2025-04-18]

pub   rsa3072 2019-07-25 [SC] [expires: 2025-07-27]
      C020 EA87 6CE4 E06C 7AB9  5AEF 4952 4C6F 9F63 8F1A
uid                      Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
uid                      Akihiro Suda <suda.kyoto@gmail.com>
```

The previous command allows us to obtain the fingerprint of the key file. It’s important to compare this fingerprint to the fingerprint listed at a trusted source, such as the issuer’s website, to verify that it is the correct public key. After verifying our public key file, we can then import it:

```bash
gpg --import runc.keyring
gpg: /home/ubuntu/.gnupg/trustdb.gpg: trustdb created
gpg: key 9E18AA267DDB8DB4: public key "Aleksa Sarai <asarai@suse.com>" imported
gpg: key 34401015D1D2D386: public key "Aleksa Sarai <cyphar@cyphar.com>" imported
gpg: key 17DE5ECB75A1100E: public key "Kir Kolyshkin <kolyshkin@gmail.com>" imported
gpg: key 49524C6F9F638F1A: public key "Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>" imported
gpg: Total number processed: 4
gpg:               imported: 4
```

## Step 2: Installing runc

Download the runc.<ARCH> binary from <https://github.com/opencontainers/runc/releases> , verify its sha256sum, and install it as /usr/local/sbin/runc.

```bash
wget https://github.com/opencontainers/runc/releases/download/v1.1.13/runc.amd64

sudo install -m 755 runc.amd64 /usr/local/sbin/runc
```

The binary is built statically and should work on any Linux distribution.

Step 3: Installing CNI plugins
Download the cni-plugins-<OS>-<ARCH>-<VERSION>.tgz archive from <https://github.com/containernetworking/plugins/releases> , verify its sha256sum, and extract it under /opt/cni/bin:

```bash
mkdir -p /opt/cni/bin
tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.1.1.tgz
```

N
