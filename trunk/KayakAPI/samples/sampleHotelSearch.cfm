<cfset kayakObj = createObject('component','net.infoaccelerator.travel.kayak.Kayak')/>
<cfset kayakObj.init("ELbI0KUodURBLn2_16Gh_A") />
<cfset kSessionID = kayakObj.getSession()/>

<cfset results 		= kayakObj.startHotelSearch(FORM.othercity,FORM.checkin_date,FORM.checkout_date,FORM.guests1,FORM.rooms,kSessionID)		/>

<cfif results.status EQ "ok">
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
		<cfoutput>#results.msg#</cfoutput>
</cfif>
