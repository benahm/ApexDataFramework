## Running a Query




<table>
<thead>
<tr>
  <th>Method</th>
  <th>Result</th>
</tr>
</thead>
<tbody>
<tr>
  <td>
  <em>getList</em>
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
<pre lang='apex'>  

</pre>
  </td>
</tr>
</table>


## Next

* [Data Mapper](../DM/README.md) 
