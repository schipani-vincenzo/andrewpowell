<html>
	<head> 
		<title>Flight Search Sample</title> 
	

</head>
<body>
	<cfform action="sampleFlightSearch.cfm" method="post">
		<table width="75%" border="0">
	      <tr>
	        <td><div align="right">Departing From:</div></td>
	        <td><cfinput type="text" name="origin" autosuggest="cfc:net.infoaccelerator.travel.kayak.ajaxServices.AirportLookupService.searchAirports({cfautosuggestvalue})"/></td>
	      </tr>
	      <tr>
	        <td><div align="right">Departure Date:</div></td>
	        <td><cfcalendar name="depart_date" selecteddate="#now()#" mask="mm/dd/yyyy" height="200" width="150"/></td>
	      </tr>
	      <tr>
	        <td><div align="right">Departure Time:</div></td>
	        <td><label>
	          <select name="depart_time" id="depart_time">
	            <option value="a">Any</option>
	            <option value="e">Early Morning</option>
	            <option value="m">Morning</option>
	            <option value="12">Noon</option>
	            <option value="n">Afternoon</option>
	            <option value="e">Evening</option>
	            <option value="l">Night</option>
	          </select>
	        </label></td>
	      </tr>
	      <tr>
	        <td><div align="right">Destination:</div></td>
	        <td><cfinput type="text" name="destination" autosuggest="cfc:net.infoaccelerator.travel.kayak.ajaxServices.AirportLookupService.searchAirports({cfautosuggestvalue})"/></td>
	      </tr>
	      <tr>
	        <td><div align="right"><br/>
	        Return Date:</div></td>
	        <td><cfcalendar name="return_date" selecteddate="#now()#" mask="mm/dd/yyyy" height="200" width="150"/></td>
	      </tr>
	      <tr>
	        <td><div align="right">Return Time:</div></td>
	        <td><select name="return_time" id="return_time">
	          <option value="a">Any</option>
	          <option value="e">Early Morning</option>
	          <option value="m">Morning</option>
	          <option value="12">Noon</option>
	          <option value="n">Afternoon</option>
	          <option value="e">Evening</option>
	          <option value="l">Night</option>
	        </select></td>
	      </tr>
	      <tr>
	        <td><div align="right">Travelers</div></td>
	        <td><label>
	          <select name="travelers" id="travelers">
	            <option value="1">1</option>
	            <option value="2">2</option>
	            <option value="3">3</option>
	            <option value="4">4</option>
	            <option value="5">5</option>
	            <option value="6">6</option>
	            <option value="7">7</option>
	            <option value="8">8</option>
	          </select>
	        </label></td>
	      </tr>
	      <tr>
	        <td><div align="right">Cabin</div></td>
	        <td><label>
	          <select name="cabin" id="cabin">
	            <option value="e">Economy</option>
	            <option value="b">Business</option>
	            <option value="f">First</option>
	          </select>
	        </label></td>
	      </tr>
	      <tr>
	        <td><div align="right">Sort Results By:</div></td>
            <td><label>
              <select name="sort" id="sort">
                <option value="price">Price</option>
                <option value="duration">Flight Duration</option>
                <option value="depart">Departure Time</option>
                <option value="arrive">Arrival Time</option>
                <option value="airline">Airline</option>
              </select>
            </label></td>
	      </tr>
	      <tr>
	        <td colspan="2"><div align="center">
	          <label>
	          <input type="submit" name="submitsearch" id="submitsearch" value="Submit">
	          </label>
	        </div></td>
	      </tr>
	    </table>
	    
</cfform>

</body>
</html> 