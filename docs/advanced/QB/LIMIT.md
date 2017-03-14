## Limit keyword

  ```apex
  QB.select_x('Id')
    .from_x('Account')
    .limitTo(1)
  ```
*Equivalent SOQL Query*

  ```sql
  SELECT Id FROM Account LIMIT 1
  ```
