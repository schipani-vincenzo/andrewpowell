<cfform action="index.cfm?action=saveEmployee">
	<p>First Name: <input name="firstName" type="text"/></p>
	<p>Last Name: <input name="lastName" type="text"/></p>
	<p>Birthdate: 
	<select name="birthmonth">
		<cfloop from="1" to="12" index="i">
			<cfoutput><option value="#i#">#i#</option></cfoutput>
		</cfloop>
	</select>	
		
	<select name="birthday">
		<cfloop from="1" to="31" index="i">
			<cfoutput><option value="#i#">#i#</option></cfoutput>
		</cfloop>
	</select>
	
	<select name="birthyear">
		<cfloop from="1930" to="2008" index="i">
			<cfoutput><option value="#i#">#i#</option></cfoutput>
		</cfloop>
	</select>
	
	</p>
	
	<p>Hire Date: 
	<select name="hiremonth">
		<cfloop from="1" to="12" index="i">
			<cfoutput><option value="#i#">#i#</option></cfoutput>
		</cfloop>
	</select>	
		
	<select name="hireday">
		<cfloop from="1" to="31" index="i">
			<cfoutput><option value="#i#">#i#</option></cfoutput>
		</cfloop>
	</select>
	
	<select name="hireyear">
		<cfloop from="1990" to="2008" index="i">
			<cfoutput><option value="#i#">#i#</option></cfoutput>
		</cfloop>
	</select>
	
	</p>
	
	<p>Title: <input name="title" type="text"/></p>
	<p>Salary: <input name="salary" type="text"/></p>
	<p>Department:<br/> 
	<select name="department">
		<cfloop from="1" to="#arrayLen(request.departments)#" index="i">
			<cfoutput>
				<option value="#request.departments[i].getID()#">#request.departments[i].getName()#</option>
			</cfoutput>
		</cfloop>
	</select>
	</p>
	
	<p>
		<cfinput name="submit" type="submit" value="Save Employee">
	</p>
	
</cfform>