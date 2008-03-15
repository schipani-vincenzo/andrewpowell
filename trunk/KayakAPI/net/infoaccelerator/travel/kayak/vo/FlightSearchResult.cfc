<cfcomponent extends="SearchResults" output="false">
	<cfproperty name="trips" 			displayname="trips" 			type="array"	/>
	
	<cfscript>
		this.trips			=	arrayNew(1);
	</cfscript>
</cfcomponent>