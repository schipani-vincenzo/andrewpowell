<cfcomponent displayname="net.infoaccelerator.travel.kayak.vo.Leg" output="false">
	<cfproperty name="airline" 		displayname="airline" 		type="string">
	<cfproperty name="airlineName" 	displayname="airlineName" 	type="string">
	<cfproperty name="origin" 		displayname="origin" 		type="string">
	<cfproperty name="destination" 	displayname="destination" 	type="string">
	<cfproperty name="depart" 		displayname="depart" 		type="date">
	<cfproperty name="arrive" 		displayname="arrive" 		type="date">
	<cfproperty name="stops" 		displayname="stops" 		type="numeric">
	<cfproperty name="mDuration" 	displayname="mDuration" 	type="numeric">
	<cfproperty name="cabin" 		displayname="cabin" 		type="string">
	<cfproperty name="segments" 	displayname="segments" 		type="array">
	
	<cfscript>
		this.airline		=	"";
		this.airlineName	=	"";
		this.origin			=	"";
		this.destination	=	"";
		this.depart			=	createDateTime(0,0,0,0,0,0);
		this.arrive			=	createDateTime(0,0,0,0,0,0);
		this.stops			=	 0;
		this.mDuration		=	 0;
		this.cabin			=	"";
		this.segments		=	arrayNew(1);
	</cfscript>
</cfcomponent>