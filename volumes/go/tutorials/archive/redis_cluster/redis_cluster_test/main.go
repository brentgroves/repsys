package main

// https://redis.io/docs/latest/develop/connect/clients/go/
import (
	"context"
	"fmt"

	"github.com/redis/go-redis/v9"
)

func main() {
	client := redis.NewClusterClient(&redis.ClusterOptions{
		Addrs: []string{":16379", ":16380", ":16381", ":16382", ":16383", ":16384"},

		// To route commands by latency or randomly, enable one of the following.
		//RouteByLatency: true,
		//RouteRandomly: true,
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
