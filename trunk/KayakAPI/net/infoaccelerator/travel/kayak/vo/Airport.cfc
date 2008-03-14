<cfcomponent output="false">
	<cfproperty name="code" 	type="string" displayname="code"/>
	<cfproperty name="name" 	type="string" displayname="name"/>
	<cfproperty name="city" 	type="string" displayname="city"/>
	<cfproperty name="state"   	type="string" displayname="state"/>
	<cfproperty name="country" 	type="string" displayname="country"/>
	
	<cfscript>
		this.code 		= "";
		this.name 		= "";
		this.city 		= "";
		this.state 		= "";
		this.country 	= "";
	</cfscript>
</cfcomponent>