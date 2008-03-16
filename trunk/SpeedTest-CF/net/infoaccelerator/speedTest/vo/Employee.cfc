<cfcomponent output="false">
	
	<cfset variables.firstName = ""/>
	<cfset variables.lastName  = ""/>
	<cfset variables.birthday  = ""/>
	<cfset variables.hireDate  = ""/>
	
	
	<cffunction name="init" access="public" returntype="net.infoaccelerator.speedTest.vo.Employee">
		<cfargument name="firstName" 	type="string" 	required="false"	default=""							/>
		<cfargument name="lastName" 	type="string" 	required="false"	default=""							/>
		<cfargument name="birthday" 	type="date" 	required="false"	default="#createDate(1970,1,1)#"	/>
		<cfargument name="hireDate" 	type="date" 	required="false"	default="#createDate(1970,1,1)#"	/>
		
		<cfset variables.firstName = arguments.firstName	/>
		<cfset variables.lastName  = arguments.lastName		/>
		<cfset variables.birthday  = arguments.birthday		/>
		<cfset variables.hireDate  = arguments.hireDate		/>
	
		<cfreturn this/>
	</cffunction>
	
	<cffunction name="getFirstName" access="public" returntype="string">
		<cfreturn variables.firstName/>
	</cffunction>
	<cffunction name="setFirstName" access="public" returntype="void">
		<cfargument name="firstName" type="string" required="true"/>
		<cfset variables.firstName = arguments.firstName/>
	</cffunction>
	
	<cffunction name="getLastName" access="public" returntype="string">
		<cfreturn variables.lastName/>
	</cffunction>
	<cffunction name="setLastName" access="public" returntype="void">
		<cfargument name="lastName" type="string" required="true"/>
		<cfset variables.lastName = arguments.lastName/>
	</cffunction>
	
	<cffunction name="getBirthday" access="public" returntype="date">
		<cfreturn variables.birthday/>
	</cffunction>
	<cffunction name="setBirthday" access="public" returntype="void">
		<cfargument name="birthday" type="date" required="true"/>
		<cfset variables.birthday = arguments.birthday/>
	</cffunction>
	
	<cffunction name="getHireDate" access="public" returntype="date">
		<cfreturn variables.hireDate/>
	</cffunction>
	<cffunction name="setHireDate" access="public" returntype="void">
		<cfargument name="hireDate" type="date" required="true"/>
		<cfset variables.hireDate = arguments.hireDate/>
	</cffunction>

</cfcomponent>