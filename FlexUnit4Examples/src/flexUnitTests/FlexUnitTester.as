/*

Copyright (c) 2009 Elad Elrom.  Elrom LLC. All rights reserved. 

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

@author  Elad Elrom
@contact elad.ny at gmail.com

*/
package flexUnitTests
{
	import flash.display.Sprite;
	import flexunit.framework.Assert;
	
	public class FlexUnitTester
	{
		//--------------------------------------------------------------------------
		//
		//  Before and After
		//
		//--------------------------------------------------------------------------
		
		[Before]
		public function runBeforeEveryTest():void 
		{
			// implement
		}
		
		[After]
		public function runAfterEveryTest():void 
		{
			// implement
		}                    
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test(order=1)] 
		public function checkMethod():void
		{
			Assert.assertTrue( true );
		}
		
		[Test(expected="RangeError")]
		public function rangeCheck():void
		{
			var child:Sprite = new Sprite();
			child.getChildAt(1);
		}
		
		[Test(expected="flexunit.framework.AssertionFailedError")]
		public function testAssertNullNotEqualsNull():void 
		{
			Assert.assertEquals( null, "" );
		}
		
		[Ignore("Not Ready to Run")]
		[Test]
		public function methodNotReadyToTest():void 
		{
			Assert.assertFalse( true );
		}                        
	}
}