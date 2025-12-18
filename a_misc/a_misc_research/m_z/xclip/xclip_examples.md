# **[Copy and paste at the Linux command line with xclip](https://opensource.com/article/19/7/xclip)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

```bash
az aks show --resource-group $RESOURCE_GROUP --name $CLUSTER | xclip -sel clip

xclip -selection c < ~/src/pki/intermediateCA/certs/client.linamar.com.crt
```
