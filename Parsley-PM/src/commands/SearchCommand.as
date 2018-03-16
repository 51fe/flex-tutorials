package commands
{
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.RemoteObject;
	
	import messages.StudentMessage;
	
	import models.StudentPM;

	public class SearchCommand
	{
		[Inject(id="studentService")]
		public var service:RemoteObject;
		
		[Inject] 
		public var model:StudentPM;

		public function execute (message:StudentMessage):AsyncToken
		{
			return service.getList(message.student.name, "id", true);
		}
		
		public function result(ac:ArrayCollection):void
		{
			model.students = ac;
			if(ac.length > 0)
			{
				model.state = "success";
			}
			else
			{
				model.state = "fail";
				model.errorMessage = "Can't find any student";
			}
			
		}
		
		public function error(errorMessage:String): void
		{
			model.state = "fail";
			model.errorMessage = errorMessage;
		}
	}
}