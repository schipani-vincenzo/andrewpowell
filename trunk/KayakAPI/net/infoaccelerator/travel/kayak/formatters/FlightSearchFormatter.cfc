<cfcomponent output="false" implements="SearchFormatter">
	<cffunction name="format" access="public" returntype="struct">
		<cfargument name="subject" type="struct" required="true"/>
		<cfreturn structNew()/>
	</cffunction>
</cfcomponent>