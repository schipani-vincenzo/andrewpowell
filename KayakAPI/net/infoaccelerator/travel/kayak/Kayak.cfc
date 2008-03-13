<cfcomponent output="false">
	
	<cfscript>
		variables.version   				=  1;
		//TODO:  take this value out after testing;
		variables.key						= "ELbI0KUodURBLn2_16Gh_A";
		variables.token     				= "";
		variables.lastToken 				= "";
		variables.baseURL   				= "http://api.kayak.com";
		variables.flightSearchValidator 	= createObject('component', 'net.infoaccelerator.travel.kayak.validators.SearchValidator');
	</cfscript>
	
	<cffunction name="init" access="public" returntype="net.infoaccelerator.travel.kayak.Kayak" output="false">
		<cfargument name="key" type="string" required="true"/>
		
		<cfset variables.key = arguments.key/>
		
		<cfreturn this/>
		
	</cffunction>
	
	<cffunction name="getSession" access="private" returntype="string" output="false">
		<cfset var url 			 = variables.baseURL & "/k/ident/apisession?version=" & variables.version & "&token=" & variables.key />
		<cfset var sessionResult = structNew() 																											/>
		<cfset var xmlResult     = xmlNew()																												/>
		
		<cfif variables.lastToken NEQ "" AND (dateDiff('n',variables.lastToken,now()) LTE 30)>
			<cfreturn variables.token/>
			<cfelse>
				<cfhttp url="#url#" result="sessionResult" method="get"/>
				<cfset xmlResult = xmlParse(sessionResult.FileContent)/>
								
				<cfreturn xmlResult.ident.sid.XmlText/>		
		</cfif>
	</cffunction>
	
	<cffunction name="startSearch" access="private" returntype="struct" output="false">
		<cfargument name="oneway" 		type="boolean" 	required="true"		/>
		<cfargument name="origin" 		type="boolean" 	required="true"		/>
		<cfargument name="destination" 	type="boolean" 	required="true"		/>
		<cfargument name="depart" 		type="date"    	required="true"		/>
		<cfargument name="return" 		type="date"	 	required="true"		/>
		<cfargument name="departTime" 	type="string" 	required="true"		/>
		<cfargument name="travelers"  	type="numeric" 	required="true"		/>
		<cfargument name="cabin"	  	type="string" 	required="true"		/>
		
				
		<cfset var basicmode  = "true"/>
		<cfset var action     = "doFlights"/>
		<cfset var apimode	  = variables.version/>
		<cfset var sid		  = getSession()/>
		<cfset var url		  = variables.baseURL & "/s/apisearch?basicmode=" & basicmode & "&action=" & action & "&apimode=" & apimode & "&_sid_=" & sid & "&version=" & variables.version/>
		<cfset var httpResult = structNew()/>
		
		
		<cfif variables.searchValidator.validate(arguments)>
		
		</cfif>
	</cffunction>
	
	
</cfcomponent>