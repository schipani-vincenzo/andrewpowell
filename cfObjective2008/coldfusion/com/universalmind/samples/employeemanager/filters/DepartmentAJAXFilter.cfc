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
		</cfscript>
		<cfloop from="1" to="#deptLen#" index="i">
			<cfscript>
					ajaxDepts[i] = structNew();
					ajaxDepts[i].name = departments[i].name;
					ajaxDepts[i].id	  = departments[i].id;
			</cfscript>
		</cfloop>
		
		<cfset arguments.event.setArg('ajaxData',serializeJSON(ajaxDepts))/>
		<cfreturn true/>
		
	</cffunction>

</cfcomponent>