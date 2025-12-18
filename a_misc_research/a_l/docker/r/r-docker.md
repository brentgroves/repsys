# R in docker

## references

<https://rocker-project.org/>
<https://github.com/rstudio/r-docker>
<https://rocker-project.org/images/>
<https://solutions.posit.co/envs-pkgs/environments/docker/>
<https://rocker-project.org/images/versioned/rstudio.html>

## The Rocker Project

Docker Containers for the R Environment

Ensure you have Docker installed and start R inside a container with:

```bash
docker run --rm -ti r-base
```

## Or get started with an RStudio® instance

```bash
docker run --rm -ti -e PASSWORD=yourpassword -p 8787:8787 rocker/rstudio

```

and point your browser to localhost:8787. Log in with user/password rstudio/yourpassword.

<https://rocker-project.org/images/>

## Overview

<https://rocker-project.org/images/versioned/rstudio.html>

These images are based on rocker/r-ver, and RStudio Server is already installed.

The basic usage of these images is the same, with the difference being the amount of additional (R) packages installed. (See image details for lists of installation packages)

- rocker/tidyverse has already installed many R packages and their dependencies apt packages. e.g. the tidyverse package, the devtools package, the rmarkdown package, some R Database Interface packages, the data.table package, the fst package, and the Apache Arrow R package.
- rocker/verse has already installed TeX Live and some publishing-related R packages, in addition to the packages installed in rocker/tidyverse.
- rocker/geospatial has already installed some geospatial R packages in addition to the packages installed in rocker/verse.

These images start RStudio Server with the default command. Since the RStudio Server port is set to 8787, you can open the RStudio screen on localhost:8787 from your browser with the following command.

```bash
docker run --rm -ti -p 8787:8787 rocker/rstudio
```

The non-root default user rstudio is set up as RStudio Server user, so please enter the username rstudio and a randomly generated password which is displayed in the console to the RStudio login form.

RStudio will not start if the default command (/init) is overridden. To use R on the command line, specify the R command as follows.

```bash
docker run --rm -ti rocker/tidyverse R

```

## 4.1 Environment variables

Several special environment variables can be set to modify RStudio Server’s behavior.

Note
The process of referencing these environment variables is done by the /init command, which is the default command set for the container. Therefore, if the /init command is not executed, nothing will happen.

For example, if you enter the container with the following command, the uid of the user rstudio is unchanged and remains 1000.

```bash
docker run --rm -ti -e USERID=1001 -e GROUPID=1001 --user rstudio rocker/tidyverse bash
```

4.1.1 PASSWORD
You can set a custom password to log in the RStudio instance. Please set your password as an environmental variable PASSWORD like this:

```bash
docker run --rm -ti -e PASSWORD=yourpassword -p 8787:8787 rocker/rstudio
```

4.1.2 ROOT
If ROOT is set to true, the default non-root user will be added to the sudoers group when the server init process.

```bash
docker run --rm -ti -e ROOT=true -p 8787:8787 rocker/rstudio
```

This configuration allows you to execute sudo commands, like sudo apt update, on the terminal on RStudio.

When using the sudo command, you must enter the same password you used to log into RStudio.

4.1.3 DISABLE_AUTH
You can disable authentication for RStudio Server by setting an environmental variable DISABLE_AUTH=true.

```bash
docker run --rm -ti -e DISABLE_AUTH=true -p 127.0.0.1:8787:8787 rocker/rstudio
```

With this example, when you visit localhost:8787, you will now automatically be logged in as the user rstudio without having to first enter a user name and password.

If you are using a container on your local computer, it is recommended that you configure the port publishing as -p 127.0.0.1:8787:8787, as in the example, so that it can only be accessed from the same computer.

DISABLE_AUTH=true setting only skips the RStudio log in page. So you will still need to enter the password when use the sudo command with ROOT=true option.

4.1.4 USERID and GROUPID
The UID and GID of the default non-root user can be changed as follows:

docker run --rm -ti -e USERID=1001 -e GROUPID=1001 -p 8787:8787 rocker/rstudio

Warning
If these are set, ownership of the /home/rstudio directory in the container is updated by the root user. This will also overwrite the ownership of any files that are bind-mounted under the /home/rstudio directory.

4.2 Editing work on RStudio Server
If you want to make repeated edits on RStudio Server, It would be useful to be able to share files edited on the container with the Docker host.

Here are some hints for doing this and a sample compose file (for docker compose).

1. Recent RStudio Server’s configuration files are saved in the ~/.config/rstudio/ directory1.

2. It is not recommended to bind-mount whole home directory on the container (/home/rstudio); RStudio Server may not work properly.

3. Since RStudio Server opens the user’s home directory (/home/rstudio) by default, it is easier to use if a working directory is set up under /home/rstudio,e.g. /home/rstudio/workspace. However, for example, another directory such as the one containing CSV files should not necessarily have to be under the home directory, so it is recommended to bind-mount it under its own name directly under the root, e.g. /other_dir.

compose.yaml

```yaml
services:
  rstudio:
    image: rocker/verse:4
    ports:
      - "8787:8787"
    environment:
      PASSWORD: yourpassword
    volumes:
      - ./.rstudio_config:/home/rstudio/.config/rstudio
      - ~/workspace:/home/rstudio/workspace
      - /other_dir:/other_dir
```

## networking

### 3 Linking database containers

Here is an example of a compose file that configures a Shiny Server that can connect to a database (PostgreSQL).

<https://rocker-project.org/use/networking.html>

```yaml
services:
  db:
    image: postgres:13
    restart: always
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
    volumes:
      - pgdata:/var/lib/postgresql/data
    expose:
      - 5432

  shiny:
    image: rocker/shiny-verse:4
    restart: always
    environment:
      DB_HOST: db
      DB_PORT: 5432
    depends_on:
      - db
    volumes:
      - ./app/app.R:/srv/shiny-server/app/app.R:ro
    ports:
      - 3838:3838

volumes:
  pgdata:
```

## launch R Studio using compose

```bash
pushd .
cd ~/src/repsys/docker/r
docker compose up

```
