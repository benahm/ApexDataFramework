/**
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
 *  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
 *  THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 *  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 *  OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**/

/**
* @author benahm
* @date 2017
* @description Query Builder class
*/
public class QB {
	private static final String singleQuote='\'';
	private static final Util util=new Util();
	private static final ErrorMessage errMsg=new ErrorMessage();
	public enum Op {EQ, EQUAL,
			NE, NOTEQUAL,
			GT, GREATERTHAN,
			LT, LESSTHAN,
			GE, GREATEROREQUAL,
			LE, LESSOREQUAL,
			LK, ISLIKE}
	

	private static final Map <String, Schema.SObjectType> globalSchemaMap;

	// class initialisation code
	static {
	    globalSchemaMap = Schema.getGlobalDescribe();
	}



	/**
	* @description apply the logical operator NOT to a condition
	* @param cnd : Condition
	* @return NotCondition 
	*/
	public static IFieldCondition not_x(IFieldCondition cnd){
		return new NotCondition(cnd) ;
	}
	public static IHavingCondition not_x(IHavingCondition cnd){
		return new NotCondition(cnd) ;
	}


	/**
	* @description apply the logical operator AND to two conditions
	* @param cnd1 : the first condition
	* @param cnd2 : the second condition
	* @return AndCondition
	*/
	public static IFieldMultiCondition and_x(IFieldCondition cnd1, IFieldCondition cnd2){
		return new AndCondition(cnd1,cnd2);
	}
	public static IHavingMultiCondition and_x(IHavingCondition cnd1, IHavingCondition cnd2){
		return new AndCondition(cnd1,cnd2);
	}


	/**
	* @description apply the logical operator OR to two conditions
	* @param cnd1 : the first condition
	* @param cnd2 : the second condition
	* @return OrCondition
	*/
	public static IFieldMultiCondition or_x(IFieldCondition cnd1, IFieldCondition cnd2){
		return new OrCondition(cnd1,cnd2);
	}
	public static IHavingMultiCondition or_x(IHavingCondition cnd1, IHavingCondition cnd2){
		return new OrCondition(cnd1,cnd2);
	}

	/**
	* @description wrap a field
	* @param name : field name
	* @return Field
	*/
	public static Field field(String name){
		return new Field(name);
	}	

	/**
	* @description field expression
	* @param name : field name
	* @param operator : the comparator operator
	* @return Field
	*/
	public static IFieldCondition fieldExpr(String name, Op operator, Object value){
		return new Field(name).op(operator,value);
	}
	public static IFieldCondition fieldExpr(String name, String operator, Object value){
		return new Field(name).op(operator,value);
	}

	/**
	* @description count aggregate function
	* @return AggregateFunction
	*/
	public static AggregateFunction count(){
		return new AggregateFunction('COUNT');
	}
	public static AggregateFunction count(String fieldName){
		return new AggregateFunction('COUNT',fieldName);
	}

	/**
	* @description count_distinct aggregate function
	* @return AggregateFunction
	*/
	public static AggregateFunction count_distinct(String fieldName){
		return new AggregateFunction('COUNT_DISTINCT',fieldName);
	}

	/**
	* @description avg aggregate function
	* @return AggregateFunction
	*/
	public static AggregateFunction avg(String fieldName){
		return new AggregateFunction('AVG',fieldName);
	}

	/**
	* @description min aggregate function
	* @return AggregateFunction
	*/
	public static AggregateFunction min(String fieldName){
		return new AggregateFunction('MIN',fieldName);
	}

	/**
	* @description max aggregate function
	* @return AggregateFunction
	*/
	public static AggregateFunction max(String fieldName){
		return new AggregateFunction('MAX',fieldName);
	}

	/**
	* @description sum aggregate function
	* @return AggregateFunction
	*/
	public static AggregateFunction sum(String fieldName){
		return new AggregateFunction('SUM',fieldName);
	}

