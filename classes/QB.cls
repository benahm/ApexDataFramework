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
	private static Object bindVariable;
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

	public static Regex regex(String ptrn){
		return new Regex(ptrn);
	}

	/**
	* @description wrap a field
	* @param name : field name
	* @return Field
	*/
	public static IFieldWrap field(String name){
		return new Wrapper(name);
	}	

	/**
	* @description field expression
	* @param name : field name
	* @param operator : the comparator operator
	* @return Field
	*/
	public static IFieldCondition fieldExpr(String name, Op operator, Object value){
		return new Wrapper(name).op(operator,value);
	}
	public static IFieldCondition fieldExpr(String name, String operator, Object value){
		return new Wrapper(name).op(operator,value);
	}

	public static BindType bind(Object bindVarValue){
		if(bindVariable != null)
			throw new QBBindException('Error only one bind variable is allowed');

		bindVariable=bindVarValue;
		return new BindType('bindVariable');
	}

	/**
	* @description SOQL aggregate functions
	* @param fieldName 
	* @return IAggregateFunctionWrap
	*/
	public static IAggregateFunctionWrap count(){
		return new Wrapper(null,'COUNT');
	}
	public static IAggregateFunctionWrap count(String fieldName){
		return new Wrapper(fieldName,'COUNT');
	}
	public static IAggregateFunctionWrap count_distinct(String fieldName){
		return new Wrapper(fieldName,'COUNT_DISTINCT');
	}
	public static IAggregateFunctionWrap avg(String fieldName){
		return new Wrapper(fieldName,'AVG');
	}
	public static IAggregateFunctionWrap min(String fieldName){
		return new Wrapper(fieldName,'MIN');
	}
	public static IAggregateFunctionWrap max(String fieldName){
		return new Wrapper(fieldName,'MAX');
	}
	public static IAggregateFunctionWrap sum(String fieldName){
		return new Wrapper(fieldName,'SUM');
	}

	/**
	* @description ToLabel function
	* @param fieldName 
	* @return ITranslateFunctionWrap
	*/
	public static ITranslateFunctionWrap toLabel(String fieldName){
		return new Wrapper(fieldName,'TOLABEL');
	}

	/**
	* @description select clause
	* @return ISelectClause
	*/	
	public static ISelectFieldsClause select_x(Regex rgx){
		return new SelectClause(rgx);
	}
	public static ISelectFieldsClause select_x(String fieldName){
		return new SelectClause(fieldName);
	}
	public static ISelectFieldsClause select_x(Schema.SObjectField field){
		return new SelectClause(field.getDescribe().getName());
	}
	public static ISelectFieldsClause select_x(List<String> fieldNames){
		return new SelectClause(fieldNames);
	}
	public static ISelectAggregateClause select_x(IAggregateFunctionWrap aggrFunc){
		return new SelectClause(aggrFunc);
	}

	/**
	* @description order type for the Order By
	* @return OrderType
	*/	
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

	/* Date Literals */
	private static final String YESTERDAY='YESTERDAY';
	private static final String TODAY='TODAY';
	private static final String TOMORROW='TOMORROW';
	private static final String LAST_WEEK='LAST_WEEK';
	private static final String THIS_WEEK='THIS_WEEK';
	private static final String NEXT_WEEK='NEXT_WEEK';
	private static final String LAST_MONTH='LAST_MONTH';
	private static final String THIS_MONTH='THIS_MONTH';
	private static final String NEXT_MONTH='NEXT_MONTH';
	private static final String LAST_90_DAYS='LAST_90_DAYS';
	private static final String NEXT_90_DAYS='NEXT_90_DAYS';
	private static String LAST_N_DAYS(Integer n){ return 'LAST_N_DAYS'+':'+n; }
	private static String NEXT_N_DAYS(Integer n){ return 'NEXT_N_DAYS'+':'+n; }
	private static String NEXT_N_WEEKS(Integer n){ return 'NEXT_N_WEEKS'+':'+n; }
	private static String LAST_N_WEEKS(Integer n){ return 'LAST_N_WEEKS'+':'+n; }
	private static String NEXT_N_MONTHS(Integer n){ return 'NEXT_N_MONTHS'+':'+n; }
	private static String LAST_N_MONTHS(Integer n){ return 'LAST_N_MONTHS'+':'+n; }
	private static final String THIS_QUARTER='THIS_QUARTER';
	private static final String NEXT_QUARTER='NEXT_QUARTER';
	/* ... */

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
	* @description Select clause interfaces
	*/
	public interface ISelectClause{
		String toString();
	}
	public interface ISelectFieldsClause extends ISelectClause{ 
		ISelectFieldsClause addField(String fieldName);
		ISelectFieldsClause addFields(List<String> fieldNames);
		ISelectFieldsClause addFunction(ITranslateFunctionWrap dateFunc);
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
	* @description ACondition : Abstract class for a single condition
	*/
	public abstract class ACondition implements IFieldCondition,IHavingCondition{}

	/**
	* @description NotCondition : NOT applied to a condition
	*/
	public class NotCondition extends ACondition {
		private ICondition cnd;

		public NotCondition(ICondition cnd){
			this.cnd=cnd;
		}

		public override String toString(){
			return 'NOT ('+cnd+')';
		}
	}

	/**
	* @description AMultiCondition : Abstract class for conditions that can be
	* 			      applied to multiple conditions
	*/
	public abstract class AMultiCondition implements IFieldMultiCondition,IHavingMultiCondition {
		protected abstract String getOperator();
		protected abstract List<ICondition> getListConditions();

		public AMultiCondition add(ICondition cnd){
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
	public class AndCondition extends AMultiCondition {
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
	public class OrCondition extends AMultiCondition {
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

	public interface IWrapper{}

	public interface IFieldWrap extends IWrapper{
		IFieldCondition eq(Object value);
		IFieldCondition equal(Object value);
		IFieldCondition ne(Object value);
		IFieldCondition notEqual(Object value);
		IFieldCondition gt(Object value);
		IFieldCondition greaterThan(Object value);
		IFieldCondition lt(Object value);
		IFieldCondition lessThan(Object value);
		IFieldCondition ge(Object value);
		IFieldCondition greaterOrEqual(Object value);
		IFieldCondition le(Object value);
		IFieldCondition lessOrEqual(Object value);
		IFieldCondition lk(Object value);
		IFieldCondition isLike(Object value);
	}

	public interface IAggregateFunctionWrap extends IWrapper{
		IHavingCondition eq(Integer value);
		IHavingCondition equal(Integer value);
		IHavingCondition ne(Integer value);
		IHavingCondition notEqual(Integer value);
		IHavingCondition gt(Integer value);
		IHavingCondition greaterThan(Integer value);
		IHavingCondition lt(Integer value);
		IHavingCondition lessThan(Integer value);
		IHavingCondition ge(Integer value);
		IHavingCondition greaterOrEqual(Integer value);
		IHavingCondition le(Integer value);
		IHavingCondition lessOrEqual(Integer value);
	}

	public interface ITranslateFunctionWrap extends IWrapper{
		IFieldCondition eq(String value);
		IFieldCondition equal(String value);
		IFieldCondition ne(String value);
		IFieldCondition notEqual(String value);
		IFieldCondition gt(String value);
		IFieldCondition greaterThan(String value);
		IFieldCondition lt(String value);
		IFieldCondition lessThan(String value);
		IFieldCondition ge(String value);
		IFieldCondition greaterOrEqual(String value);
		IFieldCondition le(String value);
		IFieldCondition lessOrEqual(String value);
		IFieldCondition lk(String value);
		IFieldCondition isLike(String value);
	}

	public abstract class AWrapper implements IFieldWrap,IAggregateFunctionWrap,ITranslateFunctionWrap {} 

	/**
	* @description Wrapper : field wrapper
	*/
	public class Wrapper extends AWrapper{
		private final String fieldName;
		private final String functionName;

		public Wrapper(String fieldName){
			this.fieldName=fieldName;
		}

		public Wrapper(String fieldName, String functionName){
			this.fieldName=fieldName;
			this.functionName=functionName;
		}

		private ACondition handleOperator(Op operator,Object value){
			return new Condition(this,operator,value);
		}
		private ACondition handleOperator(String operator,Object value){
			return new Condition(this,operator,value);
		}

		public ACondition op(Op operator, Object value){
			return handleOperator(operator,value);
		}
		public ACondition op(String operator, Object value){
			return handleOperator(operator,value);
		}

		// equal to
		public ACondition eq(Object value){
			return handleOperator(Op.EQ,value);
		}
		public ACondition equal(Object value){
			return eq(value);
		}
		// not equal to
		public ACondition ne(Object value){
			return handleOperator(Op.NE,value);	
		}
		public ACondition notEqual(Object value){
			return ne(value);
		}
		// greater than
		public ACondition gt(Object value){
			return handleOperator(Op.GT,value);
		}
		public ACondition greaterThan(Object value){
			return gt(value);
		}
		// less than
		public ACondition lt(Object value){
			return handleOperator(Op.LT,value);
		}
		public ACondition lessThan(Object value){
			return lt(value);
		}
		// greater than or equal to
		public ACondition ge(Object value){
			return handleOperator(Op.GE,value);
		}
		public ACondition greaterOrEqual(Object value){
			return ge(value);
		}
		// less than or equal to
		public ACondition le(Object value){
			return handleOperator(Op.LE,value);
		}
		public ACondition lessOrEqual(Object value){
			return le(value);
		}
		// like 
		public ACondition lk(Object value){
			return handleOperator(Op.LK,value);
		}
		public ACondition isLike(Object value){
			return lk(value);
		}

		public override String toString(){
			if(fieldName!=null && functionName!=null){
				return functionName+'('+fieldName+')';
			} else if(functionName!=null){
				return functionName+'()';
			} else if(functionName==null){
				return fieldName;
			} 

			System.debug('Throw Error');
			return null;
		}
	}


	/**
	* @description Condition : field condition
	*/
	public class Condition extends ACondition {
		private final Wrapper cmpble;
		private final String operator;
		private final String values;

		public Condition(Wrapper cmpble,Op operator,Object value){
			this(cmpble,util.operatorToString(operator),value);
		}
		public Condition(Wrapper cmpble,String operator,Object value){
			this.cmpble=cmpble;
			this.operator=operator.trim();
			this.values=parseValue(value);
		}

		private String parseValue(Object value){
			if(value == null) return 'NULL';
			// TODO Handle Date/DateTime
			if(util.isNumberOrBoolean(value)){
				return value+'';
			} else if(value instanceof String){
				return singleQuote+String.escapeSingleQuotes(value+'')+singleQuote;
			} else if(value instanceof bindType){
				return value+'';
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
					return cmpble+' IN '+values;
				} else if(this.operator == '!='){ // NOT EQUAL
					return cmpble+' NOT IN '+values;
				} else {
					throw new QBConditionException(errMsg.operatorDoNotHandleMultiValues);
				}
			}

			// Single value
			if(util.isValidFieldConditionOperator(operator))
				return cmpble+' '+operator+' '+values;
			else 
				throw new QBConditionException(errMsg.unkownOperator);
		}
	}

	/**
	* @description Query : a valid query
	*/
	public abstract class Query implements IQuery {

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
		private final Regex rgx;

		public SelectClause(Regex rgx){
			this.rgx=rgx;
			this.soqlQuery='SELECT ';
		}
		public SelectClause(String fieldName){
			this(new List<String>{fieldName});
		}
		public SelectClause(List<String> fieldNames){
			this.soqlQuery='SELECT ';
			if(!fieldNames.isEmpty()) 
				this.soqlQuery+=String.join(fieldNames,',');
		}
		public SelectClause(IAggregateFunctionWrap aggrFunc){
			this.soqlQuery='SELECT '+aggrFunc;
		}
		
		public ISelectFieldsClause addField(String fieldName){
			this.soqlQuery+=','+fieldName;
			return this;
		}
		public ISelectFieldsClause addFields(List<String> fieldNames){
			this.soqlQuery+=','+String.join(fieldNames,',');
			return this;
		}

		public ISelectFieldsClause addFunction(ITranslateFunctionWrap transFunc){
			this.soqlQuery+=','+transFunc;
			return this;
		}

		public ISelectFieldsClause addSubQuery(IQuery query){
			soqlQuery+=','+'('+query+')';
			return this;
		}

		public ISelectFromQuery from_x(String sObjectName){
			if(rgx != null)
				this.soqlQuery+=String.join(rgx.getMatches(util.getListFieldNamesFor(sObjectName)),',');
			return new SelectQuery(sObjectName,this.soqlQuery);
		}
		public ISelectFromQuery from_x(Schema.sObjectType sObjectType){
			return from_x(sObjectType.getDescribe().getName());
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

		public SelectQuery(String sObjectName, String soqlSelectClause, String selectType){
			this.soqlQuery=soqlSelectClause+' FROM '+sObjectName;
		}

		public ISelectWhereQuery where_x(IFieldCondition cnd){
			this.soqlQuery+=' WHERE '+cnd;
			return this;
		}
		public ISelectWhereQuery where_x(String fieldName, Op operator, Object value){
			return where_x(new Wrapper(fieldName).op(operator,value));
		}
		public ISelectWhereQuery where_x(String fieldName, String operator, Object value){
			return where_x(new Wrapper(fieldName).op(operator,value));
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
	
	public class Regex{
		private final String ptrn;

		public Regex(String ptrn){
			this.ptrn=ptrn;
		}

		public List<String> getMatches(List<String> inList){
			List<String> outList = new List<String>();
			
			for (String elem : inList) {
				if(Pattern.matches(ptrn.toUpperCase(),elem.toUpperCase()))
			    	outList.add(elem);
			}
			return outList;
		}
	}

	/**
	* @description BindType : defines the type of the order
	*/
	public class BindType {
		private final Object bindVarName;

		public BindType(Object bindVarName){
			this.bindVarName=bindVarName;
		}

		public override String toString(){
			return ':'+bindVarName;
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

		public Boolean isPattern(String fieldName){
			return Pattern.matches('.*(\\+|\\?|\\*)+.*', fieldName);
		}

		public List<String> getListFieldNamesFor(String sObjectName){
			Schema.SObjectType sObjectType = globalSchemaMap.get(sObjectName);
			Map <String, Schema.SObjectField> fieldMap = sObjectType.getDescribe().fields.getMap();
			List<String> fieldNames = new List<String>();
			for (Schema.SObjectField sfield : fieldMap.Values()) {
			    fieldNames.add(sfield.getDescribe().getname());
			}
			return fieldNames;
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
	public class QBBindException extends Exception {}

}