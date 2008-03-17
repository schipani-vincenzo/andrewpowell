<html>
	<head> 
		<title>Hotel Search Sample</title> 
	

</head>
<body>
	<cfform action="sampleHotelSearch.cfm" method="post">
		<table width="75%" border="0">
	      <tr>
	        <td><div align="right">City (i.e. "Boston, MA, US", "Boston, MA", "London, UK"):</div></td>
	        <td><cfinput type="text" name="othercity"/></td>
	      </tr>
	      <tr>
	        <td><div align="right">Check In Date:</div></td>
	        <td><cfcalendar name="checkin_date" selecteddate="#now()#" mask="mm/dd/yyyy" height="200" width="150"/></td>
	      </tr>
	      <tr>
	        <td><div align="right"><br/>
	        Check Out Date:</div></td>
	        <td><cfcalendar name="checkout_date" selecteddate="#now()#" mask="mm/dd/yyyy" height="200" width="150"/></td>
	      </tr>
	      <tr>
	        <td><div align="right">Guests</div></td>
	        <td><label>
	          <select name="guests1" id="guests1">
	            <option value="1">1</option>
	            <option value="2">2</option>
	            <option value="3">3</option>
	            <option value="4">4</option>
	            <option value="5">5</option>
	            <option value="6">6</option>
	          </select>
	        </label></td>
	      </tr>
	      <tr>
	        <td><div align="right">Rooms</div></td>
	        <td><label>
	          <select name="rooms" id="rooms">
	            <option value="1">1</option>
	            <option value="2">2</option>
	            <option value="3">3</option>
	          </select>
	        </label></td>
	      </tr>
	      <tr>
	        <td><div align="right">Sort Results By:</div></td>
            <td><label>
              <select name="sort" id="sort">
                <option value="price">Price</option>
                <option value="stars">Rating</option>
                <option value="hotel">Hotel</option>
                <option value="distance">Distance</option>
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