	/**
	* @description select clause
	* @return AggregateFunction
	*/	
	public static SelectFieldsClause select_x(String fieldName){
		return new SelectFieldsClause(fieldName);
	}
	public static SelectFieldsClause select_x(List<String> fieldNames){
		return new SelectFieldsClause(fieldNames);
	}
	public static SelectAggregateClause select_x(AggregateFunction aggrFunc){
		return new SelectAggregateClause(aggrFunc);
	}
	public static SelectAggregateClause select_x(AggregateFunction aggrFunc, String fieldName){
		return new SelectAggregateClause(aggrFunc,fieldName);
	}
	public static SelectAggregateClause select_x(AggregateFunction aggrFunc, List<String> fieldNames){
		return new SelectAggregateClause(aggrFunc,fieldNames);
	}

	public static OrderType ascNullsFirst(){
		return new OrderType('ASC','FIRST');
	}
	public static OrderType ascNullsLast(){
		return new OrderType('ASC','LAST');
	}
	public static OrderType descNullsFirst(){
		return new OrderType('DESC','FIRST');
	}
	public static OrderType descNullsLast(){
		return new OrderType('DESC','LAST');
	}

	/****************************************************************************************/
	/*					Interfaces					*/
	/****************************************************************************************/
	/**
	* @description IQuery : a valid query
	*/
	public interface IQuery{
		List<SObject> getList();
		Map<Id, SObject> getMap();
	}

	/**
	* @description ICondition : interface for a valid condition
	*/
	public interface ICondition{}
	public interface IFieldCondition extends ICondition{ String toString(); }
	public interface IFieldMultiCondition extends IFieldCondition{ IFieldMultiCondition add(IFieldCondition cnd); }
	public interface IHavingCondition extends ICondition{ String toString(); }
	public interface IHavingMultiCondition extends IHavingCondition{ IHavingMultiCondition add(IHavingCondition cnd); }


	/**
	* @description IField : interface for the field wrapper
	*/
	public interface IField {
		// equal to
		FieldCondition eq(Object value);
		FieldCondition equal(Object value);

		// not equal to
		FieldCondition ne(Object value);
		FieldCondition notEqual(Object value);
		
		// greater than
		FieldCondition gt(Object value);
		FieldCondition greaterThan(Object value);

		// less than
		FieldCondition lt(Object value);
		FieldCondition lessThan(Object value);

		// greater than or equal to
		FieldCondition ge(Object value);
		FieldCondition greaterOrEqual(Object value);

		// less than or equal to
		FieldCondition le(Object value);
		FieldCondition lessOrEqual(Object value);

		// like 
		FieldCondition lk(String fieldValue);
		FieldCondition isLike(String fieldValue);
	}


	/****************************************************************************************/
	/*					Classes						*/
	/****************************************************************************************/
	/**
	* @description NotCondition : NOT applied to a condition
	*/
	public class NotCondition implements IFieldCondition,IHavingCondition {
		private ICondition cnd;

		public NotCondition(ICondition cnd){
			this.cnd=cnd;
		}

		public override String toString(){
			return 'NOT ('+cnd+')';
		}
	}

	/**
	* @description MultiCondition : Abstract class for operations that can be
	* 			      applied to multiple conditions
	*/
	public abstract class MultiCondition implements IFieldMultiCondition,IHavingMultiCondition {
		protected abstract String getOperator();
		protected abstract List<ICondition> getListConditions();

		public MultiCondition add(ICondition cnd){
			getListConditions().add(cnd);
			return this;
		}

		public override String toString(){
			String result='';

			for(ICondition cnd:getListConditions()){
				result+='('+cnd+')'+' '+getOperator()+' ';
			}
			return result.removeEnd(' '+getOperator()+' ');
		}
	}

	/**
	* @description AndCondition : AND applied to multiple conditions
	*/
	public class AndCondition extends MultiCondition {
		private List<ICondition> listConditions;
		private final String operator = 'AND';

		public AndCondition(ICondition cnd1, ICondition cnd2){
			this.listConditions=new List<ICondition>{cnd1,cnd2};
		}

		public override String getOperator(){
			return operator;
		}

		public override List<ICondition> getListConditions(){
			return listConditions;
		}
	}

	/**
	* @description AndCondition : OR applied to multiple conditions
	*/
	public class OrCondition extends MultiCondition {
		private List<ICondition> listConditions;
		private final String operator = 'OR';

		public OrCondition(ICondition cnd1, ICondition cnd2){
			this.listConditions=new List<ICondition>{cnd1,cnd2};
		}

		public override String getOperator(){
			return operator;
		}

