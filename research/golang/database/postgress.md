# Postgress

## references

<https://stackoverflow.com/questions/63752246/how-to-call-postgres-stored-procedure-from-golang-using-gorm-package>

## How to call postgres stored procedure from golang using gorm package

I was working on a golang project, I've used a postgres database to store data with some Stored Procedure.

I used github.com/jinzhu/gorm for connecting to the database.

I used below query to retrieve data. I know in postgres we are unable to use select, so I only tried insert code in SP.

db.Database.Raw("CALL mydatabase.mystoredprocedure('" + param1 + "','" + param2 + "')")

db.Database.Raw("SELECT * FROM table1").Scan(&tableValue)
But here I'm only able to call a SELECT statement, not able to call the stored procedure.

Please, can any one help me to solve this problem?

db.Database.Raw(...) alone does not do anything, it needs to be chained with Scan. If you are not expecting any results, use Exec:

db.Database.Exec("CALL mydatabase.mystoredprocedure($1, $2)", param1, param2)
