<!---
Copyright (c) 2008 Universal Mind, Inc.

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
--->

<cfcomponent output="false">
	
	<cfset variables.rubySrc = ""/>
	<cfset variables.engineMgr = ""/>
	<cfset variables.rubyEngine = ""/>
	
	<cffunction name="init" access="public" returntype="RubyLoader" output="false">
		<cfargument name="fileSrc" type="string" required="false" default=""/>
		<cfargument name="stringSRC" type="string" required="false" default=""/>
			
		<cfif arguments.fileSrc NEQ "">
			<cfset variables.rubySrc = loadScriptFromFile(arguments.fileSrc)/>
			<cfelse>
				<cfset variables.rubySrc = arguments.stringSrc/>
		</cfif>
		
		<cfset	variables.engineMgr = createObject("java","javax.script.ScriptEngineManager").init()/>
		<cfset	variables.rubyEngine = variables.engineMgr.getEngineByName("ruby")/>
		
		<cfreturn this/>
		
	</cffunction>
	
	<cffunction name="executeScript" access="public" returntype="boolean" output="false">
		<cftry>	
			<cfset variables.rubyEngine.eval(javacast("String",variables.rubySrc))/>
			<cfreturn true/>
			<cfcatch type="javax.script.ScriptException">
				<cfreturn false/>
			</cfcatch>
		</cftry>	
	</cffunction>
	
	<cffunction name="getResultValues" access="public" returntype="Array" output="false">
		<cfargument name="varNames" type="array" required="true"/>
		<cfset resultArray = arrayNew(1)/>
		<cfset varLen = arrayLen(arguments.varNames)/>
		<cfloop from="1" to="#varLen#" index="i">
			<cftry>	
				<cfset arrayAppend(resultArray,rubyEngine.getContext().getAttribute(javacast('string',arguments.varNames[i])))/>
				<cfcatch type="any">
					<cfset arrayAppend(resultArray,"INVALID_VAR_NAME")>
				</cfcatch>
			</cftry>
		</cfloop>
		<cfreturn resultArray/>
	</cffunction>
		
	<cffunction name="loadScriptFromFile" access="private" returntype="string" output="false">
		<cfargument name="fileSrc" type="string" required="true"/>
		<cfset var rubySrc = ""/>
		<cftry>
			<cffile action="read" file="#arguments.fileSrc#" variable="rubySrc"/>
			<cfcatch type="any">
				<cfthrow message="Could Not Read Ruby Script File." extendedinfo="Error Reading File: #arguments.rubySrc#" type="Application"/>
			</cfcatch>
		</cftry>
		<cfreturn rubySrc/>
	</cffunction>
</cfcomponent>