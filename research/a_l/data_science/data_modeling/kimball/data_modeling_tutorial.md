# **[Data Modeling Tutorial: Star Schema (aka Kimball Approach)](https://www.youtube.com/watch?v=gRE3E7VUzRU)**

Identify a fact
Determine dimensions attributes around the fact

need a snowflake account

order table or another option is order transaction table. you can aggregate transactions upto orders. you have a lower granularity so more flexibility.

## order fact table

```yaml
id:
product_id:
quantity:
userid:
customerid:
datetime:
```

## order transaction table

alot more information here

```yaml
amount:
cost per:
date:
order id:
product_id:
quantity:
tax:
total charged:
```

## create a fact table for transactions
