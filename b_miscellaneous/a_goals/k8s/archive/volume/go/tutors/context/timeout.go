package main

import (
	"context"
	"fmt"
	"os/exec"
	"time"
)

func main() {
	// To stop these processes, we need to send a kill signal from
	// our application. We can do this by adding a context instance
	// to the command.

	// If the context gets cancelled, the command terminates as well.
	// https://www.sohamkamani.com/golang/context/
	ctx := context.Background()
	// var cancel context.CancelFunc
	// The context now times out after 1 second
	// alternately, we can call `cancel()` to terminate immediately
	ctx, _ = context.WithTimeout(ctx, 5*time.Second)

	cmd := exec.CommandContext(ctx, "sleep", "100")

	out, err := cmd.Output()
	if err != nil {
		fmt.Println("could not run command: ", err)
	}
	fmt.Println("Output: ", string(out))
}
