# Check required ports

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

You can use tools like netcat to check if a port is open. For example:

```bash
nc 127.0.0.1 6443 -v
```

```bash
sudo lsof -i -P -n | grep :80
sudo lsof -i -P -n | grep :8400
```
