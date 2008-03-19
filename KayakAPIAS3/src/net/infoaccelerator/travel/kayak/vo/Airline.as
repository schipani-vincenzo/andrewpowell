package net.infoaccelerator.travel.kayak.vo
{
	[RemoteClass(alias="net.infoaccelerator.travel.kayak.vo.Airline")]

	[Bindable]
	public class Airline
	{

		public var code:String = "";
		public var airline:String = "";
		public var country:String = "";
		public var fullname:String = "";
		public var keywords:String = "";
		public var phone:String = "";
		public var website:String = "";


		public function Airline()
		{
		}

	}
}