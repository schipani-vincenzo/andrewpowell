<cfcomponent displayname="ContactListener" output="false" extends="MachII.framework.Listener">
	
	<cffunction name="configure" access="public" output="false" returntype="void" hint="Configures this listener as part of the Mach-II framework">
		<cfset variables.applicationContext = createObject('java','org.springframework.web.context.support.WebApplicationContextUtils').getWebApplicationContext(getPageContext().getServletContext())>
	</cffunction>
	
	<cffunction name="getAllDepartments" access="public" output="false" returntype="array">
		<cfargument name="event" type="MachII.framework.Event" required="true">
		<cfset var service = variables.applicationContext.getBean("empMgrService")/>
		<cfreturn service.getAllDepartments()/>
	</cffunction>
	
	<cffunction name="saveNewDepartment" access="public" output="false" returntype="void">
		<cfargument name="event" type="MachII.framework.Event" required="true">
		
		<cfset var newDepartment = variables.applicationContext.getBean("dptVO")/>
		<cfset var dptDAO        = variables.applicationContext.getBean("dptDAO")/>
		<cfset newDepartment.setName(javacast('string',arguments.event.getArg('departmentName')))/>
		<cfset dptDAO.create(newDepartment)/>
	</cffunction>
	
	<cffunction name="getEmployeesForDepartment" access="public" returntype="array">
		<cfargument name="event" type="MachII.framework.Event" required="true">
			
		<cfscript>
			var dptDAO 			= variables.applicationContext.getBean("dptDAO");
			var department		= dptDAO.read(javacast('string',arguments.event.getArg('departmentID')));
			return department.getEmployees();
		</cfscript>
		
	</cffunction>
	
	<cffunction name="changeEmployeeDepartment" access="public" output="false" returntype="boolean">
		<cfargument name="event" type="MachII.framework.Event" required="true">
		<cfscript>
			var service 		= variables.applicationContext.getBean("empMgrService");
			
			var saveCheck       = service.changeEmployeeDepartment(arguments.event.getArg('emp'),arguments.event.getArg('oldDpt'),arguments.event.getArg('newDpt'));
			
			return saveCheck;
		</cfscript>
	</cffunction>
	
	<cffunction name="saveEmployee" access="public" output="false" returntype="Boolean">
		<cfargument name="event" type="MachII.framework.Event" required="true">
		
		<cfscript>
			var empVO  			= variables.applicationContext.getBean("empVO");
			var service 		= variables.applicationContext.getBean("empMgrService");
			var saveCheck 		= true;
			
			empVO.firstName 	= javacast('string',arguments.event.getArg('firstname'));
			empVO.lastName 		= javacast('string',arguments.event.getArg('lastname'));
			empVO.birthdate 	= arguments.event.getArg('birthdate');
			empVO.hiredate  	= arguments.event.getArg('hiredate');
			empVO.title     	= javacast('string',arguments.event.getArg('title'));
			empVO.salary    	= javacast('double',arguments.event.getArg('salary'));
		
			saveCheck 			= service.saveEmployee(empVO,javacast('string',arguments.event.getArg('department')));	
		</cfscript>
			
		<cfreturn saveCheck/>
		
	</cffunction>
	
	<cffunction name="saveManager" access="public" output="false" returntype="boolean">
		<cfargument name="event" type="MachII.framework.Event" required="true">
		<cfscript>
			var mgrVO  			= variables.applicationContext.getBean("mgrVO");
			var mgrDAO 			= variables.applicationContext.getBean("mgrDAO");
			var dptDAO 			= variables.applicationContext.getBean("dptDAO");
			var service 		= variables.applicationContext.getBean("empMgrService");
			var department 		= dptDAO.read(javacast('string',arguments.event.getArg('department')));
			var saveCheck 		= true;
			
			mgrVO.firstName 	= javacast('string',arguments.event.getArg('firstname'));
			mgrVO.lastName 		= javacast('string',arguments.event.getArg('lastname'));
			mgrVO.birthdate 	= arguments.event.getArg('birthdate');
			mgrVO.hiredate  	= arguments.event.getArg('hiredate');
			mgrVO.title     	= javacast('string',arguments.event.getArg('title'));
			mgrVO.salary    	= javacast('double',arguments.event.getArg('salary'));
			mgrVO.rating    	= javacast('double',arguments.event.getArg('rating'));
			department.manager  = mgrVO;	
			mgrVO 				= mgrDAO.create(mgrVO);
			saveCheck 			= service.addEmployeeToDepartment(mgrVO,department);	
		</cfscript>
		
		<cfreturn saveCheck/>
	</cffunction>
	
	<cffunction name="dump" access="private" returntype="void">
		<cfargument name="dumpVar" type="any" required="true"/>
		<cfargument name="abort" type="boolean" required="false" default="false"/>
		
		<cfdump var="#arguments.dumpVar#"/>
		<cfif arguments.abort>
			<cfabort/>
		</cfif>
	</cffunction>
</cfcomponent>