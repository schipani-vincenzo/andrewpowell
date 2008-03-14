<cfcomponent output="false">
	<cfproperty name="searchInstance" 	displayname="searchInstance" 	type="string"	/>
	<cfproperty name="searchID" 		displayname="searchID" 			type="string"	/>
	<cfproperty name="count" 			displayname="count" 			type="numeric"	/>
	<cfproperty name="trips" 			displayname="trips" 			type="array"	/>
	
	<cfscript>
		this.searchInstance	=	"";
		this.searchID		=	"";
		this.count			=	 0;
		this.trips			=	arrayNew();
	</cfscript>
</cfcomponent>