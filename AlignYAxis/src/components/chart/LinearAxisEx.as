package components.chart
{
	import mx.charts.AxisLabel;
	import mx.charts.LinearAxis;
	
	public class LinearAxisEx extends LinearAxis
	{
		public function LinearAxisEx()
		{
			super();
		}
		
		override protected function buildLabelCache():Boolean 
		{ 
			var resultVal:Boolean = super.buildLabelCache();
			var len:int = labelCache.length;
			var minLabel:AxisLabel = labelCache[0];
			var maxLabel:AxisLabel = labelCache[len - 1];
			if(minLabel.position < this.computedInterval)
				labelCache.shift();
			if(maxLabel && (1 - maxLabel.position < this.computedInterval))
				labelCache.pop();
			return resultVal;
		}
		
		/*override protected function adjustMinMax(minValue:Number, maxValue:Number):void
		{
			super.adjustMinMax(minValue, maxValue);
			computedMinimum = minValue;
			computedMaximum = maxValue;
		}*/
	}
	
}