<p>
<cfif request.saveStatus>
	<cfoutput>Employee Saved</cfoutput>
	<cfelse>
		<cfoutput>Employee Save Failed</cfoutput>
</cfif>
</p>

<a href="index.cfm?action=showMenu">Show Menu</a>