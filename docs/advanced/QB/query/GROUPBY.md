## Group by keyword

### 1. Group by without a having condition
  ```apex
  QB.select_x(QB.count('Id'))
    .from_x('Account')
    .groupBy('Type')
  ```
  ```sql
  SELECT COUNT(Id) FROM Account GROUP BY Type
  ```
  
### 2. Group by with a having condition  
  ```apex
  QB.select_x(QB.count('Id'),'Type')
    .from_x('Account')
    .groupBy('Type',QB.count('Id').gt(1))
  ```
  ```sql
  SELECT COUNT(Id) FROM Account GROUP BY Type HAVING COUNT(Id)>1
  ```

## Next

* [Order by clause](ORDERBY.md) 
