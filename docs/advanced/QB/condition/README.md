## Building a Condition

<table>
<thead>
<tr>
  <th>Operator</th>
  <th>Query Builder</th>
  <th>Invocation</th>
  <th>Example</th>
</tr>
</thead>
<tbody><tr>
  <td><em>=</em></td>
  <td>eq, equal</td>
  <td>
    <ul>
      <li>Field</li>
      <li>AggregateFunction</li>
      <li>IDateFunctionWrap</li>
      <li>IDateOnlyFunctionWrap</li>
      <li>IToLabelFunctionWrap</li>
    </ul>
  </td>
  <td><pre lang="apex">
  QB.field('Name').eq('Value') // Field - SOQL : Name = 'Value'
  QB.count().eq(1) // AggregateFunction - SOQL : COUNT() = 1
  QB.calendar_month('CreatedDate').eq(1) // IDateFunctionWrap - SOQL : CALENDAR_MONTH(CreatedDate) = 1
  QB.date_only('CreatedDate').eq(Date.newinstance(1960, 2, 17)) // IDateOnlyFunctionWrap - SOQL : DATE_ONLY(CreatedDate) = '17-2-1960'
  QB.toLabel('Name').eq('My Name') // AggregateFunction - SOQL : toLabel(Name) = 'My Name'
  </pre></td>
</tr>
<tr></tr>
<tr>
  <td><em>IN</em></td>
  <td>eq, equal</td>
  <td>  
    <ul>
      <li>Field</li>
    </ul>
  </td>
  <td><pre lang="apex">
  QB.field('Name').eq(new List&lt;String&gt;{'Value1','Value2'}) // - SOQL : Name IN ('Value1','Value2')
  </pre></td>
</tr>
<tr></tr>
<tr>
  <td><em>!=</em></td>
  <td>ne, notequal</td>
  <td>
    <ul>
      <li>Field</li>
      <li>AggregateFunction</li>
    </ul>
  </td>
  <td><pre lang="apex">
  QB.field('Name').ne('Value') // Field
  QB.count().ne(1) // AggregateFunction
  </pre></td>
</tr>
<tr></tr>
<tr>
  <td><em>NOT IN</em></td>
  <td>ne, notequal</td>
  <td>    
    <ul>
      <li>Field</li>
    </ul>
  </td>
  <td><pre lang="apex">
  QB.field('Name').ne(new List&lt;String&gt;{'Value1','Value2'})
  </pre></td>
</tr>
<tr></tr>
<tr>
  <td><em>&gt;</em></td>
  <td>gt, greaterThan</td>
  <td>  
    <ul>
      <li>Field</li>
      <li>AggregateFunction</li>
    </ul>
  </td>
  <td><pre lang="apex">
  QB.field('Name').gt('Value') // Field
  QB.count().gt(1) // AggregateFunction
  </pre></td>
</tr>
<tr></tr>
<tr>
  <td><em>&lt;</em></td>
  <td>lt, lessThan</td>
  <td>  
    <ul>
      <li>Field</li>
      <li>AggregateFunction</li>
    </ul>
  </td>
  <td><pre lang="apex">
  QB.field('Name').lt('Value') // Field
  QB.count().lt(1) // AggregateFunction
  </pre></td>
</tr>
<tr></tr>
<tr>
  <td><em>&gt;=</em></td>
  <td>ge, greaterOrEqual</td>
  <td>  
    <ul>
      <li>Field</li>
      <li>AggregateFunction</li>
    </ul>
  </td>
  <td><pre lang="apex">
  QB.field('Name').ge('Value') // Field
  QB.count().ge(1) // AggregateFunction
  </pre></td>
</tr>
<tr></tr>
<tr>
  <td><em>&lt;=</em></td>
  <td>le, lessOrEqual</td>
  <td>  
    <ul>
      <li>Field</li>
      <li>AggregateFunction</li>
    </ul>
  </td>
  <td><pre lang="apex">
  QB.field('Name').le('Value') // Field
  QB.count().le(1) // AggregateFunction
  </pre></td>
</tr>
<tr></tr>
<tr>
  <td><em>LIKE</em></td>
  <td>lk, isLike</td>
  <td>    
    <ul>
      <li>Field</li>
    </ul>
  </td>
  <td><pre lang="apex">
  QB.field('Name').lk('Value') 
  </pre></td>
</tr>
</tbody>
</table>
