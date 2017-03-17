## Data Access Object

#### Basic examples

1. **Example 1**

  ```apex
  List<Account> accs=DAO.base('Account').find(listIds)
  ```


  ```apex
  List<Account> accs=[select * from Account where Id in :listIds]
  ```
  
2. **Example 2**

  ```apex
  List<Account> accs=DAO.base('Account').find(listIds,'Id,Name')
  ```


  ```apex
  List<Account> accs=[select Id,Name from Account where Id in :listIds]
  ```
  
3. **Example 3**
  
  ```apex
  List<Account> accs=DAO.base('Account').find('Name',listNames,'Id')
  ```


  ```apex
  List<Account> accs=[select Id from Account where Name in :listNames]
  ```
  
4. **Example 4**
  
  ```apex
  List<Account> accs=DAO.base('Account').find(QB.fieldExpr('Type','=','Prospect'),'Id')
  ```


  ```apex
  List<Account> accs=[select Id from Account where Type='Prospect']
  ```

5. **Example 5**
  
  ```apex
  List<Account> accs=DAO.base('Account').find(QB.select_x('Name').from_x('Account'))
  ```


  ```apex
  List<Account> accs=[select Name from Account]
  ```
