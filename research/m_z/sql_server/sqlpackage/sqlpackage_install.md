# **[sqlpackage install](https://learn.microsoft.com/en-us/sql/tools/sqlpackage/sqlpackage-download?view=sql-server-ver16#linux)**

- Download **[SqlPackage for Linux](https://aka.ms/sqlpackage-linux)**
  - sqlpackage-linux-x64-en-162.3.566.1.zip
- Extract the file and launch SqlPackage, open a new Terminal window and type the following commands:

```bash
cd ~
# Added this to export.zsh
mkdir -p ~/bin/sqlpackage
unzip ~/Downloads/sqlpackage-linux-<version string>.zip -d ~/bin/sqlpackage 
unzip ~/Downloads/sqlpackage-linux-x64-en-162.3.566.1.zip -d ~/bin/sqlpackage 
chmod a+x ~/bin/sqlpackage/sqlpackage
```

## Automated environments

Evergreen links are available for downloading the latest Sqlpackage versions:

Linux (<https://aka.ms/sqlpackage-linux>)
