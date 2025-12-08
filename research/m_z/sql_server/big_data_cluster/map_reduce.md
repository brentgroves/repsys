# **[map reduce](https://www.geeksforgeeks.org/data-science/mapreduce-understanding-with-real-life-example/)**

**Map Reduce** is a framework in which we can write applications to run huge amount of data in parallel and in large cluster of commodity hardware in a reliable manner.

## Phases of MapReduce

MapReduce model has three major and one optional phase.​

1. Mapping
2. Shuffling and Sorting
3. Reducing
4. Combining

1) Mapping
It is the first phase of MapReduce programming. Mapping Phase accepts key-value pairs as input as (k, v), where the key represents the Key address of each record and the value represents the entire record content.​The output of the Mapping phase will also be in the key-value format (k’, v’).

2) Shuffling and Sorting
The output of various mapping parts (k’, v’), then goes into Shuffling and Sorting phase.​ All the same values are deleted, and different values are grouped together based on same keys.​ The output of the Shuffling and Sorting phase will be key-value pairs again as key and array of values (k, v[ ]).

3) Reducer
The output of the Shuffling and Sorting phase (k, v[]) will be the input of the Reducer phase.​ In this phase reducer function’s logic is executed and all the values are Collected against their corresponding keys. ​Reducer stabilize outputs of various mappers and computes the final output.​

4) Combining
It is an optional phase in the MapReduce phases .​ The combiner phase is used to optimize the performance of MapReduce phases. This phase makes the Shuffling and Sorting phase work even quicker by enabling additional performance features in MapReduce phases.

![i](https://media.geeksforgeeks.org/wp-content/uploads/20230420231217/map-reduce-mode.png)

## Numerical Example

We will be using MovieLens Data.

| USER_ID | MOVIE_ID | RATING | TIMESTAMP |
|---------|----------|--------|-----------|
| 196     | 242      | 3      | 881250949 |
| 186     | 302      | 3      | 891717742 |
| 196     | 377      | 1      | 878887116 |
| 244     | 51       | 2      | 880606923 |
| 166     | 346      | 1      | 886397596 |
| 186     | 474      | 4      | 884182806 |
| 186     | 265      | 2      | 881171488 |

Solution
Step 1: First we have to map the values , it is happen in 1st phase of Map Reduce model.

196:242   ;  186:302   ;  196:377   ;  244:51   ;  166:346   ;  186:274   ;  186:265

Step 2:  After Mapping we have to shuffle and sort the values.

166:346   ;  186:302,274,265   ;  196:242,377   ;  244:51  

Step 3:  After completion of step1 and step2 we have to reduce each key's values.

Now, put all values together

![i](https://media.geeksforgeeks.org/wp-content/uploads/20230420224240/solve.png)

## Common Use Cases of MapReduce

- Counting word frequency (as shown above)
- Log analysis
- Indexing web pages
- Processing large datasets for ETL (Extract, Transform, Load)
- Recommendation systems and data mining
