<cfset airlines = queryNew("code,airline,fullname,country,keywords,phone,website")/>
<cfloop file="#expandPath('net/infoaccelerator/travel/kayak/xml/airlines.txt')#" index="cLine">
	<cfif len(trim(listGetAt(cLine,1,chr(9)))) LT 4>
		<cfset queryAddRow(airlines)/>
		<cfscript>
			querySetCell(airlines,"code",listGetAt(cLine,1,chr(9)));
			querySetCell(airlines,"airline",listGetAt(cLine,2,chr(9)));
			querySetCell(airlines,"fullname",listGetAt(cLine,3,chr(9)));
			querySetCell(airlines,"country",listGetAt(cLine,4,chr(9)));
			if(listLen(cLine,chr(9)) GT 4){
				if(find("-",listGetAt(cLine,5,chr(9))) NEQ 0 AND find(".",listGetAt(cLine,5,chr(9))) EQ 0){
					querySetCell(airlines,"phone",listGetAt(cLine,5,chr(9)));
					if(listLen(cLine,chr(9)) EQ 6){
						querySetCell(airlines,"website",listGetAt(cLine,6,chr(9)));
					}	
				}
				else if(find(".",listGetAt(cLine,5,chr(9))) NEQ 0){
						querySetCell(airlines,"website",listGetAt(cLine,5,chr(9)));
					}
			}			
		</cfscript>
	</cfif>
</cfloop>


<cfwddx action="cfml2wddx" input="#airlines#" output="airlinesWDDX">

<cffile action="write" file="#expandPath('/kayak/net/infoaccelerator/travel/kayak/xml/')#/airlines.xml" output="#toString(airlinesWDDX)#">