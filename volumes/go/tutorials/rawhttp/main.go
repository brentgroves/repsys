// https://stackoverflow.com/questions/33963467/parse-http-requests-and-responses-from-text-file-in-go
// https://stackoverflow.com/questions/67755205/programmatically-replaying-a-raw-http-request
package main

import (
	"bufio"
	"bytes"
	"fmt"
	"io"
	"io/ioutil"
	"log"
	"net/http"
	"net/http/httputil"
	"os"
)

type Connection struct {
	Request  *http.Request
	Response *http.Response
}

func ReadHTTPFromFile(r io.Reader) ([]Connection, error) {
	buf := bufio.NewReader(r)
	stream := make([]Connection, 0)

	for {
		req, err := http.ReadRequest(buf)
		if err == io.EOF {
			break
		}
		if err != nil {
			return stream, err
		}

		resp, err := http.ReadResponse(buf, req)
		if err != nil {
			return stream, err
		}

		//save response body
		b := new(bytes.Buffer)
		io.Copy(b, resp.Body)
		resp.Body.Close()
		resp.Body = ioutil.NopCloser(b)

		stream = append(stream, Connection{Request: req, Response: resp})
	}
	return stream, nil

}
func main() {
	f, err := os.Open("/tmp/test.http")
	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()
	stream, err := ReadHTTPFromFile(f)
	if err != nil {
		log.Fatalln(err)
	}
	for _, c := range stream {
		b, err := httputil.DumpRequest(c.Request, true)
		if err != nil {
			log.Fatal(err)
		}
		fmt.Println(string(b))
		b, err = httputil.DumpResponse(c.Response, true)
		if err != nil {
			log.Fatal(err)
		}
		fmt.Println(string(b))
	}
}
