package main

import (
	"context"
	"log"
	"time"

	amqp "github.com/rabbitmq/amqp091-go"
)

func failOnError(err error, msg string) {
	if err != nil {
		log.Panicf("%s: %s", msg, err)
	}
}

func main() {
	// conn, err := amqp.Dial("amqp://guest:guest@localhost:5672/")
	// username="$(kubectl get secret rabbitmqcluster-sample-default-user -o jsonpath='{.data.username}' | base64 --decode)"
	// password="$(kubectl get secret rabbitmqcluster-sample-default-user -o jsonpath='{.data.password}' | base64 --decode)"
	// conn, err := amqp.Dial("amqp://default_user_ur_9_UJ1UUV0kFbT1v9:password@repsys11-c2-n1:32672/") // delete me
	// conn, err := amqp.Dial("amqp://default_user__rDlt8SqGfm2unYYV0z:TY0G0L34M34pZ9XJiNdSuY5sbBcwxb-w@172.168.159.107:32079/") // delete me
	conn, err := amqp.Dial("amqp://default_user__rDlt8SqGfm2unYYV0z:TY0G0L34M34pZ9XJiNdSuY5sbBcwxb-w@172.168.159.107:5672/") // delete me

	failOnError(err, "Failed to connect to RabbitMQ")
	defer conn.Close()

	ch, err := conn.Channel()
	failOnError(err, "Failed to open a channel")
	defer ch.Close()

	// To send, we must declare a queue for us to send to; then we can publish a message to the queue:
	q, err := ch.QueueDeclare(
		"hello", // name
		false,   // durable
		false,   // delete when unused
		false,   // exclusive
		false,   // no-wait
		nil,     // arguments
	)
	failOnError(err, "Failed to declare a queue")

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	body := "Hello World!"
	err = ch.PublishWithContext(ctx,
		"",     // exchange
		q.Name, // routing key
		false,  // mandatory
		false,  // immediate
		amqp.Publishing{
			ContentType: "text/plain",
			Body:        []byte(body),
		})
	failOnError(err, "Failed to publish a message")
	log.Printf(" [x] Sent %s\n", body)

}
