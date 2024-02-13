# SqlPackage Installation

## Install dotnet sdk

<https://learn.microsoft.com/en-us/sql/tools/sqlpackage/sqlpackage-download?view=sql-server-ver16#installation-zip-download>

<https://learn.microsoft.com/en-us/sql/tools/sqlpackage/sqlpackage-download?view=sql-server-ver16>

```bash
sudo apt update && sudo apt install -y dotnet-sdk-7.0
```

## Install SqlPackage

Download **[SqlPackage for Linux](https://aka.ms/sqlpackage-linux)**.

To extract the file and launch SqlPackage, open a new Terminal window and type the following commands:

```bash
# sqlpackage-linux-x64-en-162.1.172.1
cd ~
mkdir sqlpackage
unzip ~/Downloads/sqlpackage-linux-x64-en-162.1.172.1.zip -d ~/sqlpackage 
# This path is now in dotfile export.sh 
echo "export PATH=\"\$PATH:$HOME/sqlpackage\"" >> ~/.bashrc
chmod a+x ~/sqlpackage/sqlpackage
source ~/.bashrc
sqlpackage
```
