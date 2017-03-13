/**
* @author benahm
* @date 2017
* @description DAO Class
*/
public with sharing class DAO {


	public static Base base(String sObjectName){
		return new Base(sObjectName);
	}

	public interface IBase{
		/* find specification */
		/* find ( Ids, Fields, WhereOptions ) */
		/* find ( field, Values, Fields, WhereOptions ) */
		/* find ( Criteria, Fields, WhereOptions ) */
		/* find ( Query ) */


		// find list of sobjects by ids
		List<SObject> find(List<Id> ids);
		List<SObject> find(Set<Id> ids);

		List<SObject> find(List<Id> ids, String fieldName);
		List<SObject> find(Set<Id> ids, String fieldName);
		List<SObject> find(List<Id> ids, String fieldName, Integer limitOption);
		List<SObject> find(Set<Id> ids, String fieldName, Integer limitOption);
		//List<SObject> find(List<Id> ids, String fieldName, QB.WhereOption whereOption);
		//List<SObject> find(Set<Id> ids, String fieldName, QB.WhereOption whereOption);

		/*
		List<SObject> find(List<Id> ids, List<String> fieldNames);
		List<SObject> find(Set<Id> ids, List<String> fieldNames);
		List<SObject> find(List<Id> ids, List<String> fieldNames, Integer limitOption);
		List<SObject> find(Set<Id> ids, List<String> fieldNames, Integer limitOption);
		List<SObject> find(List<Id> ids, List<String> fieldNames, QB.WhereOption whereOption);
		List<SObject> find(Set<Id> ids, List<String> fieldNames, QB.WhereOption whereOption);
		*/

		// find list by field other than Id
		/*		
		List<SObject> find(String fieldName, String fieldValue);
		List<SObject> find(String fieldName, Set<String> fieldValue);
		List<SObject> find(String fieldName, List<String> fieldValue);
		*/		
		
		List<SObject> find(QB.ICondition condition);
		List<SObject> find(QB.ICondition condition, String fieldName);
		List<SObject> find(QB.ICondition condition, List<String> fieldNames);
		List<SObject> find(QB.ICondition condition, Set<String> fieldNames);


		// find list by query
		List<SObject> find(QB.IQuery query);



		/* findOne Sepcification */
		/* findOne(Criteria, fieldNames) */

		// find one sobject by id
		SObject findOne(Id id);
		SObject findOne(Id id, String fieldName);
		SObject findOne(Id id, List<String> fieldNames);


		// findMap a find method that returns a map 
		/*Map<Id,SObject> findMap(List<Id> String);*/


		// find one random sobject
		SObject findOne();
	}

	public class Base implements IBase{

		private final String sObjectName;

		public Base(String sObjectName){
			this.sObjectName=sObjectName;
		}

		/* Request handle data */
		// find list of sobjects by ids
		public List<SObject> find(List<Id> ids){
			return find(ids,'*',0);
		}

		public List<SObject> find(Set<Id> ids){
			return find(new List<Id>(ids),'*',0);
		}

		public List<SObject> find(List<Id> ids, String fieldName){
			return find(ids,fieldName,0);
		}

		public List<SObject> find(Set<Id> ids, String fieldName){
			return find(new List<Id>(ids),fieldName,0);
		}

		public List<SObject> find(List<Id> ids, String fieldName, Integer limitOption){
			return find(ids,new List<String>{fieldName},0);
		}

		public List<SObject> find(Set<Id> ids, String fieldName, Integer limitOption){
			return find(new List<Id>(ids),new List<String>{fieldName},0);
		}


		public List<SObject> find(List<Id> ids, List<String> fieldNames, Integer limitOption){
			String soqlQuery='SELECT '+String.join(fieldNames,',')
							+' FROM '+sObjectName
							+' WHERE '+'Id IN :ids';
			return new List<SObject>(Database.query(soqlQuery));
		}

		public List<SObject> find(Set<Id> ids, List<String> fieldNames, Integer limitOption){
			return find(new List<Id>(ids),fieldNames,limitOption);
		}


		// find list with restricted list of fieldNames by ids
		public List<SObject> find(List<Id> ids, List<String> fieldNames){
			return null;
		}

		public List<SObject> find(List<Id> ids, Set<String> fieldNames){
			return null;
		}

		public List<SObject> find(Set<Id> ids, List<String> fieldNames){
			return null;
		}

		public List<SObject> find(Set<Id> ids, Set<String> fieldNames){
			return null;
		}


		public List<SObject> find(QB.ICondition condition){
			return find(condition,new List<String>());
		}

		public List<SObject> find(QB.ICondition condition, String fieldName){
			return find(condition,new List<String>{fieldName});
		}

		public List<SObject> find(QB.ICondition condition, List<String> fieldNames){
			String soqlQuery='SELECT '+String.join(fieldNames,',')
							+' FROM '+sObjectName
							+' WHERE '+condition;
			return new List<SObject>(Database.query(soqlQuery));
		}

		public List<SObject> find(QB.ICondition condition, Set<String> fieldNames){
			return find(condition,new List<String>(fieldNames));
		}



		// find list by query
		public List<SObject> find(QB.IQuery query){
			return query.getList();
		}


		/* findOne Sepcification */
		/* findOne(Criteria, fieldNames) */

		// find one sobject by id
		public SObject findOne(Id id){
			return null;
		}

		public SObject findOne(Id id, String fieldName){
			return null;
		}

		public SObject findOne(Id id, List<String> fieldNames){
			return null;
		}



		// find one random sobject
		public SObject findOne(){
			return null;
		}
		
	}

	public class Meta /*implements INT_DAO_META*/{
		/* Request handle meta data */
	}

}