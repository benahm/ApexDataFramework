## Query Builder

QB is a query builder that offers a simple and friendly API to generate SOQL queries

### Basic examples:

1. **Simple query without a where clause**

  Query builder syntax:
  ```apex
  QB.select_x('Name')
    .from_x('Account')
  ```

  SOQL equivalent:
  ```sql
  select Name from Account
  ```


2. **Simple query with a where clause**

  Query builder syntax:
  ```apex
  QB.select_x('Id,Name')
    .from_x('Account')
    .where_x('Name','=','Acme Corporation')
  ```

  SOQL equivalent:
  ```sql
  select Id,Name from Account where Name='Acme Corporation'
  ```

### Building a condition:

The query builder offers a way to create complex conditions 

  Query builder syntax:
  ```apex
  QB.and_x(QB.field('Name').eq('Acme Corporation'),QB.fieldExpr('Type','=','Prospect'))
  ```

  Equivalent to:
  ```sql
  Name='Acme Corporation' AND Type='Prospect'
  ```
#### Field Condition:

  ```apex
  QB.field('Name').eq('Acme Corporation')
  ```
  ```apex
  QB.fieldExpr('Name','=','Acme Corporation')
  ```

*__NOTE__: 'select', 'from' and 'where' are all reserved words in apex and can not be used as names of methods, to get around the suffix '__\_x__' is appended to the reserved words*
