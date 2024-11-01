# **[OOP in Golang: Using Constructors](https://www.toptal.com/golang/golang-oop-tutorial)**

## **[Create feature branch for module](./new_branch.md)**

## Verify you are on a branch instead of main

```bash
pushd .
cd ~/src/go/tutorials/oop/vin1

git branch
  main
* add_test
```

To avoid the panic when handling an invalid VIN, it’s possible to add validity checks to the Manufacturer() function itself. The disadvantages are that the checks would be done on every call to the Manufacturer() function, and that an error return value would have to be introduced, which would make it impossible to use the return value directly without an intermediate variable (e.g., as a map key).

A more elegant way is to put the validity checks in a constructor for the VIN type, so that the Manufacturer() function is called for valid VINs only and does not need checks and error handling:

```go
package vin

import "fmt"

type VIN string

// it is debatable if this func should be named New or NewVIN
// but NewVIN is better for greping and leaves room for other
// NewXY funcs in the same package
func NewVIN(code string)(VIN, error) {

  if len(code) != 17 {
    return "", fmt.Errorf("invalid VIN %s: more or less than 17 characters", code)
  }

  // ... check for disallowed characters ...

  return VIN(code), nil
}

func (v VIN) Manufacturer() string {

  manufacturer := v[: 3]
  if manufacturer[2] == '9' {
    manufacturer += v[11: 14]
  }

  return string(manufacturer)
}
```

Of course, we add a test for the NewVIN function. Invalid VINs are now rejected by the constructor:

```go
package vin_test

import (
  "vin-stages/3"
  "testing"
)

const (
  validVIN = "W0L000051T2123456"
  invalidVIN = "W0"
)

func TestVIN_New(t *testing.T) {

  _, err := vin.NewVIN(validVIN)
  if err != nil {
    t.Errorf("creating valid VIN returned an error: %s", err.Error())
  }

  _, err = vin.NewVIN(invalidVIN)
  if err == nil {
    t.Error("creating invalid VIN did not return an error")
  }
}

func TestVIN_Manufacturer(t *testing.T) {

  testVIN, _ := vin.NewVIN(validVIN)
  manufacturer := testVIN.Manufacturer()
  if manufacturer != "W0L" {
    t.Errorf("unexpected manufacturer %s for VIN %s", manufacturer, testVIN)
  }
}
```

The test for the Manufacturer() function can now omit testing an invalid VIN since it already would have been rejected by the NewVIN constructor.

### 2. **[Commit, test, merge, and publish new feature](./commit_test_merge_tag_publish.md)**

### 3. **[Create branch for main module](./new_branch.md)**

## Update main with new module

```bash
pushd .
cd ~/src/go/tutorials/oop/vin_main

# go get github.com/brentgroves/vin1@v0.x.0
go get github.com/brentgroves/vin1@v0.5.0
go: downloading github.com/brentgroves/vin1 v0.3.0
go: upgraded github.com/brentgroves/vin1 v0.2.0 => v0.3.0
```

## Verify go.mod was updated to use the new version of the greetings module

```bash
pushd .
cd ~/src/go/tutorials/oop/vin_main
code go.mod
go run .

### 4. In your main_test.go

```go
package main_test

import (
 "testing"

 vin "github.com/brentgroves/vin1/vin-stages/3"
)

const (
 validVIN   = "W0L000051T2123456"
 invalidVIN = "W0"
)

func TestVIN_New(t *testing.T) {

 _, err := vin.NewVIN(validVIN)
 if err != nil {
  t.Errorf("creating valid VIN returned an error: %s", err.Error())
 }

 _, err = vin.NewVIN(invalidVIN)
 if err == nil {
  t.Error("creating invalid VIN did not return an error")
 }
}

func TestVIN_Manufacturer(t *testing.T) {

 testVIN, _ := vin.NewVIN(validVIN)
 manufacturer := testVIN.Manufacturer()
 if manufacturer != "W0L" {
  t.Errorf("unexpected manufacturer %s for VIN %s", manufacturer, testVIN)
 }
}

```

## In your main.go

```go
package main

import (
 "fmt"
 "log"

 vin "github.com/brentgroves/vin1/vin-stages/3"
)

func main() {
 // Set properties of the predefined Logger, including
 // the log entry prefix and a flag to disable printing
 // the time, source file, and line number.
 log.SetPrefix("vin_main: ")
 log.SetFlags(0)

 const (
  validVIN   = "W0L000051T2123456"
  invalidVIN = "W0"
 )

 vin1, err := vin.NewVIN(validVIN)
 if err != nil {
  t.Errorf("creating NewVIN from %s returned an error: %s", validVIN, err.Error())
 }

 manufacturer := vin1.Manufacturer()
 if manufacturer != "W0L" {
  log.Fatal("W0L error")
 }
 fmt.Println(manufacturer)

 // Request greeting messages for the names.
 // messages, err := greetings.Hellos(names)
 // if err != nil {
 //  log.Fatal(err)
 // }
 // If no error was returned, print the returned map of
 // messages to the console.
 // fmt.Println(messages)
}
```

### 6. **[Commit, test, merge, and publish new feature in main module](./commit_test_merge_tag_publish.md)**
