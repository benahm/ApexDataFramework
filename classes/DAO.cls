/**
* @author benahm
* @date 2017
* @description DAO Class
*/
public with sharing class DAO {



	public DAO() {
		
	}

	public interface IBase{
		/* find specification */
		/* find ( Ids, Fields, WhereOptions ) */
		/* find ( field, Values, Fields, WhereOptions ) */
		/* find ( Criteria, Fields, WhereOptions ) */


		// find list of sobjects by ids
		List<SObject> find(List<Id> ids);
		List<SObject> find(Set<Id> ids);

		List<SObject> find(List<Id> ids, String fieldName);
		List<SObject> find(Set<Id> ids, String fieldName);
		List<SObject> find(List<Id> ids, String fieldName, Integer limitOption);
		List<SObject> find(Set<Id> ids, String fieldName, Integer limitOption);
		List<SObject> find(List<Id> ids, String fieldName, QB.WhereOption whereOption);
		List<SObject> find(Set<Id> ids, String fieldName, QB.WhereOption whereOption);

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
		
		List<SObject> find(QB.ICriteria criteria);
		List<SObject> find(QB.ICriteria criteria, String fieldName);
		List<SObject> find(QB.ICriteria criteria, List<String> fields);
		List<SObject> find(QB.ICriteria criteria, Set<String> fields);


		// find list by query
		List<SObject> find(QB.Query query);



		/* findOne Sepcification */
		/* findOne(Criteria, fields) */

		// find one sobject by id
		SObject findOne(Id id);
		SObject findOne(Id id, String fieldName);
		SObject findOne(Id id, List<String> fields);


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
			return null;
		}

		public List<SObject> find(Set<Id> ids){
			return null;
		}

		public List<SObject> find(List<Id> ids, String fieldName){
			return null;
		}

		public List<SObject> find(Set<Id> ids, String fieldName){
			return null;
		}

		public List<SObject> find(List<Id> ids, String fieldName, Integer limitOption){
			return null;
		}

		public List<SObject> find(Set<Id> ids, String fieldName, Integer limitOption){
			return null;
		}

		public List<SObject> find(List<Id> ids, String fieldName, QB.WhereOption whereOption){
			return null;
		}

		public List<SObject> find(Set<Id> ids, String fieldName, QB.WhereOption whereOption){
			//String query='SELECT '+sObjectName+' '
			return null;
		}

		public List<SObject> find(List<Id> ids, List<String> fieldNames, Integer limitOption){
			return null;
		}

		public List<SObject> find(Set<Id> ids, List<String> fieldNames, Integer limitOption){
			return null;
		}

		public List<SObject> find(List<Id> ids, List<String> fieldNames, QB.WhereOption whereOption){
			return null;
		}

		public List<SObject> find(Set<Id> ids, List<String> fieldNames, QB.WhereOption whereOption){
			String query='SELECT '+String.join(fieldNames,',')+' FROM '+sObjectName+' WHERE Id IN :ids ';
			return null;
		}


		// find list with restricted list of fields by ids
		public List<SObject> find(List<Id> ids, List<String> fields){
			return null;
		}

		public List<SObject> find(List<Id> ids, Set<String> fields){
			return null;
		}

		public List<SObject> find(Set<Id> ids, List<String> fields){
			return null;
		}

		public List<SObject> find(Set<Id> ids, Set<String> fields){
			return null;
		}


		public List<SObject> find(QB.ICriteria criteria){
			return null;
		}

		public List<SObject> find(QB.ICriteria criteria, String fieldName){
			return null;
		}

		public List<SObject> find(QB.ICriteria criteria, List<String> fields){
			return null;
		}

		public List<SObject> find(QB.ICriteria criteria, Set<String> fields){
			return null;
		}



		// find list by query
		public List<SObject> find(QB.Query query){
			return null;
		}


		/* findOne Sepcification */
		/* findOne(Criteria, fields) */

		// find one sobject by id
		public SObject findOne(Id id){
			return null;
		}

		public SObject findOne(Id id, String fieldName){
			return null;
		}

		public SObject findOne(Id id, List<String> fields){
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