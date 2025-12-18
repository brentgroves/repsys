Now, to test the code, open two terminals (in Linux). Run this program from terminal 1 with the following command:

Terminal 1: go run main.go
Go to terminal 2 and find the PID (process ID) of the running program main with the command:

$ ps -e.
Say, the process ID is 22304. We would then want to give a specific signal to the running main program using the following kill command:

$ kill -SIGHUP 22304
This will hang up the process running in terminal 1.

Next, run main.go again and test another signal, such as kill -SIGINT 22969. Repeat this process several times until you are comfortable with it. Notice how we can generate software (keyboard – CTRL+C) interrupts programmatically without actually pressing CTRL+C.

Final Thoughts on OS Signals in Go and Golang
In C, signal handling is actually very common. It is interesting to see Go also provide features to handle some low-level code. This can be quite useful because, as developers handle signals or write their own custom handler functions, we can write some cleanup code to gracefully terminate a program, say a server, or terminate any process gracefully even if CTRL+C is pressed. These low level benefits are otherwise not possible. But, understand that Go is not built to replace C; the language C is, and will remain, supreme when it comes to system level programming.
