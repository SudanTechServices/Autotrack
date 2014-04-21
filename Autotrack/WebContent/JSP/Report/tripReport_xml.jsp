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
       }
       
       </style>
</head>       
<body bgcolor="#2ECCFA">
<%


List<Halt_time> halt_obj = new ArrayList<Halt_time>();
String xmlstr = request.getParameter("xmlstr");
String place = "";
String start_time = "";
String halt_position = "";
String halted_time = "";
String distance = "";
String stoped_at ="";
String imeinumber = request.getParameter("imeinumber");
System.out.println("IMEI NUMBER ISSSSSSs!!!!!!!!!!!!!"+ imeinumber);
String startdate = request.getParameter("startdate");
String enddate = request.getParameter("enddate");

String vehicle_number = null;
response.setContentType("application/pdf");
String filename="halt_time_report.pdf";
int pagenumber=1;
response.setHeader("Content-Disposition", "attachment;filename=" + filename);

try {

	 	DBTransaction dbtranobj=new DBTransaction();
		Connection connection=dbtranobj.connect();
		ResultSet rs = null;
		Statement st=null;
		st=connection.createStatement();
		 rs = st.executeQuery("SELECT vehicle_number from vehicle_information where imei_no='"+imeinumber+"'");
	    if(rs.next())
	    {
	    	vehicle_number = rs.getString("vehicle_number");
	    	
	    } 
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
			start_time = eElement.getElementsByTagName("startTime").item(0).getTextContent();
			halt_position = eElement.getElementsByTagName("haltPosition").item(0).getTextContent();
			stoped_at = eElement.getElementsByTagName("stopedAt").item(0).getTextContent();
			halted_time = eElement.getElementsByTagName("HaltedTime").item(0).getTextContent();
			distance = eElement.getElementsByTagName("distance").item(0).getTextContent();
			
			halttimeinfoobj.setPlace(place);
			halttimeinfoobj.setStart_time(start_time);
			halttimeinfoobj.setHalt_position(halt_position);
			halttimeinfoobj.setStoped_at(stoped_at);
			halttimeinfoobj.setHalted_time(halted_time);
			halttimeinfoobj.setDistance(distance);
			halt_obj.add(halttimeinfoobj);
			
		}
		
	}  
	
	request.setAttribute("halt_time_record",halt_obj);
	
	
    
} catch (Exception e) {
    System.err.println(e);
}
String i=request.getParameter("action");
System.out.println("Button Clicked is :::"+i);
RequestDispatcher rd=request.getRequestDispatcher("trip_report_pdf_new.jsp?imeinumber="+imeinumber+"&startdate="+startdate+"&enddate="+enddate);
rd.forward(request, response); 

%>

</body>

</html>