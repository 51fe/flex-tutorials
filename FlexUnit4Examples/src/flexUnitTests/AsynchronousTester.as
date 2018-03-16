package flexUnitTests
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import flexunit.framework.Assert;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.flexunit.async.Async;
	
	public class AsynchronousTester
	{
		private var service:HTTPService;
		
		//--------------------------------------------------------------------------
		//
		//  Before and After
		//
		//--------------------------------------------------------------------------
		
		[Before]
		public function runBeforeEveryTest():void 
		{
			service = new HTTPService();
			service.resultFormat = "e4x";
		}
		
		[After]
		public function runAfterEveryTest():void 
		{
			service = null;
		}       
		
		//--------------------------------------------------------------------------
		//
		//  Tests
		//
		//--------------------------------------------------------------------------
		
		[Test(async,timeout="500")]
		public function testServiceRequest():void 
		{
			service.url = "../assets/file.xml";
			service.addEventListener(ResultEvent.RESULT, Async.asyncHandler( this, onResult, 500 ), false, 0, true );
			service.send();
		}
		
		[Test(async,timeout="500")]
		public function testFailedServicRequest():void 
		{
			service.url = "file-that-dont-exists";
			service.addEventListener( FaultEvent.FAULT, Async.asyncHandler( this, onFault, 500 ), false, 0, true );
			service.send();
		}         
		
		[Test(async,timeout="500")]
		public function testEvent():void 
		{
			var EVENT_TYPE:String = "eventType";
			var eventDispatcher:EventDispatcher = new EventDispatcher();
			
			eventDispatcher.addEventListener(EVENT_TYPE, Async.asyncHandler( this,  handleAsyncEvnet, 500 ), false, 0, true );
			eventDispatcher.dispatchEvent( new Event(EVENT_TYPE) ); 
		}
		
		[Test(async,timeout="500")]
		public function testMultiAsync():void 
		{
			testEvent();
			testServiceRequest();
		}             
		
		//--------------------------------------------------------------------------
		//
		//  Asynchronous handlers
		//
		//--------------------------------------------------------------------------
		
		private function onResult(event:ResultEvent, passThroughData:Object):void
		{
			Assert.assertTrue( event.hasOwnProperty("result") );
		}
		
		private function handleAsyncEvnet(event:Event, passThroughData:Object):void
		{
			Assert.assertEquals( event.type, "eventType" );
		}         
		
		private function onFault(event:FaultEvent, passThroughData:Object):void
		{
			Assert.assertTrue( event.fault.hasOwnProperty("faultCode") );
		}         
	}
}