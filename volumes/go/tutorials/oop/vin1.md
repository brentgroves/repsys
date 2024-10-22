# **[GoLang OOP](https://www.toptal.com/golang/golang-oop-tutorial)**

## Create a github repo

Call the repo greetings3 and clone it.

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/oop/
git clone git@github.com:brentgroves/vin1.git
Cloning into 'vin1'...
remote: Enumerating objects: 4, done.
remote: Counting objects: 100% (4/4), done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 4 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
Receiving objects: 100% (4/4), done.
cd vin1
```

## Create the Go project and **[initialize a module](https://go.dev/ref/mod#go-mod-init)**

If you publish a module, this must be a path from which your module can be downloaded by Go tools. That would be your code's repository.

For more on naming your module with a module path, see Managing dependencies.

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/oop/vin1

# Run go mod init {module name} to create a go.mod file for the current directory. For example go mod init github.com/brutella/dnssd 

go mod init github.com/brentgroves/vin1
go: creating new go.mod: module github.com/brentgroves/vin1
cd ~/src/repsys
go work use ./volumes/go/tutorials/oop/vin1
code go.work 
dirs -v
pushd +x
# checkin code to github repo
git add -A 
git commit -m "updated"
git push -u origin main  
```

The go mod init command creates a go.mod file to track your code's dependencies. So far, the file includes only the name of your module and the Go version your code supports. But as you add dependencies, the go.mod file will list the versions your code depends on. This keeps builds reproducible and gives you direct control over which module versions to use.

## Create the Go project

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/oop/
mkdir vin1
cd vin1
go mod init vin1
pushd .
cd ~/src/repsys
go work use ./volumes/go/tutorials/oauth2/oauth2_example
dirs -v
pushd +x

```
