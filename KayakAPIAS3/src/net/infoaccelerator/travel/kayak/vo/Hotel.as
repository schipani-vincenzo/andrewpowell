package net.infoaccelerator.travel.kayak.vo
{
	[RemoteClass(alias="net.infoaccelerator.travel.kayak.vo.Hotel")]

	[Bindable]
	public class Hotel
	{

		public var id:Number = 0;
		public var price:net.infoaccelerator.travel.kayak.vo.Price = null;
		public var priceLow:Number = 0;
		public var priceHigh:Number = 0;
		public var stars:Number = 0;
		public var name:String = "";
		public var phone:String = "";
		public var address:String = "";
		public var lat:String = "";
		public var lon:String = "";
		public var city:String = "";
		public var region:String = "";
		public var country:String = "";


		public function Hotel()
		{
		}

	}
}