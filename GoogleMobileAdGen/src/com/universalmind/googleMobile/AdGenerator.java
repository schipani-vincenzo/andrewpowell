package com.universalmind.googleMobile;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
/**
 * @author Andrew Powell
 * @version 1.0
 * 
 */
public class AdGenerator extends TagSupport {

	private String clientID;  // required attribute
	private String format;    // required attribute
	private String markup;    // required attribute
	
	
	private static final long serialVersionUID = -7771685651508649193L;
	private static final String PAGEAD = "http://pagead2.googlesyndication.com/pagead/ads?";

	/**
	 * 
	 * @param clientID The client id given to you by google.  You have to generate a mobile ad to get this value in the code given to you
	 */
	public void setClientID(String clientID)
	{
		this.clientID = clientID;
	}
	
	/**
	 * 
	 * @param format Format of ad, either mobile_single or mobile_double
	 */
	public void setFormat(String format)
	{
		this.format = format;
	}
	
	/**
	 * 
	 * @param markup Format of the code generated:  wap, xhtml, chtml
	 */
	public void setMarkup(String markup)
	{
		this.markup = markup;
	}
	
	
	public int doStartTag(){
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		JspWriter out = pageContext.getOut();
		long googleDt = System.currentTimeMillis();
		String googleHost = (request.isSecure() ? "https://" : "http://")
		    + request.getHeader("Host");

		StringBuilder googleAdUrlStr = new StringBuilder(PAGEAD);
		googleAdUrlStr.append("ad_type=text");
		googleAdUrlStr.append("&channel=");
		googleAdUrlStr.append("&client=");
		googleAdUrlStr.append(clientID);
		googleAppendColor(googleAdUrlStr, "color_border", "555555", googleDt);
		googleAppendColor(googleAdUrlStr, "color_bg", "EEEEEE", googleDt);
		googleAppendColor(googleAdUrlStr, "color_link", "0000CC", googleDt);
		googleAppendColor(googleAdUrlStr, "color_text", "000000", googleDt);
		googleAppendColor(googleAdUrlStr, "color_url", "008000", googleDt);
		googleAdUrlStr.append("&dt=").append(googleDt);
		googleAdUrlStr.append("&format=");
		googleAdUrlStr.append(format);
		try {
			googleAppendUrl(googleAdUrlStr, "host", googleHost);
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			googleAppendUrl(googleAdUrlStr, "ip", request.getRemoteAddr());
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		googleAdUrlStr.append("&markup=");
		googleAdUrlStr.append(markup);
		googleAdUrlStr.append("&oe=utf8");
		googleAdUrlStr.append("&output=wml");
		try {
			googleAppendUrl(googleAdUrlStr, "ref", request.getHeader("Referer"));
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String googleUrl = request.getRequestURL().toString();
		if (request.getQueryString() != null) {
		  googleUrl += "?" + request.getQueryString().toString();
		}
		try {
			googleAppendUrl(googleAdUrlStr, "url", googleUrl);
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			googleAppendUrl(googleAdUrlStr, "useragent", request.getHeader("User-Agent"));
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		try {
		  URL googleAdUrl = new URL(googleAdUrlStr.toString());
		  BufferedReader reader = new BufferedReader(
		      new InputStreamReader(googleAdUrl.openStream(), "UTF-8"));
		  for (String line; (line = reader.readLine()) != null;) {
		    out.println(line);
		  }
		} catch (IOException e) {}
		return(SKIP_BODY);
	}
	
	
	
	private void googleAppendUrl(StringBuilder url, String param, String value)
	    throws UnsupportedEncodingException {
	  if (value != null) {
	    String encodedValue = URLEncoder.encode(value, "UTF-8");
	    url.append("&").append(param).append("=").append(encodedValue);
	  }
	}

	private void googleAppendColor(StringBuilder url, String param,
	    String value, long random) {
	  String[] colorArray = value.split(",");
	  url.append("&").append(param).append("=").append(
	      colorArray[(int)(random % colorArray.length)]);
	}
	
	
}
