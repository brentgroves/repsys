# Execute **[Stored Procedure with GraphQL](https://stackoverflow.com/questions/73944424/execute-stored-procedure-with-graphql)**

We have database with a lot of stored procedures. I need to implement GraphQL, but I can't find information about is it possible to Execute stored procedures with GraphQL.

GraphQL has nothing to do with stored procedures. It is only a wrapper over your http requests.

In your GraphQL resolvers, you can execute any code that needs to talk to your database.

```graphql
const resolvers = {
  Query: {
    executeSomeProcedure() {  
      return db.execute('select some_procedure();');
    }
  }
}
```
