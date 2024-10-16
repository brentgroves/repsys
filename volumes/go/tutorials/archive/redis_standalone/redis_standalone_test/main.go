package main

// https://redis.io/docs/latest/develop/connect/clients/go/
import (
	"context"
	"fmt"

	"github.com/redis/go-redis/v9"
)

func main() {
	client := redis.NewClient(&redis.Options{
		Addr: "reports31:30380", //"localhost:6379"
		// Addr:     "reports31:30379", //"localhost:6379"
		Password: "password", // no password set
		DB:       0,          // use default DB
	})
	ctx := context.Background()

	err := client.Set(ctx, "foo", "bar", 0).Err()
	if err != nil {
		panic(err)
	}

	val, err := client.Get(ctx, "foo").Result()
	if err != nil {
		panic(err)
	}
	fmt.Println("foo", val)
}
