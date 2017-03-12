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
private class QBTest {
	
	/* Tests for Criteria builder */
	@isTest 
	static void fieldCriteriaEqualTest() {
		Test.startTest();

		System.assertEquals('Name = \'Value\'',QB.field('Name').eq('Value').toString());
		System.assertEquals('Name = \'Value\'',QB.field('Name').op(QB.Op.EQ,'Value').toString());
		System.assertEquals('Name = \'Value\'',QB.fieldExpr('Name',QB.Op.EQ,'Value').toString());
		System.assertEquals('Name = \'Value\'',QB.field('Name').equal('Value').toString());

		System.assertEquals('Name IN (\'Value1\',\'Value2\')',QB.field('Name').eq(new List<String>{'Value1','Value2'}).toString());
		System.assertEquals('Name IN (\'Value1\',\'Value2\')',QB.field('Name').op(QB.Op.EQ,new List<String>{'Value1','Value2'}).toString());
		System.assertEquals('Name IN (\'Value1\',\'Value2\')',QB.fieldExpr('Name',QB.Op.EQ,new List<String>{'Value1','Value2'}).toString());
		System.assertEquals('Name IN (\'Value1\',\'Value2\')',QB.field('Name').equal(new List<String>{'Value1','Value2'}).toString());

		Test.stopTest();
	}
	
	@isTest 
	static void fieldCriteriaNotEqualTest() {
		Test.startTest();

		System.assertEquals('Name != \'Value\'',QB.field('Name').ne('Value').toString());
		System.assertEquals('Name != \'Value\'',QB.field('Name').op(QB.Op.NE,'Value').toString());
		System.assertEquals('Name != \'Value\'',QB.fieldExpr('Name',QB.Op.NE,'Value').toString());
		System.assertEquals('Name != \'Value\'',QB.field('Name').notEqual('Value').toString());

		System.assertEquals('Name NOT IN (\'Value1\',\'Value2\')',QB.field('Name').ne(new List<String>{'Value1','Value2'}).toString());
		System.assertEquals('Name NOT IN (\'Value1\',\'Value2\')',QB.field('Name').op(QB.Op.NE,new List<String>{'Value1','Value2'}).toString());
		System.assertEquals('Name NOT IN (\'Value1\',\'Value2\')',QB.fieldExpr('Name',QB.Op.NE,new List<String>{'Value1','Value2'}).toString());
		System.assertEquals('Name NOT IN (\'Value1\',\'Value2\')',QB.field('Name').notEqual(new List<String>{'Value1','Value2'}).toString());

		Test.stopTest();
	}

	@isTest 
	static void fieldCriteriaGreaterThanTest() {
		Test.startTest();

		System.assertEquals('Name > \'Value\'',QB.field('Name').gt('Value').toString());
		System.assertEquals('Name > \'Value\'',QB.field('Name').op(QB.Op.GT,'Value').toString());
		System.assertEquals('Name > \'Value\'',QB.fieldExpr('Name',QB.Op.GT,'Value').toString());
		System.assertEquals('Name > \'Value\'',QB.field('Name').greaterThan('Value').toString());

		Test.stopTest();
	}

	@isTest 
	static void fieldCriteriaLessThanTest() {
		Test.startTest();

		System.assertEquals('Name < \'Value\'',QB.field('Name').lt('Value').toString());
		System.assertEquals('Name < \'Value\'',QB.field('Name').op(QB.Op.LT,'Value').toString());
		System.assertEquals('Name < \'Value\'',QB.fieldExpr('Name',QB.Op.LT,'Value').toString());
		System.assertEquals('Name < \'Value\'',QB.field('Name').lessThan('Value').toString());

		Test.stopTest();
	}
	
	@isTest 
	static void fieldCriteriaGreaterOrEqualTest() {
		Test.startTest();

		System.assertEquals('Name >= \'Value\'',QB.field('Name').ge('Value').toString());
		System.assertEquals('Name >= \'Value\'',QB.field('Name').op(QB.Op.GE,'Value').toString());
		System.assertEquals('Name >= \'Value\'',QB.fieldExpr('Name',QB.Op.GE,'Value').toString());
		System.assertEquals('Name >= \'Value\'',QB.field('Name').greaterOrEqual('Value').toString());

		Test.stopTest();
	}
	
