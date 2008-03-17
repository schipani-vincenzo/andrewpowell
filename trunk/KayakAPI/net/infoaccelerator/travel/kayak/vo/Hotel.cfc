<cfcomponent output="false">
	<cfproperty name="id"			displayname="id"		type="numeric"	/>
	<cfproperty name="price" 		displayname="price" 	type="net.infoaccelerator.travel.kayak.vo.Price"/>
	<cfproperty name="priceLow" 	displayname="priceLow" 	type="numeric"	/>
	<cfproperty name="priceHigh" 	displayname="priceHigh" type="numeric"	/>
	<cfproperty name="stars" 		displayname="stars" 	type="numeric"	/>
	<cfproperty name="name" 		displayname="name" 		type="string"	/>
	<cfproperty name="phone" 		displayname="phone" 	type="string"	/>
	<cfproperty name="address"  	displayname="address" 	type="string"	/>
	<cfproperty name="lat"			displayname="lat"		type="string"	/>
	<cfproperty name="lon"			displayname="lon"		type="string"	/>
	<cfproperty name="city" 		displayname="city" 		type="string"	/>
	<cfproperty name="region"		displayname="region"	type="string"	/>
	<cfproperty name="country"		displayname="country"	type="string"	/>

	<cfscript>
		this.id			= 0;
		this.price 		= createObject('component','net.infoaccelerator.travel.kayak.vo.Price');
		this.priceLow 	= 0;
		this.priceHigh 	= 0;
		this.stars 		= 0;
		this.name 		= "";
		this.phone 		= "";
		this.address 	= "";
		this.lat		= "";
		this.lon		= "";
		this.city 		= "";
		this.region		= "";
		this.country	= "";

	</cfscript>	
</cfcomponent>