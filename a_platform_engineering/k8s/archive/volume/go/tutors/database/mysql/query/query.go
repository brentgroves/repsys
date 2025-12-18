package main

// https://golangbot.com/connect-create-db-mysql/
// https://stackoverflow.com/questions/19927879/golang-mysql-database-not-selected
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
	// https://golangbot.com/connect-create-db-mysql/
	db.SetMaxOpenConns(20)
	db.SetConnMaxLifetime(time.Minute * 5)
	db.SetMaxIdleConns(20)
	defer db.Close()

	// Set Maximum time (in seconds) that a connection can remain open.
	// db.SetConnMaxLifetime(1800 * time.Second)
	stmtOut, err := db.Prepare("SELECT squareNumber FROM squareNum WHERE number = ?")
	if err != nil {
		log.Fatal(err)
	}
	defer stmtOut.Close()
	var squareNum int // we "scan" the result in here

	// Query the square-number of 13
	err = stmtOut.QueryRow(13).Scan(&squareNum) // WHERE number = 13
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("The square number of 13 is: %d", squareNum)

	// // Query another number.. 1 maybe?
	err = stmtOut.QueryRow(1).Scan(&squareNum) // WHERE number = 1
	if err != nil {
		panic(err.Error()) // proper error handling instead of panic in your app
	}
	fmt.Printf("The square number of 1 is: %d", squareNum)

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
	// fmt.Println(squareNumber)
	// fmt.Println(version)

	// var squareNum int // we "scan" the result in here

	// // Query the square-number of 13
	// err = stmtOut.QueryRow(13).Scan(&squareNum) // WHERE number = 13
	// if err != nil {
	// 	log.Fatal(err)
	// }
	// fmt.Printf("The square number of 13 is: %d", squareNum)

	// // // Query another number.. 1 maybe?
	// err = stmtOut.QueryRow(1).Scan(&squareNum) // WHERE number = 1
	// if err != nil {
	// 	panic(err.Error()) // proper error handling instead of panic in your app
	// }
	// fmt.Printf("The square number of 1 is: %d", squareNum)
	// https://golangbot.com/connect-create-db-mysql/
}
