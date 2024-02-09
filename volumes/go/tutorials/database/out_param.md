# Out params

```go
type Out struct {

 // Dest is a pointer to the value that will be set to the result of the
 // stored procedure's OUTPUT parameter.
 Dest any

 // In is whether the parameter is an INOUT parameter. If so, the input value to the stored
 // procedure is the dereferenced value of Dest's pointer, which is then replaced with
 // the output value.
 In bool
 // contains filtered or unexported fields
}
```

Out may be used to retrieve OUTPUT value parameters from stored procedures.

Not all drivers and databases support OUTPUT value parameters.

Example usage:

var outArg string
_, err := db.ExecContext(ctx, "ProcName", sql.Named("Arg1", sql.Out{Dest: &outArg}))

## reference

<https://pkg.go.dev/database/sql#Out>
