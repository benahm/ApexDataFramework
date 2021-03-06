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
* findById(ids, fieldNames, appendOptions) // select fieldNames where Id in ids with the appendOptions
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
* findBy(fieldName, fieldValues, fieldNames, appendOptions) // select fieldNames where fieldName in fieldValues with the appendOptions
* findBy(Condition) // select all fields where condition is true
* findBy(Condition, fieldNames) // select fieldNames where condition is true
* findBy(Condition, fieldNames, appendOptions) // select fieldNames where condition is true with the appendOptions
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
* findMapById(ids, fieldNames, appendOptions) // select fieldNames where Id in ids with the appendOptions
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
* findMapBy(fieldName, fieldValues, fieldNames, appendOptions) // select fieldNames where fieldName in fieldValues with the appendOptions
* findMapBy(Condition) // select all fields where condition is true
* findMapBy(Condition, fieldNames) // select fieldNames where condition is true 
* findMapBy(Condition, fieldNames, appendOptions) // select fieldNames where condition is true with the appendOptions
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
</pre>  
  </td>
</tr>
</tbody>
</table>
