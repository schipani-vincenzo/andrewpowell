<cfcomponent output="false">
	
	<cffunction name="validate" access="public" returntype="boolean" output="false">
		<cfargument name="subject" type="struct" required="true"/>
			<cfscript>
				if(validateAirportCode(arguments.subject.origin)){
					if(validateAirportCode(arguments.subject.destination)){
						if(validateDate(arguments.subject.depart_date)){
							if(validateDate(arguments.subject.return_date)){
								if(validateTime(arguments.subject.depart_time)){
									if(validateTime(arguments.subject.return_time)){
										if(validatePassengerCount(arguments.subject.travelers)){
											if(validateCabin(arguments.subject.cabin)){
												if(validateOneway(arguments.subject.oneway)){
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
	
	<cffunction name="validateOneway" access="private" returntype="boolean" output="false">
		<cfargument name="target" type="boolean" required="true"/>
		<cfreturn true/>
	</cffunction>
	
	
	
	
</cfcomponent>