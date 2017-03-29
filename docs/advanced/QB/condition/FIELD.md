## Field condition


<table>
<thead>
<tr>
  <th>fieldCondition </th>
  <th>Query Builder</th>
</tr>
</thead>
<tbody>
<tr>
  <td>Simple field condition</td>
  <td> 
  <pre lang="apex">
  QB.field(fieldName).eq(value) 
  QB.fiedExpr(fieldName,op,value)
  QB.toLabel(fieldName).eq(value)
  </pre>
  </td>
</tr>
<tr></tr>
<tr>
  <td>Composite condition</td>
  <td> 
  <pre lang="apex">
  QB.not_x(fieldCondition) 
  QB.and_x(fieldCondition,fieldCondition)
  QB.or_x(fieldCondition,fieldCondition)
  </pre>
  </td>
</tr>
</table>
Building field condition


