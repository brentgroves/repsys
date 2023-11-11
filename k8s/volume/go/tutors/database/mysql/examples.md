<https://github.com/go-sql-driver/mysql/wiki/Examples>

A word on sql.Open
First, you should understand that a sql.DB is not a connection. When you use sql.Open() you get a handle for a database. The database/sql package manages a pool of connections in the background, and doesn't open any connections until you need them. Therefore sql.Open() doesn't directly open a connection. As a result, sql.Open() does not return an error, if the server isn't available or the connection data (Username, Password) isn't correct. If you want to check this before making queries (e.g at application startup) you can use db.Ping().
