package flexUnitTests
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Button;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	import org.fluint.sequence.SequenceRunner;
	import org.fluint.sequence.SequenceSetter;
	import org.fluint.sequence.SequenceWaiter;
	import org.fluint.uiImpersonation.UIImpersonator;
	
	public class FlexUnit4CheckUITester
	{
		private var component:UIComponent;
		private var btn:Button;
		
		//--------------------------------------------------------------------------
		//
		//  Before and After
		//
		//--------------------------------------------------------------------------
		
		[Before(async,ui)]
		public function setUp():void 
		{
			component = new UIComponent();
			btn = new Button();
			component.addChild( btn );
			btn.addEventListener( MouseEvent.CLICK, function():void { component.dispatchEvent( new Event( 'myButtonClicked' ) ); } )
			
			Async.proceedOnEvent( this, component, FlexEvent.CREATION_COMPLETE, 500 );
			UIImpersonator.addChild( component );
		}
		
		[After(async,ui)]
		public function tearDown():void 
		{
			UIImpersonator.removeChild( component );			
			component = null;
		}				   
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test(async,ui)]
		public function testButtonClick():void 
		{
			Async.handleEvent( this, component, "myButtonClicked", handleButtonClickEvent, 500 ); 
			btn.dispatchEvent( new MouseEvent( MouseEvent.CLICK, true, false ) );
		}
		
		[Test(async,ui)]
		public function testButtonClickSequence():void 
		{
			var sequence:SequenceRunner = new SequenceRunner( this );
			
			var passThroughData:Object = new Object();
			passThroughData.buttonLable = 'Click button';
			
			with ( sequence ) 
			{
				addStep( new SequenceSetter( btn, {label:passThroughData.buttonLable} ) );
				addStep( new SequenceWaiter( component, 'myButtonClicked', 500 ) );
				addAssertHandler( handleButtonClickSqEvent, passThroughData );
				
				run();
			}
			
			btn.dispatchEvent( new MouseEvent( MouseEvent.CLICK, true, false ) );
		}		
		
		//--------------------------------------------------------------------------
		//
		//  Handlers
		//
		//--------------------------------------------------------------------------
		
		private function handleButtonClickEvent( event:Event, passThroughData:Object ):void 
		{
			Assert.assertEquals( event.type, "myButtonClicked" );
		}
		
		private function handleButtonClickSqEvent( event:*, passThroughData:Object ):void 
		{
			Assert.assertEquals(passThroughData.buttonLable, btn.label);
		}		
	}
}