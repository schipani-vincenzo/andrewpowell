package net.infoaccelerator.travel.kayak.formatters
{
	import mx.formatters.DateFormatter;
	
	public class FlightSearchFormatter implements IFormatter
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
		
	}
}