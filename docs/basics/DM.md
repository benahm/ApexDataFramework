## Data Mapper

The DM class offers the powerful ``find`` method to query the Salesforce database without writing SOQL queries 

For more advanced examples please see the [advanced section](/docs/advanced/DM/FIND.md)

### Find method

The find method offers a flexible way to query data in Salesforce here is an introduction

* _findById(ids, fieldNames)_
* _findBy(fieldName, fieldValues, fieldNames)_
* _findBy(Condition, fieldNames)_

Some examples below

#### Basic examples

1. **Query by list of Ids**

  ```apex
  List<Account> accs=DM.base('Account').findById(listIds)
  ```


  ```apex
  List<Account> accs=[select * from Account where Id in :listIds]
  ```
  
2. **Query by list of Ids and specify field names to select**

  ```apex
  List<Account> accs=DM.base('Account').findById(listIds,'Id,Name')
  ```


  ```apex
  List<Account> accs=[select Id,Name from Account where Id in :listIds]
  ```
  
3. **Query by list of values for a given field**
  
  ```apex
  List<Account> accs=DM.base('Account').findBy('Name',listNames,'Id')
  ```


  ```apex
  List<Account> accs=[select Id from Account where Name in :listNames]
  ```
  
4. **Query by condition**
  
  ```apex
  List<Account> accs=DM.base('Account').findBy(QB.fieldExpr('Type','=','Prospect'),'Id')
  ```


  ```apex
  List<Account> accs=[select Id from Account where Type='Prospect']
  ```

## Next

* [Advanced](/docs/advanced/README.md) 
