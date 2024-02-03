# migrate

## references

<https://www.freecodecamp.org/news/database-migration-golang-migrate/>
github.com/golang-migrate/migrate/v4/cmd/migrate
<https://github.com/golang-migrate/migrate/tree/master/database/mysql>

## Go migrate

Database migrations written in Go. Use as CLI or import as library.

Migrate reads migrations from sources and applies them in correct order to a database.
Drivers are "dumb", migrate glues everything together and makes sure the logic is bulletproof. (Keeps the drivers lightweight, too.)
Database drivers don't assume things or try to correct user input. When in doubt, fail.

<https://github.com/golang-migrate/migrate/tree/master/database/mysql>

## **[How to Perform Database Migrations using Go Migrate](https://www.freecodecamp.org/news/database-migration-golang-migrate/)**

### What is a Database Migration?

A database migration, also known as a schema migration, is a set of changes to be made to a structure of objects within a relational database.

It is a way to manage and implement incremental changes to the structure of data in a controlled, programmatic manner. These changes are often reversible, meaning they can be undone or rolled back if required.

The process of migration helps to change the database schema from its current state to a new desired state, whether it involves adding tables and columns, removing elements, splitting fields, or changing types and constraints.

By managing these changes in a programmatic way, it becomes easier to maintain consistency and accuracy in the database, as well as keep track of the history of modifications made to it.

Setup and Installation
migrate is a CLI tool that you can use to run migrations. You can easily install it on various operating systems such as Linux, Mac and Windows by using package managers like curl, brew, and scoop, respectively.

For more information on how to install and use the tool, you can refer to the official documentation.

<https://github.com/golang-migrate/migrate/tree/master/cmd/migrate>

## With Go toolchain

### Versioned

Notes

- Requires a version of Go that supports modules. e.g. Go 1.11+
- These examples build the cli which will only work with postgres. In order to build the cli for use with other databases, replace the postgres build tag with the appropriate database tag(s) for the **[databases](https://github.com/golang-migrate/migrate/blob/master/database)** desired. - - The tags correspond to the names of the sub-packages underneath the database package.
- Similarly to the database build tags, if you need to support other sources, use the appropriate build tag(s).
- Support for build constraints will be removed in the future: #60
- For versions of Go 1.15 and lower, make sure you're not installing the migrate CLI from a module. e.g. there should not be any go.mod files in your current directory or any directory from your current directory to the root

```bash
# https://pkg.go.dev/cmd/go
# https://go.dev/ref/mod#go-get
# https://github.com/golang-migrate/migrate/releases
# go get supports the following flags:

# The -d flag tells go get NOT to build or install packages. When -d is used, go get will only manage dependencies in go.mod. Using go get without -d to build and install packages is deprecated (as of Go 1.17). In Go 1.18, -d will always be enabled.

# The -u flag tells go get to upgrade modules providing packages imported directly or indirectly by packages named on the command line. Each module selected by -u will be upgraded to its latest version unless it is already required at a higher version (a pre-release).


go install -tags 'mysql' github.com/golang-migrate/migrate/v4/cmd/migrate@v4.17.0
go install -tags 'mysql' github.com/golang-migrate/migrate/v4/cmd/migrate@latest
ls $HOME/go/bin/
dlv  go1.20  gomodifytags  go-outline  goplay  gopls  gotests  hello  impl  migrate  runner  staticcheck
cd internal/pkg/db/migrations/
migrate create -ext sql -dir mysql -seq create_users_table
migrate create -ext sql -dir mysql -seq create_links_table
```

How to Create a New Migration
Create a directory like database/migration to store all the migration files.
