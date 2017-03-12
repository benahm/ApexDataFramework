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
	* @description apply the logical operator NOT to a criteria
	* @param ctr : Criteria
	* @return NotCriteria 
	*/
	public static NotCriteria not_x(ICriteria ctr){
		return new NotCriteria(ctr) ;
	}

	/**
	* @description apply the logical operator AND to two criterias
	* @param ctr1 : the first criteria
	* @param ctr2 : the second criteria
	* @return AndCriteria
	*/
	public static AndCriteria and_x(ICriteria ctr1, ICriteria ctr2){
		return new AndCriteria(ctr1,ctr2);
	}

	/**
	* @description apply the logical operator OR to two criterias
	* @param ctr1 : the first criteria
	* @param ctr2 : the second criteria
	* @return OrCriteria
	*/
	public static OrCriteria or_x(ICriteria ctr1, ICriteria ctr2){
		return new OrCriteria(ctr1,ctr2);
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
	public static FieldCriteria fieldExpr(String name, Op operator, String fieldValue){
		return new Field(name).op(operator,fieldValue);
	}
	public static FieldCriteria fieldExpr(String name, Op operator, List<String> fieldValues){
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
	* @description IQuery : a valide query
	*/
	public interface IQuery{
		List<SObject> getList();
		Map<Id, SObject> getMap();
	}

	/**
	* @description ICriteria : interface for a valide criteria
	*/
	public interface ICriteria{
		String toString();
	}

	/**
	* @description IField : interface for the field wrapper
	*/
	public interface IField {
		// equal to
		FieldCriteria eq(String fieldValue);
		FieldCriteria eq(List<String> fieldValues);
		FieldCriteria equal(String fieldValue);
		FieldCriteria equal(List<String> fieldValues);

		// not equal to
		FieldCriteria ne(String fieldValue);
		FieldCriteria ne(List<String> fieldValues);
		FieldCriteria notEqual(String fieldValue);
		FieldCriteria notEqual(List<String> fieldValues);
		
		// greater than
		FieldCriteria gt(String fieldValue);
		FieldCriteria greaterThan(String fieldValue);

		// less than
		FieldCriteria lt(String fieldValue);
		FieldCriteria lessThan(String fieldValue);

		// greater than or equal to
		FieldCriteria ge(String fieldValue);
		FieldCriteria greaterOrEqual(String fieldValue);

		// less than or equal to
		FieldCriteria le(String fieldValue);
		FieldCriteria lessOrEqual(String fieldValue);

		// like 
		FieldCriteria lk(String fieldValue);
		FieldCriteria isLike(String fieldValue);

	}

	/**
	* @description IWhereOption : a where option
	*/
	public interface IWhereOption{}



	/****************************************************************************************/
	/*					Classes						*/
	/****************************************************************************************/
	/**
	* @description NotCriteria : NOT applied to a criteria
	*/
	public class NotCriteria implements ICriteria {

		public ICriteria ctr;

		public NotCriteria(ICriteria ctr){
			this.ctr=ctr;
		}

		public override String toString(){
			return 'NOT ('+ctr+')';
		}
	}

	/**
	* @description NaryCriteria : Abstract class for operations that can be
	* 			      applied to multiple criterias
	*/
	public abstract class NaryCriteria implements ICriteria {
		public abstract String getOperator();
		public abstract List<ICriteria> getListCriterias();
		public abstract NaryCriteria getInstance();

		public NaryCriteria add(ICriteria ctr){
			getListCriterias().add(ctr);
			return getInstance();
		}

		public override String toString(){
			String result='';

			for(ICriteria ctr:getListCriterias()){
				result+='('+ctr+')'+' '+getOperator()+' ';
			}
			return result.removeEnd(' '+getOperator()+' ');
		}

	}

	/**
	* @description AndCriteria : AND applied to multiple criterias
	*/
	public class AndCriteria extends NaryCriteria {
		private List<ICriteria> listCriterias;
		private final String operator ='AND';

		public AndCriteria(ICriteria ctr1, ICriteria ctr2){
			this.listCriterias=new List<ICriteria>{ctr1,ctr2};
		}

		public override String getOperator(){
			return operator;
		}

		public override List<ICriteria> getListCriterias(){
			return listCriterias;
		}

		public override NaryCriteria getInstance(){
			return this;
		}

	}

	/**
	* @description AndCriteria : OR applied to multiple criterias
	*/
	public class OrCriteria extends NaryCriteria {
		private List<ICriteria> listCriterias;
		private final String operator ='OR';

		public OrCriteria(ICriteria ctr1, ICriteria ctr2){
			this.listCriterias=new List<ICriteria>{ctr1,ctr2};
		}

		public override String getOperator(){
			return operator;
		}

		public override List<ICriteria> getListCriterias(){
			return listCriterias;
		}

		public override NaryCriteria getInstance(){
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

		private FieldCriteria handleOperator(Op operator,List<String> fieldValues){
			return new FieldCriteria(this,operator,fieldValues);
		}

		public FieldCriteria op(Op operator, String fieldValue){
			return handleOperator(operator,new List<String>{fieldValue});
		}
		public FieldCriteria op(Op operator, List<String> fieldValues){
			return handleOperator(operator,fieldValues);
		}

		// equal to
		public FieldCriteria eq(String fieldValue){
			return eq(new List<String>{fieldValue}); 
		}
		public FieldCriteria eq(List<String> fieldValues){
			return handleOperator(Op.EQ,fieldValues);
		}
		public FieldCriteria equal(String fieldValue){
			return eq(fieldValue);
		}
		public FieldCriteria equal(List<String> fieldValues){
			return eq(fieldValues);
		}

		// not equal to
		public FieldCriteria ne(String fieldValue){
			return ne(new List<String>{fieldValue});
		}
		public FieldCriteria ne(List<String> fieldValues){
			return handleOperator(Op.NE,fieldValues);	
		}
		public FieldCriteria notEqual(String fieldValue){
			return ne(fieldValue);
		}
		public FieldCriteria notEqual(List<String> fieldValues){
			return ne(fieldValues);
		}
		
		// greater than
		public FieldCriteria gt(String fieldValue){
			return handleOperator(Op.GT,new List<String>{fieldValue});
		}
		public FieldCriteria greaterThan(String fieldValue){
			return gt(fieldValue);
		}

		// less than
		public FieldCriteria lt(String fieldValue){
			return handleOperator(Op.LT,new List<String>{fieldValue});
		}
		public FieldCriteria lessThan(String fieldValue){
			return lt(fieldValue);
		}

		// greater than or equal to
		public FieldCriteria ge(String fieldValue){
			return handleOperator(Op.GE,new List<String>{fieldValue});
		}
		public FieldCriteria greaterOrEqual(String fieldValue){
			return ge(fieldValue);
		}

		// less than or equal to
		public FieldCriteria le(String fieldValue){
			return handleOperator(Op.LE,new List<String>{fieldValue});
		}
		public FieldCriteria lessOrEqual(String fieldValue){
			return le(fieldValue);
		}

		// like 
		public FieldCriteria lk(String fieldValue){
			return handleOperator(Op.LK,new List<String>{fieldValue});
		}
		public FieldCriteria isLike(String fieldValue){
			return lk(fieldValue);
		}

		public override String toString(){
			return fieldName;
		}

	}

	/**
	* @description FieldCriteria : field criteria
	*/
	public class FieldCriteria implements ICriteria {
		private Field field;
		private Op operator;
		private List<String> fieldValues;

		public FieldCriteria(Field field,Op operator,List<String> fieldValues){
			this.field=field;
			this.operator=operator;
			this.fieldValues = new List<String>(fieldValues);
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
					throw new CriteriaException('Only the operators EQUAL & NOTEQUAL can handle a list of values');
				}
			}

			// Single value
			String fieldValue=fieldValues.get(0);
			String strOperator=util.operatorToString(operator);
			if(strOperator == null)
				throw new CriteriaException(errMsg.unkownOperator);
			else 
				return field+' '+strOperator+' '+'\''+ fieldValue+'\'';

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
		private List<String> selectedFields;
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
		private List<String> selectedFields;
		private AggregateFunction aggrFunc;

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
			throw new QueryException('You can\'t add a sub query to aggregate clause');
		}

		public override String toString(){
			String result='SELECT ';
			if(aggrFunc!=null) result+=aggrFunc;
			if(!selectedFields.isEmpty()) 
				result+=String.join(selectedFields,',');

			return result;
		}

	}


	/**
	* @description SelectQuery : select query without a where clause
	*/
	public class SelectQuery  implements IQuery{
		private String sObjectName;
		private SelectClause sClause;

		public SelectQuery(String sObjectName, SelectClause sClause){
			this.sObjectName=sObjectName;
			this.sClause=sClause;
		}

		public SelectWhereQuery where_x(ICriteria ctr){
			return new SelectWhereQuery(ctr,this);
		}

		public override String toString(){
			return sClause+' FROM '+sObjectName;
		}

		public List<SObject> getList(){
			return null;
		}

		public map<Id,SObject> getMap(){
			return null;
		}
	}

	/**
	* @description SelectWhereQuery : select query with a where clause
	*/
	public class SelectWhereQuery implements IQuery{
		private ICriteria ctr;
		private SelectQuery sQuery;

		public SelectWhereQuery(ICriteria ctr, SelectQuery sQuery){
			this.ctr=ctr;
			this.sQuery=sQuery;
		}

		public GroupByWhereOption groupBy(String groupByField){
			return new GroupByWhereOption(groupByField,this);
		}

		public GroupByWhereOption groupBy(List<String> groupByFields){
			return new GroupByWhereOption(groupByFields,this);
		}

		public GroupByWhereOption groupBy(String groupByField, HavingCriteria havingCtr){
			return new GroupByWhereOption(groupByField,havingCtr,this);
		}

		public GroupByWhereOption groupBy(List<String> groupByFields, HavingCriteria havingCtr){
			return new GroupByWhereOption(groupByFields,havingCtr,this);
		}

		public OrderByWhereOption orderBy(String orderByField){
			return new OrderByWhereOption(orderByField,this);
		}
		public OrderByWhereOption orderBy(List<String> orderByFields){
			return new OrderByWhereOption(orderByFields,this);
		}

		public LimitWhereOption limitTo(Integer lmt){
			return new LimitWhereOption(lmt,this);
		}

		public OffsetWhereOption offset(Integer ofst){
			return new OffsetWhereOption(ofst,this);
		}

		public override String toString(){
			return ' '+sQuery+' WHERE '+ctr;
		}

		public List<SObject> getList(){
			return null;
		}

		public map<Id,SObject> getMap(){
			return null;
		}

	}

	/**
	* @description GroupByWhereOption : Group By option of the where clause
	*/
	public class GroupByWhereOption implements IWhereOption,IQuery {
		private List<String> groupByFields;
		private HavingCriteria havingCtr;
		private IQuery swQuery;

		public GroupByWhereOption(String groupByField,IQuery swQuery){
			this(new List<String>{groupByField},null,swQuery);
		}

		public GroupByWhereOption(List<String> groupByFields,IQuery swQuery){
			this(groupByFields,null,swQuery);
		}

		public GroupByWhereOption(String groupByField,HavingCriteria havingCtr,IQuery swQuery){
			this(new List<String>{groupByField},havingCtr,swQuery);
		}

		public GroupByWhereOption(List<String> groupByFields,HavingCriteria havingCtr,IQuery swQuery){
			this.groupByFields=new List<String>(groupByFields);
			this.havingCtr=havingCtr;
			this.swQuery=swQuery;
		}

		public OrderByWhereOption orderBy(String orderByField){
			return new OrderByWhereOption(orderByField,this);
		}
		public OrderByWhereOption orderBy(List<String> orderByFields){
			return new OrderByWhereOption(orderByFields,this);
		}

		public LimitWhereOption limitTo(Integer lmt){
			return new LimitWhereOption(lmt,this);
		}

		public OffsetWhereOption offset(Integer ofst){
			return new OffsetWhereOption(ofst,this);
		}

		public override String toString(){
			return swQuery+' GROUP BY '+String.join(groupByFields, ',')+' HAVING '+havingCtr;
		}

		public List<SObject> getList(){
			return null;
		}

		public map<Id,SObject> getMap(){
			return null;
		}
	}

	/**
	* @description OrderByWhereOption : Order By option of the where clause
	*/
	public class OrderByWhereOption implements IWhereOption,IQuery{
		private List<String> orderByFields;
		private IQuery swQuery;

		public OrderByWhereOption(String orderByField,IQuery swQuery){
			this(new List<String>{orderByField},swQuery);
		}
		public OrderByWhereOption(List<String> orderByFields,IQuery swQuery){
			this.orderByFields=new List<String>(orderByFields);
			this.swQuery=swQuery;
		}

		public LimitWhereOption limitTo(Integer lmt){
			return new LimitWhereOption(lmt,this);
		}

		public OffsetWhereOption offset(Integer ofst){
			return new OffsetWhereOption(ofst,this);
		}

		public override String toString(){
			return swQuery+' ORDER BY '+String.join(orderByFields, ',');
		}

		public List<SObject> getList(){
			return null;
		}

		public map<Id,SObject> getMap(){
			return null;
		}
	}

	/**
	* @description LimitWhereOption : Limit option of the where clause
	*/
	public class LimitWhereOption implements IWhereOption,IQuery{
		private Integer lmt;
		private IQuery swQuery;

		public LimitWhereOption(Integer lmt,IQuery swQuery){
			this.lmt=lmt;
			this.swQuery=swQuery;
		}

		public OffsetWhereOption offset(Integer ofst){
			return new OffsetWhereOption(ofst,this);
		}

		public override String toString(){
			return swQuery+' LIMIT '+lmt;
		}

		public List<SObject> getList(){
			return null;
		}

		public map<Id,SObject> getMap(){
			return null;
		}
	}

	/**
	* @description OffsetWhereOption : Offset option of the where clause
	*/
	public class OffsetWhereOption implements IWhereOption,IQuery{
		private Integer ofst;
		private IQuery swQuery;

		public OffsetWhereOption(Integer ofst, IQuery swQuery){
			this.ofst=ofst;
			this.swQuery=swQuery;
		}

		public override String toString(){
			return swQuery+' OFFSET '+ofst;
		}

		public List<SObject> getList(){
			return null;
		}

		public map<Id,SObject> getMap(){
			return null;
		}
	}

	/**
	* @description AggregateFunction : aggregate function
	*/
	public class AggregateFunction {
		private String functionType;
		private String fieldName;

		public AggregateFunction(String functionType){
			this(functionType,null);
		}
		public AggregateFunction(String functionType, String fieldName){
			this.functionType=functionType;
			this.fieldName=fieldName;
		}

		private HavingCriteria handleOperator(Op operator,String value){
			return new HavingCriteria(this,operator,value);
		}

		// equal to
		public HavingCriteria eq(String value){
			return handleOperator(Op.EQ,value); 
		}
		public HavingCriteria equal(String value){
			return eq(value);
		}

		// not equal to
		public HavingCriteria ne(String value){
			return handleOperator(Op.NE,value);
		}
		public HavingCriteria notEqual(String value){
			return ne(value);
		}
		
		// greater than
		public HavingCriteria gt(String value){
			return handleOperator(Op.GT,value);
		}
		public HavingCriteria greaterThan(String value){
			return gt(value);
		}

		// less than
		public HavingCriteria lt(String value){
			return handleOperator(Op.LT,value);
		}
		public HavingCriteria lessThan(String value){
			return lt(value);
		}

		// greater than or equal to
		public HavingCriteria ge(String value){
			return handleOperator(Op.GE,value);
		}
		public HavingCriteria greaterOrEqual(String value){
			return ge(value);
		}

		// less than or equal to
		public HavingCriteria le(String value){
			return handleOperator(Op.LE,value);
		}
		public HavingCriteria lessOrEqual(String value){
			return le(value);
		}

		public override String toString(){
			if(fieldName==null)
				return functionType+'()';
			else return functionType+'('+fieldName+')';
		}
	}

	public class HavingCriteria{
		private AggregateFunction aggrFunc;
		private Op operator;
		private String value;

		public HavingCriteria(AggregateFunction aggrFunc,Op operator,String value){
			this.aggrFunc=aggrFunc;
			this.operator=operator;
			this.value=value;
		}

		public override String toString(){
			String strOperator=util.operatorToString(operator);
			if(strOperator==null)
				throw new CriteriaException(errMsg.unkownOperator);
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
	}

	/**
	* @description ErrorMessage : Class holding all the error messages
	*/
	private class ErrorMessage {
		public final String unkownOperator='Unkown Operator';
	}

	// Exceptions
	public class QueryException extends Exception {}
	public class CriteriaException extends Exception {}

}
