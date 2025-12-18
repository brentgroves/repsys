# **[Kroki CLI](https://docs.kroki.io/kroki/setup/kroki-cli/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

The easiest way to interact with Kroki is probably to use the Kroki CLI. This client is available on **[Linux, macOS, Windows and OpenBSD](https://github.com/yuzutech/kroki-cli/releases/)** and provides a user-friendly Command Line Interface.

Once you’ve downloaded the archive, extract the kroki binary file from the archive to a directory, then open a terminal and type:

```bash
pushd .
cd ~/Downloads
curl https://github.com/yuzutech/kroki-cli/releases/download/v0.5.0/kroki-cli_0.5.0_linux_amd64.tar.gz


# Untar Tar Gz file and place uncompressed files in another directory
mkdir ./kroki_cli
tar -xzvf kroki-cli_0.5.0_linux_amd64.tar.gz  -C ./kroki_cli
sudo install ./kroki_cli/kroki /usr/local/bin/
kroki version
```
