## Data Access Object

The DAO class offers the powerful find method to query the Salesforce database without writing SOQL queries 

The class DAO has 3 methods to query the salesforce db

| Method    | Description      |
|-----------|------------------|
| *find*    | find a list      |
| *findMap* | find a map       |
| *findOne* | find one sObject |

Each of the three methods supports the following signatures 

* find(ids, fieldNames)
* find(fieldName, fieldValues, fieldNames)
* find(Condition, fieldNames) 
* find(Query)

See the examples below

#### Basic examples

1. **Example 1**

Query by list of Ids
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
