package main

// https://redis.io/docs/latest/develop/connect/clients/go/
import (
	"context"
	"fmt"

	"github.com/redis/go-redis/v9"
)

// func ExampleNewFailoverClient() {
// 	// See http://redis.io/topics/sentinel for instructions how to
// 	// setup Redis Sentinel.
// 	rdb := redis.NewFailoverClient(&redis.FailoverOptions{
// 		MasterName:    "master",
// 		SentinelAddrs: []string{":26379"},
// 	})
// 	rdb.Ping(ctx)
// }

func main() {

	// https://redis.uptrace.dev/guide/go-redis-sentinel.html#redis-server-client
	// https://github.com/redis/go-redis/blob/master/example_test.go
	// Dont know how NewFailoverClient works but NewClient seems to work ok.
	// rdb := redis.NewFailoverClient(&redis.FailoverOptions{
	// 	MasterName:    "redis-sentinel-master",
	// 	SentinelAddrs: []string{":9126", ":9127", ":9128"},
	// })
	// redis-sentinel-master

	// connect to node port service
	// client := redis.NewClient(&redis.Options{
	// 	// Addr: "reports31:30380", //"localhost:6379"
	// 	Addr:     "reports31:30379", //"localhost:6379"
	// 	Password: "CeMTAUol3n",      // no password set
	// 	DB:       0,                 // use default DB
	// })

	// connect with port-forward running and FQDN added to /etc/hosts
	client := redis.NewClient(&redis.Options{
		// Addr: "localhost:6379",
		Addr:     "redis-sentinel-master.redis-sentinel.svc.cluster.local:6379", //"localhost:6379"
		Password: "CeMTAUol3n",                                                  // no password set
		DB:       0,                                                             // use default DB
	})

	// redis-sentinel-master.redis-sentinel.svc.cluster.local
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
