# Install Shell scripts

Go to a development system with the repo of the shell scripts to be installed.

## mirror

mirror -c source_dir target_dir
source_dir is the ftp server dir
target_dir is the ftp client dir

examples:

```bash
pushd .
cd ~/src/repsys/shell_scripts
lftp brent@reports31
# copies all files in ~/src/repsys/shell_scripts to reports31 ~ dir
mirror -R
popd
```
