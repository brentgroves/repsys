# Go environment variables

**[GOROOT](https://medium.com/@ugurkinik/golang-basics-goroot-gopath-3f80063a08d8)**
GOROOT is an environment variable that defines the location of your Go SDK. It means you can find the compiler, go tools or, standard libraries in this directory.

To check where is your GOROOT, you can use go env.  I did not set these values so I imagine they are the defaults.

GOPATH
GOPATH is another environment variable. It defines the locations of your go source codes. If this variable includes more than one location, these locations are separated by columns (semicolon separated for Windows).

When your code has any imported package, this package has to be located here.

In your GOPATH, there are three folders:

src: Your source code has to be here if you don’t use go modules.
pkg: Go packages that are used in your projects
bin: Compiled executable programs
Thanks to Go modules, which is a new method to manage dependencies, you don’t have to use $GOPATH/src for your projects since Go 1.11. However, pkg and bin folders are still used.

Do I need to change them in any case?
I don’t think you need to change GOPATH in any case. But, there are some situations in which you want to change GOROOT.

1- Different installation folder:
If you want to install Go into a different folder, you have to set this folder to your GOROOT. Otherwise, your go tools or codes won’t work.

2- Use more than one version of Go:
Let’s say you need to install two different versions of Go (Like 1.15 and 1.17). You installed them in two different folders, so what’s next? You should set GOROOT as the folder of which version you want to use. Then, you can set it as the other folder whenever you want to switch to the other version.

It is possible, yes. However, I strongly recommend you to use Docker or similar solutions in order to use different environments.

```bash
go env GOROOT
/home/brent/sdk/go1.22.0
go env GOPATH
/home/brent/go
ls /home/brent/go                     
bin  pkg
ls -alh /home/brent/go/pkg/mod
drwxrwxr-x  22 brent brent 4.0K Apr 24 17:35 .
drwxrwxr-x   4 brent brent 4.0K Sep 18  2023 ..
drwxrwxr-x   4 brent brent 4.0K Sep 18  2023 cache
drwxrwxr-x   4 brent brent 4.0K Feb  1 17:11 cloud.google.com
drwxrwxr-x 151 brent brent 4.0K May 15 18:39 github.com
drwxrwxr-x   3 brent brent 4.0K Feb  1 17:11 gitlab.com
drwxrwxr-x   5 brent brent 4.0K Mar  1 19:14 golang.org
drwxrwxr-x   3 brent brent 4.0K Feb  1 17:11 go.mongodb.org
drwxrwxr-x  11 brent brent 4.0K May 15 18:39 google.golang.org
dr-xr-xr-x  13 brent brent 4.0K Feb  1 17:11 go.opencensus.io@v0.24.0
drwxrwxr-x   4 brent brent 4.0K Mar 18 18:23 go.opentelemetry.io
drwxrwxr-x   9 brent brent 4.0K May 15 18:39 gopkg.in
dr-xr-xr-x  15 brent brent 4.0K Sep 18  2023 go.starlark.net@v0.0.0-20220816155156-cfacd8902214
dr-xr-xr-x  15 brent brent 4.0K Mar  1 19:35 go.starlark.net@v0.0.0-20231101134539-556fd59b42f6
drwxrwxr-x   3 brent brent 4.0K Feb  1 17:11 go.uber.org
drwxrwxr-x   3 brent brent 4.0K Sep 18  2023 honnef.co
drwxrwxr-x   9 brent brent 4.0K May 15 18:20 k8s.io
drwxrwxr-x   3 brent brent 4.0K Feb  1 17:12 lukechampine.com
drwxrwxr-x  21 brent brent 4.0K Feb  1 17:12 modernc.org
drwxrwxr-x   5 brent brent 4.0K Feb 28 17:46 mvdan.cc
drwxrwxr-x   4 brent brent 4.0K Sep 18  2023 rsc.io
drwxrwxr-x   5 brent brent 4.0K Apr 24 17:35 sigs.k8s.io
ls -alh /home/brent/go/bin    
total 118M
drwxrwxr-x 2 brent brent 4.0K Apr 16 17:22 .
drwxrwxr-x 4 brent brent 4.0K Sep 18  2023 ..
-rwxrwxr-x 1 brent brent  20M Mar  1 19:36 dlv
-rwxrwxr-x 1 brent brent 6.6M Sep 18  2023 go1.20
-rwxrwxr-x 1 brent brent 6.9M Mar  1 19:22 go1.22.0
-rwxrwxr-x 1 brent brent 3.7M Mar  1 19:35 gomodifytags
-rwxrwxr-x 1 brent brent 3.3M Sep 18  2023 go-outline
-rwxrwxr-x 1 brent brent 7.4M Mar  1 19:35 goplay
-rwxrwxr-x 1 brent brent  30M Apr 16 17:22 gopls
-rwxrwxr-x 1 brent brent  11M Mar  1 19:35 gotests
-rwxrwxr-x 1 brent brent 2.0M Sep 19  2023 hello
-rwxrwxr-x 1 brent brent 6.3M Mar  1 19:35 impl
-rwxrwxr-x 1 brent brent 6.5M Feb  2 18:10 migrate
-rwxrwxr-x 1 brent brent 2.4M Nov 27 16:35 runner
-rwxrwxr-x 1 brent brent  14M Mar  1 19:36 staticcheck
```
