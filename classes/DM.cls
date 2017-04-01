/**
* @author benahm
* @date 2017
* @description DM Class
*/
public class DM{
	private static IBase base=null;

	public static IBase Base(String sObjectName){
		if(base == null)
			return new Base(sObjectName);
		return base;
	}

	/**
	* @description interface IBase
	*/
	public interface IBase{

		/************************* find a list *************************/
		/**
		 * @description find a list of sObjects by Id
		 * @return List<sObject> : list of sObjects
		 */
		List<SObject> findById(List<Id> ids);
		List<SObject> findById(Set<Id> ids);
		List<SObject> findById(List<Id> ids, String fieldNames);
		List<SObject> findById(Set<Id> ids, String fieldNames);
		List<SObject> findById(List<Id> ids, String fieldNames, String appendOptions);
		List<SObject> findById(Set<Id> ids, String fieldNames, String appendOptions);

		/**
		 * @description find a list of sObjects by given field
		 * @return List<sObject> : list of sObjects
		 */
		List<SObject> findBy(String fieldName, Object value);
		List<SObject> findBy(Schema.SObjectField field, Object value);
		List<SObject> findBy(String fieldName, Object value, String fieldNames);
		List<SObject> findBy(Schema.SObjectField field, Object value, String fieldNames);
		List<SObject> findBy(String fieldName, Object value, String fieldNames,String appendOptions);
		List<SObject> findBy(Schema.SObjectField field, Object value, String fieldNames,String appendOptions);
		
		/**
		 * @description find a list of sObjects by condition
		 * @return List<sObject> : list of sObjects
		 */
		List<SObject> findBy(QB.IFieldCondition condition);
		List<SObject> findBy(QB.IFieldCondition condition, String fieldNames);
		List<SObject> findBy(QB.IFieldCondition condition, String fieldNames, String appendOptions);


		/************************* find a map *************************/
		/**
		 * @description find a map of sObjects by Id
		 * @return Map<Id,sObject> : map of sObjects
		 */
		Map<Id,SObject> findMapById(List<Id> ids);
		Map<Id,SObject> findMapById(Set<Id> ids);
		Map<Id,SObject> findMapById(List<Id> ids, String fieldNames);
		Map<Id,SObject> findMapById(Set<Id> ids, String fieldNames);
		Map<Id,SObject> findMapById(List<Id> ids, String fieldNames, String appendOptions);
		Map<Id,SObject> findMapById(Set<Id> ids, String fieldNames, String appendOptions);

		/**
		 * @description find a map of sObjects by a given field
		 * @return Map<Id,sObject> : map of sObjects
		 */		
		Map<Id,SObject> findMapBy(String fieldName, Object value);
		Map<Id,SObject> findMapBy(Schema.SObjectField field, Object value);
		Map<Id,SObject> findMapBy(String fieldName, Object value, String fieldNames);
		Map<Id,SObject> findMapBy(Schema.SObjectField field, Object value, String fieldNames);
		Map<Id,SObject> findMapBy(String fieldName, Object value, String fieldNames,String appendOptions);
		Map<Id,SObject> findMapBy(Schema.SObjectField field, Object value, String fieldNames,String appendOptions);
		
		/**
		 * @description find a map of sObjects by condition
		 * @return Map<Id,sObject> : map of sObjects
		 */		
		Map<Id,SObject> findMapBy(QB.IFieldCondition condition);
		Map<Id,SObject> findMapBy(QB.IFieldCondition condition, String fieldNames);
		Map<Id,SObject> findMapBy(QB.IFieldCondition condition, String fieldNames, String appendOptions);


		/************************* find sObject *************************/
		/**
		 * @description find one record whitout criteria
		 * @return sObject : sObject instance
		 */
		SObject findOne();

		/**
		 * @description find one record by Id
		 * @return sObject : sObject instance
		 */
		SObject findOneById(Id id);
		SObject findOneById(Set<Id> id);
		SObject findOneById(List<Id> id);
		SObject findOneById(Id id, String fieldNames);
		SObject findOneById(Set<Id> id, String fieldNames);
		SObject findOneById(List<Id> id, String fieldNames);
		
