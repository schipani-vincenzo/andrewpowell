<cfcomponent output="false">
	<cfproperty name="price" 		displayname="price" 	type="net.infoaccelerator.travel.kayak.vo.Price"/>
	<cfproperty name="priceLow" 	displayname="priceLow" 	type="numeric"	/>
	<cfproperty name="priceHigh" 	displayname="priceHigh" type="numeric"	/>
	<cfproperty name="stars" 		displayname="stars" 	type="numeric"	/>
	<cfproperty name="name" 		displayname="name" 		type="string"	/>
	<cfproperty name="phone" 		displayname="phone" 	type="string"	/>
	<cfproperty name="address"  	displayname="address" 	type="string"	/>
	<cfproperty name="city" 		displayname="city" 		type="string"	/>
	<cfscript>
		this.price 		= createObject('component','net.infoaccelerator.travel.kayak.vo.Price');
		this.priceLow 	= 0;
		this.priceHigh 	= 0;
		this.stars 		= 0;
		this.name 		= "";
		this.phone 		= "";
		this.address 	= "";
		this.city 		= "";
	</cfscript>	
</cfcomponent>