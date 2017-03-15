## From clause

**As a String** 

  ```apex
  QB.select_x('Name')
    .from_x('Account')
  ```
  ```sql
  SELECT Name FROM Account
  ```

**As an SObject** 

  ```apex
  QB.select_x('Name')
    .from_x(Account)
  ```
  ```sql
  SELECT Name FROM Account
  ```
