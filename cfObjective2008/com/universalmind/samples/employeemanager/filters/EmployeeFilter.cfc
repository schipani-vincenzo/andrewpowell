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
			var hiredate  = createDate(event.getArg('hireyear'),event.getArg('hiremonth'),event.getArg('hireday'));
			var birthdate = createDate(event.getArg('birthyear'),event.getArg('birthmonth'),event.getArg('birthday'));
			
			event.setArg('hiredate',hiredate);
			event.setArg('birthdate', birthdate);
			return true;
		</cfscript>
		
		
	</cffunction>

</cfcomponent>