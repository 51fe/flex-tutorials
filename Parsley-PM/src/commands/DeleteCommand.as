package commands
{
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;
	
	import messages.StudentMessage;
	
	import models.Student;
	import models.StudentPM;

	public class DeleteCommand
	{
		[Inject(id="studentService")]
		public var service:RemoteObject;
		
		[Inject] 
		public var model:StudentPM;
		
		private var student:Student;
		
		public function execute(message:StudentMessage):AsyncToken
		{
			student = message.student;
			return service.remove(student.id);
		}
		
		public function result(success:Boolean):void
		{
			if(success)
			{
				var ac:ArrayCollection = model.students;
				ac.removeItemAt(ac.getItemIndex(student));
			}
			else
			{
				model.state = "fail";
				model.errorMessage = "Can't delete any student";
			}
			
		}
		
		public function error(errorMessage:String): void
		{
			model.state = "fail";
			model.errorMessage = errorMessage;
		}
	}
}