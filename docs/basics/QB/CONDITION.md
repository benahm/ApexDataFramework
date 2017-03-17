
## Building a Condition

QB builds two types for conditions 

* Field Condition : condition mean to be used in the where clause 
* having condition : condition mean to be used in the having clause
 
#### Field Condition:

  ```apex
  QB.field('Name').eq('Acme Corporation')
  ```
  ```apex
  QB.fieldExpr('Name','=','Acme Corporation')
  ```
#### Logical operators:
**NOT** :
  ```apex
  QB.not_x(QB.field('Name').eq('Acme Corporation'))
  ```
  ```apex
  NOT (Name='Acme Coproration')
  ```
**AND** :
  ```apex
  QB.and_x(QB.field('Name').eq('Acme Corporation'),QB.field('Name','=','Acme Corporation'))
  ```
  ```apex
  Name='Acme Coproration' AND Name='Acme Corporation'
  ```
