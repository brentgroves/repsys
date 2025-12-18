package main

import (
	"database/sql"
	"fmt"
	"log"

	"github.com/go-sql-driver/mysql"
)

var db *sql.DB

func main() {
	// Capture connection properties.
	// https://pkg.go.dev/github.com/go-sql-driver/mysql#Config
	// https://github.com/go-sql-driver/mysql/wiki/Examples
	cfg := mysql.Config{
		User:   "root",
		Passwd: "password",
		// User:   os.Getenv("username3"),
		// Passwd: os.Getenv("password3"),
		Net:    "tcp",
		Addr:   "reports31:30031",
		DBName: "mysql",
	}
	// Get a database handle.
	var err error
	db, err = sql.Open("mysql", cfg.FormatDSN())
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()
	pingErr := db.Ping()
	if pingErr != nil {
		log.Fatal(pingErr)
	}
	fmt.Println("Connected!")
}
