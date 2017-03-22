## Limit keyword

  ```apex
  QB.select_x('Id')
    .from_x('Account')
    .limitTo(1)
  ```
  ```sql
  SELECT Id FROM Account LIMIT 1
  ```

## Next

* [Offset clause](OFFSET.md) 
