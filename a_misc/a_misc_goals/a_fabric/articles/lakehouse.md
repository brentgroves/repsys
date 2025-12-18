# Microsoft Fabric Notes

Hi Team,

As you may know Microsoft unified there data analytics and AI services with Fabric. Central to Microsoft Fabric is a Lakehouse.

What is a Fabric Lakehouse?
Answer: It is a Parquet file with a delta log.

Next: Why does Microsoft push Apache Spark for analytics instead of SSIS?

- thanks
Brent

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>.

- **[Parquet](https://parquet.apache.org/)**

Apache Parquet is an open source, column-oriented data file format designed for efficient data storage and retrieval. It provides high performance compression and encoding schemes to handle complex data in bulk and is supported in many programming language and analytics tools.

- **[Delta log](https://www.databricks.com/blog/2019/08/21/diving-into-delta-lake-unpacking-the-transaction-log.html)**

When a user creates a table, that table’s transaction log is automatically created in the _delta_log subdirectory. As he or she makes changes to that table, those changes are recorded as ordered, atomic commits in the transaction log. Each commit is written out as a JSON file, starting with 000000.json. Additional changes to the table generate subsequent JSON files in ascending numerical order so that the next commit is written out as 000001.json, the following as 000002.json, and so on.

## team

- Kristian Smith: Global Directory IT
- Tarek Mohamed, IT Supervisor - Data & Analytics
- Adrian Wise: System Admin, Technical Services Manager.
- Brent Hall, System Administrator Senior
- Ramarao Guttikonda, Senior System Administrator
- Deza Birhan - Senior Database Administrator
- Aamir Ghaffar: IT Systems Architect
- Christian Trujillo, IT Structures Manager
- Kevin Young, Information Systems Manager
- Jared Davis, IT Manager
- Hayley Rymer, IT Supervisor, Mills River
- Matthew Bump, Muscle Shoals, Engineering Supervisor II / IT
- Angelina Shadder, Muscle Shoals, Cyber Securtity, Desktop and Systems Support Technician
- Sam Jackson, Information Systems Developer, Southfield
- Brad D. Cook, Quality Engineer, Fruitport
- Jared Eikenberry, Quality Engineer, Fruitport
- Carl Stangland, Desktop and System Support Technician, Indiana
- Ricardo Baca, Sr. Manufacturing Engineer
