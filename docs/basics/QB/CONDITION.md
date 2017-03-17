
## Building a Condition



The query builder offers a way to create complex conditions 

  Query builder syntax:
  ```apex
  QB.and_x(QB.field('Name').eq('Acme Corporation'),QB.fieldExpr('Type','=','Prospect'))
  ```

  Equivalent to:
  ```sql
  Name='Acme Corporation' AND Type='Prospect'
  ```
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
