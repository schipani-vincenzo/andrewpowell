<cfset airports = queryNew("code,name,city,state,country")/>
<cfloop file="#expandPath('net/infoaccelerator/travel/kayak/xml/airports.txt')#" index="cLine">
	<cfif len(trim(listGetAt(cLine,1,chr(9)))) EQ 3>
		<cfset queryAddRow(airports)/>
		<cfscript>
			if(listLen(cLine,chr(9)) EQ 5){
			querySetCell(airports,"code",listGetAt(cLine,1,chr(9)));
			querySetCell(airports,"name",listGetAt(cLine,2,chr(9)));
			querySetCell(airports,"city",listGetAt(cLine,3,chr(9)));
			querySetCell(airports,"state",listGetAt(cLine,4,chr(9)));
			querySetCell(airports,"country",listGetAt(cLine,5,chr(9)));
			}
			else{
				querySetCell(airports,"code",listGetAt(cLine,1,chr(9)));
				querySetCell(airports,"name",listGetAt(cLine,2,chr(9)));
				querySetCell(airports,"city",listGetAt(cLine,3,chr(9)));
				querySetCell(airports,"state",listGetAt(cLine,4,chr(9)));

			}
		</cfscript>
	</cfif>
</cfloop>

<cfwddx action="cfml2wddx" input="#airports#" output="airportWDDX">

<cffile action="write" file="#expandPath('/kayak/net/infoaccelerator/travel/kayak/xml/')#/airports.xml" output="#toString(airportWDDX)#">