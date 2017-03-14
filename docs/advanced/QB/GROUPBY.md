## Group by keyword


  ```apex
  QB.select_x(QB.count())
    .from_x('Account')
    .groupBy('Name')
  ```
  
  ```apex
  QB.select_x(QB.count('Name'),'Type')
    .from_x('Account')
    .groupBy('Type',QB.count('Name').gt(1))
  ```
