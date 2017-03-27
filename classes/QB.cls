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
	private static final List<String> standardIncludedFields=new List<String>{'Id'};
	private static final Util util=new Util();
	private static final ErrorMessage errMsg=new ErrorMessage();
	private static Object qbBindVariable;
	public enum Op {EQ, EQUAL,
			NE, NOTEQUAL,
			GT, GREATERTHAN,
			LT, LESSTHAN,
			GE, GREATEROREQUAL,
			LE, LESSOREQUAL,
			LK, ISLIKE}

	private static final Map <String, Schema.SObjectType> globalSchemaMap;

	private QB(){}

	static {
	    globalSchemaMap = Schema.getGlobalDescribe();
	}

	/* Date literals */
	public static final DateLiteral YESTERDAY=new DateLiteral('YESTERDAY');
	public static final DateLiteral TODAY=new DateLiteral('TODAY');
	public static final DateLiteral TOMORROW=new DateLiteral('TOMORROW');
	public static final DateLiteral LAST_WEEK=new DateLiteral('LAST_WEEK');
	public static final DateLiteral THIS_WEEK=new DateLiteral('THIS_WEEK');
	public static final DateLiteral NEXT_WEEK=new DateLiteral('NEXT_WEEK');
	public static final DateLiteral LAST_MONTH=new DateLiteral('LAST_MONTH');
	public static final DateLiteral THIS_MONTH=new DateLiteral('THIS_MONTH');
	public static final DateLiteral NEXT_MONTH=new DateLiteral('NEXT_MONTH');
	public static final DateLiteral LAST_90_DAYS=new DateLiteral('LAST_90_DAYS');
	public static final DateLiteral NEXT_90_DAYS=new DateLiteral('NEXT_90_DAYS');
	public static DateLiteral LAST_N_DAYS(Integer n){ return new DateLiteral('LAST_N_DAYS'+':'+n); }
	public static DateLiteral NEXT_N_DAYS(Integer n){ return new DateLiteral('NEXT_N_DAYS'+':'+n); }
	public static DateLiteral NEXT_N_WEEKS(Integer n){ return new DateLiteral('NEXT_N_WEEKS'+':'+n); }
	public static DateLiteral LAST_N_WEEKS(Integer n){ return new DateLiteral('LAST_N_WEEKS'+':'+n); }
	public static DateLiteral NEXT_N_MONTHS(Integer n){ return new DateLiteral('NEXT_N_MONTHS'+':'+n); }
	public static DateLiteral LAST_N_MONTHS(Integer n){ return new DateLiteral('LAST_N_MONTHS'+':'+n); }
	public static final DateLiteral THIS_QUARTER=new DateLiteral('THIS_QUARTER');
	public static final DateLiteral LAST_QUARTER=new DateLiteral('LAST_QUARTER');
	public static final DateLiteral NEXT_QUARTER=new DateLiteral('NEXT_QUARTER');
	public static DateLiteral NEXT_N_QUARTERS(Integer n){ return new DateLiteral('NEXT_N_QUARTERS'+':'+n); }
	public static DateLiteral LAST_N_QUARTERS(Integer n){ return new DateLiteral('LAST_N_QUARTERS'+':'+n); }
	public static final DateLiteral THIS_YEAR=new DateLiteral('THIS_YEAR');
	public static final DateLiteral LAST_YEAR=new DateLiteral('LAST_YEAR');
	public static final DateLiteral NEXT_YEAR=new DateLiteral('NEXT_YEAR');
	public static DateLiteral NEXT_N_YEARS(Integer n){ return new DateLiteral('NEXT_N_YEARS'+':'+n); }
	public static DateLiteral LAST_N_YEARS(Integer n){ return new DateLiteral('LAST_N_YEARS'+':'+n); }
	public static final DateLiteral THIS_FISCAL_QUARTER=new DateLiteral('THIS_FISCAL_QUARTER');
	public static final DateLiteral LAST_FISCAL_QUARTER=new DateLiteral('LAST_FISCAL_QUARTER');
	public static final DateLiteral NEXT_FISCAL_QUARTER=new DateLiteral('NEXT_FISCAL_QUARTER');
	public static DateLiteral NEXT_N_FISCAL_QUARTERS(Integer n){ return new DateLiteral('NEXT_N_FISCAL_QUARTERS'+':'+n); }
	public static DateLiteral LAST_N_FISCAL_QUARTERS(Integer n){ return new DateLiteral('LAST_N_FISCAL_QUARTERS'+':'+n); }
	public static final DateLiteral THIS_FISCAL_YEAR=new DateLiteral('THIS_FISCAL_YEAR');
	public static final DateLiteral LAST_FISCAL_YEAR=new DateLiteral('LAST_FISCAL_YEAR');
	public static final DateLiteral NEXT_FISCAL_YEAR=new DateLiteral('NEXT_FISCAL_YEAR');
	public static DateLiteral LAST_N_FISCAL_YEARS(Integer n){ return new DateLiteral('LAST_N_FISCAL_YEARS'+':'+n); }

	/**
	* @description Apply the logical operator NOT to a condition
	* @param cnd : Condition
	* @return IFieldCondition 
	*/
	public static IFieldCondition not_x(IFieldCondition cnd){
		return new NotCondition(cnd) ;
	}
	public static IHavingCondition not_x(IHavingCondition cnd){
		return new NotCondition(cnd) ;
	}


	/**
	* @description Apply the logical operator AND to two conditions
	* @param cnd1 : the first condition
	* @param cnd2 : the second condition
	* @return IFieldMultiCondition
	*/
	public static IFieldMultiCondition and_x(IFieldCondition cnd1, IFieldCondition cnd2){
		return new AndCondition(cnd1,cnd2);
	}
	public static IHavingMultiCondition and_x(IHavingCondition cnd1, IHavingCondition cnd2){
		return new AndCondition(cnd1,cnd2);
	}

	/**
	* @description Apply the logical operator OR to two conditions
	* @param cnd1 : the first condition
	* @param cnd2 : the second condition
	* @return IFieldMultiCondition
	*/
	public static IFieldMultiCondition or_x(IFieldCondition cnd1, IFieldCondition cnd2){
		return new OrCondition(cnd1,cnd2);
	}
	public static IHavingMultiCondition or_x(IHavingCondition cnd1, IHavingCondition cnd2){
		return new OrCondition(cnd1,cnd2);
	}

	/**
	* @description Wrap a field
	* @param name : field name
	* @return IFieldWrap
	*/
	public static IFieldWrap field(String name){
		return new Wrapper(name);
	}	

	/**
	* @description Field expression
	* @param name : field name
	* @param operator : operator
	* @return IFieldCondition
	*/
	public static IFieldCondition fieldExpr(String name, Op operator, Object value){
		return new Wrapper(name).op(operator,value);
	}
	public static IFieldCondition fieldExpr(String name, String operator, Object value){
		return new Wrapper(name).op(operator,value);
	}

	/**
	* @description Bind a variable
	* @return BindType
	*/
	public static BindType bind(Object bindVarValue){
		if(qbBindVariable != null)
			throw new QBBindException(errMsg.maxBindVariable);

		qbBindVariable=bindVarValue;
		return new BindType('qbBindVariable');
	}

	/**
	* @description SOQL aggregate functions
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
	* @description SOQL date functions
	* @return IDateFunctionWrap
	*/
	public static IDateFunctionWrap calendar_month(String fieldName){
		return new Wrapper(fieldName,'CALENDAR_MONTH');
	}
	public static IDateFunctionWrap calendar_quarter(String fieldName){
		return new Wrapper(fieldName,'CALENDAR_QUARTER');
	}
	public static IDateFunctionWrap calendar_year(String fieldName){
		return new Wrapper(fieldName,'CALENDAR_YEAR');
	}
	public static IDateFunctionWrap day_in_month(String fieldName){
		return new Wrapper(fieldName,'DAY_IN_MONTH');
	}
	public static IDateFunctionWrap day_in_week(String fieldName){
		return new Wrapper(fieldName,'DAY_IN_WEEK');
	}
	public static IDateFunctionWrap fiscal_month(String fieldName){
		return new Wrapper(fieldName,'FISCAL_MONTH');
	}
	public static IDateFunctionWrap fiscal_quarter(String fieldName){
		return new Wrapper(fieldName,'FISCAL_QUARTER');
	}
	public static IDateFunctionWrap fiscal_year(String fieldName){
		return new Wrapper(fieldName,'FISCAL_YEAR');
	}
	public static IDateFunctionWrap hour_in_day(String fieldName){
		return new Wrapper(fieldName,'HOUR_IN_DAY');
	}
	public static IDateFunctionWrap week_in_month(String fieldName){
		return new Wrapper(fieldName,'WEEK_IN_MONTH');
	}
	public static IDateFunctionWrap week_in_year(String fieldName){
		return new Wrapper(fieldName,'WEEK_IN_YEAR');
	}

	/**
	* @description Day_only function
	* @return IDayOnlyFunctionWrap
	*/
	public static IDayOnlyFunctionWrap day_only(String fieldName){
		return new Wrapper(fieldName,'DAY_ONLY');
	}

	/**
	* @description ToLabel function
	* @return IToLabelFunctionWrap
	*/
	public static IToLabelFunctionWrap toLabel(String fieldName){
		return new Wrapper(fieldName,'TOLABEL');
	}

	/**
	* @description Select clause
	* @return ISelectClause
	*/	
	public static ISelectClause select_x(){
		return new SelectClause('Id');
	}
	public static ISelectClause select_x(String fieldName){
		return new SelectClause(fieldName);
	}
	public static ISelectClause select_x(Schema.SObjectField field){
		return new SelectClause(field.getDescribe().getName());
	}
	public static ISelectClause select_x(List<String> fieldNames){
		return new SelectClause(fieldNames);
	}
	public static ISelectClause select_x(IFunctionWrap func){
		return new SelectClause(func);
	}

	/**
	* @description Order type for an Order By
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

	/* private methods */
	private static void clearBindVariables(){
		qbBindVariable=null;
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
	* @description Select clause interfaces
	*/
	public interface ISelectClause{
		ISelectClause addField(String fieldName);
		ISelectClause addFields(List<String> fieldNames);
		ISelectClause addFunction(IFunctionWrap func);
		ISelectClause addSubQuery(IQuery query);
		ISelectFromQuery from_x(String sObjectName);
		ISelectFromQuery from_x(Schema.sObjectType sObjectType); 
		String toString();
	}

	/**
	* @description Select query interfaces
	*/
	public interface IQuery{
		List<SObject> getList();
		Map<Id, SObject> getMap();
		Integer getCount();
		String toString();
	}
	public interface ISelectFromQuery extends IQuery{
		ISelectWhereQuery where_x(IFieldCondition cnd);
		ISelectWhereQuery where_x(String fieldName, Op operator, Object value);
		ISelectWhereQuery where_x(String fieldName, String operator, Object value);

		ISelectGroupByQuery groupBy(String groupByField);
		ISelectGroupByQuery groupBy(IDateFunctionWrap groupByFunc);
		ISelectGroupByQuery groupBy(IDayOnlyFunctionWrap groupByFunc);
		ISelectGroupByQuery groupBy(List<String> groupByFields);
		ISelectGroupByQuery groupBy(String groupByField, IHavingCondition havingCtr);
		ISelectGroupByQuery groupBy(IDateFunctionWrap groupByFunc, IHavingCondition havingCtr);
		ISelectGroupByQuery groupBy(IDayOnlyFunctionWrap groupByFunc, IHavingCondition havingCtr);
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
		ISelectGroupByQuery groupBy(IDateFunctionWrap groupByFunc);
		ISelectGroupByQuery groupBy(IDayOnlyFunctionWrap groupByFunc);
		ISelectGroupByQuery groupBy(List<String> groupByFields);
		ISelectGroupByQuery groupBy(String groupByField, IHavingCondition havingCtr);
		ISelectGroupByQuery groupBy(IDateFunctionWrap groupByFunc, IHavingCondition havingCtr);
		ISelectGroupByQuery groupBy(IDayOnlyFunctionWrap groupByFunc, IHavingCondition havingCtr);
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

	/**
	* @description Wrapper interfaces
	*/
	public interface IWrapper{
		String toString();
	}
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
	public interface IFunctionWrap extends IWrapper{}
	public interface IAggregateFunctionWrap extends IFunctionWrap{
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
		IAliasAggregateFunctionWrap alias(String alias);
	}
	public interface IAliasAggregateFunctionWrap extends IFunctionWrap{}
	public interface IDateFunctionWrap extends IFunctionWrap{
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
		IAliasDateFunctionWrap alias(String alias);
	}
	public interface IAliasDateFunctionWrap extends IFunctionWrap{}
	public interface IDayOnlyFunctionWrap extends IFunctionWrap{
		IHavingCondition eq(Date value);
		IHavingCondition equal(Date value);
		IHavingCondition ne(Date value);
		IHavingCondition notEqual(Date value);
		IHavingCondition gt(Date value);
		IHavingCondition greaterThan(Date value);
		IHavingCondition lt(Date value);
		IHavingCondition lessThan(Date value);
		IHavingCondition ge(Date value);
		IHavingCondition greaterOrEqual(Date value);
		IHavingCondition le(Date value);
		IHavingCondition lessOrEqual(Date value);
		IHavingCondition eq(DateLiteral value);
		IHavingCondition equal(DateLiteral value);
		IHavingCondition ne(DateLiteral value);
		IHavingCondition notEqual(DateLiteral value);
		IHavingCondition gt(DateLiteral value);
		IHavingCondition greaterThan(DateLiteral value);
		IHavingCondition lt(DateLiteral value);
		IHavingCondition lessThan(DateLiteral value);
		IHavingCondition ge(DateLiteral value);
		IHavingCondition greaterOrEqual(DateLiteral value);
		IHavingCondition le(DateLiteral value);
		IHavingCondition lessOrEqual(DateLiteral value);
		IAliasDayOnlyFunctionWrap alias(String alias);
	}
	public interface IAliasDayOnlyFunctionWrap extends IFunctionWrap{}
	public interface IToLabelFunctionWrap extends IFunctionWrap{
		IFieldCondition eq(String value);
		IFieldCondition equal(String value);
		IFieldCondition ne(String value);
		IFieldCondition notEqual(String value);
		IFieldCondition lk(String value);
		IFieldCondition isLike(String value);
	}
	public interface IFormatFunctionWrap extends IFunctionWrap{}

	/****************************************************************************************/
	/*					Classes						*/
	/****************************************************************************************/
	/**
	* @description ACondition : Abstract class for a single condition
	*/
	private abstract class ACondition implements IFieldCondition,IHavingCondition{}

	/**
	* @description NotCondition : NOT applied to a condition
	*/
	private class NotCondition extends ACondition {
		private String sCondition;

		public NotCondition(ICondition cnd){
			this.sCondition='NOT'+' '+'('+cnd+')';
		}

		public override String toString(){
			return sCondition;
		}
	}

	/**
	* @description AMultiCondition : Abstract class for conditions that can be
	* 			      applied to multiple conditions
	*/
	private abstract class AMultiCondition implements IFieldMultiCondition,IHavingMultiCondition {
		protected String sCondition;

		protected abstract String getOperator();

		public AMultiCondition(ICondition cnd1, ICondition cnd2){
			this.sCondition='('+cnd1+')'+' '+getOperator()+' '+'('+cnd2+')';
		}

		public AMultiCondition add(ICondition cnd){
			this.sCondition+=' '+getOperator()+' '+'('+cnd+')';
			return this;
		}

		public override String toString(){
			return sCondition;
		}
	}

	/**
	* @description AndCondition : AND applied to multiple conditions
	*/
	private class AndCondition extends AMultiCondition {
		private final String operator = 'AND';

		public AndCondition(ICondition cnd1, ICondition cnd2){
			super(cnd1,cnd2);
		}

		public override String getOperator(){
			return operator;
		}
	}

	/**
	* @description AndCondition : OR applied to multiple conditions
	*/
	private class OrCondition extends AMultiCondition {
		private final String operator = 'OR';

		public OrCondition(ICondition cnd1, ICondition cnd2){
			super(cnd1,cnd2);
		}

		public override String getOperator(){
			return operator;
		}
	}
	
	/**
	* @description AWrapper : Abstract class for the wrapper 
	*/
	private abstract class AWrapper implements IFieldWrap,IAggregateFunctionWrap,IDateFunctionWrap,IDayOnlyFunctionWrap,IToLabelFunctionWrap,IFormatFunctionWrap,
											  IAliasAggregateFunctionWrap,IAliasDateFunctionWrap,IAliasDayOnlyFunctionWrap{} 

	/**
	* @description Wrapper : field or function wrapper
	*/
	private class Wrapper extends AWrapper{
		private String sWrap;

		public Wrapper(String fieldName){
			this.sWrap=fieldName;
		}
		public Wrapper(String fieldName, String functionName){
			this.sWrap=functionName+'('+util.ifNull(fieldName,'')+')';
		}

		private ACondition op(Op operator, Object value){
			return new Condition(this,operator,value);
		}
		private ACondition op(String operator, Object value){
			return new Condition(this,operator,value);
		}

		// equal to
		public ACondition eq(Object value){
			return op(Op.EQ,value);
		}
		public ACondition equal(Object value){
			return eq(value);
		}
		// not equal to
		public ACondition ne(Object value){
			return op(Op.NE,value);	
		}
		public ACondition notEqual(Object value){
			return ne(value);
		}
		// greater than
		public ACondition gt(Object value){
			return op(Op.GT,value);
		}
		public ACondition greaterThan(Object value){
			return gt(value);
		}
		// less than
		public ACondition lt(Object value){
			return op(Op.LT,value);
		}
		public ACondition lessThan(Object value){
			return lt(value);
		}
		// greater than or equal to
		public ACondition ge(Object value){
			return op(Op.GE,value);
		}
		public ACondition greaterOrEqual(Object value){
			return ge(value);
		}
		// less than or equal to
		public ACondition le(Object value){
			return op(Op.LE,value);
		}
		public ACondition lessOrEqual(Object value){
			return le(value);
		}
		// like 
		public ACondition lk(Object value){
			return op(Op.LK,value);
		}
		public ACondition isLike(Object value){
			return lk(value);
		}

		public Wrapper alias(String alias){
			this.sWrap+=' '+alias;
			return this;
		}

		public override String toString(){
			return sWrap;
		}
	}

	/**
	* @description Condition : wrap condition
	*/
	private class Condition extends ACondition { 
		private String sCondition;

		public Condition(Wrapper wrp,Op op,Object val){
			this(wrp,util.operatorToString(op),val);
		}
		public Condition(Wrapper wrp,String op,Object val){
			if(isList(val)){ // List value
				String listVal=parseListValue((List<Object>)val);
				if(op == '='){ // EQUAL
					this.sCondition=wrp+' IN '+listVal;
				} else if(op == '!='){ // NOT EQUAL
					this.sCondition=wrp+' NOT IN '+listVal;
				} else {
					throw new QBConditionException(errMsg.operatorDoNotHandleMultiValues);
				}
			}else { // One value
				String oneVal=parseOneValue(val);
				if(util.isValidFieldConditionOperator(op))
					this.sCondition=wrp+' '+op+' '+oneVal;
				else 
					throw new QBConditionException(errMsg.unkownOperator);
			}

		}

		private String parseListValue(List<Object> values){
			if(values.isEmpty()) 
				throw new QBConditionException(errMsg.emptyListAsValue);
			String result='';
			for(Object val:values){
				result+=parseOneValue(val)+',';
			}
			result=result.removeEnd(',');
			return '('+result+')';
		}

		private String parseOneValue(Object value){
			if(value == null) // null
				return 'NULL';
			if(util.isNumberOrBoolean(value)) // number or boolean
				return value+'';
			if(value instanceof Date) // date
				return String.valueOf((Date)value);
			if(value instanceof Datetime) // datetime
				return util.datetimeToUTC((Datetime)value);
			if(value instanceof String || value instanceof Id) // string or id
				return singleQuote+String.escapeSingleQuotes(value+'')+singleQuote;
			if(value instanceof BindType || value instanceof DateLiteral) // bindType or dateLiteral
				return value+'';
			throw new QBConditionException(errMsg.badValueType);
		}

		private Boolean isList(Object value){
			return value instanceof List<Object>;
		}

		public override String toString(){
			return sCondition;
		}
	}

	private abstract class ASelectClause implements ISelectClause{}

	/**
	* @description SelectClause : select clause
	*/
	private class SelectClause extends ASelectClause{
		private String sQuery;
		private final Regex rgx;

		private SelectClause(Regex rgx){
			this.rgx=rgx;
			this.sQuery='SELECT ';
		}
		public SelectClause(String fieldName){
			if(util.isPattern(fieldName)){
				this(new Regex(fieldName));
			}else{
				this(new List<String>{fieldName});
			}
		}
		public SelectClause(List<String> fieldNames){
			this.sQuery='SELECT ';
			if(!fieldNames.isEmpty()) 
				this.sQuery+=String.join(fieldNames,',');
		}
		public SelectClause(IFunctionWrap func){
			this.sQuery='SELECT '+func;
		}

		public ISelectClause addField(String fieldName){
			this.sQuery+=','+fieldName;
			return this;
		}
		public ISelectClause addFields(List<String> fieldNames){
			this.sQuery+=','+String.join(fieldNames,',');
			return this;
		}

		public ISelectClause addFunction(IFunctionWrap func){
			this.sQuery+=','+func;
			return this;
		}

		public ISelectClause addSubQuery(IQuery query){
			sQuery+=','+'('+query+')';
			return this;
		}

		public ISelectFromQuery from_x(String sObjectName){
			if(rgx != null)
				this.sQuery+=String.join(rgx.getMatches(util.getListFieldNamesFor(sObjectName)),',');
			return new SelectQuery(sObjectName,this.sQuery);
		}
		public ISelectFromQuery from_x(Schema.sObjectType sObjectType){
			return from_x(sObjectType.getDescribe().getName());
		}

		public override String toString(){
			return sQuery;
		}
	}

	private abstract class ASelectQuery implements ISelectFromQuery,ISelectWhereQuery,ISelectGroupByQuery,ISelectOrderByQuery,ISelectLimitQuery,ISelectOffsetQuery {

		public List<SObject> getList(){
			List<SObject> resultList=new List<SObject>(Database.query(toString()));
			clearBindVariables();
			return resultList;
		}

		public map<Id,SObject> getMap(){
			return new Map<Id,SObject>(getList());
		}

		public Integer getCount(){
			Integer resultCount=Database.countQuery(toString());
			clearBindVariables();
			return resultCount;

		}
	}

	/**
	* @description SelectQuery : select query without a where clause
	*/
	private class SelectQuery extends ASelectQuery {
		private String sQuery;

		public SelectQuery(String sObjectName, String soqlSelectClause){
			this.sQuery=soqlSelectClause+' FROM '+sObjectName;
		}

		public ISelectWhereQuery where_x(IFieldCondition cnd){
			if(cnd != null) this.sQuery+=' WHERE '+cnd;
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
		public ISelectGroupByQuery groupBy(IDateFunctionWrap groupByFunc){
			return groupBy(new List<String>{groupByFunc+''},null);
		}
		public ISelectGroupByQuery groupBy(IDayOnlyFunctionWrap groupByFunc){
			return groupBy(new List<String>{groupByFunc+''},null);
		}
		public ISelectGroupByQuery groupBy(List<String> groupByFields){
			return groupBy(groupByFields,null);
		}
		public ISelectGroupByQuery groupBy(String groupByField, IHavingCondition havingCtr){
			return groupBy(new List<String>{groupByField},havingCtr);
		}
		public ISelectGroupByQuery groupBy(IDateFunctionWrap groupByFunc, IHavingCondition havingCtr){
			return groupBy(new List<String>{groupByFunc+''},havingCtr);
		}
		public ISelectGroupByQuery groupBy(IDayOnlyFunctionWrap groupByFunc, IHavingCondition havingCtr){
			return groupBy(new List<String>{groupByFunc+''},havingCtr);
		}
		public ISelectGroupByQuery groupBy(List<String> groupByFields, IHavingCondition havingCtr){
			if(groupByFields != null) this.sQuery+=' GROUP BY '+String.join(groupByFields, ',');
			if(havingCtr!=null) this.sQuery+=' HAVING '+havingCtr;
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
			if(orderByFields != null) this.sQuery+=' ORDER BY '+String.join(orderByFields,',');
			if(orderType != null) this.sQuery+=orderType;
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
			if(orderByFields != null) this.sQuery+=', '+String.join(orderByFields,',');
			if(orderType != null) this.sQuery+=orderType;
			return this;
		}

		public ISelectLimitQuery limitTo(Integer lmt){
			if(lmt != null) this.sQuery+=' LIMIT '+lmt;
			return this;
		}

		public ISelectOffsetQuery offset(Integer ofst){
			if(ofst != null) this.sQuery+=' OFFSET '+ofst;
			return this;
		}

		public override String toString(){
			return sQuery;
		}
	}
	
	public class Regex{
		private final String ptrn;

		public Regex(String ptrn){
			this.ptrn=transform(ptrn);
		}

		private String transform(String ptrn){
			return ptrn.replaceAll('\\*', '.*')
					   .replaceAll('\\+', '.+')
					   .replaceAll('\\?', '.?');
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
	* @description DateLiteral : defines a date literal
	*/
	public class DateLiteral {
		private final String dateLiteral;

		public DateLiteral(String dateLiteral){
			this.dateLiteral=dateLiteral;
		}

		public override String toString(){
			return dateLiteral;
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

		public OrderType(String orderingType, String nullsHandlingType){
			this.orderingType=orderingType;
			this.nullsHandlingType=nullsHandlingType;
		}

		public override String toString(){
			return ' '+orderingType+' NULLS '+nullsHandlingType;
		}
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

		public Boolean isNumberOrBoolean(Object obj){
			return obj instanceof Integer 
					|| obj instanceof Double
					|| obj instanceof Long
					|| obj instanceof Decimal
					|| obj instanceof Boolean;
		}

		public Boolean isValidFieldConditionOperator(String operator){
			return operator == '=' 
					|| operator == '!='
					|| operator == '>'
					|| operator == '<'
					|| operator == '>='
					|| operator == '<='
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

		public String datetimeToUTC(Datetime dt){
			return dt.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ');
		}

		public String ifNull(String str1,String str2){
  			if(str1 == null )  return str2;
  			return str1;
  		}
	}

	/**
	* @description ErrorMessage : Class holding all the error messages
	*/
	private class ErrorMessage {
		public final String unkownOperator='Unkown Operator';
		public final String operatorDoNotHandleMultiValues='Only the operators EQUAL & NOTEQUAL can handle a list of values';
		public final String emptyListAsValue='Error Value is an Empty List';
		public final String badValueType='Error Bad Value Type';
		public final String maxBindVariable='Error max number of bind variables exceeded ';
	}

	// Exceptions
	public class QBQueryException extends Exception {}
	public class QBConditionException extends Exception {}
	public class QBBindException extends Exception {}

}