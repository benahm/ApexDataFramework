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
	private static Object bindVariable;
	public enum Op {EQ, EQUAL,
			NE, NOTEQUAL,
			GT, GREATERTHAN,
			LT, LESSTHAN,
			GE, GREATEROREQUAL,
			LE, LESSOREQUAL,
			LK, ISLIKE}

	/* Date literals */
	public static final String YESTERDAY='YESTERDAY';
	public static final String TODAY='TODAY';
	public static final String TOMORROW='TOMORROW';
	public static final String LAST_WEEK='LAST_WEEK';
	public static final String THIS_WEEK='THIS_WEEK';
	public static final String NEXT_WEEK='NEXT_WEEK';
	public static final String LAST_MONTH='LAST_MONTH';
	public static final String THIS_MONTH='THIS_MONTH';
	public static final String NEXT_MONTH='NEXT_MONTH';
	public static final String LAST_90_DAYS='LAST_90_DAYS';
	public static final String NEXT_90_DAYS='NEXT_90_DAYS';
	public static String LAST_N_DAYS(Integer n){ return 'LAST_N_DAYS'+':'+n; }
	public static String NEXT_N_DAYS(Integer n){ return 'NEXT_N_DAYS'+':'+n; }
	public static String NEXT_N_WEEKS(Integer n){ return 'NEXT_N_WEEKS'+':'+n; }
	public static String LAST_N_WEEKS(Integer n){ return 'LAST_N_WEEKS'+':'+n; }
	public static String NEXT_N_MONTHS(Integer n){ return 'NEXT_N_MONTHS'+':'+n; }
	public static String LAST_N_MONTHS(Integer n){ return 'LAST_N_MONTHS'+':'+n; }
	public static final String THIS_QUARTER='THIS_QUARTER';
	public static final String LAST_QUARTER='LAST_QUARTER';
	public static final String NEXT_QUARTER='NEXT_QUARTER';
	public static String NEXT_N_QUARTERS(Integer n){ return 'NEXT_N_QUARTERS'+':'+n; }
	public static String LAST_N_QUARTERS(Integer n){ return 'LAST_N_QUARTERS'+':'+n; }
	public static final String THIS_YEAR='THIS_YEAR';
	public static final String LAST_YEAR='LAST_YEAR';
	public static final String NEXT_YEAR='NEXT_YEAR';
	public static String NEXT_N_YEARS(Integer n){ return 'NEXT_N_YEARS'+':'+n; }
	public static String LAST_N_YEARS(Integer n){ return 'LAST_N_YEARS'+':'+n; }
	public static final String THIS_FISCAL_QUARTER='THIS_FISCAL_QUARTER';
	public static final String LAST_FISCAL_QUARTER='LAST_FISCAL_QUARTER';
	public static final String NEXT_FISCAL_QUARTER='NEXT_FISCAL_QUARTER';
	public static String NEXT_N_FISCAL_QUARTERS(Integer n){ return 'NEXT_N_FISCAL_QUARTERS'+':'+n; }
	public static String LAST_N_FISCAL_QUARTERS(Integer n){ return 'LAST_N_FISCAL_QUARTERS'+':'+n; }
	public static final String THIS_FISCAL_YEAR='THIS_FISCAL_YEAR';
	public static final String LAST_FISCAL_YEAR='LAST_FISCAL_YEAR';
	public static final String NEXT_FISCAL_YEAR='NEXT_FISCAL_YEAR';
	public static String LAST_N_FISCAL_YEARS(Integer n){ return 'LAST_N_FISCAL_YEARS'+':'+n; }

	private static final Map <String, Schema.SObjectType> globalSchemaMap;

	// class initialisation code
	static {
	    globalSchemaMap = Schema.getGlobalDescribe();
	}

	/**
	* @description apply the logical operator NOT to a condition
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
	* @description apply the logical operator AND to two conditions
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
	* @description apply the logical operator OR to two conditions
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
	* @description wrap a field
	* @param name : field name
	* @return IFieldWrap
	*/
	public static IFieldWrap field(String name){
		return new Wrapper(name);
	}	

	/**
	* @description field expression
	* @param name : field name
	* @param operator : the comparator operator
	* @return IFieldCondition
	*/
	public static IFieldCondition fieldExpr(String name, Op operator, Object value){
		return new Wrapper(name).op(operator,value);
	}
	public static IFieldCondition fieldExpr(String name, String operator, Object value){
		return new Wrapper(name).op(operator,value);
	}

	public static BindType bind(Object bindVarValue){
		if(bindVariable != null)
			throw new QBBindException(errMsg.maxBindVariable);

		bindVariable=bindVarValue;
		return new BindType('bindVariable');
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
	* @description ToLabel function
	* @return IDateOnlyFunctionWrap
	*/
	public static IDateOnlyFunctionWrap date_only(String fieldName){
		return new Wrapper(fieldName,'DATE_ONLY');
	}

	/**
	* @description ToLabel function
	* @return IToLabelFunctionWrap
	*/
	public static IToLabelFunctionWrap toLabel(String fieldName){
		return new Wrapper(fieldName,'TOLABEL');
	}

	/**
	* @description select clause
	* @return ISelectClause
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
		ISelectFieldsClause addFunction(IDateFunctionWrap dateFunc);
		ISelectFieldsClause addFunction(IDateOnlyFunctionWrap dateFunc);
		ISelectFieldsClause addFunction(IToLabelFunctionWrap dateFunc);
		ISelectFieldsClause addSubQuery(IQuery query);
		ISelectFromQuery from_x(String sObjectName);
		ISelectFromQuery from_x(Schema.sObjectType sObjectType); 
	}
	public interface ISelectAggregateClause extends ISelectClause{
		ISelectFieldsClause addField(String fieldName);
		ISelectFieldsClause addFields(List<String> fieldNames);
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
		ISelectGroupByQuery groupBy(IDateFunctionWrap groupByField);
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

	public interface IDateFunctionWrap extends IWrapper{
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

	public interface IDateOnlyFunctionWrap extends IWrapper{
		IFieldCondition eq(Date value);
		IFieldCondition equal(Date value);
		IFieldCondition ne(Date value);
		IFieldCondition notEqual(Date value);
		IFieldCondition gt(Date value);
		IFieldCondition greaterThan(Date value);
		IFieldCondition lt(Date value);
		IFieldCondition lessThan(Date value);
		IFieldCondition ge(Date value);
		IFieldCondition greaterOrEqual(Date value);
		IFieldCondition le(Date value);
		IFieldCondition lessOrEqual(Date value);
	}

	public interface IToLabelFunctionWrap extends IWrapper{
		IFieldCondition eq(String value);
		IFieldCondition equal(String value);
		IFieldCondition ne(String value);
		IFieldCondition notEqual(String value);
		IFieldCondition lk(String value);
		IFieldCondition isLike(String value);
	}

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
		private String sCondition;

		public NotCondition(ICondition cnd){
			this.sCondition=''+cnd;
		}

		public override String toString(){
			return 'NOT ('+sCondition+')';
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
	
	/**
	* @description AWrapper : Abstract class for the wrapper 
	*/
	public abstract class AWrapper implements IFieldWrap,IAggregateFunctionWrap,IDateFunctionWrap,IDateOnlyFunctionWrap,IToLabelFunctionWrap{} 

	/**
	* @description Wrapper : field or function wrapper
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

		public override String toString(){
			if(fieldName!=null && functionName!=null){
				return functionName+'('+fieldName+')';
			} else if(functionName!=null){
				return functionName+'()';
			} else if(functionName==null){
				return fieldName;
			} 
			throw new QBConditionException(errMsg.wrapperInputsNull);
		}
	}

	/**
	* @description Condition : field condition
	*/
	public class Condition extends ACondition {
		private final Wrapper wrp;
		private final String operator;
		private final String values;

		public Condition(Wrapper wrp,Op operator,Object value){
			this(wrp,util.operatorToString(operator),value);
		}
		public Condition(Wrapper wrp,String operator,Object value){
			this.wrp=wrp;
			this.operator=operator.trim();
			this.values=parseValue(value);
		}

		private String parseValue(Object value){
			if(value == null) return 'NULL';
			// TODO Handle DateTime
			if(util.isNumberOrBoolean(value)){
				return value+'';
			} else if(value instanceof Date){
				return singleQuote+String.valueOf((Date)value)+singleQuote;
			} else if(value instanceof String){
				return singleQuote+String.escapeSingleQuotes(value+'')+singleQuote;
			} else if(value instanceof bindType){
				return value+'';
			} else if(value instanceof List<String>){
				List<String> values=(List<String>)value;
				if(values.isEmpty()) 
					throw new QBConditionException(errMsg.emptyListAsValue);
				return '('+singleQuote+String.join(util.escapeSingleQuotes(values),singleQuote+','+singleQuote)+singleQuote+')';
			}else 
				throw new QBConditionException(errMsg.badValueType);
		}

		private Boolean isMultipeValues(String value){
			return value.startsWith('(') && value.endsWith(')');
		}

		public override String toString(){
			// Multiple values
			if(isMultipeValues(values)){
				if(operator == '='){ // EQUAL
					return wrp+' IN '+values;
				} else if(this.operator == '!='){ // NOT EQUAL
					return wrp+' NOT IN '+values;
				} else {
					throw new QBConditionException(errMsg.operatorDoNotHandleMultiValues);
				}
			}

			// Single value
			if(util.isValidFieldConditionOperator(operator))
				return wrp+' '+operator+' '+values;
			else 
				throw new QBConditionException(errMsg.unkownOperator);
		}
	}

	public abstract class ASelectClause implements ISelectFieldsClause,ISelectAggregateClause {}

	/**
	* @description SelectClause : select clause
	*/
	public class SelectClause extends ASelectClause{
		private String sQuery;
		private final Regex rgx;

		public SelectClause(Regex rgx){
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
		public SelectClause(IAggregateFunctionWrap aggrFunc){
			this.sQuery='SELECT '+aggrFunc;
		}
		
		public ISelectFieldsClause addField(String fieldName){
			this.sQuery+=','+fieldName;
			return this;
		}
		public ISelectFieldsClause addFields(List<String> fieldNames){
			this.sQuery+=','+String.join(fieldNames,',');
			return this;
		}

		public ISelectFieldsClause addFunction(IDateFunctionWrap dateFunc){
			this.sQuery+=','+dateFunc;
			return this;
		}

		public ISelectFieldsClause addFunction(IDateOnlyFunctionWrap dateOnlyFunc){
			this.sQuery+=','+dateOnlyFunc;
			return this;
		}

		public ISelectFieldsClause addFunction(IToLabelFunctionWrap toLblFunc){
			this.sQuery+=','+toLblFunc;
			return this;
		}

		public ISelectFieldsClause addSubQuery(IQuery query){
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

	public abstract class ASelectQuery implements ISelectFromQuery,ISelectWhereQuery,ISelectGroupByQuery,ISelectOrderByQuery,ISelectLimitQuery,ISelectOffsetQuery {

		public List<SObject> getList(){
			return new List<SObject>(Database.query(toString()));
		}

		public map<Id,SObject> getMap(){
			return new Map<Id,SObject>(getList());
		}
	}

	/**
	* @description SelectQuery : select query without a where clause
	*/
	public class SelectQuery extends ASelectQuery {
		private String sQuery;

		public SelectQuery(String sObjectName, String soqlSelectClause){
			this.sQuery=soqlSelectClause+' FROM '+sObjectName;
		}

		public ISelectWhereQuery where_x(IFieldCondition cnd){
			this.sQuery+=' WHERE '+cnd;
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
		public ISelectGroupByQuery groupBy(IDateFunctionWrap groupByField){
			return groupBy(new List<String>{''+groupByField},null);
		}
		public ISelectGroupByQuery groupBy(List<String> groupByFields){
			return groupBy(groupByFields,null);
		}
		public ISelectGroupByQuery groupBy(String groupByField, IHavingCondition havingCtr){
			return groupBy(new List<String>{groupByField},havingCtr);
		}
		public ISelectGroupByQuery groupBy(List<String> groupByFields, IHavingCondition havingCtr){
			this.sQuery+=' GROUP BY '+String.join(groupByFields, ',');
			if(havingCtr!=null)
				this.sQuery+=' HAVING '+havingCtr;
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
			this.sQuery+=' ORDER BY '+String.join(orderByFields,',');
			if(orderType != null)
				this.sQuery+=orderType;
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
			this.sQuery+=' '+String.join(orderByFields,' ');
			if(orderType != null)
				this.sQuery+=orderType;
			return this;
		}

		public ISelectLimitQuery limitTo(Integer lmt){
			if(lmt != null){
				this.sQuery+=' LIMIT '+lmt;
			}
			return this;
		}

		public ISelectOffsetQuery offset(Integer ofst){
			if(ofst != null){
				this.sQuery+=' OFFSET '+ofst;
			}
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
		public final String wrapperInputsNull='Error all inputs of the Wrapper are null';
		public final String emptyListAsValue='Error Value is an Empty List';
		public final String badValueType='Error Bad Value Type';
		public final String maxBindVariable='Error only one bind variable is allowed';
	}

	// Exceptions
	public class QBQueryException extends Exception {}
	public class QBConditionException extends Exception {}
	public class QBBindException extends Exception {}

}