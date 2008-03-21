<cfcomponent extends="SearchResults" output="false">
	<cfproperty name="hotels" 			displayname="hotels" 			type="net.infoaccelerator.travel.kayak.vo.Hotel[]"	/>
	
	<cfscript>
		this.hotels			=	arrayNew(1);
	</cfscript>
</cfcomponent>