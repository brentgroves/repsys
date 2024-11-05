# **[Duck typing (Structural Typing) in Go](https://medium.com/@matryer/golang-advent-calendar-day-one-duck-typing-a513aaed544d)**

**[Back to Research List](../../../../research/research_list.md)**\
**[Back to Current Status](../../../../`development/status/weekly/current_status.md)**\
**[Back to Main](../../../../`README.md)**

## Wiki **[duck typing](https://en.wikipedia.org/wiki/Duck_typing)**

In computer programming, duck typing is an application of the duck test—"If it walks like a duck and it quacks like a duck, then it must be a duck"—to determine whether an object can be used for a particular purpose. With nominative typing, an object is of a given type if it is declared as such (or if a type's association with the object is inferred through mechanisms such as object inheritance). With duck typing, an object is of a given type if it has all methods and properties required by that type.[1][2] Duck typing may be viewed as a usage-based structural equivalence between a given object and the requirements of a type.

## **[Duck typing in Golang](https://medium.com/@matryer/golang-advent-calendar-day-one-duck-typing-a513aaed544d)**

Today, did you know — a struct doesn’t have to implement an interface in Go. Go uses “duck typing” (EDIT: technically they call it **‘structural typing’** because it happens at compile time, where duck typing tends to happen at run time.) If it looks like a duck, and it quacks like a duck, then it is a duck. If it has a set of methods that match an interface, then you can use it wherever that interface is needed without explicitly defining that your types implement that interface.

Check out this interface:

```go
// Speaker types can say things.
type Speaker interface {
  Say(string)
}
```

Anything with a matching `Say` method can be called a `Speaker`.

We don’t do anything special to our struct types to satisfy this interface:

```golang
type Person struct {
  name string
}
func (p *Person) Say(message string) {
  log.Println(p.name+":", message)
}
```

Now assume we have a method that takes a Speaker:

```go
func SpeakAlphabet(via Speaker) {
  via.Say("abcdefghijklmnopqrstuvwxyz")
}
```

We can use our type look:

```go
mat := new(Person)
mat.name = "Mat"
SpeakAlphabet(mat)
```

And imagine if another package exists that provides this type:

```go
type SpeakWriter struct {
  w io.Writer
}
func (s *SpeakWriter) Say(message string)
  io.WriteString(s.w, message)
}
```

We could use that too — without the other package even knowing about our interface.

This isn’t just a code style decision by the creators of Go, it has some pretty interesting implications. For a real world example how how this is useful, check out the Mock things using Go code section on 5 simple tips and tricks for writing unit tests in Go.
