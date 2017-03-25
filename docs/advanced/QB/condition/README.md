## Building a Condition

The Query builder (QB) let you build complex conditions to use in the where clause and the having clause 

Below an overview of the conditions you can build with QB

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
      <li>DayOnlyFunction</li>
      <li>ToLabelFunction</li>
    </ul>
  </td>
  <td><pre lang="apex">
  QB.field('Name').eq('Value') // Field - SOQL : Name = 'Value'
  QB.count().eq(1) // AggregateFunction - SOQL : COUNT() = 1
  QB.calendar_month('CreatedDate').eq(1) // DateFunction - SOQL : CALENDAR_MONTH(CreatedDate) = 1
  QB.date_only('CreatedDate').eq(Date.newinstance(1960, 2, 17)) // DayOnlyFunction - SOQL : DAY_ONLY(CreatedDate) = '1960-2-17'
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
      <li>DayOnlyFunction</li>
      <li>ToLabelFunction</li>
    </ul>
  </td>
  <td><pre lang="apex">
  QB.field('Name').ne('Value') // Field - SOQL : Name != 'Value'
  QB.count().ne(1) // AggregateFunction - SOQL : COUNT() != 1
  QB.calendar_month('CreatedDate').ne(1) // DateFunction - SOQL : CALENDAR_MONTH(CreatedDate) != 1
  QB.date_only('CreatedDate').ne(Date.newinstance(1960, 2, 17)) // DayOnlyFunction - SOQL : DAY_ONLY(CreatedDate) != '1960-2-17'
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
      <li>DayOnlyFunction</li>
    </ul>
  </td>
  <td><pre lang="apex">
  QB.field('Name').gt('Value') // Field - SOQL : Name &gt; 'Value'
  QB.count().gt(1) // AggregateFunction - SOQL : COUNT() &gt; 1
  QB.calendar_month('CreatedDate').gt(1) // DateFunction - SOQL : CALENDAR_MONTH(CreatedDate) &gt; 1
  QB.date_only('CreatedDate').gt(Date.newinstance(1960, 2, 17)) // DayOnlyFunction - SOQL : DAY_ONLY(CreatedDate) &gt; '1960-2-17'
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
      <li>DayOnlyFunction</li>
    </ul>
  </td>
  <td><pre lang="apex">
  QB.field('Name').lt('Value') // Field - SOQL : Name &lt; 'Value'
  QB.count().lt(1) // AggregateFunction - SOQL : COUNT() &lt; 1
  QB.calendar_month('CreatedDate').lt(1) // DateFunction - SOQL : CALENDAR_MONTH(CreatedDate) &lt; 1
  QB.date_only('CreatedDate').lt(Date.newinstance(1960, 2, 17)) // DayOnlyFunction - SOQL : DAY_ONLY(CreatedDate) &lt; '1960-2-17'
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
      <li>DateFunction</li>
      <li>DayOnlyFunction</li>
    </ul>
  </td>
  <td><pre lang="apex">
  QB.field('Name').ge('Value') // Field - SOQL : Name &gt;= 'Value'
  QB.count().ge(1) // AggregateFunction - SOQL : COUNT() &gt;= 1
  QB.calendar_month('CreatedDate').ge(1) // DateFunction - SOQL : CALENDAR_MONTH(CreatedDate) &gt;= 1
  QB.date_only('CreatedDate').ge(Date.newinstance(1960, 2, 17)) // DayOnlyFunction - SOQL : DAY_ONLY(CreatedDate) &gt;= '1960-2-17'
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
      <li>DateFunction</li>
      <li>DayOnlyFunction</li>
    </ul>
  </td>
  <td><pre lang="apex">
  QB.field('Name').le('Value') // Field - SOQL : Name &lt;= 'Value'
  QB.count().le(1) // AggregateFunction - SOQL : COUNT() &lt;= 1
  QB.calendar_month('CreatedDate').le(1) // DateFunction - SOQL : CALENDAR_MONTH(CreatedDate) &lt;= 1
  QB.date_only('CreatedDate').le(Date.newinstance(1960, 2, 17)) // DayOnlyFunction - SOQL : DAY_ONLY(CreatedDate) &lt;= '1960-2-17'
  </pre></td>
</tr>
<tr></tr>
<tr>
  <td><em>LIKE</em></td>
  <td>lk, isLike</td>
  <td>    
    <ul>
      <li>Field</li>
      <li>ToLabelFunction</li>
    </ul>
  </td>
  <td><pre lang="apex">
  QB.field('Name').lk('Val%') // Field - SOQL : Name LIKE 'Val%'
  QB.toLabel('Name').lk('My N%') // ToLabelFunction - SOQL : toLabel(Name) LIKE 'My N%'
  </pre></td>
</tr>
</tbody>
</table>


## Details of building a Condition

* [Field condition](FIELD.md)
* [Having condition](HAVING.md)
