# **[tar.gz files](https://www.nexcess.net/help/how-to-decompress-files-in-gzip/#:~:text=How%20to%20Unzip%20GZ%20Files,we%20use%20the%20%2Dk%20flag.)**

**[Current Status](../../../`development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## How to Unzip TAR.GZ Files

You can Untar Gzip-compressed Tar archives using the -x (extract) flag the Tar command provides. Again, you can specify what directory you would like to extract the archived files to, as Tar will place all the contents of the TGZ file to the current working directory by default.

```bash
# Untar Tar Gz file and place uncompressed files in another directory
mkdir ./kroki_cli
tar -xzvf kroki-cli_0.5.0_linux_amd64.tar.gz  -C ./kroki_cli
sudo install ./kroki_cli/kroki /usr/local/bin/
```
