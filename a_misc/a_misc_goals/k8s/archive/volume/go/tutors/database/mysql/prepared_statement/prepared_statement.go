package main

import (
	"database/sql"
	"fmt"
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
		DBName:       "tutors",         // schema name
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
	// Set Maximum time (in seconds) that a connection can remain open.
	// https://golangbot.com/connect-create-db-mysql/
	db.SetMaxOpenConns(20)
	db.SetConnMaxLifetime(time.Minute * 5)
	db.SetMaxIdleConns(20)
	defer db.Close()

	// Prepare statement for inserting data
	stmtIns, err := db.Prepare("INSERT INTO squareNum VALUES( ?, ? )") // ? = placeholder
	if err != nil {
		log.Fatal(err)
	}
	defer stmtIns.Close() // Close the statement when we leave main() / the program terminates

	// Prepare statement for reading data
	// https://gosamples.dev/connection-reset-by-peer/
	// https://github.com/go-sql-driver/mysql/wiki/Examples
	stmtOut, err := db.Prepare("SELECT squareNumber FROM squareNum WHERE number = ?")
	if err != nil {
		log.Fatal(err)
	}
	defer stmtOut.Close()

	// Insert square numbers for 0-24 in the database
	for i := 0; i < 25; i++ {
		_, err = stmtIns.Exec(i, (i * i)) // Insert tuples (i, i^2)
		if err != nil {
			log.Fatal(err)
			// panic(err.Error()) // proper error handling instead of panic in your app
		}
	}

	var squareNum int // we "scan" the result in here

	// Query the square-number of 13
	err = stmtOut.QueryRow(13).Scan(&squareNum) // WHERE number = 13
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("The square number of 13 is: %d\n", squareNum)

	// // Query another number.. 1 maybe?
	err = stmtOut.QueryRow(1).Scan(&squareNum) // WHERE number = 1
	if err != nil {
		panic(err.Error()) // proper error handling instead of panic in your app
	}
	fmt.Printf("The square number of 1 is: %d\n", squareNum)

	var err3 error
	res, err3 := db.Query("SELECT squareNumber FROM squareNum")
	// res, err3 := db.Query("SELECT squareNumber FROM squareNum WHERE number = 2")
	// https://zetcode.com/golang/mysql/
	if err3 != nil {
		log.Fatal(err3)
	}

	defer res.Close()

	// if err3 != nil {
	// 	log.Fatal(err3)
	// }

	for res.Next() {

		// var city City
		// err := res.Scan(&city.Id, &city.Name, &city.Population)
		var squareNum int
		err := res.Scan(&squareNum)

		if err != nil {
			log.Fatal(err)
		}

		fmt.Printf("%v\n", squareNum)
	}

}
