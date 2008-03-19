package net.infoaccelerator.travel.kayak.vo
{
	[RemoteClass(alias="net.infoaccelerator.travel.kayak.vo.Airport")]

	[Bindable]
	public class Airport
	{

		public var code:String = "";
		public var name:String = "";
		public var city:String = "";
		public var state:String = "";
		public var country:String = "";


		public function Airport()
		{
		}

	}
}