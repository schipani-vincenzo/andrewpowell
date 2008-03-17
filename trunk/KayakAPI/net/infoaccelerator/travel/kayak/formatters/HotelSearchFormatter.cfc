<cfcomponent implements="ISearchFormatter" output="false">
	<cffunction name="format" access="public" returntype="struct">
		<cfargument name="subject" type="struct" required="true"/>
		<cfscript>
			arguments.subject.checkin_date   	= formatDate(arguments.subject.checkin_date);
			arguments.subject.checkout_date   	= formatDate(arguments.subject.checkout_date);
			
			return arguments.subject;
		</cfscript>
	</cffunction>
	
	<cffunction name="formatDate" access="private" returntype="string" output="false">
		<cfargument name="target" type="date" required="true"/>
		<cfreturn dateFormat(arguments.target,"mm/dd/yyyy")/>
	</cffunction>
</cfcomponent>