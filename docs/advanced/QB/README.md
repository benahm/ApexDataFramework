## Query Builder
* [Building a Condition](condition/README.md)
* [Building a Query](query/README.md)
  * [Select clause](query/SELECT.md)
  * [From clause](query/FROM.md)
  * [Where clause](query/WHERE.md)
  * [Group by keyword](query/GROUPBY.md)
  * [Order by keyword](query/ORDERBY.md)
  * [Limit keyword](query/LIMIT.md)
  * [Offset Keyword](query/OFFSET.md)



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
