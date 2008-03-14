<cfcomponent displayname="net.infoaccelerator.travel.kayak.vo.Price" output="false">
	<cfproperty name="url" 		displayname="url" 		type="string"/>
	<cfproperty name="currency" displayname="currency" 	type="string"/>
	<cfproperty name="value" 	displayname="value" 	type="string"/>
	
	<cfscript>
		this.url 		= "";
		this.currency 	= "";
		this.value 		=  0;
	</cfscript>
</cfcomponent>