package net.infoaccelerator.travel.kayak.events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;

	public class SearchFailureEvent extends Event
	{
		
		public static var EVENT_ID:String = "searchFailure";
		
		public var errors:ArrayCollection = new ArrayCollection();
		
		public function SearchFailureEvent(type:String, errors:ArrayCollection, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.errors = errors;
		}
		
		override public function clone():Event{
			var newEvent:SearchFailureEvent = new SearchFailureEvent(EVENT_ID,this.errors);
			return newEvent;
		}
		
		
		
	}
}