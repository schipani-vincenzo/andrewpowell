package net.infoaccelerator.travel.kayak.searches
{
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import net.infoaccelerator.travel.kayak.formatters.FlightSearchFormatter;
	import net.infoaccelerator.travel.kayak.formatters.ISearchFormatter;
	import net.infoaccelerator.travel.kayak.validators.FlightSearchValidator;
	import net.infoaccelerator.travel.kayak.validators.ISearchValidator;
	import net.infoaccelerator.travel.kayak.vo.FlightSearchResult;
	
	[Bindable]
	public class KayakFlightSearch
	{
		
		private var _flightSearchFormatter:ISearchFormatter = new FlightSearchFormatter();
		private var _flightSearchValidator:ISearchValidator = new FlightSearchValidator();
		private var _version   			  :Number			=  1;
		private var _baseURL			  :String			= "http://api.kayak.com";
		private var _basicMode			  :String			= "true";
		private var _action				  :String			= "doFlights";
		
		public var flightResults:FlightSearchResult = new FlightSearchResult();
		public var devKey:String;
		public var oneway:Boolean;
		public var origin:String;
		public var destination:String;
		public var depart_date:Date;
		public var return_date:Date;
		public var depart_time:String;
		public var return_time:String;
		public var travelers:Number;
		public var cabin:String;
				
		public function KayakFlightSearch()
		{
		}
				
				
		public function doSearch():FlightSearchResult{
			startSearchProcess(devKey);					
			return new flightResults();
		}				
				
		private function onGetSessionResult(e:ResultEvent):void{
			var kSessionID:String = e.result.ident.sid;
			doInitialFlightSearch(kSessionID);	
		}				
		
		private function onInitialFlightSearchResult(e:ResultEvent):void{
			
		}
				
				
		private function onFault(e:FaultEvent):void{
			mx.controls.Alert.show("An Error Occurred Contacting The Kayak API Service","Kayak API Connection Error");
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
			sessionService.resultFormat = HTTPService.RESULT_FORMAT_E4X;
			
			sessionService.send(params);
					
			
		}
		
		private function doInitialFlightSearch(kSessionID:String):Object{
			var url				:String 		= _baseURL + "/s/apisearch";
			var searchService	:HTTPService 	= new HTTPService();
			var params			:Object 		= new Object();
			var searchResults	:Object 		= new Object();
			var paramTO			:Object			= new Object();
			var resultCheck		:Boolean		= false;
			
			params.version 		= 	_version;
			params.token   		= 	devKey;
			params._sid_		= 	kSessionID;
			params.basicMode 	= 	_basicMode;
			params.action 		=	_action
			
			paramTO.origin 		= origin;
			paramTO.destination = destination;
			paramTO.depart_date = depart_date;
			paramTO.return_date = return_date;
			paramTO.depart_time = depart_time;
			paramTO.return_time = return_time;
			paramTO.travelers	= travelers;
			paramTO.cabin		= cabin;
			
			/*
			if(_flightSearchValidator.validate(paramTO)){
				paramTO = _flightSearchFormatter.format(paramTO);
			}
			else{
				Alert.show("Validation Failed","Kayak API Error");
			}
			*/
			
			searchService.method 				= "GET";
			searchService.useProxy 			= false;
			searchService.url 					= url;
			searchService.makeObjectsBindable 	= true;
			searchService.addEventListener(FaultEvent.FAULT,onFault);
			searchService.addEventListener(ResultEvent.RESULT,onInitialFlightSearchResult);
			
			searchService.send(params);
			
			return null
		}
		
			
		

	}
}