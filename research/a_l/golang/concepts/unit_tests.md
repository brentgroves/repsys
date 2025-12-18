# **[5 simple tips and tricks for writing unit tests in #golang](https://medium.com/@matryer/5-simple-tips-and-tricks-for-writing-unit-tests-in-golang-619653f90742#.mjytgulbg)**

**[Back to Research List](../../../../research/research_list.md)**\
**[Back to Current Status](../../../../`development/status/weekly/current_status.md)**\
**[Back to Main](../../../../`README.md)**

Test-driven development is a great way to keep the quality of your code high, while protecting yourself from regression and proving to yourself and others that your code does what it is supposed to.

Here are five tips and tricks that can improve your tests.

## 1. Put your tests in a different package

Go insists that files in the same folder belong to the same package, that is except for `_test.go` files. Moving your test code out of the package allows you to write tests as though you were a real user of the package. You cannot fiddle around with the internals, instead you focus on the exposed interface and are always thinking about any noise that you might be adding to your API.

![test](https://miro.medium.com/v2/resize:fit:720/format:webp/1*B2KNJQEck16YS2R9CpXhQA.png)

This frees you up to change the internals however you like without having to adjust your test code.

## 2. Internal tests go in a different file

If you do need to unit test some internals, create another file with `_internal_test.go` as the suffix. Internal tests will necessarily be more brittle than your interface tests — but they’re a great way to ensure internal components are behaving, and are especially useful if you do test-driven development.

![itest](https://miro.medium.com/v2/resize:fit:720/format:webp/1*ngnvEnXntoHOLuJny3mUrA.png)

## 3. Run all tests on save

Go builds and runs very quickly, so there’s little to no reason why you shouldn’t run your entire test suite every time you hit save.

While you’re at it, why not run **[go vet](https://pkg.go.dev/cmd/vet)**, **[StaticCheck](https://staticcheck.dev/)** and **[goimports](https://godoc.org/golang.org/x/tools/cmd/goimports)** at the same time?

## 4. Write table driven tests

Anonymous structs and composite literals allow us to write very clear and simple table tests without relying on any external package.

The following code allows us to setup a range of tests for an as-yet unwritten `Fib` function:

```go
var fibTests = []struct {
  n        int // input
  expected int // expected result
}{
  {1, 1},
  {2, 1},
  {3, 2},
  {4, 3},
  {5, 5},
  {6, 8},
  {7, 13},
}
```

Then our test function just ranges over the slice, calling the `Fib` method for each `n`, before asserting that the results are correct:

```go
func TestFib(t *testing.T) {
  for _, tt := range fibTests {
    actual := Fib(tt.n)
    if actual != tt.expected {
      t.Errorf("Fib(%d): expected %d, actual %d", tt.n, tt.expected, actual)
    }
  }
}
```

See if you can write the `Fib` function yourself to make the tests pass or you can get the answer from Dave Chaney.
