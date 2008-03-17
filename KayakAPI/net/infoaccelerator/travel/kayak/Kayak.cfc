<!---
The MIT License

Copyright (c) 2008 Stretford Interactive Consulting Services, Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

Created:  		3/13/2008
Created By:  	Andrew Powell (andy.powell@mac.com)
Modified By:	Andrew Powell (andy.powell@mac.com)
Modified:		3/14/2008
--->
<cfcomponent output="false">
	
	<cfscript>
		variables.version   				=  1;
		variables.key						= "";
		variables.token     				= "";
		variables.lastToken 				= "";
		variables.baseURL   				= "http://api.kayak.com";
		variables.flightSearchValidator 	= createObject('component', 'net.infoaccelerator.travel.kayak.validators.FlightSearchValidator');
		variables.flightSearchFormatter 	= createObject('component', 'net.infoaccelerator.travel.kayak.formatters.FlightSearchFormatter');
		variables.hotelSearchValidator 		= createObject('component', 'net.infoaccelerator.travel.kayak.validators.HotelSearchValidator');
		variables.hotelSearchFormatter 		= createObject('component', 'net.infoaccelerator.travel.kayak.formatters.HotelSearchFormatter');
	</cfscript>
	
	<cffunction name="init" access="public" returntype="net.infoaccelerator.travel.kayak.Kayak" output="false">
		<cfargument name="key" type="string" required="true"/>
		
		<cfset variables.key = arguments.key/>
		
		<cfreturn this/>
		
	</cffunction>
	
	<cffunction name="getSession" access="public" returntype="string" output="false">
		<cfset var url 			 = variables.baseURL & "/k/ident/apisession?version=" & variables.version & "&token=" & variables.key />
		<cfset var sessionResult = structNew() 																											/>
		<cfset var xmlResult     = xmlNew()																												/>
		
		<cfhttp url="#url#" result="sessionResult" method="GET" />
		<cftry>
			<cfif mid(sessionResult.StatusCode,1,3) EQ "200">				
				<cfset xmlResult = xmlParse(trim(sessionResult.FileContent))/>			
				<cfreturn xmlResult.ident.sid.XmlText/>
				<cfelse>
					<cfthrow message="Error Obtaining Session ID" type="communication" errorcode="#sessionResult.StatusCode#" extendedinfo="#sessionResult.FileContent#">		
			</cfif>
			<cfcatch type="any">
				<cfthrow message="Error Obtaining Session ID" type="communication" errorcode="#sessionResult.StatusCode#" extendedinfo="#sessionResult.FileContent#">
			</cfcatch>
		</cftry>
	</cffunction>
	
	<cffunction name="getCookies" access="private" returntype="array" output="false">
		<cfargument name="cookieStruct" type="struct" required="true"/>
		
		<cfset var keyArray 	= listToArray(structKeyList(arguments.cookieStruct))/>
		<cfset var keyLen   	= arrayLen(keyArray)								/>
		<cfset var i 			= 1													/>
		<cfset var x			= ""												/>
		<cfset var y			= ""												/>
		<cfset var tempList 	= ""												/>
		<cfset var cookieArray  = arrayNew(1)										/>
		
		<cfloop from="1" to="#keyLen#" index="i">
			<cfset x = listFirst(arguments.cookieStruct[keyArray[i]],";")	/>
			<cfset cookieArray[i] = structNew()							/>
			<cfset cookieArray[i]["name"]  = listFirst(x,"=")				/>
			<cfset cookieArray[i]["value"] = listLast(x,"=")				/>
		</cfloop>
		<cfreturn cookieArray/>
	</cffunction>
	
	<cffunction name="startFlightSearch" access="public" returntype="struct" output="false">
		<cfargument name="oneway" 		type="boolean" 	required="true" 	hint="y or n"							/>
		<cfargument name="origin" 		type="string" 	required="true" 	hint="three-letter airport code"		/>
		<cfargument name="destination" 	type="string" 	required="true"		hint="three-letter airport code"		/>
		<cfargument name="depart_date" 	type="date"    	required="true"		hint="date to depart"					/>
		<cfargument name="return_date" 	type="date"	 	required="false"	hint="date to return" default=""					/>
		<cfargument name="depart_time" 	type="string" 	required="true"		hint="Values:a = any time;r=early morning;m=morning;12=noon;n=afternoon;e=evening;l=night"		/>
		<cfargument name="return_time" 	type="string" 	required="false"	hint="Values:a = any time;r=early morning;m=morning;12=noon;n=afternoon;e=evening;l=night" default=""	/>
		<cfargument name="travelers"  	type="numeric" 	required="true"		hint="integer from 1-8"					/>
		<cfargument name="cabin"	  	type="string" 	required="true"		hint="f, b or e(default) (first, business, economy/coach)"/>
		<cfargument name="session"		type="string"	required="true"		hint="sessionid from getSession()"/>
		
				
		<cfset var basicmode  	= "true"/>
		<cfset var action     	= "doFlights"/>
		<cfset var apimode	  	= variables.version/>
		<cfset var url		  	= variables.baseURL & "/s/apisearch?basicmode=" & basicmode & "&action=" & action & "&apimode=" & apimode & "&_sid_=" & urlencodedFormat(arguments.session) & "&version=" & variables.version/>
		<cfset var urlKeys    	= listToArray(structKeyList(arguments,","),",")/>
		<cfset var keyLen     	= arrayLen(urlKeys)/>
		<cfset var i		  	= 1/>
		<cfset var httpResult 	= structNew()/>
		<cfset var xmlResult  	= xmlNew()/>
		<cfset var searchResult = structNew()/>
		
		
		<cfif variables.flightSearchValidator.validate(arguments)>
			<cfset arguments = variables.flightSearchFormatter.format(arguments)/>
			
			<cfloop from="1" to="#keyLen#" index="i">
				<cfif arguments[urlKeys[i]] NEQ "">
					<cfset url = url & "&" & lcase(urlKeys[i]) & "=" & urlencodedFormat(arguments[urlKeys[i]])/>
				</cfif>
			</cfloop>
			
			<cfhttp url="#url#" result="httpResult" method="GET" proxyserver="127.0.0.1" proxyport="8184" 			/>
			
			<cfset xmlResult 			= xmlParse(httpResult.fileContent)											/>
			
			<cfif xmlResult.XmlRoot.XmlName NEQ "error">
				<cfset searchResult.id  	= xmlResult.search.searchid.XmlText											/>
				<cfset searchResult.status 	= "ok"																		/>
				<cfset searchResult.cookies = getCookies(httpResult["Responseheader"]["Set-Cookie"])					/>
				<cfelse>
					<cfset errors = xmlSearch(xmlResult,'/error/flight_errors/detail')				/>
					<cfset searchResult.status = "fail"												/>
					<cfset searchResult.msg	   = ""													/>
					<cfloop from="1" to="#arrayLen(errors)#" index="i">
						<cfset searchResult.msg	   = searchResult.msg & errors[i].XmlText & "<br/>"	/>
					</cfloop>
			</cfif>
			<cfelse>
				<cfset searchResult.status = "fail"/>
				<cfset searchResult.msg    = "Validation Failed"/>
		</cfif>
		
		<cfreturn searchResult/>
	</cffunction>
	
	<cffunction name="startHotelSearch" access="public" returntype="struct" output="false">

		<cfargument name="othercity"		type="string" 	required="true" hint="String locating the city. Should be City, RegionCode, CountryCode for US, Canada. Should be City, CountryCode for others."		/>
		<cfargument name="checkin_date"		type="date"    	required="true"	hint="Checkin Date"							/>
		<cfargument name="checkout_date"	type="date"	 	required="true"	hint="Checkout Date"						/>
		<cfargument name="guests1"  		type="numeric" 	required="true" hint="integer from 1-6"						/>
		<cfargument name="rooms"	  		type="numeric" 	required="true"	hint="integer from 1-3"						/>
		<cfargument name="session"			type="string"	required="true" hint="Session from getSession() call"		/>
		
				
		<cfset var basicmode  	= "true"/>
		<cfset var action     	= "dohotels"/>
		<cfset var apimode	  	= variables.version/>
		<cfset var url		  	= variables.baseURL & "/s/apisearch?basicmode=" & basicmode & "&action=" & action & "&apimode=" & apimode & "&_sid_=" & urlencodedFormat(arguments.session) & "&version=" & variables.version/>
		<cfset var urlKeys    	= listToArray(structKeyList(arguments,","),",")/>
		<cfset var keyLen     	= arrayLen(urlKeys)/>
		<cfset var i		  	= 1/>
		<cfset var httpResult 	= structNew()/>
		<cfset var xmlResult  	= xmlNew()/>
		<cfset var searchResult = structNew()/>
		<cfset var errors		= arrayNew(1)/>
		
		
		<cfif variables.hotelSearchValidator.validate(arguments)>
			<cfset arguments = variables.hotelSearchFormatter.format(arguments)/>
			
			<cfloop from="1" to="#keyLen#" index="i">
				<cfset url = url & "&" & lcase(urlKeys[i]) & "=" & urlencodedFormat(arguments[urlKeys[i]])/>
			</cfloop>
			
			<cfhttp url="#url#" result="httpResult" method="GET" proxyserver="127.0.0.1" proxyport="8184"  			/>
			
			<cfset xmlResult 			= xmlParse(httpResult.fileContent)											/>
			
			<cfif xmlResult.XmlRoot.XmlName NEQ "error">
				<cfset searchResult.id  	= xmlResult.search.searchid.XmlText											/>
				<cfset searchResult.status 	= "ok"																		/>
				<cfset searchResult.cookies = getCookies(httpResult["Responseheader"]["Set-Cookie"])					/>
				<cfelse>
					<cfset errors = xmlSearch(xmlResult,'/error/hotel_errors/detail')				/>
					<cfset searchResult.status = "fail"												/>
					<cfset searchResult.msg	   = ""													/>
					<cfloop from="1" to="#arrayLen(errors)#" index="i">
						<cfset searchResult.msg	   = searchResult.msg & errors[i].XmlText & "<br/>"	/>
					</cfloop>
			</cfif>
			<cfelse>
				<cfset searchResult.status = "fail"/>
				<cfset searchResult.msg    = "Validation Failed"/>
		</cfif>
		
		<cfreturn searchResult/>
	</cffunction>
	
	<cffunction name="pollFlightResults" access="private" returntype="xml" output="false">
		<cfargument name="searchID" 	type="string" 	required="true"/>
		<cfargument name="session"		type="string"	required="true"/>
		<cfargument name="resultCount"	type="numeric"	required="true"/>
		<cfargument name="filterMode"	type="string"	required="true"/>
		<cfargument name="airline"		type="string"	required="true"/>
		<cfargument name="sortDir"		type="string"	required="true"/>
		<cfargument name="sortKey"		type="string"	required="true"/>
		<cfargument name="cookies"		type="array"	required="true"/>
		
		<cfset var version 		= variables.version	/>
		<cfset var apimode 		= variables.version	/>
		<cfset var httpResult	= structNew()		/>
				
		<cfset var url = variables.baseURL & "/s/apibasic/flight?_sid_=" & arguments.session & "&version=" & variables.version & "&apimode=" & apimode/>
		<cfset url = url & "&searchid=" & arguments.searchid/>
		<cfset url = url & "&c=" & arguments.resultCount/>
		<cfif arguments.filterMode EQ "airline">
			<cfset url = url & "&m=" & arguments.filterMode & ':' & arguments.airline/>
			<cfelse>
				<cfset url = url & "&m=" & arguments.filterMode/>
		</cfif>
		<cfset url = url & "&d=" & arguments.sortDir/>
		<cfset url = url & "&s=" & arguments.sortKey/>
			
		<cfhttp url="#url#" result="httpResult" method="POST" proxyserver="127.0.0.1" proxyport="8184">
			<cfloop from="1" to="#arraylen(arguments.cookies)#" index="i">
				<cfif arguments.cookies[i].name NEQ "Apache">
					<cfhttpparam type="Cookie" value="#arguments.cookies[i].value#" name="#arguments.cookies[i].name#" >
				</cfif>
			</cfloop>
		</cfhttp>
			
		<cfreturn xmlParse(httpResult.fileContent)/>
	</cffunction>
	
	<cffunction name="pollHotelResults" access="private" returntype="xml" output="false">
		<cfargument name="searchID" 	type="string" 	required="true"/>
		<cfargument name="session"		type="string"	required="true"/>
		<cfargument name="resultCount"	type="numeric"	required="true"/>
		<cfargument name="filterMode"	type="string"	required="true"/>
		<cfargument name="filterStars"	type="numeric"	required="false" default="0">
		<cfargument name="sortDir"		type="string"	required="true"/>
		<cfargument name="sortKey"		type="string"	required="true"/>
		<cfargument name="cookies"		type="array"	required="true"/>
		
		<cfset var version 		= variables.version	/>
		<cfset var apimode 		= variables.version	/>
		<cfset var httpResult	= structNew()		/>
		<cfset var tryAgain     = true				/>
		<cfset var resultXML	= xmlNew()			/>		
		<cfset var url = variables.baseURL & "/s/apibasic/flight?_sid_=" & arguments.session & "&version=" & variables.version & "&apimode=" & apimode/>
		<cfset var jThread      = createObject('java','java.lang.Thread').init()/>
		<cfset url = url & "&searchid=" & arguments.searchid/>
		<cfset url = url & "&c=" & arguments.resultCount/>
		<cfif arguments.filterMode NEQ "stars">
			<cfset url = url & "&m=" & arguments.filterMode/>
			<cfelse>
				<cfset url = url & "&m=" & arguments.filterMode & ":" & arguments.filterStars/>
		</cfif>
		<cfset url = url & "&d=" & arguments.sortDir/>
		<cfset url = url & "&s=" & arguments.sortKey/>
		
		<cfloop condition="#tryAgain#">	
			<cftry>
				<cfhttp url="#url#" result="httpResult" method="POST" proxyserver="127.0.0.1" proxyport="8184">
					<cfloop from="1" to="#arraylen(arguments.cookies)#" index="i">
						<cfif arguments.cookies[i].name NEQ "Apache">
							<cfhttpparam type="Cookie" value="#arguments.cookies[i].value#" name="#arguments.cookies[i].name#" >
						</cfif>
					</cfloop>
				</cfhttp>
				<cfset resultXML = xmlParse(httpResult.fileContent) />
				<cfset tryAgain = false/>
				<cfcatch type="any">
					<cfset tryAgain = true/>
					<cfset jThread.sleep(5000)/>
				</cfcatch>
			</cftry>
		</cfloop>
			
		<cfreturn resultXML/>
	</cffunction>
	
	<cffunction name="getFlightResults" access="public" returntype="net.infoaccelerator.travel.kayak.vo.FlightSearchResult" output="false">
		<cfargument name="searchID" 	type="string" 	required="true"/>
		<cfargument name="session"		type="string"	required="true"/>
		<cfargument name="resultCount"	type="numeric"	required="true"/>
		<cfargument name="filterMode"	type="string"	required="true"/>
		<cfargument name="airline"		type="string"	required="true"/>
		<cfargument name="sortDir"		type="string"	required="true"/>
		<cfargument name="sortKey"		type="string"	required="true"/>
		<cfargument name="cookies"		type="array"	required="true"/>
		
		<cfset var morepending = true/>
		<cfset var searchResults = createObject('component','net.infoaccelerator.travel.kayak.vo.FlightSearchResult')/>
		<cfset var poll = ""/>
		<cfset var trips = ""/>
		<cfset var legs  = ""/>
		<cfset var currentTrip = ""/>
		<cfset var cLeg = ""/>
		<cfset var segs = ""/>
		<cfset var cSeg = ""/>
		<cfset var jThread = createObject('java','java.lang.Thread').init()/>
		
		<cfloop condition="morepending">
			<cfset poll = pollFlightResults(arguments.searchid,arguments.session,arguments.resultCount,arguments.filterMode,arguments.airline,arguments.sortDir,arguments.sortKey,arguments.cookies)/>
			
			<cfset searchResults.searchID = poll.searchresult.searchid.XmlText/>
			<cfset serachResults.count    = poll.searchresult.count.XmlText/>
			
			<cfset trips = xmlSearch(poll,'/searchresult/trips/trip')/>
			
			<cfloop from="1" to="#arrayLen(trips)#" index="i">
				<cfset currentTrip = createObject('component','net.infoaccelerator.travel.kayak.vo.Trip')>
				<cfset currentTrip.price.value 		= trips[i].price.XmlText/>
				<cfset currentTrip.price.url   		= trips[i].price.XmlAttributes.url/>
				<cfset currentTrip.price.currency 	= trips[i].price.XmlAttributes.currency/>
				
				<cfset legs = xmlSearch(poll,'/searchresult/trips/trip[#i#]/legs/leg')>
		
				<cfloop from="1" to="#arrayLen(legs)#" index="x">
					<cfset cLeg = createObject('component','net.infoaccelerator.travel.kayak.vo.Leg')/>
					<cfset cLeg.airline			=	legs[x].airline.XmlText/>
					<cfset cLeg.airlineName		=	legs[x].airline_display.XmlText/>
					<cfset cLeg.origin			=	legs[x].orig.XmlText/>
					<cfset cLeg.destination		=	legs[x].dest.XmlText/>
					<cfset cLeg.depart			=	legs[x].depart.XmlText/>
					<cfset cLeg.arrive			=	legs[x].arrive.XmlText/>
					<cfset cLeg.stops			=	legs[x].stops.XmlText/>
					<cfset cLeg.mDuration		=	legs[x].duration_minutes.XmlText/>
					<cfset cLeg.cabin			=	legs[x].cabin.XmlText/>
					<cfset segs = xmlSearch(poll,'/searchresult/trips/trip[#i#]/legs/leg[#x#]/segment')>
		
					<cfloop from="1" to="#arrayLen(segs)#" index="y">
						<cfset cSeg = createObject('component','net.infoaccelerator.travel.kayak.vo.Segment')/>
						<cfset cSeg.airline		=	segs[y].airline.XmlText/>
						<cfset cSeg.flight		=	segs[y].flight.XmlText/>
						<cfset cSeg.mDuration	=	segs[y].duration_minutes.XmlText/>
						<cfset cSeg.equipment	=	segs[y].equip.XmlText/>
						<cfset cSeg.miles		=	segs[y].miles.XmlText/>
						<cfset cSeg.origin		=	segs[y].o.XmlText/>
						<cfset cSeg.departure  	= 	segs[y].dt.XmlText/>
						<cfset cSeg.arrival		=	segs[y].at.XmlText/>
						<cfset cSeg.destination	=	segs[y].d.XmlText/>
						<cfset cSeg.cabin 		= 	segs[y].cabin.XmlText/>
						<cfset arrayAppend(cLeg.segments,cSeg)/>
					</cfloop>
					
					<cfset arrayAppend(currentTrip.legs,cLeg)/>
				</cfloop>
				<cfset arrayAppend(searchResults.trips,currentTrip)/>
			</cfloop>
			
			
			<cfif poll.searchresult.morepending.XmlText EQ "">
				<cfset morepending = false/>
				<cfelse>
					<cfset morepending = true/>
			</cfif>
			
		
			<cfset jThread.sleep(5000)/>
		</cfloop>
		
		<cfset searchResults.count = arrayLen(searchresults.trips)/>
		
		<cfreturn searchResults/>
	</cffunction>
	
	<cffunction name="getHotelResults" access="public" returntype="net.infoaccelerator.travel.kayak.vo.HotelSearchResult" output="false">
		<cfargument name="searchID" 	type="string" 	required="true" hint="search id needed for polling"/>
		<cfargument name="session"		type="string"	required="true" hint="the session id returned from the initial getSession call"/>
		<cfargument name="resultCount"	type="numeric"	required="true" hint="the number of results to return"/>
		<cfargument name="filterMode"	type="string"	required="true" hint="filter mode: normal or stars"/>
		<cfargument name="filterStars"	type="numeric"	required="false" default="0" hint="if filterMode = stars, then must be 1,2,3,4,or 5">
		<cfargument name="sortDir"		type="string"	required="true" hint="sort direction: up or down"/>
		<cfargument name="sortKey"		type="string"	required="true" hint="sort key: price,stars,hotel,distance"/>
		<cfargument name="cookies"		type="array"	required="true" hint="the cookie struct returned from the intial search"/>
		
		<cfset var morepending = true/>
		<cfset var searchResults = createObject('component','net.infoaccelerator.travel.kayak.vo.HotelSearchResult')/>
		<cfset var poll = ""/>
		<cfset var jThread = createObject('java','java.lang.Thread').init()/>
		<cfset var currentHotel = ""/>
		<cfset var hotels = ""/>
		
		<cfloop condition="morepending">
			<cfset poll = pollHotelResults(arguments.searchid,arguments.session,arguments.resultCount,arguments.filterMode,arguments.sortDir,arguments.sortKey,arguments.cookies)/>
			
			<cfset searchResults.searchID = poll.searchresult.searchid.XmlText/>
			<cfset serachResults.count    = poll.searchresult.count.XmlText/>
			
			<cfset hotels = xmlSearch(poll,'/searchresult/hotels/hotel')/>
			
			<cfloop from="1" to="#arrayLen(hotels)#" index="i">
				<cfset currentHotel = createObject('component','net.infoaccelerator.travel.kayak.vo.Hotel')/>
				<cfset currentHotel.id					= hotels[i].id.XmlText						/>
				<cfset currentHotel.price.value 		= hotels[i].price.XmlText					/>
				<cfset currentHotel.price.url   		= hotels[i].price.XmlAttributes.url			/>
				<cfset currentHotel.price.currency 		= hotels[i].price.XmlAttributes.currency	/>
				<cfset currentHotel.priceLow 			= hotels[i].pricehistorylo.XmlText			/>
				<cfset currentHotel.priceHigh 			= hotels[i].pricehistoryhi.XmlText			/>
				<cfset currentHotel.stars 				= hotels[i].stars.XmlText					/>
				<cfset currentHotel.name 				= hotels[i].name.XmlText					/>
				<cfset currentHotel.phone 				= hotels[i].phone.XmlText					/>
				<cfset currentHotel.address 			= hotels[i].address.XmlText					/>
				<cfset currentHotel.lat 				= hotels[i].lat.XmlText						/>
				<cfset currentHotel.lon 				= hotels[i].lon.XmlText						/>
				<cfset currentHotel.city 				= hotels[i].city.XmlText					/>
				<cfset currentHotel.region 				= hotels[i].region.XmlText					/>
				<cfset currentHotel.country 				= hotels[i].country.XmlText				/>
				<cfset arrayAppend(searchResults.hotels,currentHotel)								/>
			</cfloop>
			
			
			<cfif poll.searchresult.morepending.XmlText EQ "">
				<cfset morepending = false/>
				<cfelse>
					<cfset morepending = true/>
			</cfif>
			
		
			<cfset jThread.sleep(5000)/>
		</cfloop>
		
		<cfset searchResults.count = arrayLen(searchresults.hotels)/>
		
		<cfreturn searchResults/>
	</cffunction>
	
	
</cfcomponent>