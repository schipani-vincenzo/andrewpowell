package net.infoaccelerator.travel.kayak.formatters
{
	import mx.formatters.DateFormatter;
	
	public class FlightSearchFormatter implements ISearchFormatter
	{
		public function FlightSearchFormatter()
		{	

		}

		public function format(subject:Object):Object
		{
			subject.origin 		= formatToUpper(subject.origin);
			subject.destination = formatToUpper(subject.destination);
			subject.depart_date = formatDate(subject.depart_date);
			subject.return_date = formatDate(subject.return_date);
			subject.depart_time = formatToLower(subject.depart_time);
			subject.return_time = formatToLower(subject.return_time);
			subject.cabin		= formatToLower(subject.cabin);	
			subject.oneway		= formatOneway(subject.oneway);
			
			return subject;
		}
		
		private function formatDate(rawDate:Date):String{
			var flightDateFormatter:DateFormatter = new DateFormatter();
			
			flightDateFormatter.formatString = "MM/DD/YYYY";
			return flightDateFormatter.format(rawDate);
		}
		
		private function formatToLower(rawString:String):String{
			return rawString.toLowerCase();			
		}
		
		private function formatToUpper(rawString:String):String{
			return rawString.toUpperCase();			
		}
		
		private function formatOneway(rawBool:Boolean):String{
			return (rawBool ? "y" : "n");
		}
		
	}
}