		public override List<ICondition> getListConditions(){
			return listConditions;
		}
	}

	/**
	* @description Field : field wrapper
	*/
	public class Field implements IField {
		private final String fieldName;

		public Field(String fieldName){
			this.fieldName=fieldName;
		}

		private FieldCondition handleOperator(Op operator,Object value){
			return new FieldCondition(this,operator,value);
		}
		private FieldCondition handleOperator(String operator,Object value){
			return new FieldCondition(this,operator,value);
		}

		public FieldCondition op(Op operator, Object value){
			return handleOperator(operator,value);
		}
		public FieldCondition op(String operator, Object value){
			return handleOperator(operator,value);
		}

		// equal to
		public FieldCondition eq(Object value){
			return handleOperator(Op.EQ,value);
		}
		public FieldCondition equal(Object value){
			return eq(value);
		}

		// not equal to
		public FieldCondition ne(Object value){
			return handleOperator(Op.NE,value);	
		}
		public FieldCondition notEqual(Object value){
			return ne(value);
		}
		
		// greater than
		public FieldCondition gt(Object value){
			return handleOperator(Op.GT,value);
		}
		public FieldCondition greaterThan(Object value){
			return gt(value);
		}

		// less than
		public FieldCondition lt(Object value){
			return handleOperator(Op.LT,value);
		}
		public FieldCondition lessThan(Object value){
			return lt(value);
		}

		// greater than or equal to
		public FieldCondition ge(Object value){
			return handleOperator(Op.GE,value);
		}
		public FieldCondition greaterOrEqual(Object value){
			return ge(value);
		}

		// less than or equal to
		public FieldCondition le(Object value){
			return handleOperator(Op.LE,value);
		}
		public FieldCondition lessOrEqual(Object value){
			return le(value);
		}

		// like 
		public FieldCondition lk(Object value){
			return handleOperator(Op.LK,value);
		}
		public FieldCondition isLike(Object value){
			return lk(value);
		}

		public override String toString(){
			return fieldName;
		}
	}

	/**
	* @description FieldCondition : field condition
	*/
	public class FieldCondition implements IFieldCondition {
		private final Field field;
		private final String operator;
		private final String values;

		public FieldCondition(Field field,Op operator,Object value){
			this(field,util.operatorToString(operator),value);
		}
		public FieldCondition(Field field,String operator,Object value){
			this.field=field;
			this.operator=operator.trim();
			this.values=parseValue(value);
		}

		private String parseValue(Object value){
			if(value == null) return 'NULL';
			if(util.isNumberOrBoolean(value)){
				return value+'';
			} else if(value instanceof String){
				return singleQuote+String.escapeSingleQuotes(value+'')+singleQuote;
			} else if(value instanceof List<String>){
				List<String> values=(List<String>)value;
				if(values.isEmpty()) throw new QBConditionException('Error Value is Empty List');
				return '('+singleQuote+String.join(util.escapeSingleQuotes(values),singleQuote+','+singleQuote)+singleQuote+')';
			}else 
				throw new QBConditionException('Error Bad Value Type');
		}

		private Boolean isMultipeValues(String value){
			return value.startsWith('(') && value.endsWith(')');
		}

		public override String toString(){

			// Multiple values
			if(isMultipeValues(values)){
				if(operator == '='){ // EQUAL
					return field+' IN '+values;
				} else if(this.operator == '!='){ // NOT EQUAL
					return field+' NOT IN '+values;
				} else {
					throw new QBConditionException(errMsg.operatorDoNotHandleMultiValues);
				}
			}

			// Single value
			if(util.isValidFieldConditionOperator(operator))
				return field+' '+operator+' '+values;
			else 
				throw new QBConditionException(errMsg.unkownOperator);
		}
	}

	/**
	* @description Query : a valid query
	*/
	public abstract class Query implements IQuery {

		/* handle asterix & simple pattern to filter on fieldNames*/
		private String getListFieldNames(String fieldName){
			Schema.SObjectType sObjectType = globalSchemaMap.get(/*sObjectName*/'Account');
			Map <String, Schema.SObjectField> fieldMap = sObjectType.getDescribe().fields.getMap();
			
			List<String> fieldsList = new List<String>();
			
			for (Schema.SObjectField sfield : fieldMap.Values()) {
				String sObjectFieldName = sfield.getDescribe().getname();
				if(Pattern.matches(fieldName,sObjectFieldName))
			    	fieldsList.add(sfield.getDescribe().getname());
			}
			return null;
		}

