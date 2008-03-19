package net.infoaccelerator.travel.kayak.vo
{
	[RemoteClass(alias="net.infoaccelerator.travel.kayak.vo.Leg")]

	[Bindable]
	public class Leg
	{

		public var airline:String = "";
		public var airlineName:String = "";
		public var origin:String = "";
		public var destination:String = "";
		public var depart:Date = null;
		public var arrive:Date = null;
		public var stops:Number = 0;
		public var mDuration:Number = 0;
		public var cabin:String = "";
		public var segments:ArrayCollection = null;


		public function Leg()
		{
		}

	}
}