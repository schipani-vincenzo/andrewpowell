<cfcomponent displayname="net.infoaccelerator.travel.kayak.vo.Segment" output="false">
	
	<cfproperty name="airline" 		displayname="airline" 	type="string"	/>
	<cfproperty name="flight"		displayname="flight"	type="numeric"	/>
	<cfproperty name="mDuration"	displayname="mDuration"	type="numeric"	/>
	<cfproperty name="equipment"	displayname="equipment" type="string"	/>
	<cfproperty name="miles"		displayname="equipment" type="numeric"	/>
	<cfproperty name="origin"		displayname="equipment" type="string"	/>
	<cfproperty name="departure"	displayname="equipment" type="date"		/>
	<cfproperty name="arrival"		displayname="equipment" type="date"		/>
	<cfproperty name="destination"	displayname="equipment" type="string"	/>
	<cfproperty name="cabin"		displayname="equipment" type="string"	/>
	
	<cfscript>
		this.airline	=	"";
		this.flight		=	 0;
		this.mDuration	=	 0;
		this.equipment	=	"";
		this.miles		=	 0;
		this.origin		=	"";
		this.departure  = 	createDateTime(1970,1,1,0,0,0);
		this.arrival	=	createDateTime(1970,1,1,0,0,0);
		this.destination=	"";
		this.cabin 		= 	"";
	</cfscript>
	
</cfcomponent>