		public List<SObject> getList(){
			String soqlQuery=toString();
			return new List<SObject>(Database.query(soqlQuery));
		}

		public map<Id,SObject> getMap(){
			return new Map<Id,SObject>(getList());
		}

	}

	/**
	* @description SelectClause : select clause
	*/
	public abstract class SelectClause {

		public SelectQuery from_x(String sObjectName){
			return new SelectQuery(sObjectName,this);
		}
	}

	/**
	* @description SelectFieldsClause : select fields clause
	*/
	public class SelectFieldsClause extends SelectClause {
		private final List<String> selectedFields;
		private List<IQuery> subQueries;

		public SelectFieldsClause(String fieldName){
			this(new List<String>{fieldName});
		}
		public SelectFieldsClause(List<String> fieldNames){
			this.selectedFields=new List<String>(fieldNames);
			this.subQueries=new List<IQuery>();
		}

		public SelectClause addSubQuery(IQuery query){
			this.subQueries.add(query);
			return this;
		}

		public override String toString(){
			String result='SELECT ';
			if(!selectedFields.isEmpty()) 
				result+=String.join(selectedFields,',');
			if(!subQueries.isEmpty())
				result+=','+'('+util.joinListObjects(subQueries,'),(')+')';

			return result;
		}

	}

	/**
	* @description SelectAggregateClause : select aggregate clause
	*/
	public class SelectAggregateClause extends SelectClause {
		private final List<String> selectedFields;
		private final AggregateFunction aggrFunc;

		public SelectAggregateClause(AggregateFunction aggrFunc){
			this(aggrFunc,new List<String>());
		}
		public SelectAggregateClause(AggregateFunction aggrFunc, String fieldName){
			this(aggrFunc,new List<String>{fieldName});
		}
		public SelectAggregateClause(AggregateFunction aggrFunc, List<String> fieldNames){
			this.selectedFields=new List<String>(fieldNames);
			this.aggrFunc=aggrFunc;
		}

		public override String toString(){
			String result='SELECT ';
			if(aggrFunc!=null) result+=aggrFunc;
			if(!selectedFields.isEmpty()) 
				result+=','+String.join(selectedFields,',');

			return result;
		}
	}


	/**
	* @description SelectQuery : select query without a where clause
	*/
	public class SelectQuery extends Query {
		private final String sObjectName;
		private final SelectClause sClause;

		public SelectQuery(String sObjectName, SelectClause sClause){
			this.sObjectName=sObjectName;
			this.sClause=sClause;
		}

		public SelectWhereQuery where_x(IFieldCondition cnd){
			return new SelectWhereQuery(cnd,this);
		}
		public SelectWhereQuery where_x(String fieldName, Op operator, Object value){
			return new SelectWhereQuery(new Field(fieldName).op(operator,value),this);
		}
		public SelectWhereQuery where_x(String fieldName, String operator, Object value){
			return new SelectWhereQuery(new Field(fieldName).op(operator,value),this);
		}

		public SelectGroupByQuery groupBy(String groupByField){
			return new SelectGroupByQuery(groupByField,this);
		}
		public SelectGroupByQuery groupBy(List<String> groupByFields){
			return new SelectGroupByQuery(groupByFields,this);
		}
		public SelectGroupByQuery groupBy(String groupByField, IHavingCondition havingCtr){
			return new SelectGroupByQuery(groupByField,havingCtr,this);
		}
		public SelectGroupByQuery groupBy(List<String> groupByFields, IHavingCondition havingCtr){
			return new SelectGroupByQuery(groupByFields,havingCtr,this);
		}

		public SelectOrderByQuery orderBy(String orderByField){
			return new SelectOrderByQuery(orderByField,this);
		}
		public SelectOrderByQuery orderBy(List<String> orderByFields){
			return new SelectOrderByQuery(orderByFields,this);
		}
		public SelectOrderByQuery orderBy(String orderByField, OrderType orderType){
			return new SelectOrderByQuery(orderByField,orderType,this);
		}
		public SelectOrderByQuery orderBy(List<String> orderByFields, OrderType orderType){
			return new SelectOrderByQuery(orderByFields,orderType,this);
		}

