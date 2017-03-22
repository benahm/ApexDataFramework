## Where clause

### 1. Where with a single condition

  ```apex
  QB.select_x('Name')
    .from_x('Account')
    .where_x('Name','=','Acme Corporation')
  ```
  ```sql
  SELECT Name FROM Account WHERE Name = 'Acme Corporation'
  ```

### 2. Where with a complex condition

**Example 1**

  ```apex
  QB.select_x('Name')
    .from_x('Account')
    .where_x(QB.and_x(QB.field('Name').eq('Acme Corporation'), 
                      QB.fieldExpr('Type','=','Prospect')
                      )
             )
  ```
  ```sql
  SELECT Name FROM Account WHERE Name = 'Acme Corporation' AND Type = 'Prospect'
  ```

**Example 2**

  ```apex
  QB.select_x('Name')
    .from_x('Account')
    .where_x(QB.and_x(QB.field('Name').eq('Acme Corporation'),
                      QB.or_x(QB.fieldExpr('Type','=','Prospect'),
                              QB.fieldExpr('Type','=','Customer')
                      )
             )
  ```
  ```sql
  SELECT Name FROM Account WHERE Name = 'Acme Corporation' AND (Type = 'Prospect' OR Type = 'Customer')
  ```
  
**Example 3**

  ```apex
  QB.select_x('Name')
    .from_x('Account')
    .where_x(QB.and_x(QB.field('Name').eq('Acme Corporation'),
                      QB.or_x(QB.fieldExpr('Type','=','Prospect'),
                              QB.fieldExpr('Type','=','Customer')
                      ).add(QB.not_x(QB.fieldExpr('Type','!=','Partner')))
             )
  ```
  ```sql
  SELECT Name FROM Account WHERE Name = Acme Corporation' AND (Type = 'Prospect' OR Type = 'Customer' OR (NOT Type != 'Partner'))
  ```
  
### 3. Where with a bind variable

  ```apex
  QB.select_x('Name')
    .from_x('Account')
    .where_x('Name','=',QB.bind(myListOfNames))
  ```
  ```sql
  SELECT Name FROM Account WHERE Name = :myListOfNames
  ```
QB supports only one bind variable per query

### 4. Where with a date literal

**Example 1**

  ```apex
  QB.select_x('Name')
    .from_x('Account')
    .where_x('CreatedDate','<',QB.YESTERDAY)
  ```

  ```sql
  SELECT Name FROM Account WHERE CreatedDate < YESTERDAY
  ```

**Example 2**

  ```apex
  QB.select_x('Name')
    .from_x('Account')
    .where_x('CloseDate','<',QB.LAST_N_DAYS(1))
  ```
  ```sql
  SELECT Name FROM Account WHERE CreatedDate < LAST_N_DAYS:1
  ```

## Next

* [Group by clause](GROUPBY.md) 
