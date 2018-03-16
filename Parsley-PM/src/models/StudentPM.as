package models
{
	import mx.collections.ArrayCollection;
	
	import messages.StudentMessage;

	public class StudentPM
	{		
		[MessageDispatcher]
		public var dispatcher:Function;
		
		[Bindable]
		public var students:ArrayCollection;
		
		[Bindable]
		public var state:String;
		
		[Bindable]
		public var errorMessage:String;

        private var message:StudentMessage;

		public function search(firstName:String):void
		{
            message = new StudentMessage(StudentMessage.SEARCH);
            message.student.name = firstName;
			dispatcher(message);
		}

        public function remove(student:Student):void
        {
            message = new StudentMessage(StudentMessage.REMOVE);
            message.student = student;
            dispatcher(message);
        }
	}
}