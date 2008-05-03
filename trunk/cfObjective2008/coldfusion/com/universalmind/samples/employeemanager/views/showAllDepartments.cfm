<TABLE>
	<tr>
		<th>Name</th>
		<th>Manager</th>
		<th>Employees</th>
	</tr>
<cfloop from="1" to="#arrayLen(request.allDepartments)#" index="i">
	<cfoutput>
		<tr>
			<td>#request.allDepartments[i].getName()#</td>
			<cfif request.allDepartments[i].getManager() NEQ "">
			<td>#request.allDepartments[i].getManager().getFirstName()# #request.allDepartments[i].getManager().getLastName()#</td>
			<cfelse>
			<td></td>
			</cfif>
			<td>#request.allDepartments[i].getEmployees().size()#</td>
		</tr>
	</cfoutput>
</cfloop>
</TABLE>
<a href="index.cfm?action=showMenu">Show Menu</a>