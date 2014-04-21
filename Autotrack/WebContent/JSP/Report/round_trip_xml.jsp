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


List<Halt_time> halt_obj = new ArrayList<Halt_time>();  //setters and getters
String xmlstr = request.getParameter("xmls");
String place = "";
String start_time="";
String halt_position="";
String stoped_at="";
String distance="";
String halt_time = "";

String vehicle_no = request.getParameter("imeinumber");
String name = request.getParameter("name");
String values = request.getParameter("values");
 
System.out.println("second table name of field"+name +"value is : "+values);

/* String startdate = request.getParameter("startdate");
String enddate = request.getParameter("enddate"); */
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
			
			place = eElement.getElementsByTagName("start_position").item(0).getTextContent();
			start_time = eElement.getElementsByTagName("start_time").item(0).getTextContent();
			halt_position = eElement.getElementsByTagName("halt_Position").item(0).getTextContent();
			stoped_at= eElement.getElementsByTagName("stopedAt").item(0).getTextContent();
			halt_time  = eElement.getElementsByTagName("halted_time").item(0).getTextContent();
			distance = eElement.getElementsByTagName("distance").item(0).getTextContent();
			
			
			System.out.println("Place : " + place);
			System.out.println("start time : " + start_time);
			System.out.println("halt position : " + halt_position);
			System.out.println("stoped at : " + stoped_at);
			System.out.println("halt_time : " + halt_time);
			System.out.println("distance travelled : " + distance);
			
			halttimeinfoobj.setPlace(place);
			halttimeinfoobj.setStart_time(start_time);
			halttimeinfoobj.setHalt_position(halt_position);
			halttimeinfoobj.setStoped_at(stoped_at);
			halttimeinfoobj.setHalt_time(halt_time);
			halttimeinfoobj.setDistance(distance);
			halt_obj.add(halttimeinfoobj);
			
			//NOTE want to get values and pass those to jsp page
			
			/*int row=studentinfodao.studentInfoSave(studentinfoobj);*/
			/*if (row>0)
			{
				RequestDispatcher rd=request.getRequestDispatcher("/JSP/CRM_studentregistration.jsp?message=saved");
				rd.forward(request, response);
			}*/
		}
		
	}  
	request.setAttribute("round_trip_record",halt_obj);
	/*halt_obj.add(halttimeinfoobj);*/
	System.out.println("IMEI "+vehicle_no);
	//System.out.println("DATE "+startdate+" , "+enddate);
	
	
    
} catch (Exception e) {
    System.err.println(e);
}
String i=request.getParameter("action");

System.out.println("Button Clicked is :::"+i);
/* if(i.equalsIgnoreCase("Export To Pdf"))
{
RequestDispatcher rd=request.getRequestDispatcher("halt_time_report_pdf_new.jsp?imeinumber="+vehicle_no+"&startdate="+startdate+"&enddate="+enddate);
rd.forward(request, response);
}
else if(i.equalsIgnoreCase("Export To Excel"))
{ */
	RequestDispatcher rd=request.getRequestDispatcher("round_trip_pdf.jsp?imeinumber="+vehicle_no+"&name="+name+"&values="+values+"");
	rd.forward(request, response);
/* } */
%>

</body>

</html>