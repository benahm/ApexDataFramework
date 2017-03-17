
## Building a Query

QB is a query builder that offers a simple and friendly API to generate SOQL queries

### Basic examples:

#### 1. **Simple query without a where clause**

Query builder syntax:
  ```apex
  QB.select_x('Name')
    .from_x('Account')
  ```

SOQL equivalent:
  ```sql
  select Name from Account
  ```


#### 2. **Simple query with a simple where clause**

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
