# **[Publishing a module](https://go.dev/doc/modules/publishing)**

When you want to make a module available for other developers, you publish it so that it’s visible to Go tools. Once you’ve published the module, developers importing its packages will be able to resolve a dependency on the module by running commands such as go get.

Note: Don’t change a tagged version of a module after publishing it. For developers using the module, Go tools authenticate a downloaded module against the first downloaded copy. If the two differ, Go tools will return a security error. Instead of changing the code for a previously published version, publish a new version.

See also

- For an overview of module development, see **[Developing and publishing modules](https://go.dev/doc/modules/developing)**
- For a high-level module development workflow – which includes publishing – see **[Module release and versioning workflow](https://go.dev/doc/modules/release-workflow)**.

## Publishing steps¶

Use the following steps to publish a module.

Open a command prompt and change to your module’s root directory in the local repository.

Run go mod tidy, which removes any dependencies the module might have accumulated that are no longer necessary.

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/modules/greetings3

go mod tidy
```

Run go test ./... a final time to make sure everything is working.

This runs the unit tests you’ve written to use the Go testing framework.

```bash
go test ./...
ok      github.com/brentgroves/greetings3       0.015s
```

Tag the project with a new version number using the git tag command.

For the version number, use a number that signals to users the nature of changes in this release. For more, see Module version numbering.

```bash
cd ~/src/repsys/volumes/go/tutorials/modules/greetings3
git add -A
git commit -m "greetings3: changes for v0.1.0"
git tag v0.1.0
```

Push the new tag to the origin repository.

```bash
# update both branch main and v0.1.0
git push origin v0.1.0
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 4 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 576 bytes | 576.00 KiB/s, done.
Total 4 (delta 0), reused 0 (delta 0), pack-reused 0
To github.com:brentgroves/greetings3.git
 * [new tag]         v0.1.0 -> v0.1.0
git push origin main
```

Make the module available by running the go list command to prompt Go to update its index of modules with information about the module you’re publishing.

Precede the command with a statement to set the GOPROXY environment variable to a Go proxy. This will ensure that your request reaches the proxy.

```bash
GOPROXY=proxy.golang.org go list -m github.com/brentgroves/greetings3@v0.1.0
github.com/brentgroves/greetings3 v0.1.0
```

Developers interested in your module import a package from it and run the go get command just as they would with any other module. They can run the go get command for latest versions or they can specify a particular version, as in the following example:

```bash
go get github.com/brentgroves/greetings3@v0.1.0
```
