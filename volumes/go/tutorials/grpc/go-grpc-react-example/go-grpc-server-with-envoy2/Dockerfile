FROM golang:1.22.0-alpine

WORKDIR /app

COPY go.sum ./


COPY . ./

RUN go build -o  /go-grpc-server-with-envoy2

EXPOSE 8080

CMD [ "/go-grpc-server-with-envoy2" ]