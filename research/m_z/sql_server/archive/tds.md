# **[tds]()**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

## Tabular Data Stream (TDS)

is an application layer protocol used to transfer data between a database server and a client. It was initially designed and developed by Sybase Inc. for their Sybase SQL Server relational database engine in 1984, and later by Microsoft in Microsoft SQL Server.

History
During the early development of Sybase SQL Server, the developers at Sybase perceived the lack of a commonly accepted application level protocol to transfer data between a database server and its client. In order to encourage the use of its products, Sybase promoted the use of a flexible pair of libraries, called netlib and db-lib, to implement standard SQL. A further library was included in order to implement "Bulk Copy" called blk. While netlib's job is to ferry data between the two computers through the underlying network protocol, db-lib provides an API to the client program, and communicates with the server via netlib. db-lib sends to the server a structured stream of bytes meant for tables of data, hence a Tabular Data Stream. blk provides, like db-lib, an API to the client programs and communicates with the server via netlib.

In 1990 Sybase entered into a technology-sharing agreement with Microsoft which resulted in Microsoft marketing its own SQL Server — Microsoft SQL Server — based on Sybase's code. Microsoft kept the db-lib API and added ODBC. (Microsoft has since added additional APIs.) At about the same time, Sybase introduced a more powerful successor to db-lib, called ct-lib, and called the pair Open Client. db-lib, though officially deprecated, remains in widespread[quantify] use.

The TDS protocol comes in several varieties, most of which had not been openly documented because they were regarded[by whom?] as proprietary technology. The exception was TDS 5.0, used exclusively by Sybase, for which documentation is available from Sybase.[1] This situation changed when Microsoft published the TDS specification in 2008,[2] as part of the Open Specification Promise.

The FreeTDS team has developed a free native-library implementation of the TDS protocol,[3] licensed under the LGPL license. WireShark has a protocol decoder for TDS.[4]

Oracle Corporation provides Oracle Net - software analogous to TDS.[5]
