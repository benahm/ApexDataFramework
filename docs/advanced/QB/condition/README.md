## Building a Condition

The Query builder (QB) let you build complex conditions to use in the where clause and the having clause 

Below an overview of the conditions you can build with QB

* [Logical operators](#logical-operators)
* [Conditions](#conditions)
  * [Field condition](#field-condition)
  * [Having condition](#having-condition)

### Logical operators

QB support all SOQL logical operators

<table>
<thead>
<tr>
  <th>SOQL Keyword</th>
  <th>Query Builder</th>
  <th>Signature</th>
  <th>Description</th>
</tr>
</thead>
<tbody>
<tr>
  <td><em>NOT</em></td>
  <td>not_x</td>
  <td>
    <pre lang="apex">
  QB.not_x(fieldCondition) 
  QB.not_x(havingCondition)
  </pre>
  </td>
  <td></td>
</tr>
<tr></tr>
<tr>
  <td><em>AND</em></td>
  <td>and_x</td>
  <td>
    <pre lang="apex">
  QB.and_x(fieldCondition,fieldCondition) 
  QB.and_x(havingCondition,havingCondition)
  </pre>
  </td>
  <td>QB.and_x can be chained with the "add" method to add more conditions 
  
  Example : 
  <pre lang="apex">
  QB.and_x(fieldCondition,fieldCondition)
    .add(fieldCondition) 
  QB.and_x(havingCondition,havingCondition)
    .add(havingCondition)
  </pre>
  </td>
</tr>
<tr></tr>
<tr>
  <td><em>OR</em></td>
  <td>or_x</td>
  <td>
    <pre lang="apex">
  QB.or_x(fieldCondition,fieldCondition) 
  QB.or_x(havingCondition,havingCondition)
  </pre>
  </td>
  <td>QB.or_x can be chained with the "add" method to add more conditions 
  
  Example : 
  <pre lang="apex">
  QB.or_x(fieldCondition,fieldCondition)
    .add(fieldCondition) 
  QB.or_x(havingCondition,havingCondition)
    .add(havingCondition)
  </pre>
  </td>
</tr>
</table>

### Conditions

The table below describe all the conditions you'll be able to build using QB

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


#### Field condition

field condition is a condition that can be used in the where clause

<table>
<thead>
<tr>
  <th>FieldCondition </th>
  <th>Examples</th>
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

#### Having condition

having condition is a condition that can be used in the having clause

<table>
<thead>
<tr>
  <th>HavingCondition </th>
  <th>Examples</th>
</tr>
</thead>
<tbody>
<tr>
  <td>Simple field condition</td>
  <td> 
  <pre lang="apex">
  QB.count().eq(value) 
  QB.count_distinct(fieldName).eq(value) 
  QB.avg(fieldName).eq(value) 
  QB.min(fieldName).eq(value) 
  QB.max(fieldName).eq(value) 
  QB.sum(fieldName).eq(value) 
  QB.calendar_month(fieldName).eq(value) 
  QB.calendar_quarter(fieldName).eq(value) 
  QB.calendar_year(fieldName).eq(value) 
  QB.day_in_month(fieldName).eq(value) 
  QB.day_in_week(fieldName).eq(value) 
  QB.fiscal_month(fieldName).eq(value) 
  QB.fiscal_quarter(fieldName).eq(value) 
  QB.fiscal_year(fieldName).eq(value) 
  QB.hour_in_day(fieldName).eq(value) 
  QB.week_in_month(fieldName).eq(value) 
  QB.week_in_year(fieldName).eq(value)
  QB.day_only(fieldName).eq(value)
  QB.calendar_month(convertTimeZone(fieldName)).eq(value)
  </pre>
  </td>
</tr>
<tr></tr>
<tr>
  <td>Composite condition</td>
  <td> 
  <pre lang="apex">
  QB.not_x(havingCondition) 
  QB.and_x(havingCondition,havingCondition)
  QB.or_x(havingCondition,havingCondition)
  </pre>
  </td>
</tr>
</table>

