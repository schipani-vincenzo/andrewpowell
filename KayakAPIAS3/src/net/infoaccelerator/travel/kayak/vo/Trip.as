package net.infoaccelerator.travel.kayak.vo
{
	import mx.collections.ArrayCollection;
	import net.infoaccelerator.travel.kayak.vo.Price;
	
	[RemoteClass(alias="net.infoaccelerator.travel.kayak.vo.Trip")]

	[Bindable]
	public class Trip
	{

		public var price:Price				= new Price();
		public var legs	:ArrayCollection 	= new ArrayCollection();


		public function Trip()
		{
		}

	}
}