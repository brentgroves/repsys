<https://go.dev/doc/tutorial/database-access>

Find and import a database driver
Now that you’ve got a database with some data, get your Go code started.

Locate and import a database driver that will translate requests you make through functions in the database/sql package into requests the database understands.

In your browser, visit the SQLDrivers wiki page to identify a driver you can use.

Use the list on the page to identify the driver you’ll use. For accessing MySQL in this tutorial, you’ll use Go-MySQL-Driver.

Note the package name for the driver – here, github.com/go-sql-driver/mysql.

Using your text editor, create a file in which to write your Go code and save the file as main.go in the data-access directory you created earlier.

Into main.go, paste the following code to import the driver package.

package main

import "github.com/go-sql-driver/mysql"
In this code, you:

Add your code to a main package so you can execute it independently.

Import the MySQL driver github.com/go-sql-driver/mysql.

With the driver imported, you’ll start writing code to access the database.

Get a database handle and connect
Now write some Go code that gives you database access with a database handle.

You’ll use a pointer to an sql.DB struct, which represents access to a specific database.

var db *sql.DB

func main() {
    // Capture connection properties.
    cfg := mysql.Config{
        User:   "root",
        Passwd: "password",
        <!-- User:   os.Getenv("username3"),
        Passwd: os.Getenv("password3"), -->
        Net:    "tcp",
        Addr:   "127.0.0.1:3306",
        DBName: "recordings",
    }
    // Get a database handle.
    var err error
    db, err = sql.Open("mysql", cfg.FormatDSN())
    if err != nil {
        log.Fatal(err)
    }

    pingErr := db.Ping()
    if pingErr != nil {
        log.Fatal(pingErr)
    }
    fmt.Println("Connected!")
}
export username3=$(</etc/lastpass/username3)
export password3=$(</etc/lastpass/password3)

DBUSER root
