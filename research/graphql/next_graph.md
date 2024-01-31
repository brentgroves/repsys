
created both repos

<git@github.com>:brentgroves/hackernews.git (from scratch)
<git@github.com>:brentgroves/graphql-golang.git (complete)

Continue the **[graphql tutorial](https://www.howtographql.com/graphql-go/4-database/)**

Attempt to use the GraphQL mutation concept to call stored procedures.

## Execute **[Stored Procedure with GraphQL](https://stackoverflow.com/questions/73944424/execute-stored-procedure-with-graphql)**

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

<https://graphql.org/code/#go>

To get a sense on how to implement a new backend, check out the Static Data Source, as it's the simplest one.

It's used in production by many enterprises for multiple years now, battle tested and actively maintained.

samsarahq/thunder

GitHub
samsarahq/thunder
0
A GraphQL implementation with easy schema building, live queries, and batching.
