## Data Access Object

The DAO class offers the powerful find method to query the Salesforce database without writing SOQL queries 

The class DAO has 3 methods to query the salesforce db

### Find method

Each of the three methods supports the following signatures 

* find(ids, fieldNames)
* find(fieldName, fieldValues, fieldNames)
* find(Condition, fieldNames) 
* find(Query)

See the examples below

#### Basic examples

1. **Query by list of Ids**

  ```apex
  List<Account> accs=DAO.base('Account').find(listIds)
  ```


  ```apex
  List<Account> accs=[select * from Account where Id in :listIds]
  ```
  
2. **Query by list of Ids and specify field names to select**

  ```apex
  List<Account> accs=DAO.base('Account').find(listIds,'Id,Name')
  ```


  ```apex
  List<Account> accs=[select Id,Name from Account where Id in :listIds]
  ```
  
3. **Query by list of values for a given field**
  
  ```apex
  List<Account> accs=DAO.base('Account').find('Name',listNames,'Id')
  ```


  ```apex
  List<Account> accs=[select Id from Account where Name in :listNames]
  ```
  
4. **Query by condition**
  
  ```apex
  List<Account> accs=DAO.base('Account').find(QB.fieldExpr('Type','=','Prospect'),'Id')
  ```


  ```apex
  List<Account> accs=[select Id from Account where Type='Prospect']
  ```

5. **Query by specifying a query built by the Query Builder**
  
  ```apex
  List<Account> accs=DAO.base('Account').find(QB.select_x('Name').from_x('Account'))
  ```


  ```apex
  List<Account> accs=[select Name from Account]
  ```
