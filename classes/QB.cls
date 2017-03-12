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
	private static final Util util=new Util();
	private static final ErrorMessage errMsg=new ErrorMessage();
	public enum Op {EQ, EQUAL,
			NE, NOTEQUAL,
			GT, GREATERTHAN,
			LT, LESSTHAN,
			GE, GREATEROREQUAL,
			LE, LESSOREQUAL,
			LK, ISLIKE}


	/**
	* @description apply the logical operator NOT to a condition
	* @param cnd : Condition
	* @return NotCondition 
	*/
	public static NotCondition not_x(ICondition cnd){
		return new NotCondition(cnd) ;
	}


	/**
	* @description apply the logical operator AND to two conditions
	* @param cnd1 : the first condition
	* @param cnd2 : the second condition
	* @return AndCondition
	*/
	public static AndCondition and_x(ICondition cnd1, ICondition cnd2){
		return new AndCondition(cnd1,cnd2);
	}


	/**
	* @description apply the logical operator OR to two conditions
	* @param cnd1 : the first condition
	* @param cnd2 : the second condition
	* @return OrCondition
	*/
	public static OrCondition or_x(ICondition cnd1, ICondition cnd2){
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
	public static FieldCondition fieldExpr(String name, Op operator, String fieldValue){
		return new Field(name).op(operator,fieldValue);
	}
	public static FieldCondition fieldExpr(String name, Op operator, List<String> fieldValues){
		return new Field(name).op(operator,fieldValues);
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
	public static AggregateFunction avg(){
		return new AggregateFunction('AVG');
	}

	/**
	* @description min aggregate function
	* @return AggregateFunction
	*/
	public static AggregateFunction min(){
		return new AggregateFunction('MIN');
	}

	/**
	* @description max aggregate function
	* @return AggregateFunction
	*/
	public static AggregateFunction max(){
		return new AggregateFunction('MAX');
	}

	/**
	* @description sum aggregate function
	* @return AggregateFunction
	*/
	public static AggregateFunction sum(){
		return new AggregateFunction('SUM');
	}

	/**
	* @description select clause
	* @return AggregateFunction
	*/	
	public static SelectClause select_x(String fieldName){
		return new SelectFieldsClause(fieldName);
	}
	public static SelectClause select_x(List<String> fieldNames){
		return new SelectFieldsClause(fieldNames);
	}
	public static SelectClause select_x(AggregateFunction aggrFunc){
		return new SelectAggregateClause(aggrFunc);
	}
	public static SelectClause select_x(AggregateFunction aggrFunc, String fieldName){
		return new SelectAggregateClause(aggrFunc,fieldName);
	}
	public static SelectClause select_x(AggregateFunction aggrFunc, List<String> fieldNames){
		return new SelectAggregateClause(aggrFunc,fieldNames);
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
	public interface ICondition{
		String toString();
	}

	/**
	* @description IField : interface for the field wrapper
	*/
	public interface IField {
		// equal to
		FieldCondition eq(String fieldValue);
		FieldCondition eq(List<String> fieldValues);
		FieldCondition equal(String fieldValue);
		FieldCondition equal(List<String> fieldValues);

		// not equal to
		FieldCondition ne(String fieldValue);
		FieldCondition ne(List<String> fieldValues);
		FieldCondition notEqual(String fieldValue);
		FieldCondition notEqual(List<String> fieldValues);
		
		// greater than
		FieldCondition gt(String fieldValue);
		FieldCondition greaterThan(String fieldValue);

		// less than
		FieldCondition lt(String fieldValue);
		FieldCondition lessThan(String fieldValue);

		// greater than or equal to
		FieldCondition ge(String fieldValue);
		FieldCondition greaterOrEqual(String fieldValue);

		// less than or equal to
		FieldCondition le(String fieldValue);
		FieldCondition lessOrEqual(String fieldValue);

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
	public class NotCondition implements ICondition {
		private ICondition cnd;

		public NotCondition(ICondition cnd){
			this.cnd=cnd;
		}

		public override String toString(){
			return 'NOT ('+cnd+')';
		}
	}

	/**
	* @description NaryCondition : Abstract class for operations that can be
	* 			      applied to multiple conditions
	*/
	public abstract class NaryCondition implements ICondition {
		public abstract String getOperator();
		public abstract List<ICondition> getListConditions();
		public abstract NaryCondition getInstance();

		public NaryCondition add(ICondition cnd){
			getListConditions().add(cnd);
			return getInstance();
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
	public class AndCondition extends NaryCondition {
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

		public override NaryCondition getInstance(){
			return this;
		}
	}

	/**
	* @description AndCondition : OR applied to multiple conditions
	*/
	public class OrCondition extends NaryCondition {
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

		public override NaryCondition getInstance(){
			return this;
		}
	}

	/**
	* @description Field : field wrapper
	*/
	public class Field implements IField {
		private final String fieldName;

		public Field(String fieldName){
			// escape
			this.fieldName=fieldName;
		}

		private FieldCondition handleOperator(Op operator,List<String> fieldValues){
			return new FieldCondition(this,operator,fieldValues);
		}

		public FieldCondition op(Op operator, String fieldValue){
			return handleOperator(operator,new List<String>{fieldValue});
		}
		public FieldCondition op(Op operator, List<String> fieldValues){
			return handleOperator(operator,fieldValues);
		}

		// equal to
		public FieldCondition eq(String fieldValue){
			return eq(new List<String>{fieldValue}); 
		}
		public FieldCondition eq(List<String> fieldValues){
			return handleOperator(Op.EQ,fieldValues);
		}
		public FieldCondition equal(String fieldValue){
			return eq(fieldValue);
		}
		public FieldCondition equal(List<String> fieldValues){
			return eq(fieldValues);
		}

		// not equal to
		public FieldCondition ne(String fieldValue){
			return ne(new List<String>{fieldValue});
		}
		public FieldCondition ne(List<String> fieldValues){
			return handleOperator(Op.NE,fieldValues);	
		}
		public FieldCondition notEqual(String fieldValue){
			return ne(fieldValue);
		}
		public FieldCondition notEqual(List<String> fieldValues){
			return ne(fieldValues);
		}
		
		// greater than
		public FieldCondition gt(String fieldValue){
			return handleOperator(Op.GT,new List<String>{fieldValue});
		}
		public FieldCondition greaterThan(String fieldValue){
			return gt(fieldValue);
		}

		// less than
		public FieldCondition lt(String fieldValue){
			return handleOperator(Op.LT,new List<String>{fieldValue});
		}
		public FieldCondition lessThan(String fieldValue){
			return lt(fieldValue);
		}

		// greater than or equal to
		public FieldCondition ge(String fieldValue){
			return handleOperator(Op.GE,new List<String>{fieldValue});
		}
		public FieldCondition greaterOrEqual(String fieldValue){
			return ge(fieldValue);
		}

		// less than or equal to
		public FieldCondition le(String fieldValue){
			return handleOperator(Op.LE,new List<String>{fieldValue});
		}
		public FieldCondition lessOrEqual(String fieldValue){
			return le(fieldValue);
		}

		// like 
		public FieldCondition lk(String fieldValue){
			return handleOperator(Op.LK,new List<String>{fieldValue});
		}
		public FieldCondition isLike(String fieldValue){
			return lk(fieldValue);
		}

		public override String toString(){
			return fieldName;
		}
	}

	/**
	* @description FieldCondition : field condition
	*/
	public class FieldCondition implements ICondition {
		private final Field field;
		private final Op operator;
		private final List<String> fieldValues;

		public FieldCondition(Field field,Op operator,List<String> fieldValues){
			this.field=field;
			this.operator=operator;
			this.fieldValues = new List<String>(Util.escapeSingleQuotes(fieldValues));
		}

		public override String toString(){
			if(fieldValues.isEmpty())
				return field+'';

			// Multiple values
			if(fieldValues.size() > 1){
				String joinedFieldValues=String.join(fieldValues,'\',\'');
				if(operator == Op.EQ){
					return field+' IN (\''+joinedFieldValues+'\')';
				} else if(this.operator == Op.NE){
					return field+' NOT IN (\''+joinedFieldValues+'\')';
				} else {
					throw new QBConditionException(errMsg.operatorDoNotHandleMultiValues);
				}
			}

			// Single value
			String fieldValue=fieldValues.get(0);
			String strOperator=util.operatorToString(operator);
			if(strOperator == null)
				throw new QBConditionException(errMsg.unkownOperator);
			else 
				return field+' '+strOperator+' '+'\''+ fieldValue+'\'';
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

	/**
	* @description SelectClause : select clause
	*/
	public abstract class SelectClause {

		public abstract SelectClause addSubQuery(IQuery query);

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

		public override SelectClause addSubQuery(IQuery query){
			this.subQueries.add(query);
			return this;
		}

		public override String toString(){
			String result='SELECT ';
			if(!selectedFields.isEmpty()) 
				result+=String.join(selectedFields,',');
			if(!subQueries.isEmpty())
				result+=','+util.subQueriesToString(subQueries);

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

		public override SelectClause addSubQuery(IQuery query){
			throw new QBQueryException(errMsg.cannotAddSubQuery);
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

		public SelectWhereQuery where_x(ICondition cnd){
			return new SelectWhereQuery(cnd,this);
		}
		public SelectWhereQuery where_x(String fieldName, Op operator, String fieldValue){
			return new SelectWhereQuery(new Field(fieldName).op(operator,fieldValue),this);
		}
		public SelectWhereQuery where_x(String fieldName, Op operator, List<String> fieldValues){
			return new SelectWhereQuery(new Field(fieldName).op(operator,fieldValues),this);
		}

		public SelectGroupByQuery groupBy(String groupByField){
			return new SelectGroupByQuery(groupByField,this);
		}
		public SelectGroupByQuery groupBy(List<String> groupByFields){
			return new SelectGroupByQuery(groupByFields,this);
		}
		public SelectGroupByQuery groupBy(String groupByField, HavingCondition havingCtr){
			return new SelectGroupByQuery(groupByField,havingCtr,this);
		}
		public SelectGroupByQuery groupBy(List<String> groupByFields, HavingCondition havingCtr){
			return new SelectGroupByQuery(groupByFields,havingCtr,this);
		}

		public SelectOrderByQuery orderBy(String orderByField){
			return new SelectOrderByQuery(orderByField,this);
		}
		public SelectOrderByQuery orderBy(List<String> orderByFields){
			return new SelectOrderByQuery(orderByFields,this);
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

		public SelectWhereQuery(ICondition cnd, SelectQuery sQuery){
			this.cnd=cnd;
			this.sQuery=sQuery;
		}

		public SelectGroupByQuery groupBy(String groupByField){
			return new SelectGroupByQuery(groupByField,this);
		}
		public SelectGroupByQuery groupBy(List<String> groupByFields){
			return new SelectGroupByQuery(groupByFields,this);
		}
		public SelectGroupByQuery groupBy(String groupByField, HavingCondition havingCtr){
			return new SelectGroupByQuery(groupByField,havingCtr,this);
		}
		public SelectGroupByQuery groupBy(List<String> groupByFields, HavingCondition havingCtr){
			return new SelectGroupByQuery(groupByFields,havingCtr,this);
		}

		public SelectOrderByQuery orderBy(String orderByField){
			return new SelectOrderByQuery(orderByField,this);
		}
		public SelectOrderByQuery orderBy(List<String> orderByFields){
			return new SelectOrderByQuery(orderByFields,this);
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
		private final HavingCondition havingCtr;
		private final IQuery swQuery;

		public SelectGroupByQuery(String groupByField,IQuery swQuery){
			this(new List<String>{groupByField},null,swQuery);
		}

		public SelectGroupByQuery(List<String> groupByFields,IQuery swQuery){
			this(groupByFields,null,swQuery);
		}

		public SelectGroupByQuery(String groupByField,HavingCondition havingCtr,IQuery swQuery){
			this(new List<String>{groupByField},havingCtr,swQuery);
		}

		public SelectGroupByQuery(List<String> groupByFields,HavingCondition havingCtr,IQuery swQuery){
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
	public class SelectOrderByQuery extends Query {
		private final List<String> orderByFields;
		private final IQuery swQuery;

		public SelectOrderByQuery(String orderByField,IQuery swQuery){
			this(new List<String>{orderByField},swQuery);
		}
		public SelectOrderByQuery(List<String> orderByFields,IQuery swQuery){
			this.orderByFields=new List<String>(orderByFields);
			this.swQuery=swQuery;
		}

		public SelectOrderByQuery(String orderByField,String orderType,IQuery swQuery){
			// TODO
			this(new List<String>{orderByField},swQuery);
		}
		public SelectOrderByQuery(List<String> orderByFields,String orderType,IQuery swQuery){
			// TODO
			this.orderByFields=new List<String>(orderByFields);
			this.swQuery=swQuery;
		}

		public SelectLimitQuery limitTo(Integer lmt){
			return new SelectLimitQuery(lmt,this);
		}

		public SelectOffsetQuery offset(Integer ofst){
			return new SelectOffsetQuery(ofst,this);
		}

		public override String toString(){
			return swQuery+' ORDER BY '+String.join(orderByFields, ',');
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
	public class HavingCondition{
		private final AggregateFunction aggrFunc;
		private final Op operator;
		private final Integer value;

		public HavingCondition(AggregateFunction aggrFunc,Op operator,Integer value){
			this.aggrFunc=aggrFunc;
			this.operator=operator;
			this.value=value;
		}

		public override String toString(){
			String strOperator=util.operatorToString(operator);
			if(strOperator==null)
				throw new QBConditionException(errMsg.unkownOperator);
			else
				return aggrFunc+' '+strOperator+' '+value;
		}
	}

	/**
	* @description Validator : all validating methods
	*/
	private class Validator {

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

		public String subQueriesToString(List<IQuery> subQueries){
			String result='';
			for(IQuery subQuery: subQueries){
				result+='('+subQuery+'),';
			}
			return result.removeEnd(',');
		}

		public List<String> escapeSingleQuotes(List<String> values){
			List<String> escapedValues=new List<String>();
			for(String value:values){
				escapedValues.add(String.escapeSingleQuotes(value));
			}
			return escapedValues;
		}
	}

	/**
	* @description ErrorMessage : Class holding all the error messages
	*/
	private class ErrorMessage {
		public final String unkownOperator='Unkown Operator';
		public final String operatorDoNotHandleMultiValues='Only the operators EQUAL & NOTEQUAL can handle a list of values';
		public final String cannotAddSubQuery='You can\'t add a sub query to aggregate clause';
	}

	// Exceptions
	public class QBQueryException extends Exception {}
	public class QBConditionException extends Exception {}

}
