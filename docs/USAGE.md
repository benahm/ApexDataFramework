## Usage


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

  

-----
  

  ```apex
  public class DM_Account {
    public static final DM.IBase base = new DM.Base('Account');

    /* custom methods */
    public List<Account> findByIdWithContacts(List<Id> ids){
      return base.findById(ids,'Id,(select FirstName,LastName from contacts)');
    }

  }
  ```
