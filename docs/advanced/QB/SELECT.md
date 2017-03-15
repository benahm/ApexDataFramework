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

If no param is provided to the select_x method the Id will be selected

  ```apex
  QB.select_x()
    .from_x('Account')
  ```
  ```sql
  SELECT Id FROM Account 
  ```

### 4. Select one field

  ```apex
  QB.select_x('Name') // Using the field name
    .from_x('Account')
  ```
  ```apex
  QB.select_x(Account.Name) // Using the field object
    .from_x('Account')
  ```
  ```sql
  SELECT Name FROM Account
  ```
  
### 5. Select multiple fields

  ```apex
  QB.select_x('Name,Type') // As a string
    .from_x('Account')
  ```
  ```apex
  QB.select_x(new List<String>{'Name','Type'}) // As a list
    .from_x('Account')
  ```
  ```sql
  SELECT Name,Type FROM Account
  ```

### 6. Select with a sub query

Add a sub query with the method addSubQuery

  ```apex
  QB.select_x('Name')
    .addSubQuery(QB.select_x('LastName')
                   .from_x('Contacts'))
    .from_x('Account')
  ```
  ```sql
  SELECT Name,(SELECT LastName FROM Contacts) FROM Account
  ```

### 7. Select aggregate function

Aggregate function count with no param

  ```apex
  QB.select_x(QB.count())
    .from_x('Account')
  ```
  ```sql
  SELECT COUNT() FROM Account
  ```

Aggregate function count with pram

  ```apex
  QB.select_x(QB.count('Name'))
    .from_x('Account')
  ```
  ```sql
  SELECT COUNT(Name) FROM Account
  ```

