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
* @description QueryBuilder class
*/
public class QB {

	public enum Op {EQ,	EQUAL,
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
	public static ICriteria or_x(ICriteria ctr1, ICriteria ctr2){
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


	/**
	* @description NotCriteria : NOT applied to a criteria
	*/
	public class NotCriteria implements ICriteria {

		public ICriteria criteria;

		public NotCriteria(ICriteria criteria){
			this.criteria=criteria;
		}

		public override String toString(){
			return 'NOT ('+criteria.toString()+')';
		}
	}

	/**
	* @description NaryCriteria : Abstract class for operations that can be
	* 							  applied to multiple criterias
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
		private final String operator ='OR';

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
		private Op operator;
		private List<String> fieldValues;

		public Field(String fieldName){
			// escape
			this.fieldName=fieldName;
		}

		private FieldCriteria handleOperator(Op operator,List<String> fieldValues){
			this.operator=operator;
			this.fieldValues=new List<String>();
			this.fieldValues.addAll(fieldValues);
			return new FieldCriteria(this.toString());
		}

		public FieldCriteria op(Op operator, String fieldValue){
			return handleOperator(operator,new List<String>{fieldValue});
		}

		public FieldCriteria op(Op operator, List<String> fieldValues){
			return handleOperator(operator,fieldValues);
		}

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
			if(fieldValues.isEmpty()) {
				throw new CriteriaException('No Operator applied to Field(Name)');
			}

			// Multiple values
			if(fieldValues.size() > 1){
				if(operator == Op.EQ){
					return fieldName+' IN (\''+String.join(fieldValues,'\',\'')+'\')';
				} else if(this.operator == Op.NE){
					return fieldName+' NOT IN (\''+String.join(fieldValues,'\',\'')+'\')';
				} else {
					throw new CriteriaException('Only the operators EQUAL & NOTEQUAL can handle a list of values');
				}
			}

			// Single value
			String fieldValue=fieldValues.get(0);
			if(operator == Op.EQ){
				return fieldName+' = '+'\''+ fieldValue+'\'';
			} else if (operator == Op.NE){
				return fieldName+' != '+'\''+fieldValue+'\'';
			} else if (operator == Op.GT){
				return fieldName+' > '+'\''+fieldValue+'\'';
			} else if (operator == Op.LT){
				return fieldName+' < '+'\''+fieldValue+'\'';
			} else if (operator == Op.GE){
				return fieldName+' >= '+'\''+fieldValue+'\'';
			} else if (operator == Op.LE){
				return fieldName+' <= '+'\''+fieldValue+'\'';
			} else if (operator == Op.LK){
				return fieldName+' LIKE '+'\''+fieldValue+'\'';
			}

			throw new CriteriaException('Unkown Operator');
		}
	}

	/**
	* @description FieldCriteria : field criteria
	*/
	public class FieldCriteria implements ICriteria {
		private String value;
		public FieldCriteria(String value){
			this.value = value;
		}
		public override String toString(){
			return value;
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
				result+=','+subQueriesToString(subQueries);

			return result+' ';
		}

		private String subQueriesToString(List<IQuery> subQueries){
			String result='';
			for(IQuery subQuery: subQueries){
				result+='( '+subQuery+'),';
			}
			return result.removeEnd(',');
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

			return result+' ';
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
			return sClause+'FROM '+sObjectName+' ';
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

		public OrderByWhereOption orderBy(String orderByField){
			return new OrderByWhereOption(orderByField,toString());
		}

		public OrderByWhereOption orderBy(List<String> orderByFields){
			return new OrderByWhereOption(orderByFields,toString());
		}

		public override String toString(){
			return sQuery+'WHERE '+ctr+' ';
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
		private String swQuery;

		public OrderByWhereOption(String orderByField,String swQuery){
			this(new List<String>{orderByField},swQuery);
		}

		public OrderByWhereOption(List<String> orderByFields,String swQuery){
			this.orderByFields=new List<String>(orderByFields);
			this.swQuery=swQuery;
		}

		public LimitWhereOption limitTo(Integer lmt){
			return new LimitWhereOption(lmt,toString());
		}

		public OffsetWhereOption offset(Integer ofst){
			return new OffsetWhereOption(ofst,toString());
		}

		public override String toString(){
			return swQuery+'ORDER BY '+String.join(orderByFields, ',')+' ';
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
		private String swQuery;

		public LimitWhereOption(Integer lmt,String swQuery){
			this.lmt=lmt;
			this.swQuery=swQuery;
		}

		public OffsetWhereOption offset(Integer ofst){
			return new OffsetWhereOption(ofst,toString());
		}

		public override String toString(){
			return swQuery+'LIMIT '+lmt+' ';
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
		private String swQuery;

		public OffsetWhereOption(Integer ofst, String swQuery){
			this.ofst=ofst;
			this.swQuery=swQuery;
		}

		public override String toString(){
			return swQuery+'OFFSET '+ofst+' ';
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

		public override String toString(){
			if(fieldName==null)
				return functionType+'()';
			else return functionType+'('+fieldName+')';
		}
	}

	/**
	* @description Validator : all validating methods
	*/
	public class Validator {

	}

	// Exceptions
	public class QueryException extends Exception {}
	public class CriteriaException extends Exception {}

}
