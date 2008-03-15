<cfcomponent output="false">
	<cfproperty name="searchInstance" 	displayname="searchInstance" 	type="string"	/>
	<cfproperty name="searchID" 		displayname="searchID" 			type="string"	/>
	<cfproperty name="count" 			displayname="count" 			type="numeric"	/>
	
	<cfscript>
		this.searchInstance	=	"";
		this.searchID		=	"";
		this.count			=	 0;
	</cfscript>
</cfcomponent>