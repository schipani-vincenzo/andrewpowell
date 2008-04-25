<cfcomponent extends="MachII.framework.EventFilter">

	<cffunction name="configure" access="public" output="false" returntype="void"
		hint="Configures the event-filter.">
		<!--- Does nothing. --->
	</cffunction>

	<cffunction name="filterEvent" access="public" output="false" returntype="boolean" 
		hint="Filters event and returns a boolean to Mach-II indicating whether or not the event queue 
		should proceed. If not, the event queue is cleared and a new event is announced.">
		<cfargument name="event" type="MachII.framework.Event" required="true" />
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		
		<cfscript>
			var employees   = request.employeeList;
			var i 			= 1;
			var deptLen 	= arrayLen(employees);
			var ajaxEmps	= arrayNew(1);
			for(i=1;i LT deptLen;i=i+1){
				ajaxEmps[i] 		= structNew();
				ajaxEmps[i].name 	= employees[i].name;
				ajaxEmps[i].id	  	= employees[i].id;
			}
			
			arguments.event.setArg('ajaxData',serializeJSON(ajaxEmps));
		</cfscript>
		
		
	</cffunction>

</cfcomponent>