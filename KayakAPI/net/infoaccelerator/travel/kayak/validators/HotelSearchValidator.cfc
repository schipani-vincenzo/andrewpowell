<cfcomponent output="false">
	<cffunction name="validate" access="public" returntype="boolean" output="false">
		<cfargument name="subject" type="struct" required="true"/>
		
		<cfscript>
			if(validateDate(arguments.subject.checkin_date)){
				if(validateDate(arguments.subject.checkout_date)){
					if(validateGuestCount(arguments.subject.guests1)){
						if(validateRoomCount(arguments.subject.rooms)){
							return true;
						}
						else{
							return false;
						}
					}
					else{
						return false;
					}
				}
				else{
					return false;
				}
			}
			else{
				return false;
			}
		</cfscript>
		
	</cffunction>
	
	<cffunction name="validateDate" access="private" returntype="boolean" output="false">
		<cfargument name="target" type="date" required="true"/>
		<cfreturn true/>
	</cffunction>
	
	<cffunction name="validateGuestCount" access="private" returntype="boolean" output="false">
		<cfargument name="target" type="numeric" required="true">
		<cfscript>
			if(arguments.target GT 0 AND arguments.target LTE 6){
				return true;
			}
			else{
				return false;
				}
		</cfscript>
	</cffunction>
	
	<cffunction name="validateRoomCount" access="private" returntype="boolean" output="false">
		<cfargument name="target" type="numeric" required="true">
		<cfscript>
			if(arguments.target GT 0 AND arguments.target LTE 3){
				return true;
			}
			else{
				return false;
				}
		</cfscript>
	</cffunction>
</cfcomponent>