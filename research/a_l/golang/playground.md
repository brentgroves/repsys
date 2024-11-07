# **[The Go Playground](https://go.dev/play/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

A variadic function is a function that accepts zero, one, or more values as a single argument. While variadic functions are not the common case, they can be used to make your code cleaner and more readable.

Variadic functions are more common than they seem. The most common one is the Println function from the fmt package.

```go
func Println(a ...interface{}) (n int, err error)
```

A function with a parameter that is preceded with a set of ellipses (...) is considered a variadic function. The ellipsis means that the parameter provided can be zero, one, or more values. For the fmt.Println package, it is stating that the parameter a is variadic.

Let’s create a program that uses the fmt.Println function and pass in zero, one, or more values:

```go
package main

import "fmt"

func main() {
 fmt.Println()
 fmt.Println("one")
 fmt.Println("one", "two")
 fmt.Println("one", "two", "three")
}
```

The first time we call fmt.Println, we don’t pass any arguments. The second time we call fmt.Println we pass in only a single argument, with the value of one. Then we pass one and two, and finally one, two, and three.

Let’s run the program in **[The Go Playground](https://go.dev/play/)**

We’ll see the following output:

```bash
one
one two
one two three
```

The first line of the output is blank. This is because we didn’t pass any arguments the first time fmt.Println was called. The second time the value of one was printed. Then one and two, and finally one, two, and three.

Now that we have seen how to call a variadic function, let’s look at how we can define our own variadic function.

## Defining a Variadic Function

We can define a variadic function by using an ellipsis (...) in front of the argument. Let’s create a program that greets people when their names are sent to the function:

```go
package main

import "fmt"

func main() {
 sayHello()
 sayHello("Sammy")
 sayHello("Sammy", "Jessica", "Drew", "Jamie")
}

func sayHello(names ...string) {
 for _, n := range names {
  fmt.Printf("Hello %s\n", n)
 }
}
```

We created a sayHello function that takes only a single parameter called names. The parameter is variadic, as we put an ellipsis (...) before the data type: ...string. This tells Go that the function can accept zero, one, or many arguments.

The sayHello function receives the names parameter as a slice. Since the data type is a string, the names parameter can be treated just like a slice of strings ([]string) inside the function body. We can create a loop with the range operator and iterate through the slice of strings.

If we run the program, we will get the following output:

```bash
Hello Sammy
Hello Sammy
Hello Jessica
Hello Drew
Hello Jamie
```

Notice that nothing printed for the first time we called sayHello. This is because the variadic parameter was an empty slice of string. Since we are looping through the slice, there is nothing to iterate through, and fmt.Printf is never called.

Let’s modify the program to detect that no values were sent in:

```go
package main

import "fmt"

func main() {
 sayHello()
 sayHello("Sammy")
 sayHello("Sammy", "Jessica", "Drew", "Jamie")
}

func sayHello(names ...string) {
 if len(names) == 0 {
  fmt.Println("nobody to greet")
  return
 }
 for _, n := range names {
  fmt.Printf("Hello %s\n", n)
 }
}
```

Now, by using an if statement, if no values are passed, the length of names will be 0, and we will print out nobody to greet:

```bash
nobody to greet
Hello Sammy
Hello Sammy
Hello Jessica
Hello Drew
Hello Jamie
```

Using a variadic parameter can make your code more readable. Let’s create a function that joins words together with a specified delimiter. We’ll create this program without a variadic function first to show how it would read:

```go
package main

import "fmt"

func main() {
 var line string

 line = join(",", []string{"Sammy", "Jessica", "Drew", "Jamie"})
 fmt.Println(line)

 line = join(",", []string{"Sammy", "Jessica"})
 fmt.Println(line)

 line = join(",", []string{"Sammy"})
 fmt.Println(line)
}

func join(del string, values []string) string {
 var line string
 for i, v := range values {
  line = line + v
  if i != len(values)-1 {
   line = line + del
  }
 }
 return line
}
```

In this program, we are passing a comma (,) as the delimiter to the join function. Then we are passing a slice of values to join. Here is the output:

```bash
Output
Sammy,Jessica,Drew,Jamie
Sammy,Jessica
Sammy
```

Because the function takes a slice of string as the values parameter, we had to wrap all of our words in a slice when we called the join function. This can make the code difficult to read.

Now, let’s write the same function, but we’ll use a variadic function:

```go
package main

import "fmt"

func main() {
 var line string

 line = join(",", "Sammy", "Jessica", "Drew", "Jamie")
 fmt.Println(line)

 line = join(",", "Sammy", "Jessica")
 fmt.Println(line)

 line = join(",", "Sammy")
 fmt.Println(line)
}

func join(del string, values ...string) string {
 var line string
 for i, v := range values {
  line = line + v
  if i != len(values)-1 {
   line = line + del
  }
 }
 return line
}
```

## Variadic Argument Order

You can only have one variadic parameter in a function, and it must be the last parameter defined in the function. Defining parameters in a variadic function in any order other than the last parameter will result in a compilation error:

## Exploding Arguments

So far, we have seen that we can pass zero, one, or more values to a variadic function. However, there will be occasions when we have a slice of values and we want to send them to a variadic function.

Let’s look at our join function from the last section to see what happens:

```go
package main

import "fmt"

func main() {
 var line string

 names := []string{"Sammy", "Jessica", "Drew", "Jamie"}

 line = join(",", names)
 fmt.Println(line)
}

func join(del string, values ...string) string {
 var line string
 for i, v := range values {
  line = line + v
  if i != len(values)-1 {
   line = line + del
  }
 }
 return line
}
```

If we run this program, we will receive a compilation error:

Output

```bash
./join-error.go:10:14: cannot use names (type []string) as type string in argument to join
```

Even though the variadic function will convert the parameter of values ...string to a slice of strings []string, we can’t pass a slice of strings as the argument. This is because the compiler expects discrete arguments of strings.

To work around this, we can explode a slice by suffixing it with a set of ellipses (...) and turning it into discrete arguments that will be passed to a variadic function:

```go
package main

import "fmt"

func main() {
 var line string

 names := []string{"Sammy", "Jessica", "Drew", "Jamie"}

 line = join(",", names...)
 fmt.Println(line)
}

func join(del string, values ...string) string {
 var line string
 for i, v := range values {
  line = line + v
  if i != len(values)-1 {
   line = line + del
  }
 }
 return line
}
```

This time, when we called the join function, we exploded the names slice by appending ellipses (...).

This allows the program to now run as expected:

Output

```bash
Sammy,Jessica,Drew,Jamie
```

It’s important to note that we can still pass a zero, one, or more arguments, as well as a slice that we explode. Here is the code passing all the variations that we have seen so far:

```go
package main

import "fmt"

func main() {
 var line string

 line = join(",", []string{"Sammy", "Jessica", "Drew", "Jamie"}...)
 fmt.Println(line)

 line = join(",", "Sammy", "Jessica", "Drew", "Jamie")
 fmt.Println(line)

 line = join(",", "Sammy", "Jessica")
 fmt.Println(line)

 line = join(",", "Sammy")
 fmt.Println(line)

}

func join(del string, values ...string) string {
 var line string
 for i, v := range values {
  line = line + v
  if i != len(values)-1 {
   line = line + del
  }
 }
 return line
}
```

Now we can update our `SendWelcomeEmail` function to take the interface, rather than the concrete type:

func SendWelcomeEmail(m EmailSender, to ...*mail.Address) {...}
