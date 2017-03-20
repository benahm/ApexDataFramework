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
* @description Test Class for the Query Builder
*/
@isTest
private class DAOTest {
	
	@isTest 
	private static void findTest() {
		Test.startTest();
 		 
		System.assertEquals(0,DAO.base('Account').find(new List<Id>()).size());
		System.assertEquals(0,DAO.base('Account').find(new Set<Id>()).size());
		System.assertEquals(0,DAO.base('Account').find(new List<Id>(),'Id,Name').size());
		System.assertEquals(0,DAO.base('Account').find(new Set<Id>(),'Id,Name').size());
		System.assertEquals(0,DAO.base('Account').find(new List<Id>(),'Id,Name',1).size());
		System.assertEquals(0,DAO.base('Account').find(new Set<Id>(),'Id,Name',1).size());
		System.assertEquals(0,DAO.base('Account').find('Name','Test').size());
		System.assertEquals(0,DAO.base('Account').find('Name','Test','Id,Name').size());
		System.assertEquals(0,DAO.base('Account').find('Name','Test','Id,Name',1).size());
		System.assertEquals(0,DAO.base('Account').find(QB.field('Name').eq('Test')).size());
		System.assertEquals(0,DAO.base('Account').find(QB.field('Name').eq('Test'),'Id,Name').size());
		System.assertEquals(0,DAO.base('Account').find(QB.field('Name').eq('Test'),'Id,Name',1).size());
		System.assertEquals(0,DAO.base('Account').find(QB.select_x('Id,Name').from_x('Account')).size());

		
		ApexClass daoClass=(ApexClass)DAO.base('ApexClass').findOne('Name','DAO','Id');
		if(daoClass == null)
			System.assert(false);
		else{
			Id daoClassId=daoClass.Id;
			System.assertEquals(1,DAO.base('ApexClass').find(new List<Id>{daoClassId}).size());
			System.assertEquals(1,DAO.base('ApexClass').find(new Set<Id>{daoClassId}).size());
			System.assertEquals(1,DAO.base('ApexClass').find(new List<Id>{daoClassId},'Id,Name').size());
			System.assertEquals(1,DAO.base('ApexClass').find(new Set<Id>{daoClassId},'Id,Name').size());
			System.assertEquals(1,DAO.base('ApexClass').find(new List<Id>{daoClassId},'Id,Name',1).size());
			System.assertEquals(1,DAO.base('ApexClass').find(new Set<Id>{daoClassId},'Id,Name',1).size());
		}
		System.assertEquals(1,DAO.base('ApexClass').find('Name','DAO').size());
		System.assertEquals(1,DAO.base('ApexClass').find('Name','DAO','Id').size());
		System.assertEquals(1,DAO.base('ApexClass').find('Name','DAO','Id,Name',1).size());
		System.assertEquals(1,DAO.base('ApexClass').find(QB.field('Name').eq('DAO')).size());
		System.assertEquals(1,DAO.base('ApexClass').find(QB.field('Name').eq('DAO'),'Id,Name').size());
		System.assertEquals(1,DAO.base('ApexClass').find(QB.field('Name').eq('DAO'),'Id,Name',1).size());
		System.assertEquals(1,DAO.base('ApexClass').find(QB.select_x('Id,Name')
														.from_x('ApexClass')
														.where_x('Name','=','DAO')).size());

		Test.stopTest();
	}
	
