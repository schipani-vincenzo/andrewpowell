<cfcomponent output="false">
	
	<cfset airportDG = createObject('component','net.infoaccelerator.travel.kayak.data.gateway.AirportDG')/>
	
	<cffunction name="searchAirports" access="remote" returntype="array" output="false">
		<cfargument name="searchString" type="string" required="false" default=""/>
		
		<cfset var airports 	= 	arrayNew(1)														/>
		<cfset var rawData  	= 	airportDG.doSearchByCityAndCode(ucase(arguments.searchString))	/>
		<cfset var airportCount	=	arrayLen(rawData)												/>
		<cfset var i			=	1																/>
		
		<cfloop from="1" to="#airportCount#" index="i">
			<cfset arrayAppend(airports,rawData[i].code)>
		</cfloop>
		
		<cfreturn airports/>
	</cffunction>
</cfcomponent>