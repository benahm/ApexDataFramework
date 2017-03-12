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

		// TODO

		Test.stopTest();
	}	
}