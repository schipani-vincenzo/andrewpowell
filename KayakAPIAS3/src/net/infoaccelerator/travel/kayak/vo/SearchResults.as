package net.infoaccelerator.travel.kayak.vo
{
	[RemoteClass(alias="net.infoaccelerator.travel.kayak.vo.SearchResults")]

	[Bindable]
	public class SearchResults
	{

		public var searchInstance:String = "";
		public var searchID:String = "";
		public var count:Number = 0;


		public function SearchResults()
		{
		}

	}
}