		public SelectLimitQuery limitTo(Integer lmt){
			return new SelectLimitQuery(lmt,this);
		}

		public SelectOffsetQuery offset(Integer ofst){
			return new SelectOffsetQuery(ofst,this);
		}

		public override String toString(){
			return sClause+' FROM '+sObjectName;
		}
	}

	/**
	* @description SelectWhereQuery : select query with a where clause
	*/
	public class SelectWhereQuery extends Query {
		private final ICondition cnd;
		private final SelectQuery sQuery;

		public SelectWhereQuery(IFieldCondition cnd, SelectQuery sQuery){
			this.cnd=cnd;
			this.sQuery=sQuery;
		}

		public SelectGroupByQuery groupBy(String groupByField){
			return new SelectGroupByQuery(groupByField,this);
		}
		public SelectGroupByQuery groupBy(List<String> groupByFields){
			return new SelectGroupByQuery(groupByFields,this);
		}
		public SelectGroupByQuery groupBy(String groupByField, IHavingCondition havingCtr){
			return new SelectGroupByQuery(groupByField,havingCtr,this);
		}
		public SelectGroupByQuery groupBy(List<String> groupByFields, IHavingCondition havingCtr){
			return new SelectGroupByQuery(groupByFields,havingCtr,this);
		}

		public SelectOrderByQuery orderBy(String orderByField){
			return new SelectOrderByQuery(orderByField,this);
		}
		public SelectOrderByQuery orderBy(List<String> orderByFields){
			return new SelectOrderByQuery(orderByFields,this);
		}
		public SelectOrderByQuery orderBy(String orderByField, OrderType orderType){
			return new SelectOrderByQuery(orderByField,orderType,this);
		}
		public SelectOrderByQuery orderBy(List<String> orderByFields, OrderType orderType){
			return new SelectOrderByQuery(orderByFields,orderType,this);
		}

		public SelectLimitQuery limitTo(Integer lmt){
			return new SelectLimitQuery(lmt,this);
		}

		public SelectOffsetQuery offset(Integer ofst){
			return new SelectOffsetQuery(ofst,this);
		}

		public override String toString(){
			return sQuery+' WHERE '+cnd;
		}
	}

	/**
	* @description SelectGroupByQuery : Group By option of the where clause
	*/
	public class SelectGroupByQuery extends Query {
		private final List<String> groupByFields;
		private final IHavingCondition havingCtr;
		private final IQuery swQuery;

		public SelectGroupByQuery(String groupByField,IQuery swQuery){
			this(new List<String>{groupByField},null,swQuery);
		}
		public SelectGroupByQuery(List<String> groupByFields,IQuery swQuery){
			this(groupByFields,null,swQuery);
		}
		public SelectGroupByQuery(String groupByField,IHavingCondition havingCtr,IQuery swQuery){
			this(new List<String>{groupByField},havingCtr,swQuery);
		}
		public SelectGroupByQuery(List<String> groupByFields,IHavingCondition havingCtr,IQuery swQuery){
			this.groupByFields=new List<String>(groupByFields);
			this.havingCtr=havingCtr;
			this.swQuery=swQuery;
		}

		public SelectOrderByQuery orderBy(String orderByField){
			return new SelectOrderByQuery(orderByField,this);
		}
		public SelectOrderByQuery orderBy(List<String> orderByFields){
			return new SelectOrderByQuery(orderByFields,this);
		}
		public SelectOrderByQuery orderBy(String orderByField, OrderType orderType){
			return new SelectOrderByQuery(orderByField,orderType,this);
		}
		public SelectOrderByQuery orderBy(List<String> orderByFields, OrderType orderType){
			return new SelectOrderByQuery(orderByFields,orderType,this);
		}

		public SelectLimitQuery limitTo(Integer lmt){
			return new SelectLimitQuery(lmt,this);
		}

		public SelectOffsetQuery offset(Integer ofst){
			return new SelectOffsetQuery(ofst,this);
		}

		public override String toString(){
			String result=swQuery+' GROUP BY '+String.join(groupByFields, ',');
			if(havingCtr!=null)
				result+=' HAVING '+havingCtr;
			return result;
		}
	}

