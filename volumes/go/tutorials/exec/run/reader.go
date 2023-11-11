package main

import (
	"fmt"
	"io"
	"os"
	"os/exec"
)

func main() {
	// https://www.sohamkamani.com/golang/exec-shell-command/
	// The *Cmd instance provides us with an input stream which we
	// can write into. Let’s use it to pass input to a grep child
	// process:

	cmd4 := exec.Command("grep", "apple")

	// Create a new pipe, which gives us a reader/writer pair
	reader, writer := io.Pipe()
	// assign the reader to Stdin for the command
	cmd4.Stdin = reader
	// the output is printed to the console
	cmd4.Stdout = os.Stdout

	go func() {
		defer writer.Close()
		// the writer is connected to the reader via the pipe
		// so all data written here is passed on to the commands
		// standard input
		writer.Write([]byte("1. pear\n"))
		writer.Write([]byte("2. grapes\n"))
		writer.Write([]byte("3. apple\n"))
		writer.Write([]byte("4. banana\n"))
	}()

	if err := cmd4.Run(); err != nil {
		fmt.Println("could not run command: ", err)
	}

}
