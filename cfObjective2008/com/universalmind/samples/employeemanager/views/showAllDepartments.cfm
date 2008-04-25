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
			<td><!--- #request.allDepartments[i].getManager().getFirstName()# #request.allDepartments[i].getManager().getLastName()# ---></td>
			<td>#request.allDepartments[i].getEmployees().size()#</td>
		</tr>
	</cfoutput>
</cfloop>
</TABLE>