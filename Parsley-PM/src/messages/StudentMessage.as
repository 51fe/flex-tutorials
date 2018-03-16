package messages
{
	import models.Student;

	public class StudentMessage
	{
        public static const SEARCH:String = "search";
        public static const SAVE:String = "save";
        public static const REMOVE:String = "remove";

        public var student:Student = new Student();

        private var _type:String;

        public function StudentMessage(type:String)
        {
            _type = type;
        }

        [Selector]
        public function get type():String
        {
            return _type;
        }
	}
}