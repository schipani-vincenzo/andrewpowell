package net.infoaccelerator.travel.kayak.events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;

	public class AmbiguousLocationEvent extends Event
	{
		
		public static var EVENT_ID:String = "ambiguousLoction";
		
		public var suggestions:ArrayCollection = new ArrayCollection();
		
		public function AmbiguousLocationEvent(type:String, suggestions:ArrayCollection, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.suggestions = suggestions;
		}
		
		override public function clone():Event{
			var newEvent:AmbiguousLocationEvent = new AmbiguousLocationEvent(EVENT_ID,this.suggestions);
			return newEvent;
		}
		
		
		
	}
}