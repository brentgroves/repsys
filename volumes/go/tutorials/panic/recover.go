package main

import (
	"errors"
	"fmt"
)

func connect() error {
	// Attempt to connect to server
	err := errors.New("empty name")

	if err != nil {
		panic(err)
	}
	return nil
}

func main() {
	defer func() {
		if r := recover(); r != nil {
			fmt.Println("Recovered from panic:", r)
		}
	}()
	err := connect()
	if err != nil {
		fmt.Println("Error connecting to server:", err)
	}
	// Continue executing program
}
