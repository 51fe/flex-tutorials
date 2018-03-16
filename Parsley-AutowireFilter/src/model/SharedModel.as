package model
{
	public class SharedModel
	{
		private var _message:String;

		[Bindable]
		public function get message():String
		{
			return "Hello, " + _message;
		}

		public function set message(value:String):void
		{
			_message = value;
		}

	}
}