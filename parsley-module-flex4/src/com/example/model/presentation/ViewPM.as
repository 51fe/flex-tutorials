package com.example.model.presentation
{
	import com.example.event.MessageEvent;
	import com.example.model.domain.ExampleModel;
	
	import flash.events.EventDispatcher;

	[Event( name="message", type="com.example.event.MessageEvent" )]
	[ManagedEvents("message")]
	
	public class ViewPM extends EventDispatcher
	{
		
		//-------------------------------------------------
		//
		//	Properties
		//
		//-------------------------------------------------
		
		[Bindable]
		public var modelName : String;
		
		[Bindable]
		public var domain : ExampleModel;
		
		[Bindable]
		public var lastMessageReceived : String = "";
		
		//-------------------------------------------------
		//
		//	Public Methods
		//
		//-------------------------------------------------
		
		public function sendMessage( message : String ) : void
		{
			dispatchEvent( new MessageEvent( message ) );
		}
		
		//-------------------------------------------------
		//
		//	Event Listeners
		//
		//-------------------------------------------------
		
		[MessageHandler( selector="message" )]
		public function onMessage( event : MessageEvent ) : void
		{
			lastMessageReceived = event.message;
		}
	}
}