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
	public static ISelectFieldsClause select_x(String fieldName){
		return new SelectClause(fieldName);
	}
	public static ISelectFieldsClause select_x(Schema.SObjectField field){
		return new SelectClause(field.getDescribe().getName());
	}
	public static ISelectFieldsClause select_x(List<String> fieldNames){
		return new SelectClause(fieldNames);
	}
	public static ISelectAggregateClause select_x(AggregateFunction aggrFunc){
		return new SelectClause(aggrFunc);
	}
	public static ISelectAggregateClause select_x(AggregateFunction aggrFunc, String fieldName){
		return new SelectClause(aggrFunc,fieldName);
	}
	public static ISelectAggregateClause select_x(AggregateFunction aggrFunc, Schema.SObjectField field){
		return new SelectClause(aggrFunc,field.getDescribe().getName());
	}
	public static ISelectAggregateClause select_x(AggregateFunction aggrFunc, List<String> fieldNames){
		return new SelectClause(aggrFunc,fieldNames);
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
	* @description Condition interfaces
	*/
	public interface ICondition{
		String toString();
	}
	public interface IFieldCondition extends ICondition{}
	public interface IFieldMultiCondition extends IFieldCondition{ 
		IFieldMultiCondition add(IFieldCondition cnd); 
	}
	public interface IHavingCondition extends ICondition{}
	public interface IHavingMultiCondition extends IHavingCondition{ 
		IHavingMultiCondition add(IHavingCondition cnd); 
	}

	/**
	* @description Field interface
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

	/**
	* @description Select clause interfaces
	*/
	public interface ISelectClause{
		String toString();
	}
	public interface ISelectFieldsClause extends ISelectClause{ 
		ISelectFieldsClause addSubQuery(IQuery query);
		ISelectFromQuery from_x(String sObjectName);
		ISelectFromQuery from_x(Schema.sObjectType sObjectType); 
	}
	public interface ISelectAggregateClause extends ISelectClause{
		ISelectFromQuery from_x(String sObjectName);
		ISelectFromQuery from_x(Schema.sObjectType sObjectType);
	}

	/**
	* @description Select query interfaces
	*/
	public interface IQuery{
		List<SObject> getList();
		Map<Id, SObject> getMap();
		String toString();
	}
	public interface ISelectFromQuery extends IQuery{
		ISelectWhereQuery where_x(IFieldCondition cnd);
		ISelectWhereQuery where_x(String fieldName, Op operator, Object value);
		ISelectWhereQuery where_x(String fieldName, String operator, Object value);

		ISelectGroupByQuery groupBy(String groupByField);
		ISelectGroupByQuery groupBy(List<String> groupByFields);
		ISelectGroupByQuery groupBy(String groupByField, IHavingCondition havingCtr);
		ISelectGroupByQuery groupBy(List<String> groupByFields, IHavingCondition havingCtr);

		ISelectOrderByQuery orderBy(String orderByField);
		ISelectOrderByQuery orderBy(List<String> orderByFields);
		ISelectOrderByQuery orderBy(String orderByField, OrderType orderType);
		ISelectOrderByQuery orderBy(List<String> orderByFields, OrderType orderType);

		ISelectLimitQuery limitTo(Integer lmt);

		ISelectOffsetQuery offset(Integer ofst);
	}
	public interface ISelectWhereQuery extends IQuery{
		ISelectGroupByQuery groupBy(String groupByField);
		ISelectGroupByQuery groupBy(List<String> groupByFields);
		ISelectGroupByQuery groupBy(String groupByField, IHavingCondition havingCtr);
		ISelectGroupByQuery groupBy(List<String> groupByFields, IHavingCondition havingCtr);

		ISelectOrderByQuery orderBy(String orderByField);
		ISelectOrderByQuery orderBy(List<String> orderByFields);
		ISelectOrderByQuery orderBy(String orderByField, OrderType orderType);
		ISelectOrderByQuery orderBy(List<String> orderByFields, OrderType orderType);

		ISelectLimitQuery limitTo(Integer lmt);

		ISelectOffsetQuery offset(Integer ofst);
	}
	public interface ISelectGroupByQuery extends IQuery{
		ISelectOrderByQuery orderBy(String orderByField);
		ISelectOrderByQuery orderBy(List<String> orderByFields);
		ISelectOrderByQuery orderBy(String orderByField, OrderType orderType);
		ISelectOrderByQuery orderBy(List<String> orderByFields, OrderType orderType);

		ISelectLimitQuery limitTo(Integer lmt);
		
		ISelectOffsetQuery offset(Integer ofst);
	}
	public interface ISelectOrderByQuery extends IQuery{
		ISelectOrderByQuery addOrder(String orderByField);
		ISelectOrderByQuery addOrder(List<String> orderByFields);
		ISelectOrderByQuery addOrder(String orderByField, OrderType orderType);
		ISelectOrderByQuery addOrder(List<String> orderByFields, OrderType orderType);

		ISelectLimitQuery limitTo(Integer lmt);
		
		ISelectOffsetQuery offset(Integer ofst);
	}
	public interface ISelectLimitQuery extends IQuery{
		ISelectOffsetQuery offset(Integer ofst);
	}
	public interface ISelectOffsetQuery extends IQuery{}


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

	public abstract class ASelectClause implements ISelectFieldsClause,ISelectAggregateClause {}

	/**
	* @description SelectClause : select clause
	*/
	public class SelectClause extends ASelectClause{
		private String soqlQuery;

		public SelectClause(String fieldName){
			this(new List<String>{fieldName});
		}
		public SelectClause(List<String> fieldNames){
			this.soqlQuery='SELECT ';
			if(!fieldNames.isEmpty()) 
				this.soqlQuery+=String.join(fieldNames,',');
		}
		public SelectClause(AggregateFunction aggrFunc){
			this.soqlQuery='SELECT '+aggrFunc;
		}
		public SelectClause(AggregateFunction aggrFunc, String fieldName){
			this(aggrFunc,new List<String>{fieldName});
		}
		public SelectClause(AggregateFunction aggrFunc, List<String> fieldNames){
			this.soqlQuery='SELECT '+aggrFunc;
			if(!fieldNames.isEmpty()) 
				this.soqlQuery+=','+String.join(fieldNames,',');
		}

		public ISelectFieldsClause addSubQuery(IQuery query){
			soqlQuery+=','+'('+query+')';
			return this;
		}

		public ISelectFromQuery from_x(String sObjectName){
			return new SelectQuery(sObjectName,this.soqlQuery);
		}
		public ISelectFromQuery from_x(Schema.sObjectType sObjectType){
			return new SelectQuery(sObjectType.getDescribe().getName(),this.soqlQuery);
		}

		public override String toString(){
			return soqlQuery;
		}
	}

	public abstract class ASelectQuery implements ISelectFromQuery,ISelectWhereQuery,ISelectGroupByQuery,ISelectOrderByQuery,ISelectLimitQuery,ISelectOffsetQuery {}

	/**
	* @description SelectQuery : select query without a where clause
	*/
	public class SelectQuery extends ASelectQuery {
		private String soqlQuery;

		public SelectQuery(String sObjectName, String soqlSelectClause){
			this.soqlQuery=soqlSelectClause+' FROM '+sObjectName;
		}

		public ISelectWhereQuery where_x(IFieldCondition cnd){
			this.soqlQuery+=' WHERE '+cnd;
			return this;
		}
		public ISelectWhereQuery where_x(String fieldName, Op operator, Object value){
			return where_x(new Field(fieldName).op(operator,value));
		}
		public ISelectWhereQuery where_x(String fieldName, String operator, Object value){
			return where_x(new Field(fieldName).op(operator,value));
		}

		public ISelectGroupByQuery groupBy(String groupByField){
			return groupBy(new List<String>{groupByField},null);
		}
		public ISelectGroupByQuery groupBy(List<String> groupByFields){
			return groupBy(groupByFields,null);
		}
		public ISelectGroupByQuery groupBy(String groupByField, IHavingCondition havingCtr){
			return groupBy(new List<String>{groupByField},havingCtr);
		}
		public ISelectGroupByQuery groupBy(List<String> groupByFields, IHavingCondition havingCtr){
			this.soqlQuery+=' GROUP BY '+String.join(groupByFields, ',');
			if(havingCtr!=null)
				this.soqlQuery+=' HAVING '+havingCtr;
			return this;
		}

		public ISelectOrderByQuery orderBy(String orderByField){
			return orderBy(new List<String>{orderByField},null);
		}
		public ISelectOrderByQuery orderBy(List<String> orderByFields){
			return orderBy(orderByFields,null);
		}
		public ISelectOrderByQuery orderBy(String orderByField, OrderType orderType){
			return orderBy(new List<String>{orderByField},orderType);
		}
		public ISelectOrderByQuery orderBy(List<String> orderByFields, OrderType orderType){
			this.soqlQuery+=' ORDER BY '+String.join(orderByFields,',');
			if(orderType != null)
				this.soqlQuery+=orderType;
			return this;
		}
		public ISelectOrderByQuery addOrder(String orderByField){
			return addOrder(new List<String>{orderByField},null);
		}
		public ISelectOrderByQuery addOrder(List<String> orderByFields){
			return addOrder(orderByFields,null);
		}
		public ISelectOrderByQuery addOrder(String orderByField, OrderType orderType){
			return addOrder(new List<String>{orderByField},orderType);
		}
		public ISelectOrderByQuery addOrder(List<String> orderByFields, OrderType orderType){
			this.soqlQuery+=' '+String.join(orderByFields,',');
			if(orderType != null)
				this.soqlQuery+=orderType;
			return this;
		}

		public ISelectLimitQuery limitTo(Integer lmt){
			this.soqlQuery+=' LIMIT '+lmt;
			return this;
		}

		public ISelectOffsetQuery offset(Integer ofst){
			this.soqlQuery+=' OFFSET '+ofst;
			return this;
		}

		public override String toString(){
			return soqlQuery;
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