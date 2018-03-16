package components 
{
	import flash.events.KeyboardEvent;
	
	import mx.controls.AdvancedDataGrid;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.ClassFactory;
	
	import components.renderers.CheckBoxHeaderRenderer;
	import components.renderers.CheckBoxRenderer;
	
	/** 
	 *  DataGrid that uses checkboxes for multiple selection
	 */
	public class CheckBoxDataGrid extends AdvancedDataGrid
	{
		public function CheckBoxDataGrid()
		{
			allowMultipleSelection = true;
		}
		
		override public function set dataProvider(value:Object):void
		{
			super.dataProvider = value;
		}
		
		override public function set columns(value:Array):void
		{   
			var arr:Array = value.concat();
			var column:AdvancedDataGridColumn = new AdvancedDataGridColumn();
			column.width = 40;
			column.editable = false;
			column.headerText = ""
			column.sortable = false;
			column.headerRenderer = new ClassFactory(CheckBoxHeaderRenderer);
			column.itemRenderer = new ClassFactory(CheckBoxRenderer);
			arr.unshift(column);
			super.columns = arr;
		}
			
		override protected function selectItem(item:IListItemRenderer,
			shiftKey:Boolean, ctrlKey:Boolean,
			transition:Boolean = true):Boolean
		{
			if(item is CheckBoxRenderer)
				return super.selectItem(item, false, true, transition);
			return false;
		}
		
		override protected function drawItem(item:IListItemRenderer,
			selected:Boolean = false,
			highlighted:Boolean = false,
			caret:Boolean = false,
			transition:Boolean = false):void
		{
			if(item is CheckBoxRenderer)
				CheckBoxRenderer(item).invalidateProperties();
			super.drawItem(item, selected, highlighted, caret, transition);
		}
		
		override protected function keyDownHandler(event:KeyboardEvent):void
		{
			event.ctrlKey = true;
			event.shiftKey = false;
			super.keyDownHandler(event);
		}
		
		public function deleteItems():void
		{
			for each(var item:Object in selectedItems)
			{
				var index:int = dataProvider.getItemIndex(item);
				dataProvider.removeItemAt(index);
			}
			selectedItems = [];
		}
	}
	
}