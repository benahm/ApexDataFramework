## Running a Query


QB offers different methods to run the built query, depending on the expected result 


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
    <pre lang='apex'>List&lt;Account&gt; aList = QB.select_x('Name')
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
    <pre lang='apex'>Map&lt;Id,Account&gt; aMap = QB.select_x('Name')
                        .from_x('Account')
                        .limitTo(10)
                        .getMap();
    </pre>
  </td>
</tr>
<tr></tr>
<tr>
  <td>
  <em>getCount</em>
  </td>
   <td>
    return integer (count of sObject)
  </td>
  <td>
    <pre lang='apex'>Integer aCount = QB.select_x(QB.count())
                        .from_x('Account')
                        .getCount();
    </pre>
  </td>
</tr>
</table>


## Next

* [Data Mapper](../DM/README.md) 
