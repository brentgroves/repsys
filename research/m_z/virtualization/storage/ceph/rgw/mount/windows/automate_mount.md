# **[](https://www.nakivo.com/blog/mount-amazon-s3-as-a-drive-how-to-guide/)**

How to automate mounting an S3 bucket on Windows boot
It is convenient when the bucket is mounted as a network drive automatically on Windows boot. Let’s find out how to configure the automatic mounting of the S3 bucket in Windows.

1. Create the rclone-S3.cmd file in the C:\rclone\ directory.
Add the string to the rclone-S3.cmd file:
`C:\rclone\rclone.exe mount mybucket:mybucket/ S: --links --vfs-cache-mode full`

## 2. Save the CMD file

You can run this CMD file instead of typing the command to mount the S3 bucket manually.

## 3. Copy the rclone-S3.cmd file to the startup folder for all users

`C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp`

```bash
copy .\rclone-S3.cmd 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\'

run 
shell:startup
start /b C:\rclone\rclone.exe mount mybucket:mybucket/ S: --links --vfs-cache-mode full

start "" "C:\rclone\rclone.exe" mount mybucket:mybucket/ S: --links --vfs-cache-mode full

powershell.exe -windowstyle hidden -file C:\iis_test.ps1

Invoke-Expression "& "C:\rclone\rclone.exe mount mybucket:mybucket/ S: --links --vfs-cache-mode full"

powershell -noexit "& ""C:\rclone\test.ps1"""

Invoke-Expression "& `"C:\Program Files\Automated QA\TestExecute 8\Bin\TestExecute.exe`" C:\temp\TestProject1\TestProject1.pjs /run /exit /SilentMode"

start "" "c:\program files\Microsoft Virtual PC\Virtual PC.exe" -pc MY-PC -launch
```

As an alternative, you can create a shortcut to C:\Windows\System32\cmd.exe and set the arguments needed to mount an S3 bucket in the target properties:
C:\Windows\System32\cmd.exe /k cd c:\rclone & rclone mount blog-bucket01:blog-bucket01/ S: –vfs-cache-mode full
