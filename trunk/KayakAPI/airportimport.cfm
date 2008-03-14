<cfsetting enablecfoutputonly="true">
<cfsavecontent variable="airports">
<cfoutput>
<airports>
<cfloop file="#expandPath('net/infoaccelerator/travel/kayak/xml/airports.txt')#" index="cLine">
	<cfif len(trim(listGetAt(cLine,1,chr(9)))) EQ 3>
	<entry>
		<code>#listGetAt(cLine,1,chr(9))#</code>
		<name>#listGetAt(cLine,2,chr(9))#</name>
		<city>#listGetAt(cLine,3,chr(9))#</city>
		<state>#listGetAt(cLine,4,chr(9))#</state>
		<country>#listGetAt(cLine,4,chr(9))#</country>
	</entry>
	</cfif>
</cfloop>
</airports>
</cfoutput>
</cfsavecontent>
<cfsetting enablecfoutputonly="false">
<cfset airports = xmlParse(trim(airports))/>
<cffile action="write" file="#expandPath('/kayak/net/infoaccelerator/travel/kayak/xml/')#/airports.xml" output="#toString(airports)#">