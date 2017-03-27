## Find method

Find method offers different ways to query salesforce data 

### Find a list of SObject

<table>
<thead>
<tr>
  <th>Method</th>
  <th>Supported signatures</th>
</tr>
</thead>
<tbody>
<tr>
  <td>
  <em>findById</em>
  </td>
  <td>
<pre lang='apex'>  
* findById(ids) // select all fields where Id in ids
* findById(ids, fieldNames) // select fieldNames where Id in ids
* findById(ids, fieldNames, limitOption) // select fieldNames where Id in ids limit to limitOption
</pre>
  </td>
</tr>
<tr>
</tr>
<tr>
  <td>
  <em>findBy</em>
  </td>
  <td>
<pre lang='apex'>  
* findBy(fieldName, fieldValues) // select all fields where fieldName in fieldValues
* findBy(fieldName, fieldValues, fieldNames) // select fieldNames where fieldName in fieldValues
* findBy(fieldName, fieldValues, fieldNames, limitOption) // select fieldNames where fieldName in fieldValues limit to limitOption
* findBy(Condition) // select all fields where condition is true
* findBy(Condition, fieldNames) // select fieldNames where condition is true
* findBy(Condition, fieldNames, limitOption) // select fieldNames where condition is true limit to limitOption
* findBy(Query) // get Query results
</pre>
  </td>
</tr>
</table>

-----

### Find a map of SObject

<table>
<tr>
  <th>Method</th>
  <th>Supported signatures</th>
</tr>
<tr>
  <td><em>findMapById</em></td>
  <td>
<pre lang='apex'> 
* findMapById(ids) // select all fields where Id in ids
* findMapById(ids, fieldNames) // select fieldNames where Id in ids
* findMapById(ids, fieldNames, limitOption) // select fieldNames where Id in ids limit to limitOption
</pre>
  </td>
</tr>
<tr>
</tr>
<tr>
  <td><em>findMapBy</em></td>
  <td>
<pre lang='apex'> 
* findMapBy(fieldName, fieldValues) // select all fields where fieldName in fieldValues
* findMapBy(fieldName, fieldValues, fieldNames) // select fieldNames where fieldName in fieldValues
* findMapBy(fieldName, fieldValues, fieldNames, limitOption) // select fieldNames where fieldName in fieldValues limit to limitOption
* findMapBy(Condition) // select all fields where condition is true
* findMapBy(Condition, fieldNames) // select fieldNames where condition is true 
* findMapBy(Condition, fieldNames, limitOption) // select fieldNames where condition is true limit to limitOption
* findMapBy(Query) // get Query results
</pre>
  </td>
</tr>
</table>


<table>
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
