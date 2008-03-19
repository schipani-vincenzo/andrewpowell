package net.infoaccelerator.travel.kayak.formatters
{
	import mx.formatters.DateFormatter;
	
	public class FlightSearchFormatter implements ISearchFormatter
	{
		public function FlightSearchFormatter()
		{
		}

		public function format(subject:Object):void
		{
		}
		
		private function formatDate(rawDate:Date):String{
			var flightDateFormatter:DateFormatter = new DateFormatter();
			
			flightDateFormatter.formatString = "MM/DD/YYYY";
			return flightDateFormatter.format(rawDate);
		}
		
		private function formatToLower(rawString:String):String{
			return rawString.toLowerCase();			
		}
		
		private function formatOneway(rawBool:Boolean):String{
			return (rawBool ? "y" : "n");
		}
		
	}
}