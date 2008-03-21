package net.infoaccelerator.travel.kayak.vo
{
	import mx.collections.ArrayCollection;
	
	[RemoteClass(alias="net.infoaccelerator.travel.kayak.vo.HotelSearchResult")]

	[Bindable]
	public class HotelSearchResult extends SearchResults
	{

		public var hotels:ArrayCollection = new ArrayCollection();


		public function HotelSearchResult()
		{
		}

	}
}