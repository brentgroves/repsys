# **[sqlpackage install](https://learn.microsoft.com/en-us/sql/tools/sqlpackage/sqlpackage-download?view=sql-server-ver16#linux)**

- Download **[SqlPackage for Linux](https://aka.ms/sqlpackage-linux)**
- Extract the file and launch SqlPackage, open a new Terminal window and type the following commands:

```bash
cd ~
mkdir sqlpackage
unzip ~/Downloads/sqlpackage-linux-<version string>.zip -d ~/sqlpackage 
echo "export PATH=\"\$PATH:$HOME/sqlpackage\"" >> ~/.bashrc
chmod a+x ~/sqlpackage/sqlpackage
source ~/.bashrc
sqlpackage
```

## Automated environments

Evergreen links are available for downloading the latest Sqlpackage versions:

Linux (<https://aka.ms/sqlpackage-linux>)
