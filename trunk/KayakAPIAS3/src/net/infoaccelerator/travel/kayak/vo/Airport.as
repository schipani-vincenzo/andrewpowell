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
		public var latitude:Number = 0;
		public var longitude:Number = 0;

		public function Airport()
		{
		}

	}
}