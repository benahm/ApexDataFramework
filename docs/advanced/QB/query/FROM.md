## From clause

**As a String** 

  ```apex
  QB.select_x('Name')
    .from_x('Account')
  ```
  ```sql
  SELECT Name FROM Account
  ```

**As an sObject type** 

  ```apex
  QB.select_x('Name')
    .from_x(Account.sObjectType)
  ```
  ```sql
  SELECT Name FROM Account
  ```

## Next

* [Where clause](WHERE.md) 
