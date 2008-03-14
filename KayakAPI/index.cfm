<cfset kayakObj = createObject('component','net.infoaccelerator.travel.kayak.Kayak')/>
<cfset kayakObj.init("ELbI0KUodURBLn2_16Gh_A") />

<cfset search = kayakObj.getSession()/>

<cfset results = kayakObj.startFlightSearch(false,'ATL', 'MSP', '3/15/08' , '3/22/08', "l","a",1,"e",search)/>
 
<cfset flightresults = kayakObj.getFlightResults(results.id,search,30,'normal','','up','price',results.cookies)/>

