package
{
	import flash.display.DisplayObject;
	import flash.utils.getQualifiedClassName;
	
	import org.spicefactory.parsley.core.view.ViewAutowireMode;
	import org.spicefactory.parsley.core.view.ViewSettings;
	import org.spicefactory.parsley.core.view.impl.DefaultViewAutowireFilter;
	
	public class AutowireFilterSample extends DefaultViewAutowireFilter
	{
		public function AutowireFilterSample(settings:ViewSettings=null, excludedTypes:RegExp=null)
		{
			super(settings, excludedTypes);
		}
		
		override public function filter(object:DisplayObject):ViewAutowireMode
		{
			var fullClassname:String = getQualifiedClassName(object);
			             
			if (fullClassname.indexOf("views::") == 0) 
			{
				return ViewAutowireMode.ALWAYS;
			}
			else
			{
				return ViewAutowireMode.NEVER;
			}
		}
		
	}
}