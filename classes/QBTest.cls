/**
* @author benahm
* @date 2017
* @description Test Class for the QueryBuilder
*/
@isTest
private class QBTest {
	
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

		// TODO

		Test.stopTest();
	}

	@isTest 
	static void orCriteriaTest() {
		Test.startTest();

		// TODO

		Test.stopTest();
	}
	
}