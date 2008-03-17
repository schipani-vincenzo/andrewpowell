<cfset kayakObj = createObject('component','net.infoaccelerator.travel.kayak.Kayak')/>
<cfset kayakObj.init("YOUR DEVELOPER KEY") />
<cfset kSessionID = kayakObj.getSession()/>

<cfset searchStart 		= kayakObj.startFlightSearch(false,FORM.origin,FORM.destination,FORM.depart_date,FORM.return_date,FORM.depart_time,FORM.return_time,FORM.travelers,FORM.cabin,kSessionID)/>
<cfif searchStart.status EQ "ok">
	<cfset flightresults 	= kayakObj.getFlightResults(searchStart.id,kSessionID,30,'normal','','up',FORM.sort,searchStart.cookies)/>
	
	<cfloop from="1" to="#arrayLen(flightResults.trips)#" index="i">
		<div>
		<p><cfoutput>#lsCurrencyFormat(flightResults.trips[i].price.value)# - <a href="http://api.kayak.com#flightResults.trips[i].price.url#">Book It</a></cfoutput></p>
		<ul>
		<cfloop from="1" to="#arrayLen(flightResults.trips[i].legs)#" index="j">
			<cfoutput>
				<li>
					<p>Airline:  #flightResults.trips[i].legs[j].airlineName# - Stops: #flightResults.trips[i].legs[j].stops#<br/>
					   Departs:  #flightResults.trips[i].legs[j].depart#<br/>
					   Arrives:  #flightResults.trips[i].legs[j].arrive#</p>
					<ol>
						<cfloop from="1" to="#arrayLen(flightResults.trips[i].legs[j].segments)#" index="k">
							<li>
								#flightResults.trips[i].legs[j].segments[k].airline##flightResults.trips[i].legs[j].segments[k].flight#<br/>
								Departs #flightResults.trips[i].legs[j].segments[k].origin#:  #flightResults.trips[i].legs[j].segments[k].departure#<br/>
					   			Arrives #flightResults.trips[i].legs[j].segments[k].destination#:  #flightResults.trips[i].legs[j].segments[k].arrival#
							</li>
						</cfloop>
					</ol>
				</li>	
			</cfoutput>
			
		</cfloop>
		</ul>
		</div>
		<hr/>
	</cfloop>
	
	<cfelse>
		<cfoutput>#searchStart.msg#</cfoutput>
</cfif>