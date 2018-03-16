package component
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import spark.components.SkinnableContainer;
	import spark.components.supportClasses.ButtonBase;
	import spark.components.supportClasses.TextBase;
	
	[SkinState("confirm")]
	
	[Event(name="ok", type="flash.events.Event")]
	[Event(name="cancel", type="flash.events.Event")]
	
	[Style(name="borderColor", inherit="no", type="Number")]
	[Style(name="cornerRadius", inherit="no", type="Number")]

	
	public class FlyoutSkinnableContainer extends SkinnableContainer
	{
		public function FlyoutSkinnableContainer()
		{
			super();
			focusEnabled = true;
		}
		
		[SkinPart(required="false")]
		public var labelMessage:TextBase;
		
		[SkinPart(required="false")]
		public var buttonOk:ButtonBase;
		
		[SkinPart(required="false")]
		public var buttonCancel:ButtonBase;
		
		override protected function partAdded(partName:String, instance:Object):void	
		{
			super.partAdded(partName, instance);
			
			if (instance == labelMessage) 
			{
				labelMessage.text = message;
			}
			
			if (instance == buttonOk) 
			{
				buttonOk.label = okLabel;
				buttonOk.addEventListener(MouseEvent.CLICK, okHandler);
			}
			
			if (instance == buttonCancel) 
			{
				buttonCancel.label = cancelLabel;
				buttonCancel.addEventListener(MouseEvent.CLICK, cancelHandler);
			}
		}		
		
		override protected function partRemoved(partName:String, instance:Object):void 
		{
			super.partRemoved(partName, instance);
			if (instance == buttonOk) 
			{
				buttonOk.removeEventListener(MouseEvent.CLICK, okHandler);
			}
			
			if (instance == buttonCancel) 
			{
				buttonCancel.removeEventListener(MouseEvent.CLICK, cancelHandler);
			}
		}
		
		override protected function getCurrentSkinState():String
		{
			if(_hasConfirmation)
			{
				return "confirm";
			}
			return super.getCurrentSkinState();
		}
		
		private var _message:String = "Do you want to copy the link?";

		[Bindable(event="messageChanged")]
		public function get message():String
		{
			return _message;
		}

		public function set message(value:String):void
		{
			if( _message !== value)
			{
				_message = value;
				dispatchEvent(new Event("messageChanged"));
				invalidateProperties();
			}
		}
		
		private var _okLabel:String = "OK";

		[Bindable(event="okLabelChanged")]
		public function get okLabel():String
		{
			return _okLabel;
		}

		public function set okLabel(value:String):void
		{
			if( _okLabel !== value)
			{
				_okLabel = value;
				dispatchEvent(new Event("okLabelChanged"));
				invalidateProperties();
			}
		}
		
		private var _cancelLabel:String = "Cancel";

		[Bindable(event="cancelLabelChange")]
		public function get cancelLabel():String
		{
			return _cancelLabel;
		}

		public function set cancelLabel(value:String):void
		{
			if( _cancelLabel !== value)
			{
				_cancelLabel = value;
				dispatchEvent(new Event("cancelLabelChange"));
				invalidateProperties();
			}
		}

		private var _hasConfirmation:Boolean;

		[Bindable(event="hasConfirmationChanged")]
		public function get hasConfirmation():Boolean
		{
			return _hasConfirmation;
		}

		public function set hasConfirmation(value:Boolean):void
		{
			if( _hasConfirmation !== value)
			{
				_hasConfirmation = value;
				dispatchEvent(new Event("hasConfirmationChanged"));
				invalidateProperties();
				invalidateSkinState();
			}
		}
		
		private function okHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event("ok"));	
		}
		
		private function cancelHandler(event:MouseEvent):void
		{
			dispatchEvent(new Event("cancel"));	
		}
		
	}
	
	
}