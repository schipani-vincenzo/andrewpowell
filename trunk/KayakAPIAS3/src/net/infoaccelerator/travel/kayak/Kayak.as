package net.infoaccelerator.travel.kayak
{
	import flash.net.URLRequest;
	
	import mx.rpc.http.HTTPService;
	
	import net.infoaccelerator.travel.kayak.formatters.FlightSearchFormatter;
	import net.infoaccelerator.travel.kayak.formatters.HotelSearchFormatter;
	import net.infoaccelerator.travel.kayak.formatters.ISearchFormatter;
	
	public class Kayak
	{
		
		private var _flightSearchFormatter:ISearchFormatter = new FlightSearchFormatter();
		private var _hotelSearchFormatter :ISearchFormatter = new HotelSearchFormatter();
		private var _version   			  :Number			=  1;
		private var _baseURL   			  :String			= "http://api.kayak.com";
				
		public function Kayak()
		{

		}
		
		public function getSession(devKey:String):String{
			var apiURL:URLRequest = new URLRequest(_baseURL + "/k/ident/apisession?version=" + _version + "&token=" + devKey);
			
			var test:HTTPService = new HTTPService(_baseURL + "/k/ident/apisession?version=" + _version + "&token=" + devKey);
			
			test.method = "GET";
			
			return null;
			
		}
		
		

	}
}