	@isTest 
	static void fieldCriteriaLessOrEqualTest() {
		Test.startTest();

		System.assertEquals('Name <= \'Value\'',QB.field('Name').le('Value').toString());
		System.assertEquals('Name <= \'Value\'',QB.field('Name').op(QB.Op.LE,'Value').toString());
		System.assertEquals('Name <= \'Value\'',QB.fieldExpr('Name',QB.Op.LE,'Value').toString());
		System.assertEquals('Name <= \'Value\'',QB.field('Name').lessOrEqual('Value').toString());

		Test.stopTest();
	}
	
	@isTest 
	static void fieldCriteriaIsLikeOrEqualTest() {
		Test.startTest();

		System.assertEquals('Name LIKE \'Value\'',QB.field('Name').lk('Value').toString());
		System.assertEquals('Name LIKE \'Value\'',QB.field('Name').op(QB.Op.LK,'Value').toString());
		System.assertEquals('Name LIKE \'Value\'',QB.fieldExpr('Name',QB.Op.LK,'Value').toString());
		System.assertEquals('Name LIKE \'Value\'',QB.field('Name').isLIKE('Value').toString());

		Test.stopTest();
	}

	@isTest 
	static void notCriteriaTest() {
		Test.startTest();

		System.assertEquals('NOT (Name = \'Value\')',QB.not_x(QB.field('Name').eq('Value')).toString());
		System.assertEquals('NOT (Name != \'Value\')',QB.not_x(QB.field('Name').ne('Value')).toString());
		System.assertEquals('NOT (Name NOT IN (\'Value1\',\'Value2\'))',QB.not_x(QB.field('Name').ne(new List<String>{'Value1','Value2'})).toString());

		Test.stopTest();
	}

	@isTest 
	static void andCriteriaTest() {
		Test.startTest();

		System.assertEquals('(Name = \'Value\') AND (Name != \'Value\')',
							QB.and_x(QB.field('Name').eq('Value'),QB.field('Name').ne('Value')).toString());
		System.assertEquals('(Name = \'Value\') AND (Name != \'Value\') AND (Name LIKE \'%Value%\')',
							QB.and_x(QB.field('Name').eq('Value'),QB.field('Name').ne('Value'))
							.add(QB.field('Name').lk('%Value%')).toString());
		System.assertEquals('(Name IN (\'Value1\',\'Value2\')) AND (Name NOT IN (\'Value1\',\'Value2\')) AND (Name LIKE \'%Value%\')',
							QB.and_x(QB.field('Name').eq(new List<String>{'Value1','Value2'}),QB.field('Name').ne(new List<String>{'Value1','Value2'}))
							.add(QB.field('Name').lk('%Value%')).toString());

		Test.stopTest();
	}

	@isTest 
	static void orCriteriaTest() {
		Test.startTest();

		System.assertEquals('(Name = \'Value\') OR (Name != \'Value\')',
							QB.or_x(QB.field('Name').eq('Value'),QB.field('Name').ne('Value')).toString());
		System.assertEquals('(Name = \'Value\') OR (Name != \'Value\') OR (Name LIKE \'%Value%\')',
							QB.or_x(QB.field('Name').eq('Value'),QB.field('Name').ne('Value'))
							.add(QB.field('Name').lk('%Value%')).toString());
		System.assertEquals('(Name IN (\'Value1\',\'Value2\')) OR (Name NOT IN (\'Value1\',\'Value2\')) OR (Name LIKE \'%Value%\')',
							QB.or_x(QB.field('Name').eq(new List<String>{'Value1','Value2'}),QB.field('Name').ne(new List<String>{'Value1','Value2'}))
							.add(QB.field('Name').lk('%Value%')).toString());

		Test.stopTest();
	}

	@isTest 
	static void criteriaTest() {
		Test.startTest();

		System.assertEquals('(Name = \'Value1\') AND (NOT (Name != \'Value2\'))',
							QB.and_x(QB.field('Name').eq('Value1'),QB.not_x(QB.field('Name').ne('Value2'))).toString());
		System.assertEquals('(Name = \'Value1\') OR (NOT (Name != \'Value2\'))',
							QB.or_x(QB.field('Name').eq('Value1'),QB.not_x(QB.field('Name').ne('Value2'))).toString());
		System.assertEquals('(Name = \'Value1\') AND ((Name != \'Value2\') OR (Name != \'Value3\'))',
							QB.and_x(QB.field('Name').eq('Value1'),QB.or_x(QB.field('Name').ne('Value2'),QB.field('Name').ne('Value3'))).toString());
		System.assertEquals('(Name = \'Value1\') OR ((Name != \'Value2\') AND (Name != \'Value3\'))',
							QB.or_x(QB.field('Name').eq('Value1'),QB.and_x(QB.field('Name').ne('Value2'),QB.field('Name').ne('Value3'))).toString());
		System.assertEquals('NOT ((Name != \'Value1\') AND (Name != \'Value2\'))',
							QB.not_x(QB.and_x(QB.field('Name').ne('Value1'),QB.field('Name').ne('Value2'))).toString());
		System.assertEquals('NOT ((Name != \'Value1\') OR (Name != \'Value2\'))',
							QB.not_x(QB.or_x(QB.field('Name').ne('Value1'),QB.field('Name').ne('Value2'))).toString());

		Test.stopTest();
	}

