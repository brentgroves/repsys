# **[Send emails in Go using email API](https://mailtrap.io/blog/golang-send-email/#Send-emails-in-Go-using-email-API)**

**[Back to Research List](../../../../research/research_list.md)**\
**[Back to Current Status](../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../README.md)**

## references

- **[email sending articles](https://help.mailtrap.io/category/108-email-sending)**
- **[Mail Module](../../../../../go/tutorials/smtp/mailtrap/go_mailtrap/module/menu.md)**
- **[Mail Main](../../../../../go/tutorials/smtp/mailtrap/go_mailtrap/main/menu.md)**

## EMail bounce

- **[Grey Listing](https://serverfault.com/questions/136262/get-off-greylisting-the-reason-why-our-emails-bounced-back)**

## Send emails in Go using email API

Prefer having an automated sending process? If so, I suggest using Mailtrap’s very own **[Email API](https://mailtrap.io/email-api/)**. The API is regularly maintained and updated by a team of developers, which means you can sit back and enjoy stress-free coding.

And here’s how you can integrate the API with your project and start sending emails:

- Create a **[free Mailtrap account](https://mailtrap.io/register/signup)**.
- Verify your domain and update DNS records.
- Navigate to the Sending Domains → Integration and choose the Transactional Stream for now.
- Click on API and select Go underneath Code Samples.

![cs](https://mailtrap.io/wp-content/uploads/2024/10/Screenshot-2024-09-30-at-17.10.29-1-1920x1325.png)

Then, to send a plain-text email, copy the snippet below into your **[send.go](../../../../../go/tutorials/smtp/mailtrap/go_mailtrap/module/go_mailtrap/plain_text/send.go)** file:

```go
package main

import (

"bytes"

"fmt"

"io"

"log"

"net/http"

"time"

)

func main() {

// Mailtrap account config

token := "<secret_token>"

httpHost := "https://send.api.mailtrap.io/api/send"

// Message body

message := []byte(`{"from":{"email":"john.doe@your.domain"},

"to":[{"email":"kate.doe@example.com"}],

"subject":"Why aren’t you using Mailtrap yet?",

"text":"Here’s the space for your great sales pitch"}`)

// Set up request

request, err := http.NewRequest(http.MethodPost, httpHost, bytes.NewBuffer(message))

if err != nil {

log.Fatal(err)

}

// Set required headers

request.Header.Set("Content-Type", "application/json")

request.Header.Set("Authorization", "Bearer "+token)

// Send request

client := http.Client{Timeout: 5 * time.Second}

res, err := client.Do(request)

if err != nil {

log.Fatal(err)

}

defer res.Body.Close()

body, err := io.ReadAll(res.Body)

if err != nil {

log.Fatal(err)

}

fmt.Println(string(body))

}
```
