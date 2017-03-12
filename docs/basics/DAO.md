## Data Access Object

#### Basic examples

1. **Example 1**

  ```apex
  List<Account> accs=DAO.base('Account').find(listIds)
  ```


  ```apex
  List<Account> accs=[select * from Account where Id in :listIds]
  ```
  
1. **Example 2**

  ```apex
  List<Account> accs=DAO.base('Account').find(listIds,'Id,Name')
  ```


  ```apex
  List<Account> accs=[select Id,Name from Account where Id in :listIds]
  ```
  
  1. **Example 3**
  
  ```apex
  List<Account> accs=DAO.base('Account').find('Name',listNames,'Id')
  ```


  ```apex
  List<Account> accs=[select Id from Account where Name in :listNames]
  ```
