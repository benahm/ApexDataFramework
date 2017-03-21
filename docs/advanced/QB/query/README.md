## Building a Query


The Query Builder (QB) let you build SOQL queries with ease 

Below the mapping between the soql keywords and the QB method names 

#### Mapping between SOQL keyword and Query Builder methods

| SOQL Keyword | Query Builder | Invocation | Description        |
|--------------|---------------|------------|--------------------|
| *select*     | select_x      | QB         |                    |
| *from*       | from_x        | chained    |                    |
| *where*      | where_x       | chained    |                    |
| *group by*   | groupBy       | chained    |                    |
| *order by*   | orderBy       | chained    |                    |
| *-*          | addOrder      | chained    | adding an order by |
| *limit*      | limitTo       | chained    |                    |
| *offset*     | offset        | chained    |                    |


### Details of building a Query
* [Select clause](SELECT.md)
* [From clause](FROM.md)
* [Where clause](WHERE.md)
* [Group by keyword](GROUPBY.md)
* [Order by keyword](ORDERBY.md)
* [Limit keyword](LIMIT.md)
* [Offset Keyword](OFFSET.md)

