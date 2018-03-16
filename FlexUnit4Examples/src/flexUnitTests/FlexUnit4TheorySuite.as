package flexUnitTests
{
	import org.flexunit.assertThat;
	import org.flexunit.assumeThat;
	import org.flexunit.experimental.theories.Theories;
	import org.hamcrest.number.greaterThan;
	import org.hamcrest.object.instanceOf;
	
	[Suite]
	[RunWith("org.flexunit.experimental.theories.Theories")]
	public class FlexUnit4TheorySuite
	{
		private var theory:Theories;
		
		//--------------------------------------------------------------------------
		//
		//  DataPoints
		//
		//--------------------------------------------------------------------------
		
		[DataPoint]
		public static var number:Number = 5;
		
		//--------------------------------------------------------------------------
		//
		//  Theories
		//
		//--------------------------------------------------------------------------
		
		[Theory]
		public function testNumber( number:Number ):void 
		{
			assumeThat( number, greaterThan( 0 ) );
			assertThat( number, instanceOf(Number) );
		}
	}
}