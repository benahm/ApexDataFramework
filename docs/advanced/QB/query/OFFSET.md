## Offset keyword
  ```apex
  QB.select_x('Id')
    .from_x('Account')
    .offset(100)
  ```
  ```sql
  SELECT Id FROM Account OFFSET 100
  ```