	@isTest 
	private static void findMapTest() {
		Test.startTest();

		System.assertEquals(0,DAO.base('Account').findMap(new List<Id>()).values().size());
		System.assertEquals(0,DAO.base('Account').findMap(new Set<Id>()).values().size());
		System.assertEquals(0,DAO.base('Account').findMap(new List<Id>(),'Id,Name').values().size());
		System.assertEquals(0,DAO.base('Account').findMap(new Set<Id>(),'Id,Name').values().size());
		System.assertEquals(0,DAO.base('Account').findMap(new List<Id>(),'Id,Name',1).values().size());
		System.assertEquals(0,DAO.base('Account').findMap(new Set<Id>(),'Id,Name',1).values().size());
		System.assertEquals(0,DAO.base('Account').findMap('Name','Test').values().size());
		System.assertEquals(0,DAO.base('Account').findMap('Name','Test','Id,Name').values().size());
		System.assertEquals(0,DAO.base('Account').findMap('Name','Test','Id,Name',1).values().size());
		System.assertEquals(0,DAO.base('Account').findMap(QB.field('Name').eq('Test')).values().size());
		System.assertEquals(0,DAO.base('Account').findMap(QB.field('Name').eq('Test'),'Id,Name').values().size());
		System.assertEquals(0,DAO.base('Account').findMap(QB.field('Name').eq('Test'),'Id,Name',1).values().size());
		System.assertEquals(0,DAO.base('Account').findMap(QB.select_x('Id,Name').from_x('Account')).values().size());

		
		ApexClass daoClass=(ApexClass)DAO.base('ApexClass').findOne('Name','DAO','Id');
		if(daoClass == null)
			System.assert(false);
		else{
			Id daoClassId=daoClass.Id;
			System.assertEquals(1,DAO.base('ApexClass').findMap(new List<Id>{daoClassId}).values().size());
			System.assertEquals(1,DAO.base('ApexClass').findMap(new Set<Id>{daoClassId}).values().size());
			System.assertEquals(1,DAO.base('ApexClass').findMap(new List<Id>{daoClassId},'Id,Name').values().size());
			System.assertEquals(1,DAO.base('ApexClass').findMap(new Set<Id>{daoClassId},'Id,Name').values().size());
			System.assertEquals(1,DAO.base('ApexClass').findMap(new List<Id>{daoClassId},'Id,Name',1).values().size());
			System.assertEquals(1,DAO.base('ApexClass').findMap(new Set<Id>{daoClassId},'Id,Name',1).values().size());
		}
		System.assertEquals(1,DAO.base('ApexClass').findMap('Name','DAO').values().size());
		System.assertEquals(1,DAO.base('ApexClass').findMap('Name','DAO','Id').values().size());
		System.assertEquals(1,DAO.base('ApexClass').findMap('Name','DAO','Id,Name',1).values().size());
		System.assertEquals(1,DAO.base('ApexClass').findMap(QB.field('Name').eq('DAO')).values().size());
		System.assertEquals(1,DAO.base('ApexClass').findMap(QB.field('Name').eq('DAO'),'Id,Name').values().size());
		System.assertEquals(1,DAO.base('ApexClass').findMap(QB.field('Name').eq('DAO'),'Id,Name',1).values().size());
		System.assertEquals(1,DAO.base('ApexClass').findMap(QB.select_x('Id,Name')
														.from_x('ApexClass')
														.where_x('Name','=','DAO')).values().size());

		Test.stopTest();
	}


	@isTest
	private static void findOneTest(){
		Test.startTest();

		System.assertEquals(null,DAO.base('Account').findOne());
		System.assertEquals(null,DAO.base('Account').findOne('Name','Test'));
		System.assertEquals(null,DAO.base('Account').findOne('Name','Test','Id,Name'));
		System.assertEquals(null,DAO.base('Account').findOne(QB.field('Name').eq('Test')));
		System.assertEquals(null,DAO.base('Account').findOne(QB.field('Name').eq('Test'),'Id,Name'));
		System.assertEquals(null,DAO.base('Account').findOne(QB.select_x('Id,Name').from_x('Account')));


		System.assertNotEquals(null,DAO.base('ApexClass').findOne());
		ApexClass daoClass=(ApexClass)DAO.base('ApexClass').findOne('Name','DAO','Id');
		if(daoClass == null)
			System.assert(false);
		else{
			Id daoClassId=daoClass.Id;
			System.assertNotEquals(null,DAO.base('ApexClass').findOne(new List<Id>{daoClassId}));
			System.assertNotEquals(null,DAO.base('ApexClass').findOne(new List<Id>{daoClassId},'Id,Name'));
		}
		System.assertNotEquals(null,DAO.base('ApexClass').findOne('Name','DAO'));
		System.assertNotEquals(null,DAO.base('ApexClass').findOne('Name','DAO','Id'));
		System.assertNotEquals(null,DAO.base('ApexClass').findOne(QB.field('Name').eq('DAO')));
		System.assertNotEquals(null,DAO.base('ApexClass').findOne(QB.field('Name').eq('DAO'),'Id,Name'));
		System.assertNotEquals(null,DAO.base('ApexClass').findOne(QB.select_x('Id,Name')
														.from_x('ApexClass')
														.where_x('Name','=','DAO')));

		Test.stopTest();
	}
	
}