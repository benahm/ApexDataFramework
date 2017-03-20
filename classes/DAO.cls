/**
* @author benahm
* @date 2017
* @description DAO Class
*/
public class DAO{

	public static IBase base(String sObjectName){
		return new Base(sObjectName);
	}

	public interface IBase{

		/* find a list */

		// find list by ids
		List<SObject> find(List<Id> ids);
		List<SObject> find(Set<Id> ids);
		List<SObject> find(List<Id> ids, String fieldNames);
		List<SObject> find(Set<Id> ids, String fieldNames);
		List<SObject> find(List<Id> ids, String fieldNames, Integer limitOption);
		List<SObject> find(Set<Id> ids, String fieldNames, Integer limitOption);

		// find list by a specific field
		List<SObject> find(String fieldName, Object value);
		List<SObject> find(String fieldName, Object value, String fieldNames);
		List<SObject> find(String fieldName, Object value, String fieldNames,Integer limitOption);
		
		// find a list by condition
		List<SObject> find(QB.IFieldCondition condition);
		List<SObject> find(QB.IFieldCondition condition, String fieldNames);
		List<SObject> find(QB.IFieldCondition condition, String fieldNames, Integer limitOption);

		// find a list by query
		List<SObject> find(QB.IQuery query);


		/* find a map */

		// find list by ids
		Map<Id,SObject> findMap(List<Id> ids);
		Map<Id,SObject> findMap(Set<Id> ids);
		Map<Id,SObject> findMap(List<Id> ids, String fieldNames);
		Map<Id,SObject> findMap(Set<Id> ids, String fieldNames);
		Map<Id,SObject> findMap(List<Id> ids, String fieldNames, Integer limitOption);
		Map<Id,SObject> findMap(Set<Id> ids, String fieldNames, Integer limitOption);

		// find list by a specific field
		Map<Id,SObject> findMap(String fieldName, Object value);
		Map<Id,SObject> findMap(String fieldName, Object value, String fieldNames);
		Map<Id,SObject> findMap(String fieldName, Object value, String fieldNames,Integer limitOption);
		
		// find a list by condition
		Map<Id,SObject> findMap(QB.IFieldCondition condition);
		Map<Id,SObject> findMap(QB.IFieldCondition condition, String fieldNames);
		Map<Id,SObject> findMap(QB.IFieldCondition condition, String fieldNames, Integer limitOption);

		// find a list by query
		Map<Id,SObject> findMap(QB.IQuery query);


		/* find one record */
		SObject findOne();
		SObject findOne(List<Id> id);
		SObject findOne(List<Id> id, String fieldNames);
		SObject findOne(String fieldName, Object value);
		SObject findOne(String fieldName, Object value, String fieldNames);
		SObject findOne(QB.IFieldCondition condition);
		SObject findOne(QB.IFieldCondition condition, String fieldNames);
		SObject findOne(QB.IQuery query);
		
	}

	public class Base implements IBase{
		private final String sObjectName;

		public Base(String sObjectName){
			this.sObjectName=sObjectName;
		}


		/* find a list */
		public List<SObject> find(List<Id> ids){
			return find(ids,'*',0);
		}
		public List<SObject> find(Set<Id> ids){
			return find(new List<Id>(ids),'*',0);
		}
		public List<SObject> find(Set<Id> ids, String fieldNames){
			return find(new List<Id>(ids),fieldNames,0);
		}
		public List<SObject> find(List<Id> ids, String fieldNames){
			return find(ids,fieldNames,0);
		}
		public List<SObject> find(Set<Id> ids, String fieldNames, Integer limitOption){
			return find(new List<Id>(ids),fieldNames,0);
		}
		public List<SObject> find(List<Id> ids, String fieldNames, Integer limitOption){
			return QB.select_x(fieldNames)
			  		 .from_x(sObjectName)
		  			 .where_x('Id','=',QB.bind(ids))
		  			 .getList();
		}
		public List<SObject> find(String fieldName, Object value){
			return find(fieldName,value,'*',null);
		}
		public List<SObject> find(String fieldName, Object value, String fieldNames){
			return find(fieldName,value,fieldNames,null);
		}
		public List<SObject> find(String fieldName, Object value, String fieldNames, Integer limitOption){
				return QB.select_x(fieldNames)
				  		 .from_x(sObjectName)
			  			 .where_x(fieldName,'=',QB.bind(value))
			  			 .limitTo(limitOption)
			  			 .getList();
		}
		public List<SObject> find(QB.IFieldCondition condition){
			return find(condition,'*',null);
		}
		public List<SObject> find(QB.IFieldCondition condition, String fieldNames){
			return find(condition,fieldNames,null);
		}
		public List<SObject> find(QB.IFieldCondition condition, String fieldNames, Integer limitOption){
			return QB.select_x(fieldNames)
			  		 .from_x(sObjectName)
		  			 .where_x(condition)
		  			 .limitTo(limitOption)
		  			 .getList();
		}
		public List<SObject> find(QB.IQuery query){
			return query.getList();
		}


