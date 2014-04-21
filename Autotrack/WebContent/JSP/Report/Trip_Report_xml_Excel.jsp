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
/* String place = "";
String minimum_time = "";
String maximum_time = "";
String halt_time = ""; */
String place = "";
String start_time = "";
String halt_position = "";
String halted_time = "";
String distance = "";
String stoped_at ="";
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
	System.out.println("Root element 12212 :" + doc.getDocumentElement().getNodeName());
	
	NodeList nList = doc.getElementsByTagName("record");
	
	System.out.println("----------------------------");
	
	for (int temp = 0; temp < nList.getLength(); temp++) {
	
		Node nNode = nList.item(temp);
	
		System.out.println("\nCurrent Element :" + nNode.getNodeName());
	
		if (nNode.getNodeType() == Node.ELEMENT_NODE) {
	
			Halt_time halttimeinfoobj =new Halt_time();
			Element eElement = (Element) nNode;
			
			/* place = eElement.getElementsByTagName("place").item(0).getTextContent();
			minimum_time = eElement.getElementsByTagName("mintime").item(0).getTextContent();
			maximum_time = eElement.getElementsByTagName("maxtime").item(0).getTextContent();
			halt_time = eElement.getElementsByTagName("halttime").item(0).getTextContent(); */
			place = eElement.getElementsByTagName("place").item(0).getTextContent();
			start_time = eElement.getElementsByTagName("startTime").item(0).getTextContent();
			halt_position = eElement.getElementsByTagName("haltPodition").item(0).getTextContent();
			stoped_at = eElement.getElementsByTagName("StopedAt").item(0).getTextContent();
			halted_time = eElement.getElementsByTagName("halttime").item(0).getTextContent();
			distance = eElement.getElementsByTagName("distance").item(0).getTextContent();
			
			
			System.out.println("1 "+place);
			System.out.println("2 "+start_time);
			System.out.println("3 "+halt_position);
			System.out.println("4 "+stoped_at);
			System.out.println("5 "+halted_time);
			System.out.println("6 "+distance);
			
			
			halttimeinfoobj.setPlace(place);
			halttimeinfoobj.setStart_time(start_time);
			halttimeinfoobj.setHalt_position(halt_position);
			halttimeinfoobj.setStoped_at(stoped_at);
			halttimeinfoobj.setHalt_time(halted_time);
			halttimeinfoobj.setDistance(distance);
			halt_obj.add(halttimeinfoobj);
			
		
		}
		
	}  
	request.setAttribute("halt_time_record",halt_obj);
	/*halt_obj.add(halttimeinfoobj);*/
	System.out.println("IMEI "+vehicle_no);
	System.out.println("DATE "+startdate+" , "+enddate);
	

	RequestDispatcher rd=request.getRequestDispatcher("trip_report_excel.jsp?imeinumber="+vehicle_no+"&startdate="+startdate+"&enddate="+enddate);
	rd.forward(request, response);

    
} catch (Exception e) {
    System.err.println(e);
}

%>

</body>

</html>