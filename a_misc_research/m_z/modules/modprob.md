# **[loaded module](https://stackoverflow.com/questions/9845877/how-to-determine-if-a-specific-module-is-loaded-in-linux-kernel)**

## 1

he modinfo module method does not work well for me. I prefer this method that is similar to the alternative method proposed:

```bash
#!/bin/sh

MODULE="$1"

if lsmod | grep -wq "$MODULE"; then
  echo "$MODULE is loaded!"
  exit 0
else
  echo "$MODULE is not loaded!"
  exit 1
fi
```

## 2

The --first-time flag causes modprobe to fail if the module is already loaded. That in conjunction with the --dry-run (or the shorthand -n) flag makes a nice test:

modprobe -n --first-time $MODULE && echo "Not loaded" || echo "Loaded"
Edit 1: As @Nobody pointed out this also prints Loaded if the module does not exist. We can fix this by combining it with modinfo:

modinfo $MODULE >/dev/null 2>/dev/null &&
! modprobe -n --first-time $MODULE 2>/dev/null &&
echo "Loaded" || echo "Not loaded"
Edit 2: On some systems modprobe lives in /usr/sbin, which is not in the $PATH unless you are root. In that case you have to substitute modprobe for /usr/sbin/modprobe in the above.