	@isTest 
	static void criteriaSpecialCasesTest() {
		Test.startTest();

		System.assertEquals('Name', QB.field('Name').toString());
		System.assertEquals('Name', QB.field('Name').op(QB.Op.EQ,new List<String>()).toString());
		try{
			String test=QB.field('Name').op(QB.Op.LK,new List<String>{'Value1','Value2'}).toString();
		}catch(Exception e){
			System.assertEquals('Only the operators EQUAL & NOTEQUAL can handle a list of values',e.getMessage());
		}
		// TODO

		Test.stopTest();
	}	

	/* Tests for Query builder */
	@isTest 
	static void selectFieldsClauseTest() {
		Test.startTest();

		System.assertEquals('SELECT Name',QB.select_x('Name').toString());
		System.assertEquals('SELECT Name1,Name2',QB.select_x('Name1,Name2').toString());
		System.assertEquals('SELECT Name1,Name2',QB.select_x(new List<String>{'Name1','Name2'}).toString());
		System.assertEquals('SELECT Name,(SELECT Name FROM Account)',
								QB.select_x('Name')
								.addSubQuery(QB.select_x('Name').from_x('Account')).toString());

		Test.stopTest();
	}

	@isTest 
	static void selectAggregateClauseTest() {
		Test.startTest();

		System.assertEquals('SELECT COUNT()',QB.select_x(QB.count()).toString());
		System.assertEquals('SELECT COUNT(Name)',QB.select_x(QB.count('Name')).toString());
		System.assertEquals('SELECT COUNT(Name1),Name2',QB.select_x(QB.count('Name1'),'Name2').toString());
		System.assertEquals('SELECT COUNT(Name1),Name2,Name3',QB.select_x(QB.count('Name1'),'Name2,Name3').toString());
		System.assertEquals('SELECT COUNT(Name1),Name2,Name3',QB.select_x(QB.count('Name1'),new List<String>{'Name2','Name3'}).toString());
		System.assertEquals('SELECT COUNT_DISTINCT(Name)',QB.select_x(QB.count_distinct('Name')).toString());
		System.assertEquals('SELECT AVG()',QB.select_x(QB.avg()).toString());
		System.assertEquals('SELECT MIN()',QB.select_x(QB.min()).toString());
		System.assertEquals('SELECT MAX()',QB.select_x(QB.max()).toString());
		System.assertEquals('SELECT SUM()',QB.select_x(QB.sum()).toString());
		try{
			String test=QB.select_x(QB.count())
							.addSubQuery(QB.select_x('Name').from_x('Account')).toString();
		}catch(Exception e){
			System.assertEquals('You can\'t add a sub query to aggregate clause',e.getMessage());
		}

		Test.stopTest();
	}

