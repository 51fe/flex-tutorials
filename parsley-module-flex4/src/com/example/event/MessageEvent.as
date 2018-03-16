package com.example.event
{
	import flash.events.Event;
 	
	public class MessageEvent extends Event
	{
		public static const MESSAGE : String =  "message";
		
		public function MessageEvent( message : String )
 		{
 			super( MESSAGE );
			
			_message = message;
 		}
		
		private var _message : String;

		public function get message():String
		{
			return _message;
		}
		
		override public function clone() : Event
		{
			return new MessageEvent( message );
		}

	}
}