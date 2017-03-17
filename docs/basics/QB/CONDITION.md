
## Building a Condition

QB builds two types for conditions 

* [Field Condition](#field-condition) : condition mean to be used in the where clause 
* [Having condition](#having-condition) : condition mean to be used in the having clause
 
### Field Condition:

#### 1. Simple field Condition:

QB offers differents ways to create a simple field condition 

QB field conditions 

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

##### Not logical operator

NOT logical operator can be applied to a condition 

  ```apex
  QB.not_x(QB.field('Name').eq('Acme Corporation'))
  ```
Equivalent to : 

  ```apex
  NOT (Name = 'Acme Coproration')
  ```
  
##### And logical operator

AND logical operator can be applied to multiple conditions

**Example 1**
  ```apex
  QB.and_x(QB.field('Name').eq('Acme Corporation'),QB.field('Name','>','Acme Corporation'))
  ```
  ```apex
  Name = 'Acme Coproration' AND Name>'Acme Corporation'
  ```

**Example 2**
  ```apex
  QB.and_x(QB.field('Name').eq('Acme Corporation'),QB.field('Name','>','Acme Corporation'))
    .add(QB.fieldExpr('Name',QB.Op.LE,'Acme Corporation'))
  ```
  ```apex
  Name = 'Acme Coproration' AND Name > 'Acme Corporation' AND Name < 'Acme Corporation'
  ```

##### Or logical operator

OR logical operator can be applied to multiple conditions

**Example 1**
  ```apex
  QB.or_x(QB.field('Name').eq('Acme Corporation'),QB.field('Name','>','Acme Corporation'))
  ```
  ```apex
  Name='Acme Coproration' AND Name!='Acme Corporation'
  ```

**Example 2**

  ```apex
  QB.or_x(QB.field('Name').eq('Acme Corporation'),QB.field('Name','>','Acme Corporation'))
    .add(QB.fieldExpr('Name',QB.Op.LE,'Acme Corporation'))
  ```
  ```apex
  Name = 'Acme Coproration' OR Name > 'Acme Corporation' OR Name < 'Acme Corporation'
  ```
  
  
  ### Having Condition:
