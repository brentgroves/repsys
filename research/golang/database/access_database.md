# Database

## references

<https://go.dev/doc/database/>
<https://go.dev/doc/tutorial/database-access>

## Accessing relational databases

Using Go, you can incorporate a wide variety of databases and data access approaches into your applications. Topics in this section describe how to use the standard library’s database/sql package to access relational databases.

For an introductory tutorial to data access with Go, please see Tutorial: Accessing a relational database.

Go supports other data access technologies as well, including ORM libraries for higher-level access to relational databases, and also non-relational NoSQL data stores.

- Object-relational mapping (ORM) libraries. While the database/sql package includes functions for lower-level data access logic, you can also use Go to access data stores at a higher abstraction level. For more about two popular object-relational mapping (ORM) libraries for Go, see GORM (package reference) and ent (package reference).
- NoSQL data stores. The Go community has developed drivers for the majority of NoSQL data stores, including MongoDB and Couchbase. You can search pkg.go.dev for more.

## Supported database management systems

Go supports all of the most common relational database management systems, including MySQL, Oracle, Postgres, SQL Server, SQLite, and more.

You’ll find a complete list of drivers at the SQLDrivers page.

## Functions to execute queries or make database changes

The database/sql package includes functions specifically designed for the kind of database operation you’re executing. For example, while you can use Query or QueryRow to execute queries, QueryRow is designed for the case when you’re expecting only a single row, omitting the overhead of returning an sql.Rows that includes only one row. You can use the Exec function to make database changes with SQL statements such as INSERT, UPDATE, or DELETE.

For more, see the following:

- **[Executing SQL statements that don’t return data](https://go.dev/doc/database/change-data)**
- **[Querying for data](https://go.dev/doc/database/querying)**

## Transactions

Through sql.Tx, you can write code to execute database operations in a transaction. In a transaction, multiple operations can be performed together and conclude with a final commit, to apply all the changes in one atomic step, or a rollback, to discard them.

For more about transactions, see Executing transactions.

## Query cancellation

You can use context.Context when you want the ability to cancel a database operation, such as when the client’s connection closes or the operation runs longer than you want it to.

For any database operation, you can use a database/sql package function that takes Context as an argument. Using the Context, you can specify a timeout or deadline for the operation. You can also use the Context to propagate a cancellation request through your application to the function executing an SQL statement, ensuring that resources are freed up if they’re no longer needed.

For more, see Canceling in-progress operations.

## Managed connection pool

When you use the sql.DB database handle, you’re connecting with a built-in connection pool that creates and disposes of connections according to your code’s needs. A handle through sql.DB is the most common way to do database access with Go. For more, see Opening a database handle.

The database/sql package manages the connection pool for you. However, for more advanced needs, you can set connection pool properties as described in Setting connection pool properties.

For those operations in which you need a single reserved connection, the database/sql package provides sql.Conn. Conn is especially useful when a transaction with sql.Tx would be a poor choice.

For example, your code might need to:

Make schema changes through a DDL, including logic that contains its own transaction semantics. Mixing sql package transaction functions with SQL transaction statements is a poor practice, as described in Executing transactions.
Perform query locking operations that create temporary tables.

## **[Executing SQL that change data](https://go.dev/doc/database/change-data)**

Executing SQL statements that don't return data
When you perform database actions that don’t return data, use an Exec or ExecContext method from the database/sql package. SQL statements you’d execute this way include INSERT, DELETE, and UPDATE.

When your query might return rows, use a Query or QueryContext method instead. For more, see Querying a database.

An ExecContext method works as an Exec method does, but with an additional context.Context argument, as described in Canceling in-progress operations.

Code in the following example uses DB.Exec to execute a statement to add a new record album to an album table.

func AddAlbum(alb Album) (int64, error) {
    result, err := db.Exec("INSERT INTO album (title, artist) VALUES (?, ?)", alb.Title, alb.Artist)
    if err != nil {
        return 0, fmt.Errorf("AddAlbum: %v", err)
    }

    // Get the new album's generated ID for the client.
    id, err := result.LastInsertId()
    if err != nil {
        return 0, fmt.Errorf("AddAlbum: %v", err)
    }
    // Return the new album's ID.
    return id, nil
}
