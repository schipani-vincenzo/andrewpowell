package net.infoaccelerator.travel.kayak.formatters
{
	import mx.formatters.DateFormatter;
	
	public class HotelSearchFormatter implements ISearchFormatter
	{
		public function HotelSearchFormatter()
		{
		}

		public function format(subject:Object):Object
		{			
			subject.checkin_date 	= formatDate(subject.checkin_date);
			subject.checkout_date	= formatDate(subject.checkout_date);
			
			return subject;
		}
		
		private function formatDate(rawDate:Date):String{
			var hotelDateFormatter:DateFormatter = new DateFormatter();
			
			hotelDateFormatter.formatString = "MM/DD/YYYY";
			return hotelDateFormatter.format(rawDate);
		}
		
	}
}