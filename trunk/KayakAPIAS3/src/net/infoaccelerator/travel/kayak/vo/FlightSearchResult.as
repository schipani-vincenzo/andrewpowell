package net.infoaccelerator.travel.kayak.vo
{
	import mx.collections.ArrayCollection;
	
	[RemoteClass(alias="net.infoaccelerator.travel.kayak.vo.FlightSearchResult")]

	[Bindable]
	public class FlightSearchResult extends SearchResults
	{

		public var trips:ArrayCollection = null;


		public function FlightSearchResult()
		{
		}

	}
}