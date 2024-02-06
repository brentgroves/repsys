# Database

## references

<https://go.dev/doc/tutorial/database-access>

## Tutorial: Accessing a relational database

This tutorial introduces the basics of accessing a relational database with Go and the database/sql package in its standard library.

You’ll get the most out of this tutorial if you have a basic familiarity with Go and its tooling. If this is your first exposure to Go, please see Tutorial: Get started with Go for a quick introduction.

The database/sql package you’ll be using includes types and functions for connecting to databases, executing transactions, canceling an operation in progress, and more. For more details on using the package, see Accessing databases.

In this tutorial, you’ll create a database, then write code to access the database. Your example project will be a repository of data about vintage jazz records.

## Setup MySQL

If you have docker you can run Mysql image from docker and use it.

```bash
# Connection from localhost or docker container
# https://stackoverflow.com/questions/75704567/client-does-not-support-authentication-protocol-requested-by-server-error-in-bot
mysql -u root -pdbpass -h 127.0.0.1 -P 3306 hackernews
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'dbpass';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';
FLUSH PRIVILEGES;
# or
docker run -p 3306:3306 --name mysql -e MYSQL_ROOT_PASSWORD=dbpass -e MYSQL_DATABASE=hackernews -d mysql:latest 

# now run  and you should see our mysql image is running:

docker ps

CONTAINER ID        IMAGE                                                               COMMAND                  CREATED             STATUS              PORTS                  NAMES
8fea71529bb2        mysql:latest                                                        "docker-entrypoint.s
```

## Create a folder for your code

```bash
pushd .
cd ~/src/repsys/volumes/go/tutorials/database/mysql/tutorial_access_database

# Create a module in which you can manage dependencies you will add during this tutorial.

# Run the go mod init command, giving it your new code’s module path.

go mod init example/data-access
go: creating new go.mod: module example/data-access

#This command creates a go.mod file in which dependencies you add will be listed for tracking. For more, be sure to see Managing dependencies.

# Note: In actual development, you’d specify a module path that’s more specific to your own needs. For more, see Managing dependencies.

```

Next, you’ll create a database.

## Set up a database

In this step, you’ll create the database you’ll be working with. You’ll use the CLI for the DBMS itself to create the database and table, as well as to add data.

You’ll be creating a database with data about vintage jazz recordings on vinyl.

The code here uses the MySQL CLI, but most DBMSes have their own CLI with similar features.

## Create MySQL database

You have already started mysql instance in the previous step. Now we will need to create our hackernews database in that instance. To create the database run these commands.

```bash
docker exec -it mysql bash

# It will open the bash terminal inside mysql instance.

# In the next step we will open mysql repl as the root user:

mysql -u root -p

# It will ask you for root password, enter dbpass and enter.

# Now we are inside mysql repl. To create the database, run this command:

create database recordings;
use recordings;


```

In your text editor, in the data-access folder, create a file called create-tables.sql to hold SQL script for adding tables.

Into the file, paste the following SQL code, then save the file.

```sql
DROP TABLE IF EXISTS album;
CREATE TABLE album (
  id         INT AUTO_INCREMENT NOT NULL,
  title      VARCHAR(128) NOT NULL,
  artist     VARCHAR(255) NOT NULL,
  price      DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO album
  (title, artist, price)
VALUES
  ('Blue Train', 'John Coltrane', 56.99),
  ('Giant Steps', 'John Coltrane', 63.99),
  ('Jeru', 'Gerry Mulligan', 17.99),
  ('Sarah Vaughan', 'Sarah Vaughan', 34.98);
```

In this SQL code, you:

- Delete (drop) a table called album. Executing this command first makes it easier for you to re-run the script later if you want to start over with the table.
- Create an album table with four columns: title, artist, and price. Each row’s id value is created automatically by the DBMS.
- Add four rows with values.

mysql> select * from album;

Next, you’ll write some Go code to connect so you can query.

Find and import a database driver
Now that you’ve got a database with some data, get your Go code started.

Locate and import a database driver that will translate requests you make through functions in the database/sql package into requests the database understands.

