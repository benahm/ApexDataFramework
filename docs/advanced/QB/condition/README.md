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
      <li>DateFunction</li>
      <li>DateOnlyFunction</li>
      <li>ToLabelFunction</li>
    </ul>
  </td>
  <td><pre lang="apex">
  QB.field('Name').eq('Value') // Field - SOQL : Name = 'Value'
  QB.count().eq(1) // AggregateFunction - SOQL : COUNT() = 1
  QB.calendar_month('CreatedDate').eq(1) // DateFunction - SOQL : CALENDAR_MONTH(CreatedDate) = 1
  QB.date_only('CreatedDate').eq(Date.newinstance(1960, 2, 17)) // DateOnlyFunction - SOQL : DATE_ONLY(CreatedDate) = '1960-2-17'
  QB.toLabel('Name').eq('My Name') // ToLabelFunction - SOQL : toLabel(Name) = 'My Name'
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
  QB.field('Name').eq(new List&lt;String&gt;{'Value1','Value2'}) // Field - SOQL : Name IN ('Value1','Value2')
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
      <li>DateFunction</li>
      <li>DateOnlyFunction</li>
      <li>ToLabelFunction</li>
    </ul>
  </td>
  <td><pre lang="apex">
  QB.field('Name').ne('Value') // Field - SOQL : Name != 'Value'
  QB.count().ne(1) // AggregateFunction - SOQL : COUNT() != 1
  QB.calendar_month('CreatedDate').ne(1) // DateFunction - SOQL : CALENDAR_MONTH(CreatedDate) != 1
  QB.date_only('CreatedDate').ne(Date.newinstance(1960, 2, 17)) // DateOnlyFunction - SOQL : DATE_ONLY(CreatedDate) != '1960-2-17'
  QB.toLabel('Name').ne('My Name') // ToLabelFunction - SOQL : toLabel(Name) != 'My Name'
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
  QB.field('Name').ne(new List&lt;String&gt;{'Value1','Value2'}) // Field - SOQL : Name NOT IN ('Value1','Value2')
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
      <li>DateFunction</li>
      <li>DateOnlyFunction</li>
    </ul>
  </td>
  <td><pre lang="apex">
  QB.field('Name').gt('Value') // Field - SOQL : Name &gt; 'Value'
  QB.count().gt(1) // AggregateFunction - SOQL : COUNT() &gt; 1
  QB.calendar_month('CreatedDate').gt(1) // DateFunction - SOQL : CALENDAR_MONTH(CreatedDate) &gt; 1
  QB.date_only('CreatedDate').gt(Date.newinstance(1960, 2, 17)) // DateOnlyFunction - SOQL : DATE_ONLY(CreatedDate) &gt; '1960-2-17'
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
      <li>DateFunction</li>
      <li>DateOnlyFunction</li>
    </ul>
  </td>
  <td><pre lang="apex">
  QB.field('Name').lt('Value') // Field - SOQL : Name &lt; 'Value'
  QB.count().lt(1) // AggregateFunction - SOQL : COUNT() &lt; 1
  QB.calendar_month('CreatedDate').lt(1) // DateFunction - SOQL : CALENDAR_MONTH(CreatedDate) &lt; 1
  QB.date_only('CreatedDate').lt(Date.newinstance(1960, 2, 17)) // DateOnlyFunction - SOQL : DATE_ONLY(CreatedDate) &lt; '1960-2-17'
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
