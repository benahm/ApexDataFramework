## Find method

Find method offers different ways to query salesforce data 


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
* find(ids, fieldNames, limitOption) // select fieldNames where Id in ids limit to limitOption
* find(fieldName, fieldValues) // select all fields where fieldName in fieldValues
* find(fieldName, fieldValues, fieldNames) // select fieldNames where fieldName in fieldValues
* find(fieldName, fieldValues, fieldNames, limitOption) // select fieldNames where fieldName in fieldValues limit to limitOption
* find(Condition) // select all fields where condition is true
* find(Condition, fieldNames) // select fieldNames where condition is true
* find(Condition, fieldNames, limitOption) // select fieldNames where condition is true limit to limitOption
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
* findMap(ids, fieldNames, limitOption) // select fieldNames where Id in ids limit to limitOption
* findMap(fieldName, fieldValues) // select all fields where fieldName in fieldValues
* findMap(fieldName, fieldValues, fieldNames) // select fieldNames where fieldName in fieldValues
* findMap(fieldName, fieldValues, fieldNames, limitOption) // select fieldNames where fieldName in fieldValues limit to limitOption
* findMap(Condition) // select all fields where condition is true
* findMap(Condition, fieldNames) // select fieldNames where condition is true 
* findMap(Condition, fieldNames, limitOption) // select fieldNames where condition is true limit to limitOption
* findMap(Query) // get Query results
</pre>
  </td>
</tr>
<tr></tr>
<tr>
  <td><em>findOne</em></td>
  <td>find one record</td>
  <td>
<pre lang='apex'> 
* findOne()  // select all fields where limit is 1 
* findOne(ids) // select all fields where Id in ids
* findOne(ids, fieldNames) // select fieldNames where Id in ids
* findOne(fieldName, fieldValue) // select all fields where fieldName is equal to fieldValue
* findOne(fieldName, fieldValue, fieldNames) // select fieldNames where fieldName is equal to fieldValue
* findOne(Condition) // select all fields where condition is true
* findOne(Condition, fieldNames) // select fieldNames where condition is true
* findOne(Query) // get one from Query results
</pre>  
  </td>
</tr>
</tbody>
</table>
