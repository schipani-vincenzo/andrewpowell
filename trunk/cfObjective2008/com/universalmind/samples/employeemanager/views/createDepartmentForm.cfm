<cfform format="html" action="/cfobjective/preso/index.cfm?action=createDepartment" method="post">
	<cfformgroup type="vbox">
		<cfformgroup type="hbox">
			<cfformitem type="text">Department Name:</cfformitem>
			<cfinput name="departmentName" type="text">
		</cfformgroup>
		<cfinput type="submit" name="saveDpt" label="Save"/>
	</cfformgroup>
</cfform>