## Usage

### Pattern 1

  ```apex
  public class DM_Account {
    public static final Base base = new Base();

    public class Base extends DM.ABase{
      public override String getSObjectName(){
        return 'Account';
      }

      /* custom methods */
      public List<Account> findByIdWithContacts(List<Id> ids){
        return findById(ids,'Id,(select FirstName,LastName from contacts)');
      }
    }

  }
  ```

Access base methods :

  ```apex
  List<Account> listAccounts=DM_Account.base.findById(accountIds);
  ```
  
Access custom methods :

  ```apex
  List<Account> listAccounts=DM_Account.base.findByIdWithContacts(accountIds);
  ```

-----

### Pattern 2

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
