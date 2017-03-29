## Usage

### Pattern

  ```apex
  public class DM_Account {
    public static final DM.IBase base = new DM.Base('Account');

    /* custom methods */
    public List<Account> findByIdWithContacts(List<Id> ids){
      return base.findById(ids,'Id,(select FirstName,LastName from contacts)');
    }

  }
  ```

Access base methods :

  ```apex
  List<Account> listAccounts=DM_Account.base.findById(accountIds);
  ```
  
Access custom methods :

  ```apex
  List<Account> listAccounts=DM_Account.findByIdWithContacts(accountIds);
  ```
