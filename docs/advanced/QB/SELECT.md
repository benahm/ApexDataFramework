## Select clause

Query Builder has diffrent option to construct a SOQL select clause 


### 1. Select all fields of an sObject

You can use the asterix operator to select all fields of an sObject

  ```apex
  QB.select_x('*')
    .from_x('Account')
  ```

### 2. Select a filtered list of an SObject

You can use the asterix operator to filter on the list of field you need to have in the select clause

**Example**: the query below select all custom fields from the Account sObject

  ```apex
  QB.select_x('*__c')
    .from_x('Account')
  ```

### 3. Select the Id field

  ```apex
  QB.select_x()
    .from_x('Account')
  ```
*Equivalent SOQL Query*

  ```sql
  SELECT Id FROM Account
  ```

### 4. Select one field

using the field name

  ```apex
  QB.select_x('Name')
    .from_x('Account')
  ```
using the field object

  ```apex
  QB.select_x(Account.Name)
    .from_x('Account')
  ```
*Equivalent SOQL Query*

  ```sql
  SELECT Name FROM Account
  ```
  
### 5. Select multiple fields

### 6. Select a sub query

### 7. Select aggregate function
