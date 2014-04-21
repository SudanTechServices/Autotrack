<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>
 <%@page import="java.util.*"%>
<%@page import="com.lowagie.text.*"%>
<%@page import=" com.lowagie.text.pdf.*"%>
<%@page import=" java.text.*" %>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
<head>
<script src="//maps.google.com/maps?file=api&amp;v=2&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" type="text/javascript"></script>
 <link rel="stylesheet" type="text/css" href="../../CSS/style.css" /> 
  
</head>
<body>
<%
String vehicle_number = request.getParameter("vehicle_number");
String[] select = (String[])session.getAttribute("id"); 
String driver_name = request.getParameter("driver_name");

%>
<%

response.setContentType("application/pdf");
	String filename="Driver_report.pdf";
	response.setHeader("Content-Disposition", "attachment;filename=" + filename);
try{   
	DBTransaction dbtranobj=new DBTransaction();
	Connection connection=dbtranobj.connect();
	ResultSet rs = null;
	Statement st=null;
	st=connection.createStatement();
	  
   Document document=new Document();
   PdfWriter writer=PdfWriter.getInstance(document,response.getOutputStream());
   
   
   Font style=new Font();
   style.setStyle("bold");
   //style.setColor(0, 143, 235);
   style.setSize(7);
   style.isBold();


       /*  ByteArrayOutputStream baos = new ByteArrayOutputStream();
           PdfWriter.getInstance(document, baos); */
           HeaderFooter header = new HeaderFooter(new Phrase("Autotrack"), false);
        	 HeaderFooter footer1 = new HeaderFooter(new Phrase("Powered By TransnetworkX                                                                                              ",style),true); 
           footer1.setAlignment(Element.ALIGN_JUSTIFIED);
           footer1.setBorder(Rectangle.NO_BORDER);
        	 header.setBorder(Rectangle.NO_BORDER);
        	 header.setAlignment(Element.ALIGN_CENTER); 
        	 document.setHeader(header);
        	 // header.getBefore(footer1);
        
           
           document.setFooter(footer1); 

   
   
   document.open();
   Font myContentStyle=new Font(Font.TIMES_ROMAN);
   myContentStyle.setStyle("bold");
   myContentStyle.setColor(0, 143, 235);
   myContentStyle.setSize(12);
   myContentStyle.isBold();
   Image image = Image.getInstance("/home/administrator/workspace_Test/Autotrack/WebContent/images/PDF_Logo.jpg");
   image.setAlignment(Element.ALIGN_RIGHT); 
    image.setAbsolutePosition(80f, 820f); 
  // Image headImage = Image.getInstance("GetImagePath");
  Font myContentStyle1=new Font(Font.TIMES_ROMAN);
 
   
       Font boldFont = new Font(Font.TIMES_ROMAN,8,Font.BOLD);
       
       Font normalFont = new Font(Font.TIMES_ROMAN,8);

	   document.add(image);
	   
	   
	   Paragraph p1=new Paragraph("Report for Driver Name : "+driver_name+"",myContentStyle);
        p1.setSpacingAfter(10);
        p1.setIndentationLeft(51);
     
		document.add(p1);
	   
	  PdfPTable table=new PdfPTable(select.length + 1);
 
 	/*  //PdfPCell cell = new PdfPCell(new Paragraph("Report for Driver Name : "+driver_name+"",myContentStyle)); */
        
        
/* 
		cell.setColspan(select.length + 1);
		
		table.addCell(cell);
		  */
		Phrase sno = new Phrase("S.NO", boldFont);
		
		table.addCell(sno);
		table.setHeaderRows(1);
		
		 if (select != null && select.length != 0) {
		 	 	for (int i = 0; i < select.length; i++) {
		 	 		
                  if(select[i].equalsIgnoreCase("LICENSE_NUMBER")){
		 	 			
		 	 			Phrase firstLine = new Phrase("LicenseNo", boldFont);

			 	 		table.addCell(firstLine);
			 	 		table.setHeaderRows(1);
		 	 		}
		 	 		
		 	 		
		 	 	else if(select[i].equalsIgnoreCase("VEHICLE_NUMBER")){
		 	 			
		 	 			Phrase firstLine = new Phrase("VehicleNo", boldFont);

			 	 		table.addCell(firstLine);
			 	 		table.setHeaderRows(1);
		 	 		}
		 	 		else if(select[i].equalsIgnoreCase("SHIFT_NUMBER")){
		 	 			
		 	 			Phrase firstLine = new Phrase("ShiftNo", boldFont);

			 	 		table.addCell(firstLine);
			 	 		table.setHeaderRows(1);
		 	 		}
					else if(select[i].equalsIgnoreCase("ROUTE_NUMBER")){
		 	 			
		 	 			Phrase firstLine = new Phrase("RouteNo", boldFont);

			 	 		table.addCell(firstLine);
			 	 		table.setHeaderRows(1);
		 	 		}
		 	 		else{	
		 	 		Phrase firstLine = new Phrase(select[i].toUpperCase(), boldFont);

		 	 		table.addCell(firstLine);
		 	 		table.setHeaderRows(1);
		 	 		}
		 	 			}
		 	 		
		 	    	}
		
					
		
		rs = st.executeQuery("SELECT * FROM driver_info WHERE driver_name='"+driver_name+"' order by driver_name");
		 int count = 1;
		
		
        while(rs.next()){ 
			 
			 Phrase cellrecords_sno = new Phrase(""+count+"", normalFont);
			 
			 table.addCell(cellrecords_sno);
			 
			 if (select != null && select.length != 0) {
			 	 	for (int i = 0; i < select.length; i++) {
			 	 			
			 	 		Phrase cellrecords = new Phrase(rs.getString(select[i]), normalFont);
			 	 		
			 	 		table.addCell(cellrecords);
			 	 	
			 	 			}
			 	 		
			 	    	}
			 count  ++;	
		 }
       document.add(table);
       document.close();
%>

 <div id=message><label>Your PDF Is Saved In C Drive</label></div>

<%
connection.close();
st.close();
rs.close();
}

// FOR LINUX...............................................................................................



catch(Exception e)
{
}

%>

</body>
</html>
