## Find method


<table>
<thead>
<tr>
  <th>Method</th>
  <th>Description</th>
  <th>Supported signatures</th>
</tr>
</thead>
<tbody><tr>
  <td><em>find</em></td>
  <td>find a list</td>
  <td>
<pre lang='apex'>  
* find(ids) // select all fields where Id in ids
* find(ids, fieldNames) // select fieldNames where Id in ids
* find(fieldName, fieldValues) // select all fields where fieldName in fieldValues
* find(fieldName, fieldValues, fieldNames) // select fieldNames where fieldName in fieldValues
* find(Condition) // select all fields where condition is true
* find(Condition, fieldNames) // select fieldNames where condition is true
* find(Query) // get Query results
</pre>
  </td>
</tr>
<tr></tr>
<tr>
  <td><em>findMap</em></td>
  <td>find a map</td>
  <td>
<pre lang='apex'> 
* findMap(ids) // select all fields where Id in ids
* findMap(ids, fieldNames) // select fieldNames where Id in ids
* findMap(fieldName, fieldValues) // select all fields where fieldName in fieldValues
* findMap(fieldName, fieldValues, fieldNames) // select fieldNames where fieldName in fieldValues
* findMap(Condition) // select all fields where condition is true
* findMap(Condition, fieldNames) // select fieldNames where condition is true
* findMap(Query) // get Query results
</pre>
  </td>
</tr>
<tr></tr>
<tr>
  <td><em>findOne</em></td>
  <td>find one sObject</td>
  <td>
<pre lang='apex'> 
* findOne()  // select all fields where limit is 1 
* findOne(id) // select all fields where Id is equal to id
* findMap(id, fieldNames) // select fieldNames where Id is equal to id
* findMap(fieldName, fieldValue) // select all fields where fieldName is equal to fieldValue
* findMap(fieldName, fieldValue, fieldNames) // select fieldNames where fieldName is equal to fieldValue
* findMap(Condition) // select all fields where condition is true
* findMap(Condition, fieldNames) // select fieldNames where condition is true
* findMap(Query) // get one from Query results
</pre>  
  </td>
</tr>
</tbody>
</table>
