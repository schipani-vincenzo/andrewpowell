<cfcomponent output="false">

	<cffunction name="serialize" access="public" returntype="string" output="false" hint="Serializes a given variable to a string">
		<cfargument name="input" type="any" required="true"/>
		
		<cfscript>
			var byteOut = CreateObject("java", "java.io.ByteArrayOutputStream");
			var objOut  = CreateObject("java", "java.io.ObjectOutputStream");
			
			byteOut.init();
			objOut.init(byteOut);
			objOut.writeObject(arguments.input);
			objOut.close();

			return ToBase64(byteOut.toByteArray());
		</cfscript>
		
	</cffunction>
	
	<cffunction name="deserialize" access="public" returntype="Any" output="false" hint="Deserializes a string to it's original variable">
		<cfargument name="input" type="string" required="true"/>
		
		<cfscript>
			var byteIn = CreateObject("java", "java.io.ByteArrayInputStream");
			var objIn  = CreateObject("java", "java.io.ObjectInputStream");
			
			byteIn.init(toBinary(arguments.input));
			objIn.init(byteIn);
			return objIn.readObject();

		</cfscript>
	</cffunction>

</cfcomponent>