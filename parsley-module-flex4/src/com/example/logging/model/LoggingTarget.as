package com.example.logging.model
{
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	import mx.core.mx_internal;
	import mx.logging.Log;
	import mx.logging.targets.LineFormattedTarget;
	import mx.utils.OnDemandEventDispatcher;
	
	use namespace mx_internal;
	
	public class LoggingTarget extends LineFormattedTarget implements IEventDispatcher
	{
		private static const LOG_OUTPUT_CHANGE : String = "logOutputChange";
		
		//-------------------------------------------------
		//
		//	Constructor
		//
		//-------------------------------------------------
		
		public function LoggingTarget()
		{
			dispatcher = new OnDemandEventDispatcher();
			Log.addTarget(this);
		}
		
		//-------------------------------------------------
		//
		//	Properties
		//
		//-------------------------------------------------
		
		//-----------------------------
		//	logOutput
		//-----------------------------
		
		private var _logOutput : String = "";
		
		[Bindable( "logOutputChange" )]
		public function get logOutput() : String
		{
			return _logOutput
		}
		
		private function setLogOutput( value : String ) : void
		{
			_logOutput = value;
			
			dispatchEvent( new Event( LOG_OUTPUT_CHANGE ) );
		}
		
		//-------------------------------------------------
		//
		//	Private Variables
		//
		//-------------------------------------------------
		
		private var dispatcher : OnDemandEventDispatcher;
		
		//-------------------------------------------------
		//
		//	Public Methods
		//
		//-------------------------------------------------
		
		public function clear() : void
		{
			setLogOutput( "" );
		}
		
		//-------------------------------------------------
		//
		//	Overridden Methods: LineFormattingTarget
		//
		//-------------------------------------------------
		
		override mx_internal function internalLog( message : String ) : void
		{
			setLogOutput( logOutput + message + "\n" );
		}
		
		//-------------------------------------------------
		//
		//	Interface Implementation: IEventDispatcher
		//
		//-------------------------------------------------	
		
		public function addEventListener( type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false ) : void
		{
			dispatcher.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		public function removeEventListener( type : String, listener : Function, useCapture : Boolean = false ) : void
		{
			dispatcher.removeEventListener( type, listener, useCapture );
		}
		
		public function dispatchEvent( event : Event ) : Boolean
		{
			return dispatcher.dispatchEvent( event );
		}
		
		public function hasEventListener( type : String ) : Boolean
		{
			return dispatcher.hasEventListener( type );
		}
		
		public function willTrigger( type : String ) : Boolean
		{
			return dispatcher.willTrigger( type );
		}
	}
}