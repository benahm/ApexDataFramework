## From clause

### 1. Where with a single condition


  ```apex
  QB.select_x('Name')
    .from_x('Account')
    .where_x('Name','=','Acme Corporation')
  ```

*Equivalent SOQL Query*

  ```sql
  SELECT Name FROM Account WHERE Name='Acme Corporation'
  ```

### 2. Where with a complex condition

**Example 1**

  ```apex
  QB.select_x('Name')
    .from_x('Account')
    .where_x(QB.and_x(QB.field('Name').eq('Acme Corporation'),QB.fieldExpr('Type','=','Prospect')))
  ```
  
*Equivalent SOQL Query*

  ```sql
  SELECT Name FROM Account WHERE Name='Acme Corporation' AND Type='Prospect'
  ```
