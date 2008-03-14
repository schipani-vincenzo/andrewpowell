<cfcomponent output="false">
	
	<cfset variables.airports = createObject('component','net.infoaccelerator.travel.kayak.data.DataLoader').loadAirports()/>
	
	<cffunction name="doSearchByCode" access="public" returntype="net.infoaccelerator.travel.kayak.vo.Airport[]" output="false">
		<cfargument name="searchString" type="string" required="true"/>
		
		<cfset var searchResults = queryNew("")	/>
		<cfset var voArray       = arrayNew(1)	/>
		
		<cfquery dbtype="query" name="searchResults">
			SELECT * FROM variables.airports WHERE code like '#arguments.searchString#%'
		</cfquery>
		
		<cfoutput query="searchResults">
			<cfset voArray[searchResults.currentRow] 			= createObject('component','net.infoaccelerator.travel.kayak.vo.Airport')/>
			<cfset voArray[searchResults.currentRow].code 		= searchResults.code/>
			<cfset voArray[searchResults.currentRow].name 		= searchResults.name/>
			<cfset voArray[searchResults.currentRow].city 		= searchResults.city/>
			<cfset voArray[searchResults.currentRow].state 		= searchResults.state/>
			<cfset voArray[searchResults.currentRow].country 	= searchResults.country/>
		</cfoutput>
		
		<cfreturn voArray/>
	</cffunction>
	
	<cffunction name="doSearchByCity" access="public" returntype="net.infoaccelerator.travel.kayak.vo.Airport[]" output="false">
		<cfargument name="searchString" type="string" required="true"/>
		
		<cfset var searchResults = queryNew("")	/>
		<cfset var voArray       = arrayNew(1)	/>
		
		<cfquery dbtype="query" name="searchResults">
			SELECT * FROM variables.airports WHERE city like '#arguments.searchString#%'
		</cfquery>
		
		<cfoutput query="searchResults">
			<cfset voArray[searchResults.currentRow] 			= createObject('component','net.infoaccelerator.travel.kayak.vo.Airport')/>
			<cfset voArray[searchResults.currentRow].code 		= searchResults.code/>
			<cfset voArray[searchResults.currentRow].name 		= searchResults.name/>
			<cfset voArray[searchResults.currentRow].city 		= searchResults.city/>
			<cfset voArray[searchResults.currentRow].state 		= searchResults.state/>
			<cfset voArray[searchResults.currentRow].country 	= searchResults.country/>
		</cfoutput>
		
		<cfreturn voArray/>
	</cffunction>
	
	<cffunction name="doSearchByCityAndCode" access="public" returntype="net.infoaccelerator.travel.kayak.vo.Airport[]" output="false">
		<cfargument name="searchString" type="string" required="true"/>
		
		<cfset var searchResults = queryNew("")	/>
		<cfset var voArray       = arrayNew(1)	/>
		
		<cfquery dbtype="query" name="searchResults">
			SELECT * FROM variables.airports WHERE city like '#arguments.searchString#%' OR code like '#arguments.searchString#%'
		</cfquery>
		
		<cfoutput query="searchResults">
			<cfset voArray[searchResults.currentRow] 			= createObject('component','net.infoaccelerator.travel.kayak.vo.Airport')/>
			<cfset voArray[searchResults.currentRow].code 		= searchResults.code/>
			<cfset voArray[searchResults.currentRow].name 		= searchResults.name/>
			<cfset voArray[searchResults.currentRow].city 		= searchResults.city/>
			<cfset voArray[searchResults.currentRow].state 		= searchResults.state/>
			<cfset voArray[searchResults.currentRow].country 	= searchResults.country/>
		</cfoutput>
		
		<cfreturn voArray/>
	</cffunction>
	
</cfcomponent>