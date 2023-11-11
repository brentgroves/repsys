package main

import (
	"fmt"
	"os/exec"
)

type customOutput struct{}

func (c customOutput) Write(p []byte) (int, error) {
	fmt.Println("received output: ", string(p))
	return len(p), nil
}

func main() {
	// https://www.sohamkamani.com/golang/exec-shell-command/

	// Instead of using os.Stdout, we can create our own
	// writer that implements the io.Writer interface.

	cmd3 := exec.Command("ping", "google.com")

	// pipe the commands output to the applications
	// standard output
	cmd3.Stdout = customOutput{}

	// Run still runs the command and waits for completion
	// but the output is instantly piped to Stdout
	if err := cmd3.Run(); err != nil {
		fmt.Println("could not run command: ", err)
	}

}
