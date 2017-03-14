## Order by keyword

  ```apex
  QB.select_x('Name')
    .from_x('Account')
    .orderBy('Name')
  ```
*Equivalent SOQL Query*

  ```sql
  SELECT Name FROM Account ORDER BY Name
  ```


  
  ```apex
  QB.select_x('Name')
    .from_x('Account')
    .orderBy('Name',QB.ascNullsLast())
  ```
  
*Equivalent SOQL Query*

  ```sql
  SELECT Name FROM Account ORDER BY Name ASC NULLS LAST
  ```
  
  ```apex
  QB.select_x('Name,Type')
    .from_x('Account')
    .orderBy('Name',QB.ascNullsLast())
    .addOrder('Type'.QB.descNullsFirst())
  ```
  
*Equivalent SOQL Query*

  ```sql
  SELECT Name FROM Account ORDER BY Name ASC NULLS LAST, Type DESC NULLS LAST
  ```
