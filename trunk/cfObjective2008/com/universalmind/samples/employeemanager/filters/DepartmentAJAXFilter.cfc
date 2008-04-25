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
			var departments = request.allDepartments;
			var i 			= 1;
			var deptLen 	= arrayLen(departments);
			var ajaxDepts	= arrayNew(1);
			for(i=1;i LT deptLen;i=i+1){
				ajaxDepts[i] = structNew();
				ajaxDepts[i].name = departments[i].name;
				ajaxDepts[i].id	  = departments[i].id;
			}
			
			arguments.event.setArg('ajaxDepartments',serializeJSON(ajaxDepts));
		</cfscript>
		
		
	</cffunction>

</cfcomponent>