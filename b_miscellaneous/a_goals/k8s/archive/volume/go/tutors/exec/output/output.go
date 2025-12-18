package main

import (
	"fmt"
	"log"
	"os/exec"
)

func main() {
	// https://www.sohamkamani.com/golang/exec-shell-command/

	// Note that when we run exec, our application does not spawn
	// a shell, and runs the given command directly. This means
	// that any shell-based processing, like glob patterns or expansions
	// will not be done.
	// So for example, when we run ls ./*.md , it is not expanded
	// into README.md like we expect when running in our bash shell.

	// create a new *Cmd instance
	// here we pass the command as the first argument and the arguments to pass to the command as the
	// remaining arguments in the function
	cmd := exec.Command("ls", "./")
	// an alternate way is: out, err := exec.Command("ls", "-l").Output()

	// The `Output` method executes the command and
	// collects the output, returning its value
	out, err := cmd.Output()
	if err != nil {
		// if there was any error, print it here
		fmt.Println("could not run command: ", err)
		log.Fatal(err)
	}
	// otherwise, print the output from running the command
	fmt.Println("Output: ", string(out))

}
