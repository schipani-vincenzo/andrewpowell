<cfcomponent output="false">
	<cfproperty name="price" displayname="price" type="net.infoaccelerator.travel.kayak.vo.Price"	/>
	<cfproperty name="legs"	 displayname="legs"	 type="array"										/>
	
	<cfscript>
		this.price = createObject('component','net.infoaccelerator.travel.kayak.vo.Price');
		this.legs  = arrayNew(1);
	</cfscript>
</cfcomponent>