n your browser, visit the **[SQLDrivers wiki](https://go.dev/wiki/SQLDrivers)** page to identify a driver you can use.

Use the list on the page to identify the driver you’ll use. For accessing MySQL in this tutorial, you’ll use **[Go-MySQL-Driver](https://github.com/go-sql-driver/mysql/)**.

Note the package name for the driver – here, github.com/go-sql-driver/mysql.

Using your text editor, create a file in which to write your Go code and save the file as main.go in the data-access directory you created earlier.

Into main.go, paste the following code to import the driver package.

package main

import "github.com/go-sql-driver/mysql"

In this code, you:

- Add your code to a main package so you can execute it independently.

- Import the MySQL driver github.com/go-sql-driver/mysql.

With the driver imported, you’ll start writing code to access the database.

## Get a database handle and connect

Now write some Go code that gives you database access with a database handle.

You’ll use a pointer to an sql.DB struct, which represents access to a specific database.

Write the code
Into main.go, beneath the import code you just added, paste the following Go code to create a database handle.

```go
package main

import "github.com/go-sql-driver/mysql"

var db *sql.DB

func main() {
    // Capture connection properties.
    cfg := mysql.Config{
        User:   os.Getenv("DBUSER"),
        Passwd: os.Getenv("DBPASS"),
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
```

In this code, you:

Declare a db variable of type *sql.DB. This is your database handle.

Making db a global variable simplifies this example. In production, you’d avoid the global variable, such as by passing the variable to functions that need it or by wrapping it in a struct.

Use the MySQL driver’s Config – and the type’s FormatDSN -– to collect connection properties and format them into a DSN for a connection string.

Call sql.Open to initialize the db variable, passing the return value of FormatDSN.

Check for an error from sql.Open. It could fail if, for example, your database connection specifics weren’t well-formed.

To simplify the code, you’re calling log.Fatal to end execution and print the error to the console. In production code, you’ll want to handle errors in a more graceful way.

Call DB.Ping to confirm that connecting to the database works. At run time, sql.Open might not immediately connect, depending on the driver. You’re using Ping here to confirm that the database/sql package can connect when it needs to.

Check for an error from Ping, in case the connection failed.

Print a message if Ping connects successfully.

Near the top of the main.go file, just beneath the package declaration, import the packages you’ll need to support the code you’ve just written.

The top of the file should now look like this:

package main

import (
    "database/sql"
    "fmt"
    "log"
    "os"

    "github.com/go-sql-driver/mysql"
)

Save main.go.

Begin tracking the MySQL driver module as a dependency.

Use the go get to add the github.com/go-sql-driver/mysql module as a dependency for your own module. Use a dot argument to mean “get dependencies for code in the current directory.”

$ go get .
go get: added github.com/go-sql-driver/mysql v1.6.0

From the command prompt, set the DBUSER and DBPASS environment variables for use by the Go program.

On Linux or Mac:

$ export DBUSER=root
$ export DBPASS=dbpass

From the command line in the directory containing main.go, run the code by typing go run with a dot argument to mean “run the package in the current directory.”

$ go run .
Connected!

You can connect! Next, you’ll query for some data.

Query for multiple rows
In this section, you’ll use Go to execute an SQL query designed to return multiple rows.

For SQL statements that might return multiple rows, you use the Query method from the database/sql package, then loop through the rows it returns. (You’ll learn how to query for a single row later, in the section Query for a single row.)

Write the code
Into main.go, immediately above func main, paste the following definition of an Album struct. You’ll use this to hold row data returned from the query.

type Album struct {
    ID     int64
    Title  string
    Artist string
    Price  float32
}

Beneath func main, paste the following albumsByArtist function to query the database.

```go
// albumsByArtist queries for albums that have the specified artist name.
func albumsByArtist(name string) ([]Album, error) {
    // An albums slice to hold data from returned rows.
    var albums []Album

    rows, err := db.Query("SELECT * FROM album WHERE artist = ?", name)
    if err != nil {
        return nil, fmt.Errorf("albumsByArtist %q: %v", name, err)
    }
    defer rows.Close()
    // Loop through rows, using Scan to assign column data to struct fields.
    for rows.Next() {
        var alb Album
        if err := rows.Scan(&alb.ID, &alb.Title, &alb.Artist, &alb.Price); err != nil {
            return nil, fmt.Errorf("albumsByArtist %q: %v", name, err)
        }
        albums = append(albums, alb)
    }
    if err := rows.Err(); err != nil {
        return nil, fmt.Errorf("albumsByArtist %q: %v", name, err)
    }
    return albums, nil
}
```

In this code, you:

- Declare an albums slice of the Album type you defined. This will hold data from returned rows. Struct field names and types correspond to database column names and types.
- Use DB.Query to execute a SELECT statement to query for albums with the specified artist name.
- Query’s first parameter is the SQL statement. After the parameter, you can pass zero or more parameters of any type. These provide a place for you to specify the values for parameters in your SQL statement. By separating the SQL statement from parameter values (rather than concatenating them with, say, fmt.Sprintf), you enable the database/sql package to send the values separate from the SQL text, removing any SQL injection risk.
- Defer closing rows so that any resources it holds will be released when the function exits.
- Loop through the returned rows, using Rows.Scan to assign each row’s column values to Album struct fields.
Scan takes a list of pointers to Go values, where the column values will be written. Here, you pass pointers to fields in the alb variable, created using the & operator. Scan writes through the pointers to update the struct fields.
- Inside the loop, check for an error from scanning column values into the struct fields.
- Inside the loop, append the new alb to the albums slice.
- After the loop, check for an error from the overall query, using rows.Err. Note that if the query itself fails, checking for an error here is the only way to find out that the results are incomplete.

Update your main function to call albumsByArtist.

To the end of func main, add the following code.

```go
albums, err := albumsByArtist("John Coltrane")
if err != nil {
    log.Fatal(err)
}
fmt.Printf("Albums found: %v\n", albums)
```

In the new code, you now:

Call the albumsByArtist function you added, assigning its return value to a new albums variable.

Print the result.

Run the code
From the command line in the directory containing main.go, run the code.

$ go run .
Connected!
Albums found: [{1 Blue Train John Coltrane 56.99} {2 Giant Steps John Coltrane 63.99}]

Next, you’ll query for a single row.

Query for a single row
In this section, you’ll use Go to query for a single row in the database.

For SQL statements you know will return at most a single row, you can use QueryRow, which is simpler than using a Query loop.

Write the code
Beneath albumsByArtist, paste the following albumByID function.

```go
// albumByID queries for the album with the specified ID.
func albumByID(id int64) (Album, error) {
    // An album to hold data from the returned row.
    var alb Album

    row := db.QueryRow("SELECT * FROM album WHERE id = ?", id)
    if err := row.Scan(&alb.ID, &alb.Title, &alb.Artist, &alb.Price); err != nil {
        if err == sql.ErrNoRows {
            return alb, fmt.Errorf("albumsById %d: no such album", id)
        }
        return alb, fmt.Errorf("albumsById %d: %v", id, err)
    }
    return alb, nil
}
```

In this code, you:

- Use DB.QueryRow to execute a SELECT statement to query for an album with the specified ID.
- It returns an sql.Row. To simplify the calling code (your code!), QueryRow doesn’t return an error. Instead, it arranges to return any query error (such as sql.ErrNoRows) from Rows.Scan later.
- Use Row.Scan to copy column values into struct fields.
- Check for an error from Scan.
- The special error sql.ErrNoRows indicates that the query returned no rows. Typically that error is worth replacing with more specific text, such as “no such album” here.

Update main to call albumByID.

To the end of func main, add the following code.

```go
// Hard-code ID 2 here to test the query.
alb, err := albumByID(2)
if err != nil {
    log.Fatal(err)
}
fmt.Printf("Album found: %v\n", alb)
```

In the new code, you now:

Call the albumByID function you added.

Print the album ID returned.

Run the code
From the command line in the directory containing main.go, run the code.

$ go run .
Connected!
Albums found: [{1 Blue Train John Coltrane 56.99} {2 Giant Steps John Coltrane 63.99}]
Album found: {2 Giant Steps John Coltrane 63.99}

Next, you’ll add an album to the database.

Add data
In this section, you’ll use Go to execute an SQL INSERT statement to add a new row to the database.

You’ve seen how to use Query and QueryRow with SQL statements that return data. To execute SQL statements that don’t return data, you use Exec.

Write the code
Beneath albumByID, paste the following addAlbum function to insert a new album in the database, then save the main.go.

```go
// addAlbum adds the specified album to the database,
// returning the album ID of the new entry
func addAlbum(alb Album) (int64, error) {
    result, err := db.Exec("INSERT INTO album (title, artist, price) VALUES (?, ?, ?)", alb.Title, alb.Artist, alb.Price)
    if err != nil {
        return 0, fmt.Errorf("addAlbum: %v", err)
    }
    id, err := result.LastInsertId()
    if err != nil {
        return 0, fmt.Errorf("addAlbum: %v", err)
    }
    return id, nil
}
```

In this code, you:

Use DB.Exec to execute an INSERT statement.

Like Query, Exec takes an SQL statement followed by parameter values for the SQL statement.

Check for an error from the attempt to INSERT.

Retrieve the ID of the inserted database row using Result.LastInsertId.

Check for an error from the attempt to retrieve the ID.

Update main to call the new addAlbum function.

To the end of func main, add the following code.

```go
albID, err := addAlbum(Album{
    Title:  "The Modern Sound of Betty Carter",
    Artist: "Betty Carter",
    Price:  49.99,
})
if err != nil {
    log.Fatal(err)
}
fmt.Printf("ID of added album: %v\n", albID)
```

In the new code, you now:

Call addAlbum with a new album, assigning the ID of the album you’re adding to an albID variable.
Run the code

From the command line in the directory containing main.go, run the code.

$ go run .
Connected!
Albums found: [{1 Blue Train John Coltrane 56.99} {2 Giant Steps John Coltrane 63.99}]
Album found: {2 Giant Steps John Coltrane 63.99}
ID of added album: 5
