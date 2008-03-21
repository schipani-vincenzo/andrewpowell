package net.infoaccelerator.travel.kayak.events
{
	import flash.events.Event;

	public class SearchCompleteEvent extends Event
	{
		
		public static var EVENT_ID:String = "searchComplete";
		
		public function SearchCompleteEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		
		
	}
}