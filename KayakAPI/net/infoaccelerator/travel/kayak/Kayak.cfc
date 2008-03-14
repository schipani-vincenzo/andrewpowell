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
		
		<cfhttp url="#url#" result="sessionResult" method="get"/>
		<cfset xmlResult = xmlParse(sessionResult.FileContent)/>
						
		<cfreturn xmlResult.ident.sid.XmlText/>		

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
		<cfargument name="oneway" 		type="boolean" 	required="true"		/>
		<cfargument name="origin" 		type="string" 	required="true"		/>
		<cfargument name="destination" 	type="string" 	required="true"		/>
		<cfargument name="depart_date" 	type="date"    	required="true"		/>
		<cfargument name="return_date" 	type="date"	 	required="true"		/>
		<cfargument name="depart_time" 	type="string" 	required="true"		/>
		<cfargument name="return_time" 	type="string" 	required="true"		/>
		<cfargument name="travelers"  	type="numeric" 	required="true"		/>
		<cfargument name="cabin"	  	type="string" 	required="true"		/>
		<cfargument name="session"		type="string"	required="true"		/>
		
				
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
				<cfset url = url & "&" & lcase(urlKeys[i]) & "=" & urlencodedFormat(arguments[urlKeys[i]])/>
			</cfloop>
			
			<cfhttp url="#url#" result="httpResult" method="GET" proxyserver="127.0.0.1" proxyport="8184" 			/>
			
			<cfset xmlResult 			= xmlParse(httpResult.fileContent)											/>
			
			<cfset searchResult.id  	= xmlResult.search.searchid.XmlText											/>
			<cfset searchResult.status 	= "ok"																		/>
			<cfset searchResult.cookies = getCookies(httpResult["Responseheader"]["Set-Cookie"])					/>
			<cfelse>
				<cfset searchResult.status = "fail"/>
				<cfset searchResult.msg    = "Validation Failed"/>
		</cfif>
		
		<cfreturn searchResult/>
	</cffunction>
	
	<cffunction name="startHotelSearch" access="public" returntype="struct" output="false">
		<cfargument name="oneway" 			type="boolean" 	required="true"		/>
		<cfargument name="othercity"		type="string" 	required="true"		/>
		<cfargument name="checkin_date"		type="date"    	required="true"		/>
		<cfargument name="checkout_date"	type="date"	 	required="true"		/>
		<cfargument name="guests1"  		type="numeric" 	required="true"		/>
		<cfargument name="rooms"	  		type="numeric" 	required="true"		/>
		<cfargument name="session"			type="string"	required="true"		/>
		
				
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
		
		
		<cfif variables.flightSearchValidator.validate(arguments)>
			<cfset arguments = variables.flightSearchFormatter.format(arguments)/>
			
			<cfloop from="1" to="#keyLen#" index="i">
				<cfset url = url & "&" & lcase(urlKeys[i]) & "=" & urlencodedFormat(arguments[urlKeys[i]])/>
			</cfloop>
			
			<cfhttp url="#url#" result="httpResult" method="GET" proxyserver="127.0.0.1" proxyport="8184" 			/>
			
			<cfset xmlResult 			= xmlParse(httpResult.fileContent)											/>
			
			<cfset searchResult.id  	= xmlResult.search.searchid.XmlText											/>
			<cfset searchResult.status 	= "ok"																		/>
			<cfset searchResult.cookies = getCookies(httpResult["Responseheader"]["Set-Cookie"])					/>
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
				<cfset currentTrip.price = trips[i].price.XmlText/>
				<cfset currentTrip.url   = trips[i].price.XmlAttributes.url/>
				<cfset currentTrip.currency = trips[i].price.XmlAttributes.currency/>
				
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
	
	
</cfcomponent>