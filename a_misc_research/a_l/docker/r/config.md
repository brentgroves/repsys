# R Studio configuration

## references

<https://www.danieldsjoberg.com/rstudio.prefs/>
<https://support.posit.co/hc/en-us/articles/200552316-Configuring-RStudio-Workbench-RStudio-Server>
<https://docs.posit.co/ide/desktop-pro/1.3.404-2/settings.html>

## R Studio preference file

<https://www.danieldsjoberg.com/rstudio.prefs/>

rstudio.prefs
As of RStudio v1.3, the preferences in the Global Options dialog (and a number of other preferences that aren’t) are now saved in simple, plain-text JSON files. The {rstudio.prefs} package provides an interface for working with these RStudio JSON preference files to easily make modifications without using the point-and-click option menus. This is particularly helpful when working on teams to ensure a unified experience across machines and utilizing settings for best practices.

Installation
Install {rstudio.prefs} from CRAN with:

install.packages("rstudio.prefs")

Examples
Set RStudio Preferences
Update the RStudio default preferences. Full list of modifiable settings here: <https://docs.rstudio.com/ide/server-pro/session-user-settings.html>

```r
library(rstudio.prefs)

use_rstudio_prefs(
  always_save_history = FALSE,
  save_workspace = "never",
  load_workspace = FALSE,
  rainbow_parentheses = TRUE
)
#> √ Downloading list of available RStudio settings
#>
#> == Updates ==================================================
#> - always_save_history   [TRUE   --> FALSE]
#> - save_workspace        [ask    --> never]
#> - load_workspace        [TRUE   --> FALSE]
#> - rainbow_parentheses   [FALSE  --> TRUE ]
#> 
#> Would you like to continue? [y/n] y
#> √ File 'C:/Users/sjobergd/AppData/Roaming/RStudio/rstudio-prefs 2021-06-20.json' saved as backup.
#> √ File 'C:/Users/sjobergd/AppData/Roaming/RStudio/rstudio-prefs.json' updated.
#> * Restart RStudio for updates to take effect.
```

## R Studion config

<https://docs.posit.co/ide/desktop-pro/1.3.404-2/settings.html>

4.1 Preferences
User preferences set in the RStudio IDE’s Global Options dialog can also be set in the JSON file rstudio-prefs.json, located in the settings directory described above.

4.1.1 Example
By default, RStudio Server asks to save the workspace after the R session ends, and it always loads the workspace when starting a new session. Some organizations prefer to disable this behavior in order to discourage users from accumulating too much ad-hoc state. To do so, set the following:

%PROGRAMDATA%-prefs.json

```json
{
    "save_workspace": "never",
    "load_workspace": false
}
```

```bash
docker exec -it kind_mcnulty bash
ls -alh /home/rstudio/.config/rstudio/
total 12K
drwxr-xr-x 2 rstudio rstudio 4.0K Nov  6 10:29 .
drwxr-xr-x 3 rstudio rstudio 4.0K Nov  6 10:29 ..
-rw-r--r-- 1 rstudio rstudio  150 Nov  6 10:29 rstudio-prefs.json

```

copy config file from rstudio image so you can modify it and add it to your compose volume section.

```bash
% # sudo docker cp container-id:/home/rstudio/.config/rstudio/rstudio-prefs.json ~/src/repsys/docker/r/rstudio-prefs.json
sudo docker cp 841ebf23455e:/home/rstudio/.config/rstudio/rstudio-prefs.json ~/src/repsys/docker/r/rstudio-prefs.json


```

## r server config file

<https://support.posit.co/hc/en-us/articles/200552316-Configuring-RStudio-Workbench-RStudio-Server>

RStudio Workbench (previously RStudio Server Pro) is configured by adding entries to two configuration files (note that these files do not exist by default so you will need to create them if you wish to specify custom settings):

/etc/rstudio/rserver.conf
/etc/rstudio/rsession.conf
After editing configuration files you should perform a check to ensure that the entries you specified are valid. This can be accomplished by executing the following command:

Network Port and Address
After initial installation RStudio accepts connections on port 8787. If you wish to change to another port you should create an /etc/rstudio/rserver.conf file (if one doesn't already exist) and add a www-port entry corresponding to the port you want RStudio to listen on. For example:

www-port=80
By default RStudio binds to address 0.0.0.0 (accepting connections from any remote IP). You can modify this behavior using the www-address entry. For example:

www-address=127.0.0.1
Note that after editing the /etc/rstudio/rserver.conf file you should always restart the server to apply your changes (and validate that your configuration entries were valid). You can do this by entering the following command:

$ sudo rstudio-server restart

```bash
docker exec -it kind_mcnulty bash
ls /etc/rstudio/
database.conf  disable_auth_rserver.conf  file-locks  fonts  logging.conf  rserver.conf  rsession.conf  themes

```

copy config file from rstudio image so you can modify it and add it to your compose volume section.

```bash
% # sudo docker cp container-id:/etc/rstudio/rserver.conf ~/src/repsys/docker/r/rserver.conf
sudo docker cp 841ebf23455e:/etc/rstudio/rserver.conf ~/src/repsys/docker/r/rserver.conf


```