		/**
		 * @description find one record by a given field
		 * @return sObject : sObject instance
		 */
		SObject findOneBy(String fieldName, Object value);
		SObject findOneBy(Schema.SObjectField field, Object value);
		SObject findOneBy(String fieldName, Object value, String fieldNames);
		SObject findOneBy(Schema.SObjectField field, Object value, String fieldNames);
		SObject findOneBy(QB.IFieldCondition condition);
		SObject findOneBy(QB.IFieldCondition condition, String fieldNames);

	}

	/**
	* @description abstract class ABase
	*/
	public abstract class ABase implements IBase{

		protected abstract String getSObjectName();

		/* find a list */
		public List<SObject> findById(List<Id> ids){
			return findById(ids,'*','');
		}
		public List<SObject> findById(Set<Id> ids){
			return findById(new List<Id>(ids),'*','');
		}
		public List<SObject> findById(Set<Id> ids, String fieldNames){
			return findById(new List<Id>(ids),fieldNames,'');
		}
		public List<SObject> findById(List<Id> ids, String fieldNames){
			return findById(ids,fieldNames,'');
		}
		public List<SObject> findById(Set<Id> ids, String fieldNames, String appendOptions){
			return findById(new List<Id>(ids),fieldNames,appendOptions);
		}
		public List<SObject> findById(List<Id> ids, String fieldNames, String appendOptions){
			return findBy('Id',ids,fieldNames,appendOptions);
		}
		public List<SObject> findBy(String fieldName, Object value){
			return findBy(fieldName,value,'*','');
		}		
		public List<SObject> findBy(Schema.SObjectField field, Object value){
			return findBy(field.getDescribe().getName(),value,'*','');
		}
		public List<SObject> findBy(String fieldName, Object value, String fieldNames){
			return findBy(fieldName,value,fieldNames,'');
		}		
		public List<SObject> findBy(Schema.SObjectField field, Object value, String fieldNames){
			return findBy(field.getDescribe().getName(),value,fieldNames,'');
		}
		public List<SObject> findBy(String fieldName, Object value, String fieldNames, String appendOptions){
			return findBy(QB.field(fieldName).eq(QB.bind(value)),fieldNames,appendOptions);
		}		
		public List<SObject> findBy(Schema.SObjectField field, Object value, String fieldNames, String appendOptions){
			return findBy(QB.field(field.getDescribe().getName()).eq(QB.bind(value)),fieldNames,appendOptions);
		}
		public List<SObject> findBy(QB.IFieldCondition condition){
			return findBy(condition,'*','');
		}
		public List<SObject> findBy(QB.IFieldCondition condition, String fieldNames){
			return findBy(condition,fieldNames,'');
		}
		public List<SObject> findBy(QB.IFieldCondition condition, String fieldNames, String appendOptions){
			return QB.select_x(fieldNames)
			  		 .from_x(getSObjectName())
		  			 .where_x(condition)
		  			 .append(' '+appendOptions)
		  			 .getList();
		}


