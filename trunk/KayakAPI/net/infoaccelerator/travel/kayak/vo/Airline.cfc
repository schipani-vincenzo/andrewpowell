<cfcomponent output="false">
	<cfproperty name="code" 	displayname="code" 		type="string"/>
	<cfproperty name="airline" 	displayname="airline" 	type="string"/>
	<cfproperty name="country" 	displayname="country" 	type="string"/>
	<cfproperty name="fullname" displayname="fullname" 	type="string"/>
	<cfproperty name="keywords" displayname="keywords" 	type="string"/>
	<cfproperty name="phone" 	displayname="phone" 	type="string"/>
	<cfproperty name="website" 	displayname="website" 	type="string"/>
	
	<cfscript>
		this.code		="";
		this.airline	="";
		this.country	="";
		this.fullname	="";
		this.keywords	="";
		this.phone		="";
		this.website	="";
	</cfscript>
</cfcomponent>