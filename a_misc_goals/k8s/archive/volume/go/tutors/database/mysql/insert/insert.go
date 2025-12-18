package main

import (
	"database/sql"
	"log"
	"time"

	"github.com/go-sql-driver/mysql"
)

var db *sql.DB

func main() {
	// Capture connection properties.
	// https://pkg.go.dev/github.com/go-sql-driver/mysql#Config
	cfg := mysql.Config{
		User:   "root",
		Passwd: "password",
		// User:   os.Getenv("username3"),
		// Passwd: os.Getenv("password3"),
		Net:          "tcp",
		Addr:         "reports31:30031",
		DBName:       "tutors",
		Timeout:      30 * time.Second, // Dial timeout
		ReadTimeout:  30 * time.Second, // I/O read timeout
		WriteTimeout: 30 * time.Second, // I/O write timeout
	}

	// Get a database handle.
	var err error
	db, err = sql.Open("mysql", cfg.FormatDSN())
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()
	// Set Maximum time (in seconds) that a connection can remain open.
	// db.SetConnMaxLifetime(1800 * time.Second)
	// Prepare statement for inserting data
	stmtIns, err := db.Prepare("INSERT INTO squareNum VALUES( ?, ? )") // ? = placeholder
	if err != nil {
		log.Fatal(err)
	}
	defer stmtIns.Close() // Close the statement when we leave main() / the program terminates

	// Insert square numbers for 0-24 in the database
	for i := 0; i < 25; i++ {
		_, err = stmtIns.Exec(i, (i * i)) // Insert tuples (i, i^2)
		if err != nil {
			log.Fatal(err)
			// panic(err.Error()) // proper error handling instead of panic in your app
		}
	}

}
