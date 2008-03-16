<p>
<cftimer type="inline" label="Employee V1 - CFC with Getters/Setters">
	<cfloop from="1" to="10000" index="i">
		<cfscript>
			employee = createObject('component','net.infoaccelerator.speedTest.vo.Employee').init();
			employee.setFirstName("Test");
			employee.setLastName("Object");
			employee.setBirthday(createDate(1975,12,1));
			employee.setHireDate(createDate(2004,11,22));
		</cfscript>
	</cfloop>
</cftimer>
</p>

<p>
<cftimer type="inline" label="Employee V2 - CFC w/o Getter/Setters">
	<cfloop from="1" to="10000" index="i">
		<cfscript>
			employee 			= 	createObject('component','net.infoaccelerator.speedTest.vo.EmployeeV2');
			employee.firstName 	= 	"Test";
			employee.lastName 	= 	"Object";
			employee.birthday	= 	createDate(1975,12,1);
			employee.hireDate	=	createDate(2004,11,22);
		</cfscript>
	</cfloop>
</cftimer>
</p>

<p>
<cftimer type="inline" label="Employee V3 - Java">
	<cfloop from="1" to="10000" index="i">
		<cfscript>
			employee = createObject('java','net.infoaccelerator.speedTest.vo.Employee').init();
			employee.setFirstName("Test");
			employee.setLastName("Object");
			employee.setBirthday(createDate(1975,12,1));
			employee.setHireDate(createDate(2004,11,22));
		</cfscript>
	</cfloop>
</cftimer>
</p>