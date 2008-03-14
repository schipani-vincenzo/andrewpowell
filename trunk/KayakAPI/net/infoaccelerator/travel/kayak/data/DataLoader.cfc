<cfcomponent>
	
	<cffunction name="loadAirlines" access="public" returntype="query" output="false">
		<cfset var airlineQuery = queryNew("")/>
		<cfset var airlinesXML  = ""/>
		
		<cffile action="read" variable="airlinesXML" file="#expandPath('/net/infoaccelerator/travel/kayak/xml/airlines.xml')#"/>
		
		<cfwddx action="wddx2cfml" input="#airlinesXML#" output="airlineQuery"/>
		
		<cfreturn airlineQuery/>
		
	</cffunction>
	
	<cffunction name="loadAirports" access="public" returntype="query" output="false">
		<cfset var airportQuery = queryNew("")/>
		<cfset var airportXML   = ""/>
		
		<cffile action="read" variable="airportXML" file="#expandPath('/net/infoaccelerator/travel/kayak/xml/airports.xml')#"/>
		
		<cfwddx action="wddx2cfml" input="#airportXML#" output="airlineQuery"/>
		
		<cfreturn airlineQuery/>
		
	</cffunction>
	
	
</cfcomponent>