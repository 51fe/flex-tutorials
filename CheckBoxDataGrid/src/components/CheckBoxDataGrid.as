package components 
{
	import flash.events.KeyboardEvent;
	
	import mx.controls.AdvancedDataGrid;
	import mx.controls.DataGrid;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.core.ClassFactory;
	
	import components.renderers.CheckBoxHeaderRenderer;
	import components.renderers.CheckBoxItemRenderer;
	
	/** 
	 *  DataGrid that uses checkboxes for multiple selection
	 */
	public class CheckBoxDataGrid extends DataGrid
	{
		public function CheckBoxDataGrid()
		{
			allowMultipleSelection = true;
		}
		
		override public function set columns(value:Array):void
		{   
			var arr:Array = value.concat();
			var column:DataGridColumn = new DataGridColumn();
			column.width = 40;
			column.editable = false;
			column.headerText = ""
			column.sortable = false;
			column.headerRenderer = new ClassFactory(CheckBoxHeaderRenderer);
			column.itemRenderer = new ClassFactory(CheckBoxItemRenderer);
			arr.unshift(column);
			super.columns = arr;
		}
			
		override protected function selectItem(item:IListItemRenderer,
			shiftKey:Boolean, ctrlKey:Boolean,
			transition:Boolean = true):Boolean
		{
			if(item is CheckBoxItemRenderer)
				return super.selectItem(item, false, true, transition);
			return false;
		}
		
		override protected function drawItem(item:IListItemRenderer,
			selected:Boolean = false,
			highlighted:Boolean = false,
			caret:Boolean = false,
			transition:Boolean = false):void
		{
			if(item is CheckBoxItemRenderer)
				CheckBoxItemRenderer(item).invalidateProperties();
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