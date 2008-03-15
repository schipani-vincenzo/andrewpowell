<cfset kayakObj = createObject('component','net.infoaccelerator.travel.kayak.Kayak')/>
<cfset kayakObj.init("ELbI0KUodURBLn2_16Gh_A") />

<cfset sessionID = kayakObj.getSession()/>



<cfset results = kayakObj.startFlightSearch(false,'ATL', 'MSP', '3/15/08' , '3/22/08', "l","a",1,"e",sessionid)/>
 
<cfset flightresults = kayakObj.getFlightResults(results.id,sessionid,30,'normal','','up','price',results.cookies)/>


<cfdump var="#flightResults#">
<!--- 
<cfset results = kayakObj.startHotelSearch("Atlanta, GA",'3/15/08','3/16/08',1,1,sessionID)/>

<cfset hotelResult = kayakObj.getHotelResults(results.id,sessionID,30,'3','up','price',results.cookies)>
<cfdump var="#hotelResult#"> --->