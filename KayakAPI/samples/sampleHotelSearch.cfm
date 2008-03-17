<!--- Instantiate the kayak component --->
<cfset kayakObj 	= createObject('component','net.infoaccelerator.travel.kayak.Kayak').init("YOUR DEVELOPER KEY") />

<!--- Get the session id.  This is required for each search. --->
<cfset kSessionID 	= kayakObj.getSession()/>

<!--- Start the search process --->
<cfset results 		= kayakObj.startHotelSearch(FORM.othercity,FORM.checkin_date,FORM.checkout_date,FORM.guests1,FORM.rooms,kSessionID)		/>

<cfif results.status EQ "ok">
	<!--- This call polls the kayak service and aggregates the search and its results into a HotelSearchResult object' --->
	<cfset hotelResult 	= kayakObj.getHotelResults(results.id,kSessionID,30,'normal',0,'up',FORM.sort,results.cookies)/>
	
	<cfloop from="1" to="#arrayLen(hotelResult.hotels)#" index="i">
		<div>
		<p><cfoutput>#lsCurrencyFormat(hotelResult.hotels[i].priceLow)# to #lsCurrencyFormat(hotelResult.hotels[i].priceHigh)# - <a href="http://api.kayak.com#hotelResult.hotels[i].price.url#">Book It</a></cfoutput></p>
		<ul>
			<cfoutput>
			<li>Hotel: #hotelResult.hotels[i].name# 	</li>
			<li>Stars: #hotelResult.hotels[i].stars#	</li>
			<li>Location:  #hotelResult.hotels[i].city#, #hotelResult.hotels[i].region#, #hotelResult.hotels[i].country#</li>
			</cfoutput>
		</ul>
		</div>
		<hr/>
	</cfloop>
	<cfelse>
		<!--- If our search is not OK, then we get a msg back to explain the failure. --->
		<cfoutput>#results.msg#</cfoutput>
</cfif>
