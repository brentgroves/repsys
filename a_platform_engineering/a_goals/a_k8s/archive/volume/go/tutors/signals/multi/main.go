package main

import (
	"fmt"
	"os"
	"os/signal"
	"syscall"
)

func multiSignalHandler(signal os.Signal) {

	switch signal {
	case syscall.SIGHUP:
		fmt.Println("Signal:", signal.String())
		os.Exit(0)
	case syscall.SIGINT:
		fmt.Println("Signal:", signal.String())
		os.Exit(0)
	case syscall.SIGTERM:
		fmt.Println("Signal:", signal.String())
		os.Exit(0)
	case syscall.SIGQUIT:
		fmt.Println("Signal:", signal.String())
		os.Exit(0)
	default:
		fmt.Println("Unhandled/unknown signal")
	}
}

func main() {
	sigchnl := make(chan os.Signal, 1)
	signal.Notify(sigchnl, syscall.SIGHUP, syscall.SIGINT, syscall.SIGTERM) //we can add more sycalls.SIGQUIT etc.
	exitchnl := make(chan int)

	go func() {
		for {
			s := <-sigchnl
			multiSignalHandler(s)
		}
	}()

	exitcode := <-exitchnl
	os.Exit(exitcode)
}
