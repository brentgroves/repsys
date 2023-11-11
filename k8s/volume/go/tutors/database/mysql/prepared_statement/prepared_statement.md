// In this example we prepare two statements - one for inserting tuples (rows) and one to query.

package main

import (
 "database/sql"
 "fmt"
 "log"
 "strconv"

 "github.com/go-sql-driver/mysql"
)

var db *sql.DB

func main() {
 // Capture connection properties.
 // <https://pkg.go.dev/github.com/go-sql-driver/mysql#Config>
 // <https://github.com/go-sql-driver/mysql/wiki/Examples>
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

 // Prepare statement for inserting data
 stmtIns, err := db.Prepare("INSERT INTO tutors.album VALUES( ?, ?, ? )") // ? = placeholder
 // stmtIns, err := db.Prepare("INSERT INTO squareNum VALUES( ?, ? )") // ? = placeholder
 if err != nil {
  log.Fatal(err)
 }
 defer stmtIns.Close() // Close the statement when we leave main() / the program terminates

 // Prepare statement for reading data
 stmtOut, err := db.Prepare("select * from tutors.album WHERE id = ?")
 if err != nil {
  log.Fatal(err)
 }
 defer stmtOut.Close()

 // Insert record
 for i := 0; i < 25; i++ {
  _, err = stmtIns.Exec("title"+strconv.Itoa(i),"artist", 56.99) // Insert tuples
  if err != nil {
   log.Fatal(err)
  }
 }

 var squareNum int // we "scan" the result in here

 // Query the square-number of 13
 err = stmtOut.QueryRow(13).Scan(&squareNum) // WHERE number = 13
 if err != nil {
  panic(err.Error()) // proper error handling instead of panic in your app
 }
 fmt.Printf("The square number of 13 is: %d", squareNum)

 // Query another number.. 1 maybe?
 err = stmtOut.QueryRow(1).Scan(&squareNum) // WHERE number = 1
 if err != nil {
  panic(err.Error()) // proper error handling instead of panic in your app
 }
 fmt.Printf("The square number of 1 is: %d", squareNum)
}