		/* find a map */
		public Map<Id,SObject> findMapById(List<Id> ids){
			return new Map<Id,SObject>(findById(Ids));
		}
		public Map<Id,SObject> findMapById(Set<Id> ids){
			return new Map<Id,SObject>(findById(Ids));
		}
		public Map<Id,SObject> findMapById(Set<Id> ids, String fieldNames){
			return new Map<Id,SObject>(findById(Ids,fieldNames));
		}
		public Map<Id,SObject> findMapById(List<Id> ids, String fieldNames){
			return new Map<Id,SObject>(findById(Ids,fieldNames));
		}
		public Map<Id,SObject> findMapById(Set<Id> ids, String fieldNames, String appendOptions){
			return new Map<Id,SObject>(findById(Ids,fieldNames,appendOptions));
		}
		public Map<Id,SObject> findMapById(List<Id> ids, String fieldNames, String appendOptions){
			return new Map<Id,SObject>(findById(Ids,fieldNames,appendOptions));
		}
		public Map<Id,SObject> findMapBy(String fieldName, Object value){
			return new Map<Id,SObject>(findBy(fieldName,value));
		}
		public Map<Id,SObject> findMapBy(Schema.SObjectField field, Object value){
			return new Map<Id,SObject>(findBy(field.getDescribe().getName(),value));
		}
		public Map<Id,SObject> findMapBy(String fieldName, Object value, String fieldNames){
			return new Map<Id,SObject>(findBy(fieldName,value,fieldNames));
		}		
		public Map<Id,SObject> findMapBy(Schema.SObjectField field, Object value, String fieldNames){
			return new Map<Id,SObject>(findBy(field.getDescribe().getName(),value,fieldNames));
		}
		public Map<Id,SObject> findMapBy(String fieldName, Object value, String fieldNames, String appendOptions){
			return new Map<Id,SObject>(findBy(fieldName,value,fieldNames,appendOptions));
		}
		public Map<Id,SObject> findMapBy(Schema.SObjectField field, Object value, String fieldNames, String appendOptions){
			return new Map<Id,SObject>(findBy(field.getDescribe().getName(),value,fieldNames,appendOptions));
		}
		public Map<Id,SObject> findMapBy(QB.IFieldCondition condition){
			return new Map<Id,SObject>(findBy(condition));
		}
		public Map<Id,SObject> findMapBy(QB.IFieldCondition condition, String fieldNames){
			return new Map<Id,SObject>(findBy(condition,fieldNames));
		}
		public Map<Id,SObject> findMapBy(QB.IFieldCondition condition, String fieldNames, String appendOptions){
			return new Map<Id,SObject>(findBy(condition,fieldNames,appendOptions));
		}

		/* find sObject */
		public SObject findOne(){
			return getOne(findBy((QB.IFieldCondition)null,'*',' LIMIT 1'));
		}
		public SObject findOneById(Id id){
			return findOneById(new List<Id>{Id},'*');
		}
		public SObject findOneById(Set<Id> ids){
			return findOneById(new List<Id>(ids),'*');
		}
		public SObject findOneById(List<Id> ids){
			return findOneById(ids,'*');
		}
		public SObject findOneById(Id id, String fieldNames){
			return getOne(findById(new List<Id>{id},fieldNames));
		}
		public SObject findOneById(Set<Id> ids, String fieldNames){
			return getOne(findById(new List<Id>(ids),fieldNames));
		}
		public SObject findOneById(List<Id> ids, String fieldNames){
			return getOne(findById(ids,fieldNames));
		}
		public SObject findOneBy(String fieldName, Object value){
			return findOneBy(fieldName,value,'*');
		}
		public SObject findOneBy(Schema.SObjectField field, Object value){
			return findOneBy(field.getDescribe().getName(),value,'*');
		}
		public SObject findOneBy(String fieldName, Object value, String fieldNames){
			return getOne(findBy(fieldName,value,fieldNames));
		}
		public SObject findOneBy(Schema.SObjectField field, Object value, String fieldNames){
			return getOne(findBy(field.getDescribe().getName(),value,fieldNames));
		}
		public SObject findOneBy(QB.IFieldCondition condition){
			return findOneBy(condition,'*');
		}
		public SObject findOneBy(QB.IFieldCondition condition, String fieldNames){
			return getOne(findBy(condition,fieldNames));
		}

		/* private methods */
		private SObject getOne(List<SObject> listObj){
			if(listObj.isEmpty()) return null;
			return listObj.get(0);
		}

	}

	/**
	* @description class Base
	*/
	public class Base extends ABase{
		private String sObjectName;

		public Base(String sObjectName){
			this.sObjectName=sObjectName;
		}

		public override String getSObjectName(){
			return sObjectName;
		}
	}

}