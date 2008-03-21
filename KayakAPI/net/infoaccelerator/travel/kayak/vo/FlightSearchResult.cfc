<cfcomponent extends="SearchResults" output="false">
	<cfproperty name="trips" 			displayname="trips" 			type="net.infoaccelerator.travel.kayak.vo.Trip[]"	/>
	
	<cfscript>
		this.trips			=	arrayNew(1);
	</cfscript>
</cfcomponent>