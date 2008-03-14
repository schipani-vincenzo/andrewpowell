package net.infoaccelerator.travel.kayak;
/*
  Sample API using Kayak API.
  
*/

import java.io.*;
import java.net.*;
import javax.xml.parsers.*;
import org.w3c.dom.*;


//import
public class Kayak {
	//CONSTANTS
	private final String HOSTNAME = "http://api.kayak.com";
		
	private String token;
	
	public Kayak(String token){
		
		this.token = token;
	}
	
	private String getsession(){

		String response=fetch(this.HOSTNAME+"/k/ident/apisession?token=" + token );
		Element root=xmlRoot(response);
		NodeList sessionid=root.getElementsByTagName("sid");
		if( sessionid.getLength() == 0){
			System.out.println("BAD TOKEN: " + response);
			return null;
		}
		return sessionid.item(0).getFirstChild().getNodeValue();
	}
	
	
	public String start_flight_search(String oneway,String origin, String destination, 
			String dep_date , String ret_date) {
		String url=this.HOSTNAME +"/s/apisearch?basicmode=true&oneway=n&origin=" +origin +
			"&destination=" +destination + "&destcode=&depart_date="+ dep_date +
			"&depart_time=a&return_date=" + ret_date + "&return_time=a&travelers=1" +
			"&cabin=e&action=doflights&apimode=1&_sid_=" + getsession();
		return start_search(url);
		
	}

	
	public String start_hotel_search(String cityandcountry, String 	checkindate
			,String checkoutdate){
		try {
			cityandcountry = URLEncoder.encode(cityandcountry,"UTF-8");  
			checkindate = URLEncoder.encode(checkindate,"UTF-8");
			checkoutdate = URLEncoder.encode(checkoutdate, "UTF-8");
		} catch (Exception e) {}
		String url= this.HOSTNAME +"/s/apisearch?basicmode=true&othercity=" +cityandcountry +
		"&checkin_date=" + checkindate + "&checkout_date="+ checkoutdate +"&minstars=-1&guests1=1&guests2=1&rooms=1&action=dohotels&apimode=1"+
		"&_sid_=" + getsession();
		return start_search(url);
		
	}
	
	private String start_search(String uri){
		String response= fetch(uri);
				
		Element root= xmlRoot(response);
		NodeList searchid=root.getElementsByTagName("searchid");
		if( searchid.getLength() == 0){
			System.out.println("SEARCH ERROR: \n" + response);
			System.exit(1);
		}
		return searchid.item(0).getFirstChild().getNodeValue();
	}

	public String pollFlightResults(String searchid, String sessionid, int lastCount){
		String uri="";
		uri= this.HOSTNAME +"/s/apibasic/flight?searchid="+searchid+"&apimode=1&_sid_="+ sessionid ; 
				
		String response=fetch(uri);
			
		return response;
	}
	
	public String pollHotelResults(String searchid, String sessionid, int lastCount){
		String uri="";
				 
		uri= HOSTNAME+ "/s/apibasic/hotel?searchid="+searchid+ "&apimode=1&_sid_=" + sessionid;
			
		String response=fetch(uri);
			
		return response;
	}
	
	private Element xmlRoot(String response){
		Document doc =null;
		try {
		     DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		     DocumentBuilder db = dbf.newDocumentBuilder();
		     ByteArrayInputStream bais = new ByteArrayInputStream(response.getBytes());
		     doc = db.parse(bais);
		    } catch (Exception e) {
		      System.out.print("Problem parsing the xml: \n" + e.toString());
		}
		    
		return doc.getDocumentElement();
		
	}
	
		
	private String fetch(String urlstring){
		String content = "";
	  
		  try {
			URL url  = new URL(urlstring);  
	        InputStream is = url.openStream();
	        BufferedReader d = new BufferedReader(new InputStreamReader(is));
	        String s;
	        
	        while (null != (s = d.readLine())) {
	            content = content + s + "\n";
	        }
	        is.close();
	        
		  } catch ( Exception e ) { System.out.println(e.getMessage() ); }
		  return content;
	    }
	
}
 
