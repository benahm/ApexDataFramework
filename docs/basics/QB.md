## Query Builder


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
#### Logical operators:
**NOT** :
  ```apex
  QB.not_x(QB.field('Name').eq('Acme Corporation'))
  ```
  ```apex
  NOT (Name='Acme Coproration')
  ```
**AND** :
  ```apex
  QB.and_x(QB.field('Name').eq('Acme Corporation'),QB.field('Name','=','Acme Corporation'))
  ```
  ```apex
  Name='Acme Coproration' AND Name='Acme Corporation'
  ```

### Building a SOQL Query:
1. **Query all the fields of an SObject**

Query Builder 
  ```apex
  QB.select_x('*').from_x('Account')
  ```
SOQL
  ```sql
  select ALL_FIELDS from Account
  ```
  
2. **Query all fields starting or ending with** 

Query Builder
  ```apex
  QB.select_x('*__c').from_x('Account')
  ```
SOQL
  ```sql
  select ALL_CUSTOM_FIELDS from Account
  ```
  
3. **Select with where clause**   

Query Builder
  ```apex
  QB.select_x('Owner.Id').from_x('Account').where_x('')
  ```
SOQL
  ```sql
  select Owner.Id from Account where
  ```
  
*__NOTE__: 'select', 'from' and 'where' are all reserved words in apex and can not be used as names of methods, to get around the suffix '__\_x__' is appended to the reserved words*
