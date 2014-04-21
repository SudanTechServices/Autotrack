<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.ts.domain.Halt_time"%>
<%@page import="java.util.Iterator" %>
<%@page import="java.util.List" %>
<%@page import="com.lowagie.text.*"%>
<%@page import=" com.lowagie.text.pdf.*"%>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction" %>
<%@page import="com.lowagie.text.pdf.PdfReader" %>

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
System.out.println("Works");
String startdate = request.getParameter("startdate");
String enddate = request.getParameter("enddate");
System.out.println(startdate);

String imeinumber = request.getParameter("imeinumber");
String vehicle_number = null;
response.setContentType("application/pdf");
String filename="halt_time_report.pdf";
int pagenumber=1;
response.setHeader("Content-Disposition", "attachment;filename=" + filename);
try{   
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
	    Document document=new Document(PageSize.A4,20,10,64,44);
	    PdfWriter writer=PdfWriter.getInstance(document,response.getOutputStream());
	    Font style=new Font();
		style.setStyle("bold");
		//style.setColor(0, 143, 235);
		style.setSize(7);
		style.isBold();
		HeaderFooter header = new HeaderFooter(new Phrase("Autotrack"), false);
     	HeaderFooter footer1 = new HeaderFooter(new Phrase("Powered By TransnetworkX                                                                                              ",style),true); 
        footer1.setAlignment(Element.ALIGN_JUSTIFIED);
        footer1.setBorder(Rectangle.NO_BORDER);
     	header.setBorder(Rectangle.NO_BORDER);
     	header.setAlignment(Element.ALIGN_CENTER); 
     	document.setHeader(header);
     	document.setFooter(footer1); 
     	document.open();
     	Image image = Image.getInstance("E:/workspace/Autotrack/WebContent/images/PDF_Logo.jpg");
     	image.setAlignment(Element.ALIGN_JUSTIFIED_ALL); 
	    image.setAbsolutePosition(80f, 820f); 
	    document.add(image);
	    Font myContentStyle=new Font();
	    myContentStyle.setStyle("bold");
	    myContentStyle.setColor(0, 143, 235);
	    myContentStyle.setSize(12);
	    myContentStyle.isBold();
	    
	    
	    float[] widths ={9,3,3,3 };
	    
	    PdfPTable table=new PdfPTable(widths);
	    Paragraph paragraph1=new Paragraph("Halt time Report for : "+vehicle_number+"",myContentStyle);
        paragraph1.setSpacingAfter(10);
    	paragraph1.setIndentationLeft(54);
    	document.add(paragraph1);
    	Font heading_style=new Font();
   	 	heading_style.setStyle("bold");
   	 	heading_style.setFamily("TIMES_ROMAN");
 		heading_style.setSize(10);
 		Font no_data_style=new Font();
    	//no_data_style.setStyle("bold");
    	no_data_style.setFamily("TIMES_ROMAN");
    	no_data_style.setSize(10);
    	no_data_style.setColor(255, 0, 0);
    	Font data_style=new Font();
    	data_style.setFamily("TIMES_ROMAN");
    	data_style.setSize(10);
    	table.addCell(new Paragraph("Place",heading_style));
	    table.addCell(new Paragraph("Stoped at",heading_style));
	    table.addCell(new Paragraph("Stoped till",heading_style));
	    table.addCell(new Paragraph("Halt Time",heading_style));
	    table.setHeaderRows(1);
	    List<Halt_time> ht = (List<Halt_time>)request.getAttribute("halt_time_record");  
	    
	     for(Halt_time h : ht)
		{  
		System.out.println("Place "+h.getPlace());
		System.out.println("Min Time "+h.getMinimum_time());
		System.out.println("Max Time "+h.getMaximum_time());
		System.out.println("Halt Time "+h.getHalt_time());
		table.addCell(new Paragraph(h.getPlace(),data_style));
    	table.addCell(new Paragraph(h.getMinimum_time(),data_style));
	    table.addCell(new Paragraph(h.getMaximum_time(),data_style));
	    table.addCell(new Paragraph(h.getHalt_time(),data_style)); 
 	} 
	    int row_count=table.size();
	    System.out.println("row count"+table.size());
	    if(row_count == 1)
	    {
	    	Paragraph paragraph=new Paragraph("There is no data available...",no_data_style);
	    	paragraph.setSpacingAfter(10);
	    	paragraph.setIndentationLeft(54);
	    	paragraph.setAlignment(Element.ALIGN_LEFT);
	    	document.add(paragraph);
	    }
	    document.add(table);
	    document.close();
%>
<div id=message><label>Your PDF Saved Successfully</label></div>
<%
connection.close();
st.close();
rs.close();
}
catch(Exception e)
{
  e.printStackTrace();
}
%>
</body>

</html>