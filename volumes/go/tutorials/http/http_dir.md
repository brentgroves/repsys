# http.dir

<https://forum.golangbridge.org/t/how-does-http-dir-work/9203/3>

## http.Dir

Let’s start with http.Dir and work our way outwards in your function call.

When you write this code - http.Dir("/some/path") you are converting a string into the http.Dir type. This type has one notable method - Open.

When you call Open on an http.Dir it will open the file you named relative to the original path used to create the http.Dir.

Let’s look at two examples here. First, the folder structure:

```bash
/
  main.go
  stuff/
    thing.txt

```

So we have our source code in some root dir, and inside that we have a folder named thing.txt. Assume we are running our code form the root directory, as all paths are going to be relative to where you run your code from not where it is actually written (see <https://errorsingo.com/os-err-not-exist/> 26 for a little more info on that).

```go
func main() {
 ex2()
}

func ex1() {
 d := http.Dir(".")
 f, err := d.Open("stuff/thing.txt")
 if err != nil {
  panic(err)
 }
 defer f.Close()
 io.Copy(os.Stdout, f)
}

func ex2() {
 d := http.Dir("./stuff")
 f, err := d.Open("thing.txt")
 if err != nil {
  panic(err)
 }
 defer f.Close()
 io.Copy(os.Stdout, f)
}
```

See <https://github.com/joncalhoun/fs_dir/blob/master/main.go> 29 if you want to clone a repo and run the code.

In ex1 we create an http.Dir from wherever we run our code, presumably in the root directory, and then when we open a file at stuff/thing.txt it locates it by navigating relative to the root path.

In ex2 we create an http.Dir that starts in ./stuff, so if we were to use the same path we originally did it would actually be looking for a file in ./stuff/stuff/thing.txt which clearly doesn’t exist. To account for this, we just ask for thing.txt without the stuff/ prefix.

http.FileServer
Okay so we’ve seen how http.Dir works, how does that affect our http.FileServer?

Well an http.FileServer works by taking the complete path from a web request and using it as the file path. That is, if you do:

```go
http.Handle("/assets/", http.FileServer(http.Dir("/files"))
And a user makes a web request like this:
```

GET /assets/some/file.txt
What your server will actually look for is this file path:

/files/assets/some/file.txt

There are a couple things that I suspect could be going wrong here:

1. You used the path /files which is absolute - that is it won’t look for a folder named files in your current directory, but will look for one names files at the very root of your system. This is very unlikely to be what you want, so I suggest trying this: ./files or files as both are ways of saying, “I want the files folder relative to where I am”.
2. You may not want the /assets/ prefix from the URL as part of your file path. For instance, you might use the URL /assets/some/file.txt to refer to a file at ./files/some/file.txt. This is an easy mistake to make, because you probably assumed the routing would make it clear that this prefix is just part of your URL route, but that isn’t how the http.FileServer works as it knows nothing about any routing that happens before it runs.

So (1) is easy to fix - just use the file paths I suggested.

(2) is also easy to fix, but requires us to use the http.StripPrefix 16 handler. The way this works is shown below, then I’ll try to explain it further.

```go
// Create a file server for your files
fs := http.FileServer(http.Dir("./files"))
// We don't want that /assets/ prefix in our file paths, so let's strip it out.
prefixHandler := http.StripPrefix("/assets/", fs)
http.Handle("/assets", prefixHandler)

```

First we create our http.FileServer handler similar to before, but with the changes I suggested from (1). After that we call http.StripPrefix and tell it the path prefix we want to strip, along with the handler to call once it is done stripping the prefix (the fs variable is this last part). After that we save the resulting handler in prefixHandler and then use that in our call to http.Handle

The end result of this is code that basically runs like this:

1. Your routing will run first, and will see a path like /assets/some/file.txt and will say "Oh this path starts with /assets, I should handle it with the prefixHandler
2. When prefixHandler gets called it looks at the path and says “I should strip the /assets/ prefix from this path” so it then rewrites the path of the request object to be some/file.txt. It then calls fs with the response writer and request as this is the handler we told it to call next.
3. fs finally starts running and will say "okay the full path is some/file.txt so I’ll pass that into the http.Dir's Open method to get that file and render it to the user.

Notice that in step (3) our file server didn’t know that we altered the path, it just knows what the full path is and uses it.
