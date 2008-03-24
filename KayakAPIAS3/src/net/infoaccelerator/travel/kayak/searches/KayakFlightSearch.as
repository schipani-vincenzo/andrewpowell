package net.infoaccelerator.travel.kayak.searches
{
	
	import flash.utils.*;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import net.infoaccelerator.travel.kayak.events.SearchCompleteEvent;
	import net.infoaccelerator.travel.kayak.events.SearchFailureEvent;
	import net.infoaccelerator.travel.kayak.formatters.FlightSearchFormatter;
	import net.infoaccelerator.travel.kayak.formatters.ISearchFormatter;
	import net.infoaccelerator.travel.kayak.validators.FlightSearchValidator;
	import net.infoaccelerator.travel.kayak.validators.ISearchValidator;
	import net.infoaccelerator.travel.kayak.vo.FlightSearchResult;
	import net.infoaccelerator.travel.kayak.vo.Leg;
	import net.infoaccelerator.travel.kayak.vo.Segment;
	import net.infoaccelerator.travel.kayak.vo.Trip;
	
	[Bindable]
	[Event(name="searchComplete", type="net.infoaccelerator.travel.kayak.events.SearchCompleteEvent")]
	[Event(name="searchFailure", type="net.infoaccelerator.travel.kayak.events.SearchFailureEvent")]
	public class KayakFlightSearch
	{
		
		private var _flightSearchFormatter:ISearchFormatter = new FlightSearchFormatter();
		private var _flightSearchValidator:ISearchValidator = new FlightSearchValidator();
		private var _version   			  :Number			=  1;
		private var _baseURL			  :String			= "http://api.kayak.com";
		private var _basicMode			  :String			= "true";
		private var _action				  :String			= "doFlights";
		private var _kSessionID			  :String			= "";
		private var _currentSearchID	  :String			= "";
		private var _currentHeaders		  :Object			= new Object();
		private var _currentInterval	  :uint				= 0;
		//Search Parameters
		
		public var flightResults	:FlightSearchResult = new FlightSearchResult();
		public var loading			:Boolean			= false;
		public var devKey			:String				= "";
		public var oneway			:Boolean			= false;
		public var origin			:String				= "";
		public var destination		:String				= "";	
		public var depart_date		:Date				= new Date();
		public var return_date		:Date				= new Date();
		public var depart_time		:String				= "";
		public var return_time		:String				= "";
		public var travelers		:Number				=  1;
		public var cabin			:String				= "";
		
		//Search Sort Parameters
		public var resultCount		:Number				= 600;
		public var filterMode		:String				= "normal";
		public var filterAirline	:String				= "";
		public var sortDirection	:String				= "up";
		public var sortKey			:String				= "price";
						
		public function KayakFlightSearch()
		{
		}
				
				
		public function doSearch():void{
			startSearchProcess(devKey);
			loading = true;					
		}				
				
		private function onGetSessionResult(e:ResultEvent):void{
			_kSessionID = e.result.ident.sid;
			doInitialFlightSearch(e.headers);	
		}				
		
		private function onInitialFlightSearchResult(e:ResultEvent):void{
			if(e.result.error == null){
			
			_currentSearchID = e.result.search.searchid;
			_currentHeaders  = e.headers;
			
			_currentInterval = flash.utils.setInterval(pollResults,5000,e.result.search.searchid,e.headers); 
			}
			else{
				this.loading = false;
				if(e.result.error.flight_errors != null){
					var errors:ArrayCollection = new ArrayCollection();
					try{
						if(e.result.error.hotel_errors.detail.source != null){
							errors = e.result.error.flight_errors.detail;
						}
					}
					catch(exception:Error){
						errors.addItem(e.result.error.flight_errors.detail);
					}
					finally{
						var failureEvent:SearchFailureEvent = new SearchFailureEvent(SearchFailureEvent.EVENT_ID,errors);
						dispatchEvent(failureEvent);
					}
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
					
			
			var search:Object = e.result.searchresult;
			var intervalCheck:Boolean = search.morepending;
			
			if(!intervalCheck){
				flash.utils.clearInterval(_currentInterval);
			
				flightResults.searchID = _currentSearchID;
				//flightResults.searchInstance = searchResult.searchinstance;
				
				var tripList:ArrayCollection 	= search.trips.trip as ArrayCollection;		
				var tripLen:int 				= tripList.length;
				for(var i:int=0; i<tripLen; i++){
					var currentTrip:Trip 		= new Trip();
					currentTrip.price.currency 	= tripList.getItemAt(i).price.currency;
					currentTrip.price.url 		= "http://api.kayak.com" + tripList.getItemAt(i).price.url;
					currentTrip.price.value 	= new Number(tripList.getItemAt(i).price.value);
					var legList:ArrayCollection = tripList.getItemAt(i).legs.leg as ArrayCollection;
					var legLen:int   			= legList.length;
					for(var j:int=0; j<legLen; j++){
						var currentLeg:Leg 				= new Leg();
						currentLeg.airline 				= legList.getItemAt(j).airline;
						currentLeg.airlineName 			= legList.getItemAt(j).airline_display;
						currentLeg.arrive 				= parseStringToDate(legList.getItemAt(j).arrive); //parse date & time
						currentLeg.cabin 				= legList.getItemAt(j).cabin;
						currentLeg.depart 				= parseStringToDate(legList.getItemAt(j).depart); //parse date & time
						currentLeg.destination 			= legList.getItemAt(j).dest;
						currentLeg.mDuration 			= legList.getItemAt(j).duration_minutes;
						currentLeg.origin 				= legList.getItemAt(j).orig;
						currentLeg.stops 				= legList.getItemAt(j).stops
						var segmentList:ArrayCollection = legList.getItemAt(j).segment as ArrayCollection;
						var segmentLen:int 				= segmentList.length;
						for(var k:int; k<segmentLen; k++){
							var currentSegment:Segment 	= new Segment();
							currentSegment.airline 		= segmentList.getItemAt(k).airline;
							currentSegment.arrival 		= parseStringToDate(segmentList.getItemAt(k).at); //parse date & time
							currentSegment.cabin   		= segmentList.getItemAt(k).cabin;
							currentSegment.departure 	= parseStringToDate(segmentList.getItemAt(k).dt); //parse date & time
							currentSegment.destination 	= segmentList.getItemAt(k).d;
							currentSegment.equipment 	= segmentList.getItemAt(k).equip;
							currentSegment.flight 		= segmentList.getItemAt(k).flight;
							currentSegment.mDuration 	= segmentList.getItemAt(k).duration_minutes;
							currentSegment.miles 		= segmentList.getItemAt(k).miles;
							currentSegment.origin 		= segmentList.getItemAt(k).o;
							currentLeg.segments.addItem(currentSegment);
						}
						currentTrip.legs.addItem(currentLeg);
					}
					flightResults.trips.addItem(currentTrip);
				}
				flightResults.count = flightResults.trips.length;	
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
		
		private function doInitialFlightSearch(headers:Object):void{
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
			
			
			paramTO.origin 		= origin;
			paramTO.destination = destination;
			paramTO.depart_date = depart_date;
			paramTO.return_date = return_date;
			paramTO.depart_time = depart_time;
			paramTO.return_time = return_time;
			paramTO.travelers	= travelers;
			paramTO.cabin		= cabin;
			paramTO.oneway 		= oneway;
			
			
			if(_flightSearchValidator.validate(paramTO)){
				paramTO = _flightSearchFormatter.format(paramTO);
				url += "&origin="		+ paramTO.origin;
				url += "&destination=" 	+ paramTO.destination;
				url += "&depart_date=" 	+ encodeURIComponent(paramTO.depart_date);
				url += "&return_date=" 	+ encodeURIComponent(paramTO.return_date);
				url += "&depart_time=" 	+ paramTO.depart_time;
				url += "&return_time=" 	+ paramTO.return_time;
				url += "&travelers=" 	+ paramTO.travelers;
				url += "&cabin=" 		+ paramTO.cabin;
				url += "&oneway="		+ paramTO.oneway;
				searchService.method 				= "GET";
				searchService.useProxy 			= false;
				searchService.url 					= url;
				searchService.makeObjectsBindable 	= true;
				searchService.headers = headers;
				searchService.addEventListener(FaultEvent.FAULT,onFault);
				searchService.addEventListener(ResultEvent.RESULT,onInitialFlightSearchResult);
				
				searchService.send();
			}
			else{
				var errors:ArrayCollection = new ArrayCollection();
				errors.addItem("Validation Failed");
				var failureEvent:SearchFailureEvent = new SearchFailureEvent(SearchFailureEvent.EVENT_ID,errors);
			}
		}
		
	private function pollResults(searchID:String,headers:Object):void{
		var url				:String 		= _baseURL + "/s/apibasic/flight?";
		var searchService	:HTTPService 	= new HTTPService();
		
		url += "searchid=" + searchID;
		url += "&c="	   + resultCount;
		if(filterMode != "normal")
			url += "&m=" + filterMode + ":" + filterAirline;
			else
				url += "&m=normal";
		url += "&d=" + sortDirection;
		url += "&s=" + sortKey;
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