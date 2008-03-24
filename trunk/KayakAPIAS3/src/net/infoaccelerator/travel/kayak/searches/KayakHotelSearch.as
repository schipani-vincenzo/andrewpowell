package net.infoaccelerator.travel.kayak.searches
{
	import flash.events.EventDispatcher;
	import flash.utils.*;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import net.infoaccelerator.travel.kayak.events.AmbiguousLocationEvent;
	import net.infoaccelerator.travel.kayak.events.SearchCompleteEvent;
	import net.infoaccelerator.travel.kayak.events.SearchFailureEvent;
	import net.infoaccelerator.travel.kayak.formatters.HotelSearchFormatter;
	import net.infoaccelerator.travel.kayak.formatters.ISearchFormatter;
	import net.infoaccelerator.travel.kayak.validators.HotelSearchValidator;
	import net.infoaccelerator.travel.kayak.validators.ISearchValidator;
	import net.infoaccelerator.travel.kayak.vo.Hotel;
	import net.infoaccelerator.travel.kayak.vo.HotelSearchResult;

	
	[Bindable]
	[Event(name="searchComplete", type="net.infoaccelerator.travel.kayak.events.SearchCompleteEvent")]
	[Event(name="searchFailure", type="net.infoaccelerator.travel.kayak.events.SearchFailureEvent")]
	[Event(name="ambiguousLoction", type="net.infoaccelerator.travel.kayak.events.AmbiguousLocationEvent")]
	public class KayakHotelSearch extends EventDispatcher
	{
		
		private var _hotelSearchFormatter:ISearchFormatter = new HotelSearchFormatter();
		private var _hotelSearchValidator:ISearchValidator = new HotelSearchValidator();
		private var _version   			  :Number			=  1;
		private var _baseURL			  :String			= "http://api.kayak.com";
		private var _basicMode			  :String			= "true";
		private var _action				  :String			= "dohotels";
		private var _kSessionID			  :String			= "";
		private var _currentSearchID	  :String			= "";
		private var _currentHeaders		  :Object			= new Object();
		private var _currentInterval	  :uint				= 0;
		
		//Public data
		public var hotelResults		:HotelSearchResult 	= new HotelSearchResult();
		public var loading			:Boolean			= false;
		public var devKey			:String				= "";
		
		//Search Parameters
		public var city				:String				= "";
		public var checkin_date		:Date				= new Date();
		public var checkout_date	:Date				= new Date();
		public var guests			:Number				=  1;
		public var rooms			:Number				=  1;
		
		//Search Filtering Parameters
		public var resultCount		:Number				= 500;
		public var filterMode		:String				= "normal";
		public var filterStars		:Number				=  1;
		public var sortDirection	:String				= "up";
		public var sortKey			:String				= "price";
						
		public function KayakHotelSearch()
		{
		}
				
				
		public function doSearch():void{
			var hotelResults:HotelSearchResult = new HotelSearchResult();
			startSearchProcess(devKey);
			loading = true;					
		}				
				
		private function onGetSessionResult(e:ResultEvent):void{
			_kSessionID = e.result.ident.sid;
			doInitialHotelSearch(e.headers);	
		}				
		
		private function onInitialHotelSearchResult(e:ResultEvent):void{
			if(e.result.error == null){
			
			_currentSearchID = e.result.search.searchid;
			_currentHeaders  = e.headers;
			
			_currentInterval = flash.utils.setInterval(pollResults,5000,e.result.search.searchid,e.headers); 
			}
			else{
				this.loading = false;
				if(e.result.error.hotel_errors != null){
					var errors:ArrayCollection = new ArrayCollection();
					try{
						if(e.result.error.hotel_errors.detail.source != null){
							errors = e.result.error.hotel_errors.detail;
						}
					}
					catch(exception:Error){
						errors.addItem(e.result.error.hotel_errors.detail);
					}
					finally{
						var failureEvent:SearchFailureEvent = new SearchFailureEvent(SearchFailureEvent.EVENT_ID,errors);
						dispatchEvent(failureEvent);
					}
				}
				
				if(e.result.error.ambiguous_location != null){
					var _locations:ArrayCollection = new ArrayCollection();
					
					for(var i:int=0;i<e.result.error.ambiguous_location.origin.length;i++){
						_locations.addItem(e.result.error.ambiguous_location.origin.getItemAt(i));
					}
					
					var ambiguousLocation:AmbiguousLocationEvent = new AmbiguousLocationEvent(AmbiguousLocationEvent.EVENT_ID,_locations);
					dispatchEvent(ambiguousLocation);
				}
				
				if(e.result.error.message != null){
					var _errors:ArrayCollection = new ArrayCollection();
					_errors.addItem(e.result.error.message);
					var failureEvent:SearchFailureEvent = new SearchFailureEvent(SearchFailureEvent.EVENT_ID,_errors);
					dispatchEvent(failureEvent);
				}
				
			}
		}
		
		private function onPollResult(e:ResultEvent):void{
								
			var search:Object 			= e.result.searchresult;
			var intervalCheck:Boolean 	= search.morepending;
			
			if(!intervalCheck){
				flash.utils.clearInterval(_currentInterval);
				loading = false;
			
				hotelResults.searchID = _currentSearchID;
							
				var hotelList		:ArrayCollection 	= search.hotels.hotel as ArrayCollection;		
				var hotelListLen	:int 				= hotelList.length;
				for(var i:int=0;i<hotelListLen;i++){
					var currentHotel:Hotel  = 	new Hotel();
					currentHotel.price.currency = 	hotelList.getItemAt(i).price.currency;
					currentHotel.price.url 		= 	"http://api.kayak.com" + hotelList.getItemAt(i).price.url;
					currentHotel.price.value	= 	new Number(hotelList.getItemAt(i).price.value.substr(1,hotelList.getItemAt(i).price.value.length));
					currentHotel.address 		= 	hotelList.getItemAt(i).address;
					currentHotel.city			=	hotelList.getItemAt(i).city;
					currentHotel.country		= 	hotelList.getItemAt(i).country;
					currentHotel.id				=	hotelList.getItemAt(i).id;
					currentHotel.lat			=	hotelList.getItemAt(i).lat;
					currentHotel.lon			=	hotelList.getItemAt(i).lon;
					currentHotel.name			=	hotelList.getItemAt(i).name;
					currentHotel.phone			=	hotelList.getItemAt(i).phone;
					currentHotel.priceHigh		=	new Number(hotelList.getItemAt(i).pricehistoryhi);
					currentHotel.priceLow		=   new Number(hotelList.getItemAt(i).pricehistorylo);
					currentHotel.region			=	hotelList.getItemAt(i).region;
					currentHotel.stars			=	new Number(hotelList.getItemAt(i).stars);
					hotelResults.hotels.addItem(currentHotel);
				}
				hotelResults.count = hotelResults.hotels.length;	
				loading = false;
				dispatchEvent(new SearchCompleteEvent(SearchCompleteEvent.EVENT_ID));
			}		
		}
		
				
		private function onFault(e:FaultEvent):void{
			mx.controls.Alert.show(e.message.toString(),"Kayak API Connection Error");
		}
		
		private function parseStringToDate(raw:String):Date{
			var year	:Number	= new Number(raw.substr(0,4))	;
			var month	:Number = new Number(raw.substr(5,2))	;
			var day  	:Number = new Number(raw.substr(8,2))	;
			var hour 	:Number = new Number(raw.substr(11,2))	;
			var minute	:Number = new Number(raw.substr(14,2))	;
			
			return new Date(year,month,day,hour,minute);
		}
				
		private function startSearchProcess(devKey:String):void{
			var sessionService:HTTPService = new HTTPService();
			var params:Object = new Object();
			var resultCheck:Boolean = false;
			var sessionKey:String = "";
			
			params.version = _version;
			params.token   = devKey;
			
			sessionService.method = "GET";
			sessionService.useProxy = false;
			sessionService.url = _baseURL + "/k/ident/apisession";
			sessionService.makeObjectsBindable = true;	
			sessionService.addEventListener(FaultEvent.FAULT,onFault);
			sessionService.addEventListener(ResultEvent.RESULT,onGetSessionResult);
			
			sessionService.send(params);
			
		}
		
		private function doInitialHotelSearch(headers:Object):void{
			var url				:String 		= _baseURL + "/s/apisearch?";
			var searchService	:HTTPService 	= new HTTPService();
			var params			:Object 		= new Object();
			var searchResults	:Object 		= new Object();
			var paramTO			:Object			= new Object();
			var resultCheck		:Boolean		= false;
			
			url += "version=" 	+	_version;
			url += "&apimode="	+   _version;
			url += "&_sid_=" 	+ 	escape(_kSessionID);
			url += "&basicmode="+ 	_basicMode;
			url += "&action=" 	+	_action;
			
			
			paramTO.city 			= city;
			paramTO.checkin_date 	= checkin_date;
			paramTO.checkout_date 	= checkout_date;
			paramTO.guests			= guests;
			paramTO.rooms			= rooms;
			
			
			if(_hotelSearchValidator.validate(paramTO)){
				paramTO = _hotelSearchFormatter.format(paramTO);
				url += "&othercity="		+ paramTO.city;
				url += "&checkin_date=" 	+ encodeURIComponent(paramTO.checkin_date);
				url += "&checkout_date=" 	+ encodeURIComponent(paramTO.checkout_date);
				url += "&guests1=" 			+ paramTO.guests;
				url += "&rooms=" 			+ paramTO.rooms;
				searchService.method 				= "GET";
				searchService.useProxy 			= false;
				searchService.url 					= url;
				searchService.makeObjectsBindable 	= true;
				searchService.headers = headers;
				searchService.addEventListener(FaultEvent.FAULT,onFault);
				searchService.addEventListener(ResultEvent.RESULT,onInitialHotelSearchResult);
				
				searchService.send();
			}
			else{
				var errors:ArrayCollection = new ArrayCollection();
				errors.addItem("Validation Failed");
				var failureEvent:SearchFailureEvent = new SearchFailureEvent(SearchFailureEvent.EVENT_ID,errors);
			}
		}
		
	private function pollResults(searchID:String,headers:Object):void{
		var url				:String 		= _baseURL + "/s/apibasic/hotel?";
		var searchService	:HTTPService 	= new HTTPService();
		
		url += "searchid="	+ searchID;
		url += "&c="	   	+ resultCount;
		if(filterMode == "stars")
			url += "&m=stars:" + filterStars;
			else
				url += "&m=normal";
		url += "&d=" 		+ sortDirection;
		url += "&s=" 		+ sortKey;
		url += "&_sid_=" 	+ 	escape(_kSessionID);
		url += "&version=" 	+	_version;
		url += "&apimode="	+   _version;
		
		searchService.method 				= "POST";
		searchService.useProxy 				= false;
		searchService.url 					= url;
		searchService.makeObjectsBindable 	= true;
		searchService.headers 				= headers;
		searchService.addEventListener(FaultEvent.FAULT,onFault);
		searchService.addEventListener(ResultEvent.RESULT,onPollResult);
		searchService.resultFormat = HTTPService.RESULT_FORMAT_OBJECT;
		searchService.send();
	}			
	
	
		

	}
}