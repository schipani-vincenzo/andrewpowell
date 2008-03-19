package net.infoaccelerator.travel.kayak.vo
{
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