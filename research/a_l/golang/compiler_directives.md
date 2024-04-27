# Go Compiler Directives

## references

<https://bdemirpolat.medium.com/golang-compiler-directives-dc61820add40>

<https://github.com/golang/go/issues/25922#issuecomment-1065971260>

## Compiler Directives

The compiler accepts directives in the form of comments. To distinguish them from non-directive comments, directives require no space between the comment opening and the name of the directive. However, since they are comments, tools unaware of the directive convention or of a particular directive can skip over a directive like any other comment.

Line directives come in several forms:

```go
//line :line
//line :line:col
//line filename:line
//line filename:line:col
/*line :line*/
/*line :line:col*/
/*line filename:line*/
/*line filename:line:col*/
```

## **[build directive](https://bdemirpolat.medium.com/golang-compiler-directives-dc61820add40)**

Bonus: build tags
+build
This directive provides conditional build.

Let’s create two go files.

first.go

```go
// +build firstpackage main
import "fmt"
func init() {
   fmt.Println("my first program")
}func main(){
   fmt.Println("main function triggered")
}
```

second.go

```go
// +build secondpackage main
import "fmt"
func init() {
   fmt.Println("my second program")
}
```

And build with “first” tag.

```bash
go build -tags first && ./example
# Output:
my first program
main function triggered
```

Build with “second” tag.

```bash
go build -tags second && ./example
Output:

my second program
```

Let’s try with two tags.

```go
// +build first second
```

// +build first second
Now we tell to go build tool “build who has ‘first’ OR ‘second’ tags” (OR condition)

Change build tags for first.go and second.go

// +build first
to

// +build first,second

Now we tell to go build tool “build who has ‘first,second’ tags” (AND condition)

Last example shows how to use NOT condition.

Let’s change build tag like this:

// +build !first
Now we tell to go build tool “do not build who has ‘first’ tag”.

//go:generate goyacc -o gopher.go -p parser gopher.y
