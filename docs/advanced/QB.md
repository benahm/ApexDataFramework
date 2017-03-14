## Query Builder

#### Query Builder mapping of SOQL keywords

| SOQL Keyword | Query Builder | Invocation |
|--------------|---------------|------------|
| *select*     | select_x      | QB         |
| *from*       | from_x        | chained    |
| *where*      | where_x       | chained    |
| *group by*   | groupBy       | chained    |
| *order by*   | orderBy       | chained    |
| *limit*      | limitTo       | chained    |
| *offset*     | offset        | chained    |




#### Comparison Operators


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
  <td>Field/AggregateFunction</td>
  <td><pre lang="apex">
  QB.field('Name').eq('Value') // Field - SOQL : Name = 'Value'
  QB.count().eq(1) // AggregateFunction - SOQL : COUNT() = 1
  </pre></td>
</tr>
<tr></tr>
<tr>
  <td><em>IN</em></td>
  <td>eq, equal</td>
  <td>Field</td>
  <td><pre lang="apex">
  QB.field('Name').eq(new List&lt;String&gt;{'Value1','Value2'}) // - SOQL : Name IN ('Value1','Value2')
  </pre></td>
</tr>
<tr></tr>
<tr>
  <td><em>!=</em></td>
  <td>ne, notequal</td>
  <td>Field/AggregateFunction</td>
  <td><pre lang="apex">
  QB.field('Name').ne('Value') // Field
  QB.count().ne(1) // AggregateFunction
  </pre></td>
</tr>
<tr></tr>
<tr>
  <td><em>NOT IN</em></td>
  <td>ne, notequal</td>
  <td>Field</td>
  <td><pre lang="apex">
  QB.field('Name').ne(new List&lt;String&gt;{'Value1','Value2'})
  </pre></td>
</tr>
<tr></tr>
<tr>
  <td><em>&gt;</em></td>
  <td>gt, greaterThan</td>
  <td>Field/AggregateFunction</td>
  <td><pre lang="apex">
  QB.field('Name').gt('Value') // Field
  QB.count().gt(1) // AggregateFunction
  </pre></td>
</tr>
<tr></tr>
<tr>
  <td><em>&lt;</em></td>
  <td>lt, lessThan</td>
  <td>Field/AggregateFunction</td>
  <td><pre lang="apex">
  QB.field('Name').lt('Value') // Field
  QB.count().lt(1) // AggregateFunction
  </pre></td>
</tr>
<tr></tr>
<tr>
  <td><em>&gt;=</em></td>
  <td>ge, greaterOrEqual</td>
  <td>Field/AggregateFunction</td>
  <td><pre lang="apex">
  QB.field('Name').ge('Value') // Field
  QB.count().ge(1) // AggregateFunction
  </pre></td>
</tr>
<tr></tr>
<tr>
  <td><em>&lt;=</em></td>
  <td>le, lessOrEqual</td>
  <td>Field/AggregateFunction</td>
  <td><pre lang="apex">
  QB.field('Name').le('Value') // Field
  QB.count().le(1) // AggregateFunction
  </pre></td>
</tr>
<tr></tr>
<tr>
  <td><em>LIKE</em></td>
  <td>lk, isLike</td>
  <td>Field</td>
  <td><pre lang="apex">
  QB.field('Name').lk('Value') 
  </pre></td>
</tr>
</tbody></table>
           




