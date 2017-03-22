## Order by keyword

### 1. Order by a field
  ```apex
  QB.select_x('Name')
    .from_x('Account')
    .orderBy('Name')
  ```
  ```sql
  SELECT Name FROM Account ORDER BY Name
  ```
### 2. Order by a field with options
  ```apex
  QB.select_x('Name')
    .from_x('Account')
    .orderBy('Name',QB.ascNullsLast())
  ```
  ```sql
  SELECT Name FROM Account ORDER BY Name ASC NULLS LAST
  ```
### 3. Order by multiple fields with options  
  ```apex
  QB.select_x('Name,Type')
    .from_x('Account')
    .orderBy('Name',QB.ascNullsLast())
    .addOrder('Type'.QB.descNullsFirst())
  ```
  ```sql
  SELECT Name FROM Account ORDER BY Name ASC NULLS LAST, Type DESC NULLS LAST
  ```

## Next

* [Limit clause](LIMIT.md) 
