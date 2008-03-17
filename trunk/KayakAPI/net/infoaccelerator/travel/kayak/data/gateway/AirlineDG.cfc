<cfcomponent output="false">
	
	<cfset variables.airports = createObject('component','net.infoaccelerator.travel.kayak.data.DataLoader').loadAirlines()/>
	
	<cffunction name="doSearchByName" access="public" returntype="net.infoaccelerator.travel.kayak.vo.Airline[]" output="false">
		<cfargument name="searchString" type="string" required="true"/>
		
		<cfset var searchResults = queryNew("")	/>
		<cfset var voArray       = arrayNew(1)	/>
		
		<cfquery dbtype="query" name="searchResults">
			SELECT code,airline,fullname,country,keywords,phone,website FROM variables.airlines WHERE name like '#arguments.searchString#%'
		</cfquery>
		
		<cfoutput query="searchResults">
			<cfset voArray[searchResults.currentRow] 			= createObject('component','net.infoaccelerator.travel.kayak.vo.Airline')/>
			<cfset voArray[searchResults.currentRow].code 		= searchResults.code		/>
			<cfset voArray[searchResults.currentRow].airline 	= searchResults.airline		/>
			<cfset voArray[searchResults.currentRow].country 	= searchResults.country		/>
			<cfset voArray[searchResults.currentRow].fullname 	= searchResults.fullname	/>
			<cfset voArray[searchResults.currentRow].keywords 	= searchResults.keywords	/>
			<cfset voArray[searchResults.currentRow].phone 		= searchResults.phone		/>
			<cfset voArray[searchResults.currentRow].website 	= searchResults.website		/>
		</cfoutput>
		<cfreturn voArray/>
	</cffunction>
	
	
</cfcomponent>