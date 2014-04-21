	<%@page import="java.io.*"%>
	<%@page import="java.sql.*"%>
	<%@page import="com.ts.domain.Halt_time"%>
	<%@page import="java.util.Iterator" %>
	<%@page import="java.util.List" %>
	<%@page import="org.apache.xml.serialize.OutputFormat" %>
	<%@page import="org.apache.xml.serialize.XMLSerializer" %>
	<%@page import="org.w3c.dom.*" %>
	<%@page import="javax.xml.parsers.*" %>
	<%@page import="org.xml.sax.InputSource" %>
	<%@page import="java.util.ArrayList" %>
	<%@ page import="com.ts.dbtransactionmgr.DBTransaction" %>
	
	
	<html>
	<head>
	  <style type="text/css">
	       #message
	       {
	       
	        font-size:20px;
	   		font-family:Comic Sans MS,sans-serif;
	   		font-weight:bold;
	   		color:#EEFFFF;
	   		padding-top: 50px; 
	   		padding-left: 90px;
	   		/* background-color:#0088DD; */
	   		/* border-style:solid;
	   		border-color:#003377;
	   		border-width:2px; */
	       
	       }
	       
	       </style>
	</head>       
	<body bgcolor="#2ECCFA">
	<%
	
	
	List<Halt_time> halt_obj = new ArrayList<Halt_time>();
	String xmlstr = request.getParameter("xmlstr");
	String place = "";
	String minimum_time = "";
	String maximum_time = "";
	String halt_time = "";
	String vehicle_no = request.getParameter("imeinumber");
	String startdate = request.getParameter("startdate");
	String enddate = request.getParameter("enddate");
	try {
	    // Create a factory
	    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	    // Use document builder factory
	    DocumentBuilder builder = factory.newDocumentBuilder();
	    // Parse the document
	
		Document doc = builder.parse(new InputSource(new StringReader(xmlstr)));
		System.out.println("Root element :" + doc.getDocumentElement().getNodeName());
		
		NodeList nList = doc.getElementsByTagName("record");
		
		System.out.println("----------------------------");
		
		for (int temp = 0; temp < nList.getLength(); temp++) {
		
			Node nNode = nList.item(temp);
		
			System.out.println("\nCurrent Element :" + nNode.getNodeName());
		
			if (nNode.getNodeType() == Node.ELEMENT_NODE) {
		
				Halt_time halttimeinfoobj =new Halt_time();
				Element eElement = (Element) nNode;
				
				place = eElement.getElementsByTagName("place").item(0).getTextContent();
				minimum_time = eElement.getElementsByTagName("mintime").item(0).getTextContent();
				maximum_time = eElement.getElementsByTagName("maxtime").item(0).getTextContent();
				halt_time = eElement.getElementsByTagName("halttime").item(0).getTextContent();
				
				System.out.println("Place : " + place);
				System.out.println("Minimum Time : " + minimum_time);
				System.out.println("Maximum Time : " + maximum_time);
				System.out.println("Halt Time : " + halt_time);
				
				halttimeinfoobj.setPlace(place);
				halttimeinfoobj.setMinimum_time(minimum_time);
				halttimeinfoobj.setMaximum_time(maximum_time);
				halttimeinfoobj.setHalt_time(halt_time);
				halt_obj.add(halttimeinfoobj);
				
			
			}
			
		}  
		request.setAttribute("halt_time_record",halt_obj);
		/*halt_obj.add(halttimeinfoobj);*/
		System.out.println("IMEI "+vehicle_no);
		System.out.println("DATE "+startdate+" , "+enddate);
		
		
	    
	} catch (Exception e) {
	    System.err.println(e);
	}
	String i=request.getParameter("action");
	
	System.out.println("Button Clicked is :::"+i);
		RequestDispatcher rd=request.getRequestDispatcher("halt_time_report_excel.jsp?imeinumber="+vehicle_no+"&startdate="+startdate+"&enddate="+enddate);
		rd.forward(request, response);
	/* } */
	%>
	
	</body>
	
	</html>