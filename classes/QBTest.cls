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
	
	/* Tests for Condition builder */
	@isTest 
	private static void fieldConditionEqualTest() {
		Test.startTest();

		System.assertEquals('Name = \'Value\'',QB.field('Name').eq('Value').toString());
		System.assertEquals('Name = \'Value\'',QB.fieldExpr('Name',QB.Op.EQ,'Value').toString());
		System.assertEquals('Name = \'Value\'',QB.fieldExpr('Name','=','Value').toString());
		System.assertEquals('Name = \'Value\'',QB.field('Name').equal('Value').toString());

		System.assertEquals('Name IN (\'Value1\',\'Value2\')',QB.field('Name').eq(new List<String>{'Value1','Value2'}).toString());
		System.assertEquals('Name IN (\'Value1\',\'Value2\')',QB.fieldExpr('Name',QB.Op.EQ,new List<String>{'Value1','Value2'}).toString());
		System.assertEquals('Name IN (\'Value1\',\'Value2\')',QB.fieldExpr('Name','=',new List<String>{'Value1','Value2'}).toString());
		System.assertEquals('Name IN (\'Value1\',\'Value2\')',QB.field('Name').equal(new List<String>{'Value1','Value2'}).toString());

		Test.stopTest();
	}
	
	@isTest 
	private static void fieldConditionNotEqualTest() {
		Test.startTest();

		System.assertEquals('Name != \'Value\'',QB.field('Name').ne('Value').toString());
		System.assertEquals('Name != \'Value\'',QB.fieldExpr('Name',QB.Op.NE,'Value').toString());
		System.assertEquals('Name != \'Value\'',QB.fieldExpr('Name','!=','Value').toString());
		System.assertEquals('Name != \'Value\'',QB.field('Name').notEqual('Value').toString());

		System.assertEquals('Name NOT IN (\'Value1\',\'Value2\')',QB.field('Name').ne(new List<String>{'Value1','Value2'}).toString());
		System.assertEquals('Name NOT IN (\'Value1\',\'Value2\')',QB.fieldExpr('Name',QB.Op.NE,new List<String>{'Value1','Value2'}).toString());
		System.assertEquals('Name NOT IN (\'Value1\',\'Value2\')',QB.fieldExpr('Name','!=',new List<String>{'Value1','Value2'}).toString());
		System.assertEquals('Name NOT IN (\'Value1\',\'Value2\')',QB.field('Name').notEqual(new List<String>{'Value1','Value2'}).toString());

		Test.stopTest();
	}

	@isTest 
	private static void fieldConditionGreaterThanTest() {
		Test.startTest();

		System.assertEquals('Name > \'Value\'',QB.field('Name').gt('Value').toString());
		System.assertEquals('Name > \'Value\'',QB.fieldExpr('Name',QB.Op.GT,'Value').toString());
		System.assertEquals('Name > \'Value\'',QB.fieldExpr('Name','>','Value').toString());
		System.assertEquals('Name > \'Value\'',QB.field('Name').greaterThan('Value').toString());

		Test.stopTest();
	}

	@isTest 
	private static void fieldConditionLessThanTest() {
		Test.startTest();

		System.assertEquals('Name < \'Value\'',QB.field('Name').lt('Value').toString());
		System.assertEquals('Name < \'Value\'',QB.fieldExpr('Name',QB.Op.LT,'Value').toString());
		System.assertEquals('Name < \'Value\'',QB.fieldExpr('Name','<','Value').toString());
		System.assertEquals('Name < \'Value\'',QB.field('Name').lessThan('Value').toString());

		Test.stopTest();
	}
	
	@isTest 
	private static void fieldConditionGreaterOrEqualTest() {
		Test.startTest();

		System.assertEquals('Name >= \'Value\'',QB.field('Name').ge('Value').toString());
		System.assertEquals('Name >= \'Value\'',QB.fieldExpr('Name',QB.Op.GE,'Value').toString());
		System.assertEquals('Name >= \'Value\'',QB.fieldExpr('Name','>=','Value').toString());
		System.assertEquals('Name >= \'Value\'',QB.field('Name').greaterOrEqual('Value').toString());

		Test.stopTest();
	}
	
	@isTest 
	private static void fieldConditionLessOrEqualTest() {
		Test.startTest();

		System.assertEquals('Name <= \'Value\'',QB.field('Name').le('Value').toString());
		System.assertEquals('Name <= \'Value\'',QB.fieldExpr('Name',QB.Op.LE,'Value').toString());
		System.assertEquals('Name <= \'Value\'',QB.fieldExpr('Name','<=','Value').toString());
		System.assertEquals('Name <= \'Value\'',QB.field('Name').lessOrEqual('Value').toString());

		Test.stopTest();
	}
	
	@isTest 
	private static void fieldConditionIsLikeTest() {
		Test.startTest();

		System.assertEquals('Name LIKE \'Value\'',QB.field('Name').lk('Value').toString());
		System.assertEquals('Name LIKE \'Value\'',QB.fieldExpr('Name',QB.Op.LK,'Value').toString());
		System.assertEquals('Name LIKE \'Value\'',QB.fieldExpr('Name','LIKE','Value').toString());
		System.assertEquals('Name LIKE \'Value\'',QB.field('Name').isLike('Value').toString());

		Test.stopTest();
	}

	@isTest 
	private static void havingConditionTest() {
		Test.startTest();

		System.assertEquals('COUNT() = 1',QB.count().eq(1).toString());
		System.assertEquals('COUNT(Name) = 1',QB.count('Name').eq(1).toString());
		System.assertEquals('COUNT_DISTINCT(Name) = 1',QB.count_distinct('Name').eq(1).toString());
		System.assertEquals('AVG(Name) = 1',QB.avg('Name').eq(1).toString());
		System.assertEquals('MIN(Name) = 1',QB.min('Name').eq(1).toString());
		System.assertEquals('MAX(Name) = 1',QB.max('Name').eq(1).toString());
		System.assertEquals('SUM(Name) = 1',QB.sum('Name').eq(1).toString());

		System.assertEquals('COUNT() != 1',QB.count().ne(1).toString());
		System.assertEquals('COUNT() > 1',QB.count().gt(1).toString());
		System.assertEquals('COUNT() < 1',QB.count().lt(1).toString());
		System.assertEquals('COUNT() >= 1',QB.count().ge(1).toString());
		System.assertEquals('COUNT() <= 1',QB.count().le(1).toString());
		System.assertEquals('COUNT() = 1',QB.count().equal(1).toString());
		System.assertEquals('COUNT() != 1',QB.count().notequal(1).toString());
		System.assertEquals('COUNT() > 1',QB.count().greaterThan(1).toString());
		System.assertEquals('COUNT() < 1',QB.count().lessThan(1).toString());
		System.assertEquals('COUNT() >= 1',QB.count().greaterOrEqual(1).toString());
		System.assertEquals('COUNT() <= 1',QB.count().lessOrEqual(1).toString());
		
		System.assertEquals('NOT (COUNT() = 1)',QB.not_x(QB.count().eq(1)).toString());
		System.assertEquals('(COUNT() = 1) OR (COUNT() != 1)',QB.or_x(QB.count().eq(1),QB.count().ne(1)).toString());
		System.assertEquals('(COUNT() = 1) AND (COUNT() > 1)',QB.and_x(QB.count().eq(1),QB.count().gt(1)).toString());
		// TODO

		Test.stopTest();
	}

	@isTest 
	private static void notConditionTest() {
		Test.startTest();

		System.assertEquals('NOT (Name = \'Value\')',QB.not_x(QB.field('Name').eq('Value')).toString());
		System.assertEquals('NOT (Name != \'Value\')',QB.not_x(QB.field('Name').ne('Value')).toString());
		System.assertEquals('NOT (Name NOT IN (\'Value1\',\'Value2\'))',QB.not_x(QB.field('Name').ne(new List<String>{'Value1','Value2'})).toString());

		Test.stopTest();
	}

	@isTest 
	private static void andConditionTest() {
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
	private static void orConditionTest() {
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
	private static void conditionTest() {
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
	private static void conditionSpecialCasesTest() {
		Test.startTest();

		System.assertEquals('Name = 1', QB.field('Name').eq(1).toString());
		System.assertEquals('Name = true', QB.field('Name').eq(true).toString());
		System.assertEquals('Name = NULL', QB.field('Name').eq(null).toString());
		System.assertEquals('Name = \'1960-02-17\'', QB.field('Name').eq(date.newinstance(1960, 2, 17)).toString());
		System.assertEquals('Name', QB.field('Name').toString());
		System.assertEquals('Name = :qbBindVariable',QB.field('Name').eq(QB.bind('Value')).toString());

		try{
			String test=QB.and_x(QB.field('Name1').eq(QB.bind('Value1')),QB.field('Name2').eq(QB.bind('Value2'))).toString();
			System.assert(false);
		}catch(Exception e){
			System.assert(true);
		}

		try{
			String test=QB.field('Name').eq(new List<String>()).toString();
			System.assert(false);
		}catch(Exception e){
			System.assert(true);
		}

		try{
			String test=QB.fieldExpr('Name','UnkownOperator','Value').toString();
			System.assert(false);
		}catch(Exception e){
			System.assert(true);
		}

		try{
			String test=QB.fieldExpr('Name',QB.Op.LK,new List<String>{'Value1','Value2'}).toString();
			System.assert(false);
		}catch(Exception e){
			System.assert(true);
		}

		try{
			String test=QB.fieldExpr('Name',QB.Op.EQ,new Map<String,String>()).toString();
			System.assert(false);
		}catch(Exception e){
			System.assert(true);
		}
		// TODO

		Test.stopTest();
	}	

	@isTest 
	private static void dateLiteralsTest() {
		Test.startTest();

		System.assertEquals('LAST_N_DAYS:1',QB.LAST_N_DAYS(1));
		System.assertEquals('NEXT_N_DAYS:1',QB.NEXT_N_DAYS(1));
		System.assertEquals('NEXT_N_WEEKS:1',QB.NEXT_N_WEEKS(1));
		System.assertEquals('LAST_N_WEEKS:1',QB.LAST_N_WEEKS(1));
		System.assertEquals('NEXT_N_MONTHS:1',QB.NEXT_N_MONTHS(1));
		System.assertEquals('LAST_N_MONTHS:1',QB.LAST_N_MONTHS(1));
		System.assertEquals('NEXT_N_QUARTERS:1',QB.NEXT_N_QUARTERS(1));
		System.assertEquals('LAST_N_QUARTERS:1',QB.LAST_N_QUARTERS(1));
		System.assertEquals('NEXT_N_YEARS:1',QB.NEXT_N_YEARS(1));
		System.assertEquals('LAST_N_YEARS:1',QB.LAST_N_YEARS(1));
		System.assertEquals('NEXT_N_FISCAL_QUARTERS:1',QB.NEXT_N_FISCAL_QUARTERS(1));
		System.assertEquals('LAST_N_FISCAL_QUARTERS:1',QB.LAST_N_FISCAL_QUARTERS(1));
		System.assertEquals('LAST_N_FISCAL_YEARS:1',QB.LAST_N_FISCAL_YEARS(1));
			
		Test.stopTest();
	}

	/* Tests for Query builder */
	@isTest 
	private static void selectFieldsClauseTest() {
		Test.startTest();

		System.assertEquals('SELECT ',QB.select_x('*').toString());
		System.assertEquals('SELECT ',QB.select_x('?').toString());
		System.assertEquals('SELECT ',QB.select_x('+').toString());
		System.assertEquals('SELECT Name',QB.select_x('Name').toString());
		System.assertEquals('SELECT Name',QB.select_x(Account.Name).toString());
		System.assertEquals('SELECT Name1,Name2',
								QB.select_x('Name1')
								.addField('Name2').toString());
		System.assertEquals('SELECT Name1,Name2,Name3',
								QB.select_x('Name1')
								.addField('Name2,Name3').toString());
		System.assertEquals('SELECT Name1,Name2,Name3',
								QB.select_x('Name1')
								.addFields(new List<String>{'Name2','Name3'}).toString());
		System.assertEquals('SELECT Name1,Name2',QB.select_x('Name1,Name2').toString());
		System.assertEquals('SELECT Name1,Name2',QB.select_x(new List<String>{'Name1','Name2'}).toString());
		System.assertEquals('SELECT Name1,CALENDAR_MONTH(Name2)',
								QB.select_x('Name1')
								.addFunction(QB.calendar_month('Name2')).toString());
		System.assertEquals('SELECT Name1,CALENDAR_QUARTER(Name2)',
								QB.select_x('Name1')
								.addFunction(QB.calendar_quarter('Name2')).toString());
		System.assertEquals('SELECT Name1,CALENDAR_YEAR(Name2)',
								QB.select_x('Name1')
								.addFunction(QB.calendar_year('Name2')).toString());
		System.assertEquals('SELECT Name1,DAY_IN_MONTH(Name2)',
								QB.select_x('Name1')
								.addFunction(QB.day_in_month('Name2')).toString());
		System.assertEquals('SELECT Name1,DAY_IN_WEEK(Name2)',
								QB.select_x('Name1')
								.addFunction(QB.day_in_week('Name2')).toString());
		System.assertEquals('SELECT Name1,FISCAL_MONTH(Name2)',
								QB.select_x('Name1')
								.addFunction(QB.fiscal_month('Name2')).toString());
		System.assertEquals('SELECT Name1,FISCAL_QUARTER(Name2)',
								QB.select_x('Name1')
								.addFunction(QB.fiscal_quarter('Name2')).toString());
		System.assertEquals('SELECT Name1,FISCAL_YEAR(Name2)',
								QB.select_x('Name1')
								.addFunction(QB.fiscal_year('Name2')).toString());
		System.assertEquals('SELECT Name1,HOUR_IN_DAY(Name2)',
								QB.select_x('Name1')
								.addFunction(QB.hour_in_day('Name2')).toString());
		System.assertEquals('SELECT Name1,WEEK_IN_MONTH(Name2)',
								QB.select_x('Name1')
								.addFunction(QB.week_in_month('Name2')).toString());
		System.assertEquals('SELECT Name1,WEEK_IN_YEAR(Name2)',
								QB.select_x('Name1')
								.addFunction(QB.week_in_year('Name2')).toString());
		System.assertEquals('SELECT Name1,DATE_ONLY(Name2)',
								QB.select_x('Name1')
								.addFunction(QB.date_only('Name2')).toString());
		System.assertEquals('SELECT Name1,TOLABEL(Name2)',
								QB.select_x('Name1')
								.addFunction(QB.toLabel('Name2')).toString());
		System.assertEquals('SELECT Name,(SELECT Name FROM Account)',
								QB.select_x('Name')
								.addSubQuery(QB.select_x('Name')
								.from_x('Account')).toString());

		Test.stopTest();
	}

	@isTest 
	private static void selectAggregateClauseTest() {
		Test.startTest();

		System.assertEquals('SELECT COUNT()',QB.select_x(QB.count()).toString());
		System.assertEquals('SELECT COUNT(Name)',QB.select_x(QB.count('Name')).toString());
		System.assertEquals('SELECT COUNT(Name1),Name2',QB.select_x(QB.count('Name1')).addField('Name2').toString());
		System.assertEquals('SELECT COUNT(Name1),Name2,Name3',QB.select_x(QB.count('Name1')).addField('Name2,Name3').toString());
		System.assertEquals('SELECT COUNT(Name1),Name2,Name3',QB.select_x(QB.count('Name1')).addFields(new List<String>{'Name2','Name3'}).toString());
		System.assertEquals('SELECT COUNT_DISTINCT(Name)',QB.select_x(QB.count_distinct('Name')).toString());
		System.assertEquals('SELECT AVG(Name)',QB.select_x(QB.avg('Name')).toString());
		System.assertEquals('SELECT MIN(Name)',QB.select_x(QB.min('Name')).toString());
		System.assertEquals('SELECT MAX(Name)',QB.select_x(QB.max('Name')).toString());
		System.assertEquals('SELECT SUM(Name)',QB.select_x(QB.sum('Name')).toString());

		Test.stopTest();
	}

	@isTest 
	private static void selectQueryTest() {
		Test.startTest();
		System.assertEquals('SELECT Name FROM Account',QB.select_x('Name')
														.from_x('Account').toString());
		System.assertEquals('SELECT Name FROM Account',QB.select_x('Name')
														.from_x('Account').toString());
		System.assertEquals('SELECT Name FROM Account',QB.select_x('Name')
														.from_x(Account.sObjectType).toString());
		System.assertEquals('SELECT Name FROM Account WHERE Name = \'Value\'',QB.select_x('Name')
														.from_x('Account')
														.where_x('Name',QB.Op.EQ,'Value').toString());
		System.assertEquals('SELECT Name FROM Account WHERE Name = \'Value\'',QB.select_x('Name')
														.from_x('Account')
														.where_x('Name','=','Value').toString());
		System.assertEquals('SELECT Name FROM Account WHERE Name IN (\'Value1\',\'Value2\')',QB.select_x('Name')
														.from_x('Account')
														.where_x('Name',QB.Op.EQ,new List<String>{'Value1','Value2'}).toString());
		System.assertEquals('SELECT Name FROM Account WHERE Name = NULL',QB.select_x('Name')
														.from_x('Account')
														.where_x('Name',QB.Op.EQ,null).toString());
		System.assertEquals('SELECT Name FROM Account WHERE Name = \'Value\'',QB.select_x('Name')
														.from_x('Account')
														.where_x(QB.Field('Name').eq('Value')).toString());
		System.assertEquals('SELECT Name FROM Account GROUP BY Name',QB.select_x('Name')
														.from_x('Account')
														.groupBy('Name').toString());
		System.assertEquals('SELECT Name FROM Account GROUP BY CALENDAR_MONTH(Name)',QB.select_x('Name')
														.from_x('Account')
														.groupBy(QB.calendar_month('Name')).toString());
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
		System.assert(QB.select_x('*')
							.from_x('Account').toString().contains('Name'));
		System.assert(QB.select_x('N?me?')
							.from_x('Account').toString().contains('Name'));

		Test.stopTest();
	}

	@isTest 
	private static void selectWhereQueryTest() {
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
	private static void selectGroupByQueryTest() {
		Test.startTest();

		System.assertEquals('SELECT Name FROM Account GROUP BY Name',QB.select_x('Name')
														.from_x('Account')
														.groupBy('Name').toString());
		System.assertEquals('SELECT Name FROM Account GROUP BY Name ORDER BY Name',QB.select_x('Name')
														.from_x('Account')
														.groupBy('Name')
														.orderBy('Name').toString());
		System.assertEquals('SELECT Name FROM Account GROUP BY Name ORDER BY Name1,Name2',QB.select_x('Name')
														.from_x('Account')
														.groupBy('Name')
														.orderBy(new List<String>{'Name1','Name2'}).toString());
		System.assertEquals('SELECT Name FROM Account GROUP BY Name LIMIT 1',QB.select_x('Name')
														.from_x('Account')
														.groupBy('Name')
														.limitTo(1).toString());
		System.assertEquals('SELECT Name FROM Account GROUP BY Name OFFSET 1',QB.select_x('Name')
														.from_x('Account')
														.groupBy('Name')
														.offset(1).toString());

		Test.stopTest();
	}

	@isTest 
	private static void selectOrderByQueryTest() {
		Test.startTest();

		System.assertEquals('SELECT Name FROM Account ORDER BY Name',QB.select_x('Name')
														.from_x('Account')
														.orderBy('Name').toString());
		System.assertEquals('SELECT Name FROM Account ORDER BY Name ASC NULLS FIRST',QB.select_x('Name')
														.from_x('Account')
														.orderBy('Name',QB.ascNullsFirst()).toString());
		System.assertEquals('SELECT Name FROM Account ORDER BY Name ASC NULLS LAST',QB.select_x('Name')
														.from_x('Account')
														.orderBy('Name',QB.ascNullsLast()).toString());
		System.assertEquals('SELECT Name FROM Account ORDER BY Name DESC NULLS FIRST',QB.select_x('Name')
														.from_x('Account')
														.orderBy('Name',QB.descNullsFirst()).toString());
		System.assertEquals('SELECT Name FROM Account ORDER BY Name DESC NULLS LAST',QB.select_x('Name')
														.from_x('Account')
														.orderBy('Name',QB.descNullsLast()).toString());
		System.assertEquals('SELECT Name FROM Account ORDER BY Name1 DESC NULLS LAST Name2',QB.select_x('Name')
														.from_x('Account')
														.orderBy('Name1',QB.descNullsLast())
														.addOrder('Name2').toString());
		System.assertEquals('SELECT Name FROM Account ORDER BY Name1 DESC NULLS LAST Name2 Name3',QB.select_x('Name')
														.from_x('Account')
														.orderBy('Name1',QB.descNullsLast())
														.addOrder(new List<String>{'Name2','Name3'}).toString());
		System.assertEquals('SELECT Name FROM Account ORDER BY Name1 DESC NULLS LAST Name2 ASC NULLS FIRST',QB.select_x('Name')
														.from_x('Account')
														.orderBy('Name1',QB.descNullsLast())
														.addOrder('Name2',QB.ascNullsFirst()).toString());
		System.assertEquals('SELECT Name FROM Account ORDER BY Name LIMIT 1',QB.select_x('Name')
														.from_x('Account')
														.orderBy('Name')
														.limitTo(1).toString());
		System.assertEquals('SELECT Name FROM Account ORDER BY Name OFFSET 1',QB.select_x('Name')
														.from_x('Account')
														.orderBy('Name')
														.offset(1).toString());

		Test.stopTest();
	}

	@isTest 
	private static void selectLimitQueryTest() {
		Test.startTest();

		System.assertEquals('SELECT Name FROM Account LIMIT 1',QB.select_x('Name')
														.from_x('Account')
														.limitTo(1).toString());
		System.assertEquals('SELECT Name FROM Account LIMIT 1 OFFSET 1',QB.select_x('Name')
														.from_x('Account')
														.limitTo(1)
														.offset(1).toString());

		Test.stopTest();
	}
	
}