	/**
	* @description SelectOrderByQuery : Order By option of the where clause
	*/
	public class SelectOrderByQuery extends Query{
		private final List<OrderOption> orderOptions;
		private final IQuery swQuery;

		public SelectOrderByQuery(String orderByField,IQuery swQuery){
			this(new List<String>{orderByField},new OrderType(),swQuery);
		}
		public SelectOrderByQuery(List<String> orderByFields,IQuery swQuery){
			this(orderByFields,new OrderType(),swQuery);
		}
		public SelectOrderByQuery(String orderByField,OrderType orderType,IQuery swQuery){
			this(new List<String>{orderByField},orderType,swQuery);
		}
		public SelectOrderByQuery(List<String> orderByFields,OrderType orderType,IQuery swQuery){
			this.orderOptions=new List<OrderOption>{new OrderOption(orderByFields,orderType)};
			this.swQuery=swQuery;
		}

		public SelectOrderByQuery addOrder(String orderByField){
			addOrder(new List<String>{orderByField},new OrderType());
			return this;
		}
		public SelectOrderByQuery addOrder(List<String> orderByFields){
			this.orderOptions.add(new OrderOption(orderByFields,new OrderType()));
			return this;
		}
		public SelectOrderByQuery addOrder(String orderByField, OrderType orderType){
			addOrder(new List<String>{orderByField},orderType);
			return this;
		}
		public SelectOrderByQuery addOrder(List<String> orderByFields, OrderType orderType){
			this.orderOptions.add(new OrderOption(orderByFields,orderType));
			return this;
		}

		public SelectLimitQuery limitTo(Integer lmt){
			return new SelectLimitQuery(lmt,this);
		}

		public SelectOffsetQuery offset(Integer ofst){
			return new SelectOffsetQuery(ofst,this);
		}

		public override String toString(){
			return swQuery+' ORDER BY '+util.joinListObjects(orderOptions, ',');
		}
	}

	/**
	* @description SelectLimitQuery : Limit option of the where clause
	*/
	public class SelectLimitQuery extends Query {
		private final Integer lmt;
		private final IQuery swQuery;

		public SelectLimitQuery(Integer lmt,IQuery swQuery){
			this.lmt=lmt;
			this.swQuery=swQuery;
		}

		public SelectOffsetQuery offset(Integer ofst){
			return new SelectOffsetQuery(ofst,this);
		}

		public override String toString(){
			return swQuery+' LIMIT '+lmt;
		}
	}

	/**
	* @description SelectOffsetQuery : Offset option of the where clause
	*/
	public class SelectOffsetQuery extends Query {
		private final Integer ofst;
		private final IQuery swQuery;

		public SelectOffsetQuery(Integer ofst, IQuery swQuery){
			this.ofst=ofst;
			this.swQuery=swQuery;
		}

		public override String toString(){
			return swQuery+' OFFSET '+ofst;
		}
	}

	/**
	* @description OrderType : defines the type of the order
	*/
	public class OrderType {
		private final String orderingType;
		private final String nullsHandlingType;
		private Boolean pickDefault;

		public OrderType(){
			this.pickDefault=true;
		}
		public OrderType(String orderingType, String nullsHandlingType){
			this.orderingType=orderingType;
			this.nullsHandlingType=nullsHandlingType;
		}

		public override String toString(){
			if(pickDefault == true) return '';
			return ' '+orderingType+' NULLS '+nullsHandlingType;
		}
	}

	/**
	* @description OrderOption : defines the order fields with there orderType
	*/
	public class OrderOption {
		private OrderType orderType;
		private List<String> fieldNames;

		public OrderOption(List<String> fieldNames,OrderType orderType){
			this.fieldNames=fieldNames;	
			this.orderType=orderType;
		}

		public override String toString(){
			return String.join(fieldNames,',')	+orderType;
		}
	}

	/**
	* @description AggregateFunction : aggregate function
	*/
	public class AggregateFunction {
		private final String functionType;
		private final String fieldName;

		public AggregateFunction(String functionType){
			this(functionType,null);
		}
		public AggregateFunction(String functionType, String fieldName){
			this.functionType=functionType;
			this.fieldName=fieldName;
		}

