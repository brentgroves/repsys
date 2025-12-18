# **[50 Shades of Direct Lake – Everything You Need to Know About the New Power BI Storage Mode](https://data-mozart.com/what-do-allen-iverson-and-direct-lake-have-in-common/)**

Direct Lake is a brand new mode for consuming data through Power BI Semantic Models, which is exclusively available with Microsoft Fabric. It aims to fill the void caused by shortcomings of both Import and DirectQuery modes, by combining their main advantages: performance of the Import mode, as well as near real-time reporting and “no data duplication” of the DirectQuery.

![i1](https://data-mozart.com/wp-content/uploads/2024/01/dl1-1024x567.png)

As you may see in the illustration above, this is the world we “know” before Fabric (by the way, if you are still not sure what Microsoft Fabric is, I suggest you start by reading this article first). To summarize: with Import mode, we get blazing fast performance, because the data is stored in memory. However, in order to keep the data in sync with the original source, we need to refresh the Power BI Semantic Model, which means there is some latency (duration of the data refresh process), plus another copy of the data (basically, we are storing the same data twice – once in the original data source, and then again in the instance of the Analysis Services Tabular, which stores our Power BI Semantic Model data).

And, then, we have a DirectQuery! No data duplication, and no latency, as we are querying the source directly, with queries generated at the query time – meaning, we always get the latest data in our Power BI reports! Import mode challenges solved, life is good…Until it isn’t:). The performance of DirectQuery mode is in most cases, well, let’s say – barely acceptable (if acceptable at all). There are also many additional limitations compared to Import mode, so although DirectQuery, in theory, is “the answer” to the shortcomings of the Import mode, in reality, it’s just another “question”: why do you use DirectQuery?

## Direct Lake IS “THE ANSWER”

When Fabric was introduced, Direct Lake was labeled as one of the key innovations in this SaaS platform. And, rightly so! While we can argue that certain components of the Fabric are just rebranded existing solutions, Direct Lake is definitely a brand-new concept.

![i1](https://data-mozart.com/wp-content/uploads/2024/01/dl2-1024x569.png)

## How does the Direct Lake mode work?

Direct Lake conceptually works very similar to the Import mode. The “only” difference is that, instead of requiring data to be stored in the Analysis Services Tabular proprietary file format (*.idf), the Power BI engine (VertiPaq) can read the data directly from Delta tables stored in OneLake. The way data is stored in Delta/Parquet files is very similar to how VertiPaq stores the data (columnar storage, data compression, etc.), so the engine can “understand and interpret” the data practically the same as it would when reading it from Analysis Services Tabular instance (Import mode).

The key difference between the Import and Direct Lake mode is that in Import mode, the entire semantic model is loaded into memory, whereas in Direct Lake only the columns required by the query will be loaded into memory.

## Direct Lake Prerequisites

Here is the list of the prerequisites for Direct Lake mode to work with your Power BI semantic models:

- F or P SKUs (Fabric capacity or Power BI Premium capacity with Fabric enabled)
- Lakehouse or Warehouse in Fabric workspace
- Delta file format – although you can store various file types in the Lakehouse, Direct Lake currently supports only Delta (no Parquet, CSV, etc.)
- V-ordering* – this is not a “no-go” prerequisite – Direct Lake will still work even if Delta files are not v-ordered – but, you could then expect performance degradation. More on v-ordering **[here](https://learn.microsoft.com/en-us/fabric/data-engineering/delta-optimization-and-v-order?tabs=sparksql)**
