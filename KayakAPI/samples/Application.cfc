<cfcomponent>
<cfscript>
       this.name = "KayakAPIDemo";
       this.applicationTimeout = createTimeSpan(0,2,0,0);
       this.clientmanagement= "yes";
       this.loginstorage = "session" ;
       this.sessionmanagement = "yes";
       this.sessiontimeout = createTimeSpan(0,0,30,0);
       this.setClientCookies = "yes";
       this.setDomainCookies = "no";
       this.scriptProtect = "all";   
       //This is here to remind you to put a mapping the CFADMIN to the "net" directory
	   //this.mappings["/net"] = expandPath("/kayak/net");
   </cfscript>
   
   <cffunction name="onApplicationStart" output="false">
       <cfscript>
         appliction.airportLookupService = createObject('component','net.infoaccelerator.travel.kayak.ajaxServices.AirportLookupService');
         application.sessions = 0;
       </cfscript>
      
             
       <cflog file="#this.name#" type="Information" text="Application #this.name# Started">
      
       <cfreturn True>
   </cffunction>
   
   <cffunction name="onApplicationEnd" output="false">
      <cfargument name="applicationScope" required="true">
   </cffunction>
   
   
   <cffunction name="onSessionStart" output="false">
      <cfscript>
         session.started = now();
      </cfscript>
      
      <cflock scope="application" timeout="5" type="Exclusive">
         <cfset application.sessions = application.sessions + 1>
      </cflock>
   </cffunction>
   
   <cffunction name="onSessionEnd" output="false">
       <cfargument name = "sessionScope" required=true/>
       <cfargument name = "applicationScope" required=true/>
       <cfset var sessionLength = TimeFormat(Now() - sessionScope.started, "H:mm:ss")>
      
       <cflock name="AppLock" timeout="5" type="Exclusive">
            <cfset arguments.applicationScope.sessions = arguments.applicationScope.sessions - 1>
       </cflock>
      
       <cflog file="#this.name#" type="Information"
            text="Session #arguments.sessionScope.sessionid# ended. Length: #sessionLength# Active sessions: #arguments.applicationScope.sessions#">
   </cffunction>
   
   <cffunction name="onRequestStart">
       <cfargument name="requestname" required=true/>
       
		<cfif structKeyExists(URL,"reinit") AND reinit EQ 1>
			<cfset structClear(application)/>
			<cfset onApplicationStart()/>
		</cfif>
	
   </cffunction>
   
   
   <cffunction name="onError" output="true">
       <cfargument name="exception" required=true/>
       <cfargument name="eventName" type="String" required=true/>
       <!--- Log all errors. --->
      
      
       <!--- Display an error message if there is a page context. --->
       <cfif (trim(arguments.eventName) IS NOT "onSessionEnd") AND (trim(arguments.eventName) IS NOT "onApplicationEnd")>
            <cflog file="#this.name#" type="error"
                text="Event name: #arguments.eventName#" >
            <cflog file="#this.name#" type="error"
                text="Message: #arguments.exception.message#">
               
            <cfoutput>
                <h2>An unexpected error occurred.</h2>
                <p>Please provide the following information to technical support:</p>
                <p>Error Event: #arguments.eventName#</p>
                <p>Error details:</p>
            </cfoutput>   
            <cfdump var=#arguments.exception#>
         <cfelseif (arguments.eventName IS "onApplicationEnd")>
               <cflog file="#this.name#" type="Information"
            text="Application #this.name# Ended" >
</cfif>
</cffunction>

</cfcomponent>