		/* find a map */
		public Map<Id,SObject> findMap(List<Id> ids){
			return new Map<Id,SObject>(find(Ids));
		}
		public Map<Id,SObject> findMap(Set<Id> ids){
			return new Map<Id,SObject>(find(Ids));
		}
		public Map<Id,SObject> findMap(Set<Id> ids, String fieldNames){
			return new Map<Id,SObject>(find(Ids,fieldNames));
		}
		public Map<Id,SObject> findMap(List<Id> ids, String fieldNames){
			return new Map<Id,SObject>(find(Ids,fieldNames));
		}
		public Map<Id,SObject> findMap(Set<Id> ids, String fieldNames, Integer limitOption){
			return new Map<Id,SObject>(find(Ids,fieldNames,limitOption));
		}
		public Map<Id,SObject> findMap(List<Id> ids, String fieldNames, Integer limitOption){
			return new Map<Id,SObject>(find(Ids,fieldNames,limitOption));
		}
		public Map<Id,SObject> findMap(String fieldName, Object value){
			return new Map<Id,SObject>(find(fieldName,value));
		}
		public Map<Id,SObject> findMap(String fieldName, Object value, String fieldNames){
			return new Map<Id,SObject>(find(fieldName,value,fieldNames));
		}
		public Map<Id,SObject> findMap(String fieldName, Object value, String fieldNames, Integer limitOption){
			return new Map<Id,SObject>(find(fieldName,value,fieldNames,limitOption));
		}
		public Map<Id,SObject> findMap(QB.IFieldCondition condition){
			return new Map<Id,SObject>(find(condition));
		}
		public Map<Id,SObject> findMap(QB.IFieldCondition condition, String fieldNames){
			return new Map<Id,SObject>(find(condition,fieldNames));
		}
		public Map<Id,SObject> findMap(QB.IFieldCondition condition, String fieldNames, Integer limitOption){
			return new Map<Id,SObject>(find(condition,fieldNames,limitOption));
		}
		public Map<Id,SObject> findMap(QB.IQuery query){
			return new Map<Id,SObject>(find(query));
		}


		/* find one record */
		public SObject findOne(){
			return getOne(QB.select_x('*')
				  		 .from_x(sObjectName)
			  			 .limitTo(1)
			  			 .getList());
		}
		public SObject findOne(List<Id> ids){
			return findOne(ids,'*');
		}
		public SObject findOne(List<Id> ids, String fieldNames){
			return getOne(find(ids,fieldNames));
		}
		public SObject findOne(String fieldName, Object value){
			return findOne(fieldName,value,'*');
		}
		public SObject findOne(String fieldName, Object value, String fieldNames){
			return getOne(find(fieldName,value,fieldNames));
		}
		public SObject findOne(QB.IFieldCondition condition){
			return findOne(condition,'*');
		}
		public SObject findOne(QB.IFieldCondition condition, String fieldNames){
			return getOne(find(condition,fieldNames));
		}
		public SObject findOne(QB.IQuery query){
			return getOne(find(query));
		}


		/* private methods */
		private SObject getOne(List<SObject> listObj){
			if(listObj.isEmpty()) return null;
			return listObj.get(0);
		}

	}

	public class Meta /*implements INT_DAO_META*/{
		/* Request handle meta data */
	}

}