# **[Commit,test,merge,tag, and publish changes](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging)**

## Tidy and commit all code changes

```bash
pushd .
cd ~/src/go/tutorials/oop/vin1
# or
cd ~/src/go/tutorials/oop/vin_main

# Run go mod tidy, which removes any dependencies the module might have accumulated that are no longer necessary.
go mod tidy

```

## Run go test ./... a final time to make sure everything is working

This runs the unit tests you’ve written to use the Go testing framework.

```bash
go test ./... -v
FAIL    github.com/brentgroves/vin1     0.007s
ok      github.com/brentgroves/vin1     0.005s
ok      github.com/brentgroves/vin_main 0.004s
# more details
go test -v
=== RUN   TestVIN_Manufacturer
--- PASS: TestVIN_Manufacturer (0.00s)
PASS
ok      github.com/brentgroves/vin1     0.004s

```

## If passed tests checkin branch

```bash
cd ~/src/go/tutorials/oop/vin1

git add -A # git commit -a wont add files
git commit -a -m "vin1: using constructors"


cd ~/src/go/tutorials/oop/vin_main
git add -A # git commit -a wont add files
git commit -a -m "vin_main: bind function"

[hotfix 1fb7853] Fix broken email address
 1 file changed, 2 insertions(+)

# https://graphite.dev/guides/how-to-use-git-push-origin

git push --set-upstream origin use_constructors
Enumerating objects: 14, done.
Counting objects: 100% (14/14), done.
Delta compression using up to 4 threads
Compressing objects: 100% (9/9), done.
Writing objects: 100% (9/9), 1.34 KiB | 685.00 KiB/s, done.
Total 9 (delta 4), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (4/4), completed with 2 local objects.
remote: 
remote: Create a pull request for 'use_constructors' on GitHub by visiting:
remote:      https://github.com/brentgroves/vin_main/pull/new/use_constructors
remote: 
To github.com:brentgroves/vin_main.git
 * [new branch]      use_constructors -> use_constructors
Branch 'use_constructors' set up to track remote branch 'use_constructors' from 'origin'.

# https://phoenixnap.com/kb/git-list-remote-branches
# git branch -r. Lists all the remote branches.
# git branch -r -v. Lists all the remote branches with the latest commit hash and commit message.
# git ls-remote. Lists all the references in the remote repository, including the branches.
# git remote show [remote_name]. Shows information about the specified remote, including the remote branches.
# git branch -a. Shows all the local and remote branches.

git branch -r -v
  origin/HEAD             -> origin/main
  origin/main             7a70d92 vin_main: using constructors
  origin/use_constructors 7a70d92 vin_main: using constructors

git remote show origin          
* remote origin
  Fetch URL: git@github.com:brentgroves/vin_main.git
  Push  URL: git@github.com:brentgroves/vin_main.git
  HEAD branch: main
  Remote branches:
    main             tracked
    use_constructors tracked
  Local branches configured for 'git pull':
    main             merges with remote main
    use_constructors merges with remote use_constructors
  Local refs configured for 'git push':
    main             pushes to main             (up to date)
    use_constructors pushes to use_constructors (up to date)
```

## Merge feature branch with main

Verify all changes have been committed to feature branch.

```bash
pushd .
cd ~/src/go/tutorials/oop/vin1
# or
cd ~/src/go/tutorials/oop/vin_main

git switch main
git merge bind_function
Updating 7d6c79c..109aeef
Fast-forward
 vin_test.go | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 vin_test.go
```

## Run go test ./... from main to make sure everything is working

This runs the unit tests you’ve written to use the Go testing framework.

```bash
go test ./... -v
FAIL    github.com/brentgroves/vin1     0.007s
ok      github.com/brentgroves/vin1     0.005s
ok      github.com/brentgroves/vin_main 0.004s
# more details
go test -v
=== RUN   TestVIN_Manufacturer
--- PASS: TestVIN_Manufacturer (0.00s)
PASS
ok      github.com/brentgroves/vin1     0.004s

```

## Commit merge changes and Tag main with new version

If no commit is specified, a tag defaults to the current commit.

```bash
# look at current tags
git tag
git log --pretty=oneline

# If no commit is specified, a tag defaults to the current commit.
# git tag -a v0.x.0 -m "my version 0.x.0"
git tag -a v0.5.0 -m "use constructors"
git log --pretty=oneline

```

## Push the changes to main branch tag to the origin

```bash
git push origin main
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 4 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 736 bytes | 736.00 KiB/s, done.
Total 4 (delta 0), reused 0 (delta 0), pack-reused 0
To github.com:brentgroves/vin_main.git
   79e917e..d475be4  main -> main
```

## Push the new tag to the origin

By default, the git push command doesn’t transfer tags to remote servers. You will have to explicitly push tags to a shared server after you have created them. This process is just like sharing remote branches — you can run git push origin ```<tagname>```.

```bash
# verify origin does not have this tag
git ls-remote --tags origin

# git push origin v0.x.0
git push origin v0.5.0
Enumerating objects: 1, done.
Counting objects: 100% (1/1), done.
Writing objects: 100% (1/1), 159 bytes | 159.00 KiB/s, done.
Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
To github.com:brentgroves/vin_main.git
 * [new tag]         v0.1.0 -> v0.1.0

git ls-remote --tags origin
0587e2af737abd40d437b3d246e7f9f713f573ac        refs/tags/v0.1.0
d475be4cff3733a07ebbe9316bb7ceffac46301a        refs/tags/v0.1.0^{}
```

Make the module available by running the **[go list command](https://go.dev/cmd/go/#hdr-List_packages_or_modules)** to prompt Go to update its index of modules with information about the module you’re publishing.

Precede the command with a statement to set the GOPROXY environment variable to a Go proxy. This will ensure that your request reaches the proxy.

```bash
# GOPROXY=proxy.golang.org go list -m github.com/brentgroves/greetings3@v0.x.0
GOPROXY=proxy.golang.org go list -m github.com/brentgroves/vin1@v0.5.0
github.com/brentgroves/vin1 v0.3.0

```

Developers interested in your module import a package from it and run the go get command just as they would with any other module. They can run the go get command for latest versions or they can specify a particular version, as in the following example: