package net.infoaccelerator.travel.kayak.vo
{
	[RemoteClass(alias="net.infoaccelerator.travel.kayak.vo.Trip")]

	[Bindable]
	public class Trip
	{

		public var price:net.infoaccelerator.travel.kayak.vo.Price = null;
		public var legs:ArrayCollection = null;


		public function Trip()
		{
		}

	}
}