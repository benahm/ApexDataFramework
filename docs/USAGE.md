## Usage

Follow the pattern below to integrate the ApexDataFramework in your project 

### Pattern

Create a DM class for each standard and custom sObject (when you need to request that object)

#### Example:

DM class for the Account sObject :

  ```apex
  public class DM_Account {
    public static final DM.IBase base = new DM.Base('Account');

    /* custom methods */
    // method 1 - based on one of base.find* methods
    public static List<Account> findByIdWithContacts(List<Id> ids){
      return base.findById(ids,'Id,(select FirstName,LastName from contacts)');
    }
    
    // method 2 - based on the query builder (QB)
    public static Integer getCount(){
      return QB.select_x(QB.count())
               .from_x('Account')
               .getCount();
    }

  }
  ```

**Accessing base methods from DM_Account:**

  ```apex
  List<Account> listAccounts = DM_Account.base.findById(accountIds);
  ```
  
**Accessing custom methods from DM_Account:**

  ```apex
  // method 1
  List<Account> listAccounts = DM_Account.findByIdWithContacts(accountIds);
  
  // method 2
  Integer aCount = DM_Account.getCount();
  ```
