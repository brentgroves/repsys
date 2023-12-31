package main

import (
	"context"
	"fmt"
	"net/http"
	"time"
)

func main() {
	// Create a new context
	// With a deadline of 100 milliseconds
	ctx := context.Background()

	ctx, _ = context.WithTimeout(ctx, 100*time.Millisecond) // google.com not this fast
	// ctx, _ = context.WithTimeout(ctx, 1000*time.Millisecond) // 1 second is long enough

	// Make a request, that will call the google homepage
	req, _ := http.NewRequest(http.MethodGet, "http://google.com", nil)
	// Associate the cancellable context we just created to the request
	req = req.WithContext(ctx)

	// Create a new HTTP client and execute the request
	client := &http.Client{}
	res, err := client.Do(req)
	// If the request failed, log to STDOUT
	if err != nil {
		fmt.Println("Request failed:", err)
		return
	}
	// Print the status code if the request succeeds
	fmt.Println("Response received, status code:", res.StatusCode)
}
