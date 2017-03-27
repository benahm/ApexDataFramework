## Find method

Find method offers different ways to query salesforce data 

### Find a list of sObject

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
* findById(ids, fieldNames, whereOption) // select fieldNames where Id in ids with the whereOption
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

### Find a map of sObject

<table>
<thead>
<tr>
  <th>Method</th>
  <th>Supported signatures</th>
</tr>
</thead>
<tbody>
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


### Find an sObject

<table>
<thead>
<tr>
  <th>Method</th>
  <th>Supported signatures</th>
</tr>
</thead>
<tbody>
<tr>
  <td><em>findOne</em></td>
  <td>
<pre lang='apex'> 
* findOne()  // select all fields where limit is 1 
</pre>  
  </td>
</tr>
<tr>
</tr>
<tr>
  <td><em>findOneById</em></td>
  <td>
<pre lang='apex'> 
* findOneById(ids) // select all fields where Id in ids
* findOneById(ids, fieldNames) // select fieldNames where Id in ids
</pre>  
  </td>
</tr>
<tr>
</tr>
<tr>
  <td><em>findOneBy</em></td>
  <td>
<pre lang='apex'> 
* findOneBy(fieldName, fieldValue) // select all fields where fieldName is equal to fieldValue
* findOneBy(fieldName, fieldValue, fieldNames) // select fieldNames where fieldName is equal to fieldValue
* findOneBy(Condition) // select all fields where condition is true
* findOneBy(Condition, fieldNames) // select fieldNames where condition is true
* findOneBy(Query) // get one from Query results
</pre>  
  </td>
</tr>
</tbody>
</table>
