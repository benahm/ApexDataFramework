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
	static void fieldConditionEqualTest() {
		Test.startTest();

		System.assertEquals('Name = \'Value\'',QB.field('Name').eq('Value').toString());
		System.assertEquals('Name = \'Value\'',QB.field(Account.Name).eq('Value').toString());
		System.assertEquals('Name = \'Value\'',QB.fieldExpr('Name',QB.Op.EQ,'Value').toString());
		System.assertEquals('Name = \'Value\'',QB.fieldExpr(Account.Name,QB.Op.EQ,'Value').toString());
		System.assertEquals('Name = \'Value\'',QB.fieldExpr('Name','=','Value').toString());
		System.assertEquals('Name = \'Value\'',QB.fieldExpr(Account.Name,'=','Value').toString());
		System.assertEquals('Name = \'Value\'',QB.field('Name').equal('Value').toString());

		System.assertEquals('Name IN (\'Value1\',\'Value2\')',QB.field('Name').eq(new List<String>{'Value1','Value2'}).toString());
		System.assertEquals('Name IN (\'Value1\',\'Value2\')',QB.fieldExpr('Name',QB.Op.EQ,new List<String>{'Value1','Value2'}).toString());
		System.assertEquals('Name IN (\'Value1\',\'Value2\')',QB.fieldExpr('Name','=',new List<String>{'Value1','Value2'}).toString());
		System.assertEquals('Name IN (\'Value1\',\'Value2\')',QB.field('Name').equal(new List<String>{'Value1','Value2'}).toString());

		Test.stopTest();
	}
	
	@isTest 
	static void fieldConditionNotEqualTest() {
		Test.startTest();

		System.assertEquals('Name != \'Value\'',QB.field('Name').ne('Value').toString());
		System.assertEquals('Name != \'Value\'',QB.field(Account.Name).ne('Value').toString());
		System.assertEquals('Name != \'Value\'',QB.fieldExpr('Name',QB.Op.NE,'Value').toString());
		System.assertEquals('Name != \'Value\'',QB.fieldExpr(Account.Name,QB.Op.NE,'Value').toString());
		System.assertEquals('Name != \'Value\'',QB.fieldExpr('Name','!=','Value').toString());
		System.assertEquals('Name != \'Value\'',QB.fieldExpr(Account.Name,'!=','Value').toString());
		System.assertEquals('Name != \'Value\'',QB.field('Name').notEqual('Value').toString());

		System.assertEquals('Name NOT IN (\'Value1\',\'Value2\')',QB.field('Name').ne(new List<String>{'Value1','Value2'}).toString());
		System.assertEquals('Name NOT IN (\'Value1\',\'Value2\')',QB.fieldExpr('Name',QB.Op.NE,new List<String>{'Value1','Value2'}).toString());
		System.assertEquals('Name NOT IN (\'Value1\',\'Value2\')',QB.fieldExpr('Name','!=',new List<String>{'Value1','Value2'}).toString());
		System.assertEquals('Name NOT IN (\'Value1\',\'Value2\')',QB.field('Name').notEqual(new List<String>{'Value1','Value2'}).toString());

		Test.stopTest();
	}

	@isTest 
	static void fieldConditionGreaterThanTest() {
		Test.startTest();

		System.assertEquals('Name > \'Value\'',QB.field('Name').gt('Value').toString());
		System.assertEquals('Name > \'Value\'',QB.fieldExpr('Name',QB.Op.GT,'Value').toString());
		System.assertEquals('Name > \'Value\'',QB.fieldExpr('Name','>','Value').toString());
		System.assertEquals('Name > \'Value\'',QB.field('Name').greaterThan('Value').toString());

		Test.stopTest();
	}

	@isTest 
	static void fieldConditionLessThanTest() {
		Test.startTest();

		System.assertEquals('Name < \'Value\'',QB.field('Name').lt('Value').toString());
		System.assertEquals('Name < \'Value\'',QB.fieldExpr('Name',QB.Op.LT,'Value').toString());
		System.assertEquals('Name < \'Value\'',QB.fieldExpr('Name','<','Value').toString());
		System.assertEquals('Name < \'Value\'',QB.field('Name').lessThan('Value').toString());

		Test.stopTest();
	}
	
	@isTest 
	static void fieldConditionGreaterOrEqualTest() {
		Test.startTest();

		System.assertEquals('Name >= \'Value\'',QB.field('Name').ge('Value').toString());
		System.assertEquals('Name >= \'Value\'',QB.fieldExpr('Name',QB.Op.GE,'Value').toString());
		System.assertEquals('Name >= \'Value\'',QB.fieldExpr('Name','>=','Value').toString());
		System.assertEquals('Name >= \'Value\'',QB.field('Name').greaterOrEqual('Value').toString());

		Test.stopTest();
	}
	
	@isTest 
	static void fieldConditionLessOrEqualTest() {
		Test.startTest();

		System.assertEquals('Name <= \'Value\'',QB.field('Name').le('Value').toString());
		System.assertEquals('Name <= \'Value\'',QB.fieldExpr('Name',QB.Op.LE,'Value').toString());
		System.assertEquals('Name <= \'Value\'',QB.fieldExpr('Name','<=','Value').toString());
		System.assertEquals('Name <= \'Value\'',QB.field('Name').lessOrEqual('Value').toString());

		Test.stopTest();
	}
	
	@isTest 
	static void fieldConditionIsLikeTest() {
		Test.startTest();

		System.assertEquals('Name LIKE \'Value\'',QB.field('Name').lk('Value').toString());
		System.assertEquals('Name LIKE \'Value\'',QB.fieldExpr('Name',QB.Op.LK,'Value').toString());
		System.assertEquals('Name LIKE \'Value\'',QB.fieldExpr('Name','LIKE','Value').toString());
		System.assertEquals('Name LIKE \'Value\'',QB.field('Name').isLike('Value').toString());

		Test.stopTest();
	}

	@isTest 
	static void havingConditionTest() {
		Test.startTest();

		System.assertEquals('COUNT() = 1',QB.count().eq(1).toString());
		System.assertEquals('COUNT(Name) = 1',QB.count('Name').eq(1).toString());
		System.assertEquals('COUNT(Name) = 1',QB.count(Account.Name).eq(1).toString());
		System.assertEquals('COUNT_DISTINCT(Name) = 1',QB.count_distinct('Name').eq(1).toString());
		System.assertEquals('COUNT_DISTINCT(Name) = 1',QB.count_distinct(Account.Name).eq(1).toString());
		System.assertEquals('AVG(Name) = 1',QB.avg('Name').eq(1).toString());
		System.assertEquals('AVG(Name) = 1',QB.avg(Account.Name).eq(1).toString());
		System.assertEquals('MIN(Name) = 1',QB.min('Name').eq(1).toString());
		System.assertEquals('MIN(Name) = 1',QB.min(Account.Name).eq(1).toString());
		System.assertEquals('MAX(Name) = 1',QB.max('Name').eq(1).toString());
		System.assertEquals('MAX(Name) = 1',QB.max(Account.Name).eq(1).toString());
		System.assertEquals('SUM(Name) = 1',QB.sum('Name').eq(1).toString());
		System.assertEquals('SUM(Name) = 1',QB.sum(Account.Name).eq(1).toString());

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
	static void notConditionTest() {
		Test.startTest();

		System.assertEquals('NOT (Name = \'Value\')',QB.not_x(QB.field('Name').eq('Value')).toString());
		System.assertEquals('NOT (Name != \'Value\')',QB.not_x(QB.field('Name').ne('Value')).toString());
		System.assertEquals('NOT (Name NOT IN (\'Value1\',\'Value2\'))',QB.not_x(QB.field('Name').ne(new List<String>{'Value1','Value2'})).toString());

		Test.stopTest();
	}

	@isTest 
	static void andConditionTest() {
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
	static void orConditionTest() {
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
	static void conditionTest() {
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
	static void conditionSpecialCasesTest() {
		Test.startTest();

		System.assertEquals('Name = 1', QB.field('Name').eq(1).toString());
		System.assertEquals('Name = true', QB.field('Name').eq(true).toString());
		System.assertEquals('Name = NULL', QB.field('Name').eq(null).toString());
		System.assertEquals('Name = 1960-02-17', QB.field('Name').eq(Date.newinstance(1960, 2, 17)).toString());
		System.assertEquals('Name = 1960-02-16T23:00:00.000+0000', QB.field('Name').eq(Datetime.newinstance(1960, 2, 17)).toString());
		System.assertEquals('Name', QB.field('Name').toString());
		System.assertEquals('Name = :bindVariable',QB.field('Name').eq(QB.bind('Value')).toString());

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
	static void dateLiteralsTest() {
		Test.startTest();

		System.assertEquals('LAST_N_DAYS:1',QB.LAST_N_DAYS(1).toString());
		System.assertEquals('NEXT_N_DAYS:1',QB.NEXT_N_DAYS(1).toString());
		System.assertEquals('NEXT_N_WEEKS:1',QB.NEXT_N_WEEKS(1).toString());
		System.assertEquals('LAST_N_WEEKS:1',QB.LAST_N_WEEKS(1).toString());
		System.assertEquals('NEXT_N_MONTHS:1',QB.NEXT_N_MONTHS(1).toString());
		System.assertEquals('LAST_N_MONTHS:1',QB.LAST_N_MONTHS(1).toString());
		System.assertEquals('NEXT_N_QUARTERS:1',QB.NEXT_N_QUARTERS(1).toString());
		System.assertEquals('LAST_N_QUARTERS:1',QB.LAST_N_QUARTERS(1).toString());
		System.assertEquals('NEXT_N_YEARS:1',QB.NEXT_N_YEARS(1).toString());
		System.assertEquals('LAST_N_YEARS:1',QB.LAST_N_YEARS(1).toString());
		System.assertEquals('NEXT_N_FISCAL_QUARTERS:1',QB.NEXT_N_FISCAL_QUARTERS(1).toString());
		System.assertEquals('LAST_N_FISCAL_QUARTERS:1',QB.LAST_N_FISCAL_QUARTERS(1).toString());
		System.assertEquals('LAST_N_FISCAL_YEARS:1',QB.LAST_N_FISCAL_YEARS(1).toString());
			
		Test.stopTest();
	}

	/* Tests for Query builder */
	@isTest 
	static void selectFieldsClauseTest() {
		Test.startTest();

		System.assertEquals('SELECT Id',QB.select_x().toString());
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

		System.assertEquals('SELECT CALENDAR_MONTH(Name)',
								QB.select_x(QB.calendar_month('Name')).toString());		
		System.assertEquals('SELECT CALENDAR_MONTH(Name)',
								QB.select_x(QB.calendar_month(Account.Name)).toString());
		System.assertEquals('SELECT CALENDAR_MONTH(CONVERTTIMEZONE(Name))',
								QB.select_x(QB.calendar_month(QB.convertTimeZone('Name'))).toString());
		System.assertEquals('SELECT CALENDAR_QUARTER(Name)',
								QB.select_x(QB.calendar_quarter('Name')).toString());
		System.assertEquals('SELECT CALENDAR_QUARTER(Name)',
								QB.select_x(QB.calendar_quarter(Account.Name)).toString());
		System.assertEquals('SELECT CALENDAR_QUARTER(CONVERTTIMEZONE(Name))',
								QB.select_x(QB.calendar_quarter(QB.convertTimeZone('Name'))).toString());
		System.assertEquals('SELECT CALENDAR_YEAR(Name)',
								QB.select_x(QB.calendar_year('Name')).toString());
		System.assertEquals('SELECT CALENDAR_YEAR(Name)',
								QB.select_x(QB.calendar_year(Account.Name)).toString());
		System.assertEquals('SELECT CALENDAR_YEAR(CONVERTTIMEZONE(Name))',
								QB.select_x(QB.calendar_year(QB.convertTimeZone('Name'))).toString());
		System.assertEquals('SELECT DAY_IN_MONTH(Name)',
								QB.select_x(QB.day_in_month('Name')).toString());
		System.assertEquals('SELECT DAY_IN_MONTH(Name)',
								QB.select_x(QB.day_in_month(Account.Name)).toString());
		System.assertEquals('SELECT DAY_IN_MONTH(CONVERTTIMEZONE(Name))',
								QB.select_x(QB.day_in_month(QB.convertTimeZone('Name'))).toString());
		System.assertEquals('SELECT DAY_IN_WEEK(Name)',
								QB.select_x(QB.day_in_week('Name')).toString());
		System.assertEquals('SELECT DAY_IN_WEEK(Name)',
								QB.select_x(QB.day_in_week(Account.Name)).toString());
		System.assertEquals('SELECT DAY_IN_WEEK(CONVERTTIMEZONE(Name))',
								QB.select_x(QB.day_in_week(QB.convertTimeZone('Name'))).toString());
		System.assertEquals('SELECT FISCAL_MONTH(Name)',
								QB.select_x(QB.fiscal_month('Name')).toString());
		System.assertEquals('SELECT FISCAL_MONTH(Name)',
								QB.select_x(QB.fiscal_month(Account.Name)).toString());
		System.assertEquals('SELECT FISCAL_MONTH(CONVERTTIMEZONE(Name))',
								QB.select_x(QB.fiscal_month(QB.convertTimeZone('Name'))).toString());
		System.assertEquals('SELECT FISCAL_QUARTER(Name)',
								QB.select_x(QB.fiscal_quarter('Name')).toString());
		System.assertEquals('SELECT FISCAL_QUARTER(Name)',
								QB.select_x(QB.fiscal_quarter(Account.Name)).toString());
		System.assertEquals('SELECT FISCAL_QUARTER(CONVERTTIMEZONE(Name))',
								QB.select_x(QB.fiscal_quarter(QB.convertTimeZone('Name'))).toString());
		System.assertEquals('SELECT FISCAL_YEAR(Name)',
								QB.select_x(QB.fiscal_year('Name')).toString());
		System.assertEquals('SELECT FISCAL_YEAR(Name)',
								QB.select_x(QB.fiscal_year(Account.Name)).toString());
		System.assertEquals('SELECT FISCAL_YEAR(CONVERTTIMEZONE(Name))',
								QB.select_x(QB.fiscal_year(QB.convertTimeZone('Name'))).toString());
		System.assertEquals('SELECT HOUR_IN_DAY(Name)',
								QB.select_x(QB.hour_in_day('Name')).toString());
		System.assertEquals('SELECT HOUR_IN_DAY(Name)',
								QB.select_x(QB.hour_in_day(Account.Name)).toString());
		System.assertEquals('SELECT HOUR_IN_DAY(CONVERTTIMEZONE(Name))',
								QB.select_x(QB.hour_in_day(QB.convertTimeZone('Name'))).toString());
		System.assertEquals('SELECT WEEK_IN_MONTH(Name)',
								QB.select_x(QB.week_in_month('Name')).toString());
		System.assertEquals('SELECT WEEK_IN_MONTH(Name)',
								QB.select_x(QB.week_in_month(Account.Name)).toString());
		System.assertEquals('SELECT WEEK_IN_MONTH(CONVERTTIMEZONE(Name))',
								QB.select_x(QB.week_in_month(QB.convertTimeZone('Name'))).toString());
		System.assertEquals('SELECT WEEK_IN_YEAR(Name)',
								QB.select_x(QB.week_in_year('Name')).toString());
		System.assertEquals('SELECT WEEK_IN_YEAR(Name)',
								QB.select_x(QB.week_in_year(Account.Name)).toString());
		System.assertEquals('SELECT WEEK_IN_YEAR(CONVERTTIMEZONE(Name))',
								QB.select_x(QB.week_in_year(QB.convertTimeZone('Name'))).toString());
		System.assertEquals('SELECT DAY_ONLY(Name)',
								QB.select_x(QB.day_only('Name')).toString());
		System.assertEquals('SELECT DAY_ONLY(Name)',
								QB.select_x(QB.day_only(Account.Name)).toString());
		System.assertEquals('SELECT DAY_ONLY(CONVERTTIMEZONE(Name))',
								QB.select_x(QB.day_only(QB.convertTimeZone('Name'))).toString());
		System.assertEquals('SELECT CONVERTTIMEZONE(Name)',
								QB.select_x(QB.convertTimeZone('Name')).toString());
		System.assertEquals('SELECT CONVERTTIMEZONE(Name)',
								QB.select_x(QB.convertTimeZone(Account.Name)).toString());
		System.assertEquals('SELECT CONVERTCURRENCY(Name)',
								QB.select_x(QB.convertCurrency('Name')).toString());
		System.assertEquals('SELECT CONVERTCURRENCY(Name)',
								QB.select_x(QB.convertCurrency(Account.Name)).toString());
		System.assertEquals('SELECT TOLABEL(Name)',
								QB.select_x(QB.toLabel('Name')).toString());
		System.assertEquals('SELECT TOLABEL(Name)',
								QB.select_x(QB.toLabel(Account.Name)).toString());
		System.assertEquals('SELECT FORMAT(Name)',
								QB.select_x(QB.format('Name')).toString());
		System.assertEquals('SELECT FORMAT(Name)',
								QB.select_x(QB.format(Account.Name)).toString());
		System.assertEquals('SELECT FORMAT(TOLABEL(Name))',
								QB.select_x(QB.format(QB.toLabel('Name'))).toString());


		System.assertEquals('SELECT Name1,FORMAT(Name2)',
								QB.select_x('Name1')
								.addFunction(QB.format('Name2')).toString());
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
		System.assertEquals('SELECT COUNT(Name) Total',QB.select_x(QB.count('Name').alias('Total')).toString());
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
	static void selectQueryTest() {
		Test.startTest();
		System.assertEquals('SELECT Name FROM Account',QB.select_x('Name')
														.from_x('Account').toString());
		System.assertEquals('SELECT Name FROM Account',QB.select_x('Name')
														.from_x('Account').toString());
		System.assertEquals('SELECT Name FROM Account',QB.select_x('Name')
														.from_x(Account.sObjectType).toString());
		System.assertEquals('SELECT Name FROM Account WHERE 1=1',QB.select_x('Name')
														.from_x('Account')
														.append(' WHERE 1=1').toString());
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
		System.assertEquals('SELECT Name FROM Account GROUP BY DAY_ONLY(Name)',QB.select_x('Name')
														.from_x('Account')
														.groupBy(QB.day_only('Name')).toString());
		System.assertEquals('SELECT Name FROM Account GROUP BY CALENDAR_MONTH(Name) HAVING COUNT(Name) = 1',QB.select_x('Name')
														.from_x('Account')
														.groupBy(QB.calendar_month('Name'),QB.count('Name').eq(1)).toString());
		System.assertEquals('SELECT Name FROM Account GROUP BY DAY_ONLY(Name) HAVING COUNT(Name) = 1',QB.select_x('Name')
														.from_x('Account')
														.groupBy(QB.day_only('Name'),QB.count('Name').eq(1)).toString());
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
	static void selectOrderByQueryTest() {
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
		System.assertEquals('SELECT Name FROM Account ORDER BY Name1 DESC NULLS LAST,Name2',QB.select_x('Name')
														.from_x('Account')
														.orderBy('Name1',QB.descNullsLast())
														.addOrder('Name2').toString());
		System.assertEquals('SELECT Name FROM Account ORDER BY Name1 DESC NULLS LAST,Name2,Name3',QB.select_x('Name')
														.from_x('Account')
														.orderBy('Name1',QB.descNullsLast())
														.addOrder(new List<String>{'Name2','Name3'}).toString());
		System.assertEquals('SELECT Name FROM Account ORDER BY Name1 DESC NULLS LAST,Name2 ASC NULLS FIRST',QB.select_x('Name')
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
	static void selectLimitQueryTest() {
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

	@isTest 
	static void runSelectQueryTest() {
		Test.startTest();

		System.assertEquals(0,QB.select_x('Name').from_x('Account').getList().size());
		System.assertEquals(0,QB.select_x('Name').from_x('Account').getMap().values().size());

		Test.stopTest();
	}


	@isTest 
	static void runSelectWhereQueryTest() {
		Test.startTest();

		System.assertEquals(1,QB.select_x('Name')
								.from_x('ApexClass')
								.where_x('Name','=','QB').getList().size());
		System.assertEquals(1,QB.select_x('Name')
								.from_x('ApexClass')
								.where_x('Name','=','QB').getMap().values().size());
		System.assertEquals(1,QB.select_x('Name')
								.from_x('ApexClass')
								.where_x(QB.field('Name').eq('QB')).getList().size());
		System.assertEquals(1,QB.select_x('Name,Body')
								.from_x('ApexClass')
								.where_x(QB.field('Name').eq('QB')).getList().size());
		System.assertEquals(1,QB.select_x('Name')
								.from_x('ApexClass')
								.where_x(QB.fieldExpr('Name','=','QB')).getList().size());
		System.assertEquals(1,QB.select_x('Name')
								.from_x('ApexClass')
								.where_x(QB.not_x(QB.field('Name').ne('QB'))).getList().size());
		System.assertEquals(1,QB.select_x('Name')
								.from_x('ApexClass')
								.where_x(QB.and_x(QB.field('Name').eq('QB'),QB.field('IsValid').ne(false))).getList().size());
		System.assertEquals(1,QB.select_x('Name')
								.from_x('ApexClass')
								.where_x(QB.and_x(QB.field('Name').eq('QB'),QB.field('Name').ne('QBTest')).add(QB.field('IsValid').ne(false))).getList().size());
		System.assertEquals(2,QB.select_x('Name')
								.from_x('ApexClass')
								.where_x(QB.or_x(QB.field('Name').eq('QB'),QB.field('Name').eq('QBTest'))).getList().size());
		System.assertEquals(2,QB.select_x('Name')
								.from_x('ApexClass')
								.where_x(QB.or_x(QB.field('Name').eq('QB'),QB.field('Name').eq('QBTest')).add(QB.field('Name').eq('QBTest'))).getList().size());

		Test.stopTest();
	}

	@isTest 
	static void runSelectGroupByQueryTest() {
		Test.startTest();

		List<AggregateResult> aggregateResult;

		System.assertEquals(2,QB.select_x(QB.count())
								.from_x('ApexClass')
								.where_x(QB.or_x(QB.field('Name').eq('QB'),QB.field('Name').eq('QBTest'))).getCount());

		aggregateResult=QB.select_x(QB.count('Id')).from_x('ApexClass')
						.where_x(QB.or_x(QB.field('Name').eq('QB'),QB.field('Name').eq('QBTest'))).getList();

		System.assertNotEquals(null,aggregateResult);
		System.assertNotEquals(null,aggregateResult.get(0));
		System.assertEquals(2,aggregateResult.get(0).get('expr0'));

		aggregateResult=QB.select_x(QB.count('Id').alias('MyCount')).from_x('ApexClass')
						.where_x(QB.or_x(QB.field('Name').eq('QB'),QB.field('Name').eq('QBTest'))).getList();

		System.assertNotEquals(null,aggregateResult);
		System.assertNotEquals(null,aggregateResult.get(0));
		System.assertEquals(2,aggregateResult.get(0).get('MyCount'));

		aggregateResult=QB.select_x(QB.count('Id').alias('MyCount')).from_x('ApexClass')
						.where_x(QB.or_x(QB.field('Name').eq('QB'),QB.field('Name').eq('QBTest')))
						.groupBy('Name').getList();

		System.assertNotEquals(null,aggregateResult);
		System.assertNotEquals(null,aggregateResult.get(0));
		System.assertNotEquals(null,aggregateResult.get(1));
		System.assertEquals(1,aggregateResult.get(0).get('MyCount'));
		System.assertEquals(1,aggregateResult.get(1).get('MyCount'));

		aggregateResult=QB.select_x(QB.count('Id').alias('MyCount'))
					.addField('Name')
					.from_x('ApexClass')
					.where_x(QB.or_x(QB.field('Name').eq('QB'),QB.field('Name').eq('QBTest')))
					.groupBy('Name').getList();

		System.assertNotEquals(null,aggregateResult);
		System.assertNotEquals(null,aggregateResult.get(0));
		System.assertNotEquals(null,aggregateResult.get(1));
		System.assertEquals(1,aggregateResult.get(0).get('MyCount'));
		System.assertNotEquals(null,aggregateResult.get(0).get('Name'));
		System.assertEquals(1,aggregateResult.get(1).get('MyCount'));
		System.assertNotEquals(null,aggregateResult.get(1).get('Name'));

		aggregateResult=QB.select_x(QB.count('Name').alias('MyCount'))
					.addField('Status')
					.from_x('ApexClass')
					.where_x(QB.or_x(QB.field('Name').eq('QB'),QB.field('Name').eq('QBTest')))
					.groupBy('Status',QB.count('Name').gt(1)).getList();

		System.assertNotEquals(null,aggregateResult);
		System.assertNotEquals(null,aggregateResult.get(0));
		System.assertEquals(2,aggregateResult.get(0).get('MyCount'));
		System.assertEquals('Active',aggregateResult.get(0).get('Status'));

		Test.stopTest();
	}

	@isTest 
	static void runSelectOrderByQueryTest() {
		Test.startTest();

		List<SObject> result;

		result=QB.select_x('Name')
				.from_x('ApexClass')
				.where_x(QB.or_x(QB.field('Name').eq('QB'),QB.field('Name').eq('QBTest')))
				.orderBy('Name').getList();

		System.assertNotEquals(null,result);
		System.assertEquals(2,result.size());
		System.assertEquals('QB',result.get(0).get('Name'));
		System.assertEquals('QBTest',result.get(1).get('Name'));

		result=QB.select_x('Name')
				.from_x('ApexClass')
				.where_x(QB.or_x(QB.field('Name').eq('QB'),QB.field('Name').eq('QBTest')))
				.orderBy('Name',QB.descNullsFirst()).getList();

		System.assertNotEquals(null,result);
		System.assertEquals(2,result.size());
		System.assertEquals('QBTest',result.get(0).get('Name'));
		System.assertEquals('QB',result.get(1).get('Name'));

		Test.stopTest();
	}


	@isTest 
	static void runSelectLimitQueryTest() {
		Test.startTest();

		System.assertEquals(1,QB.select_x('Name')
								.from_x('ApexClass')
								.where_x(QB.or_x(QB.field('Name').eq('QB'),QB.field('Name').eq('QBTest')))
								.limitTo(1).getList().size());

		Test.stopTest();
	}

	@isTest 
	static void runSelectOffsetQueryTest() {
		Test.startTest();

		System.assertEquals(1,QB.select_x('Name')
								.from_x('ApexClass')
								.where_x(QB.or_x(QB.field('Name').eq('QB'),QB.field('Name').eq('QBTest')))
								.offset(1).getList().size());

		Test.stopTest();
	}

}