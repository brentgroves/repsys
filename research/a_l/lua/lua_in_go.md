# Lua

## references

https://bentsukun.ch/posts/go-lua/
https://gist.github.com/bsiegert/eb94f435e7f3782ea0d53797fc1d82a8


## Using Lua from Go

Last weekend, at FOSDEM 2023, I watched a Lightning Talk by Frank Vanbever titled “Lua for the Lazy C developer”. I had recently suggested at work that we should be using Lua to script the behavior of some systems which are written in Go, so the talk strongly resonated with me.

Lua is an ideal scripting language for embedding into other programs because it is small and provides excellent bindings in both directions – Lua code can call native code, and vice versa. Because Go has good hash tables as part of the language, using Lua as a container for your hash tables is probably less interesting than from C though.

During the talk, I tried porting the “Hello World” example to Go as the native language. It turns out that Shopify published a pure-Go reimplementation of the Lua interpreter that is byte code compatible with the original C implementation! They use this for scripting the behavior (ha!) of their load testing tools. The package is at github.com/Shopify/go-lua.

It turns out that the example from the talk translates 1:1 to Go and Lua:

```go
package main

import lua "github.com/Shopify/go-lua"

func main() {
  l := lua.NewState()
  lua.OpenLibraries(l)
  l.Global("print")
  l.PushString("Hello World!\n")
  l.Call(1, 0)
}
```

And it does exactly what you would expect:

```bash
$ go build .
$ ./luatest 
Hello World!
```
