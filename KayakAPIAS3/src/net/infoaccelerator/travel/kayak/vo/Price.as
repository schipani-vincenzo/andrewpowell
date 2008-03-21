package net.infoaccelerator.travel.kayak.vo
{
	[RemoteClass(alias="net.infoaccelerator.travel.kayak.vo.Price")]

	[Bindable]
	public class Price
	{

		public var url		:String 		= "";
		public var currency	:String 		= "";
		public var value	:Number 		=  0;


		public function Price()
		{
		}

	}
}