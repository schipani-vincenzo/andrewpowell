<cfcomponent output="false" implements="SearchValidator">
	
	<cffunction name="validate" access="public" returntype="boolean" output="false">
		<cfargument name="subject" type="struct" required="true"/>
			<cfscript>
				if(validateAirportCode(arguments.origin)){
					if(validateAirportCode(arguments.destination)){
						if(validateDate(arguments.depart_date)){
							if(validateDate(arguments.return_date)){
								if(validateTime(arguments.depart_time)){
									if(validateTime(arguments.return_time)){
										if(validatePassengerCount(arguments.travelers)){
											if(validatCabin(arguments.cabin)){
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
	
	<cffunction name="validateAirportCode" access="private" returntype="boolean" output="false">
		<cfargument name="target" type="string" required="true"/>
		
		<cfscript>
			if(len(arguments.target) NEQ 3){
				return false;
			}
			else{
				return true;
			}
		</cfscript>
	</cffunction>
	
	<cffunction name="validateDate" access="private" returntype="boolean" output="false">
		<cfargument name="target" type="date" required="true"/>
		<cfreturn true/>
	</cffunction>
	
	<cffunction name="validateTime" access="private" returntype="boolean" output="false">
		<cfargument name="target" type="string" required="true"/>
		
		<cfscript>
			if(arguments.target EQ "a" 
			OR arguments.target EQ "r" 
			OR arguments.target EQ "m"
			OR arguments.target EQ "12" 
			OR arguments.target EQ "n" 
			OR arguments.target EQ "e" 
			OR arguments.target EQ "l"){
				return true;
			}
			else{
				return false;
			}
		</cfscript>
	</cffunction>
	
	<cffunction name="validatePassengerCount" access="private" returntype="boolean" output="false">
		<cfargument name="target" type="numeric" required="true">
		<cfscript>
			if(arguments.target GT 0 AND arguments.target LTE 8){
				return true;
			}
			else{
				return false;
				}
		</cfscript>
	</cffunction>
	
	<cffunction name="validateCabin" access="private" returntype="boolean" output="false">
		<cfargument name="target" type="string" required="true"/>
		<cfscript>
			if(arguments.target EQ "f" OR arguments.target EQ "b" OR arguments.target EQ "e"){
				return true;
			}
			else{
				return false;
			}
		</cfscript>
	</cffunction>
	
	
	
	
</cfcomponent>