	@isTest 
	static void selectQueryTest() {
		Test.startTest();

		System.assertEquals('SELECT Name FROM Account',QB.select_x('Name')
														.from_x('Account').toString());
		System.assertEquals('SELECT Name FROM Account WHERE Name = \'Value\'',QB.select_x('Name')
														.from_x('Account')
														.where_x('Name',QB.Op.EQ,'Value').toString());
		System.assertEquals('SELECT Name FROM Account WHERE Name IN (\'Value1\',\'Value2\')',QB.select_x('Name')
														.from_x('Account')
														.where_x('Name',QB.Op.EQ,new List<String>{'Value1','Value2'}).toString());
		System.assertEquals('SELECT Name FROM Account WHERE Name = \'Value\'',QB.select_x('Name')
														.from_x('Account')
														.where_x(QB.Field('Name').eq('Value')).toString());
		System.assertEquals('SELECT Name FROM Account GROUP BY Name',QB.select_x('Name')
														.from_x('Account')
														.groupBy('Name').toString());
		System.assertEquals('SELECT Name FROM Account GROUP BY Name1,Name2',QB.select_x('Name')
														.from_x('Account')
														.groupBy(new List<String>{'Name1','Name2'}).toString());
		System.assertEquals('SELECT Name FROM Account GROUP BY Name HAVING COUNT(Name) = 1',QB.select_x('Name')
														.from_x('Account')
														.groupBy('Name',QB.count('Name').eq(1)).toString());
		System.assertEquals('SELECT Name FROM Account GROUP BY Name1,Name2 HAVING COUNT(Name) = 1',QB.select_x('Name')
														.from_x('Account')
														.groupBy(new List<String>{'Name1','Name2'},QB.count('Name').eq(1)).toString());
		System.assertEquals('SELECT Name FROM Account ORDER BY Name',QB.select_x('Name')
														.from_x('Account')
														.orderBy('Name').toString());
		System.assertEquals('SELECT Name FROM Account ORDER BY Name1,Name2',QB.select_x('Name')
														.from_x('Account')
														.orderBy(new List<String>{'Name1','Name2'}).toString());
		System.assertEquals('SELECT Name FROM Account LIMIT 1',QB.select_x('Name')
														.from_x('Account')
														.limitTo(1).toString());
		System.assertEquals('SELECT Name FROM Account OFFSET 1',QB.select_x('Name')
														.from_x('Account')
														.offset(1).toString());

		Test.stopTest();
	}

	@isTest 
	static void selectWhereQueryTest() {
		Test.startTest();

		System.assertEquals('SELECT Name FROM Account WHERE Name = \'Value\'',QB.select_x('Name')
														.from_x('Account')
														.where_x(QB.Field('Name').eq('Value')).toString());
		System.assertEquals('SELECT Name FROM Account WHERE Name = \'Value\' GROUP BY Name',QB.select_x('Name')
														.from_x('Account')
														.where_x(QB.Field('Name').eq('Value'))
														.groupBy('Name').toString());
		System.assertEquals('SELECT Name FROM Account WHERE Name = \'Value\' GROUP BY Name1,Name2',QB.select_x('Name')
														.from_x('Account')
														.where_x(QB.Field('Name').eq('Value'))
														.groupBy(new List<String>{'Name1','Name2'}).toString());
		System.assertEquals('SELECT Name FROM Account WHERE Name = \'Value\' GROUP BY Name HAVING COUNT(Name) = 1',QB.select_x('Name')
														.from_x('Account')
														.where_x(QB.Field('Name').eq('Value'))
														.groupBy('Name',QB.count('Name').eq(1)).toString());
		System.assertEquals('SELECT Name FROM Account WHERE Name = \'Value\' GROUP BY Name1,Name2 HAVING COUNT(Name) = 1',QB.select_x('Name')
														.from_x('Account')
														.where_x(QB.Field('Name').eq('Value'))
														.groupBy(new List<String>{'Name1','Name2'},QB.count('Name').eq(1)).toString());
		System.assertEquals('SELECT Name FROM Account WHERE Name = \'Value\' ORDER BY Name',QB.select_x('Name')
														.from_x('Account')
														.where_x(QB.Field('Name').eq('Value'))
														.orderBy('Name').toString());
		System.assertEquals('SELECT Name FROM Account WHERE Name = \'Value\' ORDER BY Name1,Name2',QB.select_x('Name')
														.from_x('Account')
														.where_x(QB.Field('Name').eq('Value'))
														.orderBy(new List<String>{'Name1','Name2'}).toString());
		System.assertEquals('SELECT Name FROM Account WHERE Name = \'Value\' LIMIT 1',QB.select_x('Name')
														.from_x('Account')
														.where_x(QB.Field('Name').eq('Value'))
														.limitTo(1).toString());
		System.assertEquals('SELECT Name FROM Account WHERE Name = \'Value\' OFFSET 1',QB.select_x('Name')
														.from_x('Account')
														.where_x(QB.Field('Name').eq('Value'))
														.offset(1).toString());

		Test.stopTest();
	}

	@isTest 
	static void selectGroupByQueryTest() {
		Test.startTest();

		// TODO

		Test.stopTest();
	}

	@isTest 
	static void selectOrderByQueryTest() {
		Test.startTest();

		// TODO

		Test.stopTest();
	}

	@isTest 
	static void selectLimitQueryTest() {
		Test.startTest();

		// TODO

		Test.stopTest();
	}

	@isTest 
	static void selectOffsetQueryTest() {
		Test.startTest();

		// TODO

		Test.stopTest();
	}
}