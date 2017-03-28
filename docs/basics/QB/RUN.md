## Running a Query

Each query has the following methods, to run the query

* _getList()_  : run a query and get a list of SObject
* _getMap()_ : run a query and get a map of Id and SObject 
* _getCount()_ : run a count query and get and Integer

Some examples below 

#### Basic examples

1. **Get a list of sObjects**

  ```apex
  List<Account> aList = QB.select_x('Name')
                          .from_x('Account')
                          .limitTo(10)
                          .getList();
  ```

2. **Get a list of aggregate results**

  ```apex
  List<AggregateResult> aList = QB.select_x(QB.count('Name'))
                                  .from_x('Account')
                                  .groupBy('Type')
                                  .getList();
  ```
  
3. **Get a map of sObjects**

  ```apex
  Map<Id,SObject> aMap = QB.select_x('Name')
                          .from_x('Account')
                          .limitTo(10)
                          .getMap();
  ```

4. **Get a count**

  ```apex
  Integer aCount = QB.select_x(QB.count())
                    .from_x('Account')
                    .getCount();
  ```

## Next

* [Data Mapper](../DM.md) 
