
## Building a Condition

QB can build two types of conditions 

* [Field Condition](#field-condition) : condition meant to be used in the where clause 
* [Having condition](#having-condition) : condition meant to be used in the having clause
 
### Field Condition:

#### 1. Simple field condition:

QB offers different ways to create a simple field condition 

Field conditions:

  ```apex
  QB.field('Name').eq('Acme Corporation')
  ```
  ```apex
  QB.fieldExpr('Name','=','Acme Corporation')
  ```
  ```apex
  QB.fieldExpr('Name',QB.Op.EQ,'Acme Corporation')
  ```
  
Equivalent to : 

  ```apex
  Name = 'Acme Corporation'
  ```
#### 2. Composite condition

##### NOT logical operator

NOT logical operator can be applied to one condition 

  ```apex
  QB.not_x(QB.field('Name').eq('Acme Corporation'))
  ```
Equivalent to : 

  ```apex
  NOT (Name = 'Acme Coproration')
  ```
  
##### AND logical operator

AND logical operator can be applied to multiple conditions

*Example 1:*
  ```apex
  QB.and_x(QB.field('Name').eq('Acme Corporation'),QB.fieldExpr('Name','>','Acme Corporation'))
  ```
  
Equivalent to : 

  ```apex
  (Name = 'Acme Coproration') AND (Name > 'Acme Corporation')
  ```

*Example 2:*
  ```apex
  QB.and_x(QB.field('Name').eq('Acme Corporation'),QB.fieldExpr('Name','>','Acme Corporation'))
    .add(QB.fieldExpr('Name',QB.Op.LE,'Acme Corporation'))
  ```
  
Equivalent to : 

  ```apex
  (Name = 'Acme Coproration') AND (Name > 'Acme Corporation') AND (Name < 'Acme Corporation')
  ```

##### OR logical operator

OR logical operator can be applied to multiple conditions

*Example 1:*
  ```apex
  QB.or_x(QB.field('Name').eq('Acme Corporation'),QB.fieldExpr('Name','>','Acme Corporation'))
  ```
  
Equivalent to : 

  ```apex
  (Name = 'Acme Coproration') AND (Name > 'Acme Corporation')
  ```

*Example 2:*

  ```apex
  QB.or_x(QB.field('Name').eq('Acme Corporation'),QB.fieldExpr('Name','>','Acme Corporation'))
    .add(QB.fieldExpr('Name',QB.Op.LE,'Acme Corporation'))
  ```
  
Equivalent to : 

  ```apex
  (Name = 'Acme Coproration') OR (Name > 'Acme Corporation') OR (Name < 'Acme Corporation')
  ```
  
  
### Having Condition:

#### 1. Simple having condition:

QB offers differents ways to create a simple having condition 

Having conditions:

  ```apex
  QB.count().eq(1)
  ```

Equivalent to : 

  ```apex
  COUNT() = 1
  ```

#### 2. Composite condition:

Having condition supports the same operators as the field condition

##### NOT logical operator

NOT logical operator can be applied to one condition 

  ```apex
  QB.not_x(QB.count('Name').gt(1))
  ```
Equivalent to : 

  ```apex
  NOT (COUNT(Name) > 1)
  ```
  
##### AND logical operator

AND logical operator can be applied to multiple conditions

*Example 1:*
  ```apex
  QB.and_x(QB.count('Name').eq(100),QB.count('Name').gt(100))
  ```
  
Equivalent to : 

  ```apex
  (COUNT(Name) = 100) AND (COUNT(Name) > 100)
  ```

*Example 2:*
  ```apex
  QB.and_x(QB.count('Name').eq(100),QB.count('Name').gt(100))
    .add(QB.count('Name').lt(100))
  ```
  
Equivalent to : 

  ```apex
  (COUNT(Name) = 100) AND (COUNT(Name) > 100) AND (COUNT(Name) < 100)
  ```

##### OR logical operator

OR logical operator can be applied to multiple conditions

*Example 1:*
  ```apex
  QB.or_x(QB.count('Name').eq(100),QB.count('Name').gt(100))
  ```
  
Equivalent to : 

  ```apex
  (COUNT(Name) = 100) OR (COUNT(Name) > 100)
  ```

*Example 2:*
  ```apex
  QB.or_x(QB.count('Name').eq(100),QB.count('Name').gt(100))
    .add(QB.count('Name').lt(100))
  ```
  
Equivalent to : 

  ```apex
  (COUNT(Name) = 100) OR (COUNT(Name) > 100) OR (COUNT(Name) < 100)
  ```

--------  
>*__NOTE__: 
>'and', 'or' and 'not' are all reserved words in apex and can not be used as names of methods, to get around the >suffix '__\_x__' is appended to the reserved words*

## Next

* [Building a Query](QUERY.md) 
