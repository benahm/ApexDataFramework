## Running a Query




<table>
<thead>
<tr>
  <th>Method</th>
  <th>Description</th>
  <th>Example</th>
</tr>
</thead>
<tbody>
<tr>
  <td>
  <em>getList</em>
  </td>
  <td>
    return a list of sObject or a list of aggregateResult
  </td>
  <td>
    <pre lang='apex'>ListAccount aList = QB.select_x('Name')
                        .from_x('Account')
                        .limitTo(10)
                        .getList();
    </pre>
  </td>
</tr>
<tr>
</tr>
<tr>
  <td>
  <em>getMap</em>
  </td>
   <td>
    return a map of Id and sObject
  </td>
  <td>
    <pre lang='apex'>ListAccount aList = QB.select_x('Name')
                        .from_x('Account')
                        .limitTo(10)
                        .getMap();
    </pre>
  </td>
</tr>
<tr>
  <td>
  <em>getCount</em>
  </td>
   <td>
    return integer (count fo sObject)
  </td>
  <td>
    <pre lang='apex'>ListAccount aList = QB.select_x(QB.count())
                        .from_x('Account')
                        .getCount();
    </pre>
  </td>
</tr>
</table>


## Next

* [Data Mapper](../DM/README.md) 
