/**
* @author benahm
* @date 2017
* @description QueryBuilder class
*/
public class QB {

	private String sObjectName;
	public enum Op {EQ,	EQUAL,
					NE, NOTEQUAL,
					GT, GREATERTHAN,
					LT, LESSTHAN,
					GE, GREATEROREQUAL,
					LE, LESSOREQUAL,
					LK, ISLIKE}


	/**
	* @description apply the logical operator NOT to a criteria
	* @param Criteria
	* @return NotCriteria 
	*/
	public static NotCriteria not_x(INT_Criteria ctr){
		return new NotCriteria(ctr) ;
	}

	/**
	* @description apply the logical operator AND to two criterias
	* @param ctr1 : the first criteria
	* @param ctr2 : the second criteria
	* @return AndCriteria
	*/
	public static AndCriteria and_x(INT_Criteria ctr1, INT_Criteria ctr2){
		return new AndCriteria(ctr1,ctr2);
	}

	/**
	* @description apply the logical operator OR to two criterias
	* @param ctr1 : the first criteria
	* @param ctr2 : the second criteria
	* @return OrCriteria
	*/
	public static INT_Criteria or_x(INT_Criteria ctr1, INT_Criteria ctr2){
		return null;
	}

	/**
	* @description Wrap a field
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

	public String toSOQL(){
		//TODO
		return null;
	}

	public class Query {
		//TODO
	}


	/**
	* @description Criteria interface
	*/
	public interface INT_Criteria{
		String toString();
	}

	/**
	* @description NotCriteria : NOT applied to a criteria
	*/
	public class NotCriteria implements INT_Criteria {

		public INT_Criteria criteria;

		public NotCriteria(INT_Criteria criteria){
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
	public abstract class NaryCriteria implements INT_Criteria {
		public abstract String getOperator();
		public abstract List<INT_Criteria> getListCriterias();
		public abstract NaryCriteria getInstance();

		public NaryCriteria add(INT_Criteria ctr){
			getListCriterias().add(ctr);
			return getInstance();
		}

		public override String toString(){
			String result='';

			for(INT_Criteria ctr:getListCriterias()){
				result+='('+ctr.toString()+')'+' '+getOperator()+' ';
			}
			return result.removeEnd(' '+getOperator()+' ');
		}

	}

	/**
	* @description AndCriteria : AND applied to multiple criterias
	*/
	public class AndCriteria extends NaryCriteria {
		private List<INT_Criteria> listCriterias;
		private final String operator ='OR';

		public AndCriteria(INT_Criteria ctr1, INT_Criteria ctr2){
			this.listCriterias=new List<INT_Criteria>{ctr1,ctr2};
		}

		public override String getOperator(){
			return operator;
		}

		public override List<INT_Criteria> getListCriterias(){
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
		private List<INT_Criteria> listCriterias;
		private final String operator ='OR';

		public OrCriteria(INT_Criteria ctr1, INT_Criteria ctr2){
			this.listCriterias=new List<INT_Criteria>{ctr1,ctr2};
		}

		public override String getOperator(){
			return operator;
		}

		public override List<INT_Criteria> getListCriterias(){
			return listCriterias;
		}

		public override NaryCriteria getInstance(){
			return this;
		}

	}

	/**
	* @description INT_Field : Interface for the field wrapper
	*/
	public interface INT_Field {
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
	* @description Field : field wrapper
	*/
	public class Field implements INT_Field {

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
	public class FieldCriteria implements INT_Criteria {
		private String value;
		public FieldCriteria(String value){
			this.value = value;
		}
		public override String toString(){
			return value;
		}
	}

	public interface WhereOption{
		//TODO
	}

	// Exceptions
	public class CriteriaException extends Exception {}

}