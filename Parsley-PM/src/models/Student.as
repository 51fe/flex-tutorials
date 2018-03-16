package models
{
	[RemoteClass(alias="com.riafan.model.Student")]
	public class Student
	{
		[Transient]
		public var id:int;
        public var studentId:String ;
        public var name:String;
        public var gender:Boolean;
        public var birthday:Date;
        public var className:String;
	}
}