package net.infoaccelerator.travel.kayak.vo
{
	[RemoteClass(alias="net.infoaccelerator.travel.kayak.vo.HotelSearchResult")]

	[Bindable]
	public class HotelSearchResult extends SearchResults
	{

		public var hotels:ArrayCollection = null;


		public function HotelSearchResult()
		{
		}

	}
}