<cfcomponent extends="SearchResults" output="false">
	<cfproperty name="hotels" 			displayname="hotels" 			type="array"	/>
	
	<cfscript>
		this.hotels			=	arrayNew(1);
	</cfscript>
</cfcomponent>