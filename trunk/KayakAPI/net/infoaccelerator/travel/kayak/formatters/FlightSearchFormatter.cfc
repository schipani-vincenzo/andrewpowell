<cfcomponent output="false" implements="ISearchFormatter">
	<cffunction name="format" access="public" returntype="struct">
		<cfargument name="subject" type="struct" required="true"/>
		<cfscript>
			arguments.subject.origin 		= formatAirportCode(arguments.subject.origin);
			arguments.subject.destination 	= formatAirportCode(arguments.subject.destination);
			arguments.subject.oneway   		= formatOneway(arguments.subject.oneway);
			arguments.subject.depart_date   = formatDate(arguments.subject.depart_date);
			arguments.subject.return_date   = formatDate(arguments.subject.return_date);
			arguments.subject.depart_time   = formatToLower(arguments.subject.depart_time);
			arguments.subject.return_time   = formatToLower(arguments.subject.return_time);
			arguments.subject.cabin         = formatToLower(arguments.subject.cabin);
			return arguments.subject;
		</cfscript>
	</cffunction>
	
	<cffunction name="formatAirportCode" access="private" returntype="string" output="false">
		<cfargument name="target" type="string" required="true"/>
		<cfreturn ucase(arguments.target)/>
	</cffunction>
	
	<cffunction name="formatDate" access="private" returntype="string" output="false">
		<cfargument name="target" type="date" required="true"/>
		<cfreturn dateFormat(arguments.target,"mm/dd/yyyy")/>
	</cffunction>
	
	<cffunction name="formatToLower" access="private" returntype="string" output="false">
		<cfargument name="target" type="string" required="true"/>
		<cfreturn lcase(arguments.target)/>
	</cffunction>
	
	<cffunction name="formatOneway" access="private" returntype="string" output="false">
		<cfargument name="target" type="boolean" required="true"/>
		<cfif arguments.target>
			<cfreturn "y"/>
			<cfelse>
				<cfreturn "n"/>
		</cfif>
	</cffunction>
</cfcomponent>