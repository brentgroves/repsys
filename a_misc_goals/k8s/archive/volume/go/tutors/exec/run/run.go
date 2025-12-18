package main

import (
	"fmt"
	"os"
	"os/exec"
)

func main() {
	// https://www.sohamkamani.com/golang/exec-shell-command/

	// If we tried executing ping using cmd.Output,
	// we wouldn’t get any output, since the Output method waits
	// for the command to execute, and the ping command executes
	// indefinitely.
	// Instead, we can create a custom Stdout attribute to read output
	// continuously:

	cmd2 := exec.Command("ping", "google.com")
	// pipe the commands output to the applications
	// standard output
	cmd2.Stdout = os.Stdout

	// Runs the command and waits for completion
	// but the output is instantly piped to Stdout
	if err := cmd2.Run(); err != nil {
		fmt.Println("could not run command: ", err)
	}

}
