
## Building a Query

QB is a query builder that offers a simple and friendly API to generate SOQL queries

### Basic examples:

#### 1. Simple query without a where clause

Query builder syntax:
  ```apex
  QB.select_x('Name')
    .from_x('Account')
  ```

SOQL equivalent:
  ```sql
  select Name from Account
  ```


#### 2. Simple query with a simple where clause

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

#### 3. Query all the fields of an sObject

Query builder syntax:
  ```apex
  QB.select_x('*')
    .from_x('Account')
  ```
  
#### 4. Query all fields starting or ending with

Query builder syntax:
  ```apex
  QB.select_x('*__c')
    .from_x('Account')
  ```
  
#### 5. Advanced select query 

Query builder syntax:
  ```apex
  QB.select_x('Name,Type')
    .from_x('Account')
    .where_x(QB.field('Name').eq('Acme Corporation'))
    .groupby('Type')
    .orderby('Name')
    .limitTo(1)
    .offset(100)
  ```
SOQL equivalent:
  ```sql
  select Name from Account where Name='Acme Corporation' group by Type order by Name limit 1 offset 100
  ```
--------  
>*__NOTE__: 
>'select', 'from' and 'where' are all reserved words in apex and can not be used as names of methods, to get around the >suffix '__\_x__' is appended to the reserved words*

## Next

* [Running a Query](RUN.md) 