		private HavingCondition handleOperator(Op operator,Integer value){
			return new HavingCondition(this,operator,value);
		}

		// equal to
		public HavingCondition eq(Integer value){
			return handleOperator(Op.EQ,value); 
		}
		public HavingCondition equal(Integer value){
			return eq(value);
		}

		// not equal to
		public HavingCondition ne(Integer value){
			return handleOperator(Op.NE,value);
		}
		public HavingCondition notEqual(Integer value){
			return ne(value);
		}
		
		// greater than
		public HavingCondition gt(Integer value){
			return handleOperator(Op.GT,value);
		}
		public HavingCondition greaterThan(Integer value){
			return gt(value);
		}

		// less than
		public HavingCondition lt(Integer value){
			return handleOperator(Op.LT,value);
		}
		public HavingCondition lessThan(Integer value){
			return lt(value);
		}

		// greater than or equal to
		public HavingCondition ge(Integer value){
			return handleOperator(Op.GE,value);
		}
		public HavingCondition greaterOrEqual(Integer value){
			return ge(value);
		}

		// less than or equal to
		public HavingCondition le(Integer value){
			return handleOperator(Op.LE,value);
		}
		public HavingCondition lessOrEqual(Integer value){
			return le(value);
		}

		public override String toString(){
			if(fieldName==null)
				return functionType+'()';
			else return functionType+'('+fieldName+')';
		}
	}

	/**
	* @description HavingCondition : having condition
	*/
	public class HavingCondition implements IHavingCondition{
		private final AggregateFunction aggrFunc;
		private final String operator;
		private final Integer value;

		public HavingCondition(AggregateFunction aggrFunc,Op operator,Integer value){
			this(aggrFunc,util.operatorToString(operator),value);
		}
		public HavingCondition(AggregateFunction aggrFunc,String operator,Integer value){
			this.aggrFunc=aggrFunc;
			this.operator=operator;
			this.value=value;
		}

		public override String toString(){
			if(util.isValidHavingConditionOperator(operator))
				return aggrFunc+' '+operator+' '+value;
			else
				throw new QBConditionException(errMsg.unkownOperator);
		}
	}

	/**
	* @description Validator : all validating methods
	*/
	private class Validator {

		// validate field name
		public Boolean validateFieldName(String fieldName){
			return null;
		}
		// validate operator
		// ...

	}

	/**
	* @description Util : Utility class
	*/
	private class Util {
		public String operatorToString(Op operator){
			if(operator == Op.EQ){
				return '=';
			} else if (operator == Op.NE){
				return '!=';
			} else if (operator == Op.GT){
				return '>';
			} else if (operator == Op.LT){
				return '<';
			} else if (operator == Op.GE){
				return '>=';
			} else if (operator == Op.LE){
				return '<=';
			} else if (operator == Op.LK){
				return 'LIKE';
			}
			return null;
		}

		public String joinListObjects(List<Object> listObj, String separator){
			String result='';
			for(Object obj:listObj){
				result+=obj+separator;
			}
			return result.removeEnd(separator);
		}

		public List<String> escapeSingleQuotes(List<String> values){
			List<String> escapedValues=new List<String>();
			for(String value:values){
				escapedValues.add(String.escapeSingleQuotes(value));
			}
			return escapedValues;
		}

		public Boolean isNumberOrBoolean(Object obj){
			return obj instanceof Integer 
					|| obj instanceof Double
					|| obj instanceof Long
					|| obj instanceof Decimal
					|| obj instanceof Boolean;
		}

		public Boolean isValidHavingConditionOperator(String operator){
			return operator == '=' 
					|| operator == '!='
					|| operator == '>'
					|| operator == '<'
					|| operator == '>='
					|| operator == '<=';
		}

		public Boolean isValidFieldConditionOperator(String operator){
			return isValidHavingConditionOperator(operator)
					|| operator == 'LIKE';
		}
	}

	/**
	* @description ErrorMessage : Class holding all the error messages
	*/
	private class ErrorMessage {
		public final String unkownOperator='Unkown Operator';
		public final String operatorDoNotHandleMultiValues='Only the operators EQUAL & NOTEQUAL can handle a list of values';
	}

	// Exceptions
	public class QBQueryException extends Exception {}
	public class QBConditionException extends Exception {}

}