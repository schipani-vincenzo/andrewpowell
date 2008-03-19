package net.infoaccelerator.travel.kayak.vo
{
	[RemoteClass(alias="net.infoaccelerator.travel.kayak.vo.Segment")]

	[Bindable]
	public class Segment
	{

		public var airline:String = "";
		public var flight:Number = 0;
		public var mDuration:Number = 0;
		public var equipment:String = "";
		public var miles:Number = 0;
		public var origin:String = "";
		public var departure:Date = null;
		public var arrival:Date = null;
		public var destination:String = "";
		public var cabin:String = "";


		public function Segment()
		{
		}

	}
}