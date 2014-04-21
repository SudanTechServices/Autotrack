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
String IMEI = request.getParameter("IMEI");
String[] select = (String[])session.getAttribute("id"); 
String locations = request.getParameter("locations");


%>
<%

response.setContentType("application/pdf");
	String filename="location_report.pdf";
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
	   
	   
	    Paragraph p1=new Paragraph("Report for Location : "+locations+"",myContentStyle);
        p1.setSpacingAfter(10);
        p1.setIndentationLeft(51);
     
		document.add(p1);
	   
	    PdfPTable table=new PdfPTable(select.length + 1);
	  
	  
	  

 
 	 /*  PdfPCell cell = new PdfPCell(new Paragraph("Report for Location : "+locations+"",myContentStyle));
        
        
 	 cell.setColspan(select.length + 1);
		
		table.addCell(cell); */
		
		
		rs = st.executeQuery("SELECT * FROM student WHERE location='"+locations+"' order by pick_point");
		while(rs.next()){ 
		if(rs.isLast()){
			
			
			    Paragraph p2=new Paragraph("Number of Students Record  :  "+rs.getRow() +"",myContentStyle);
		        p2.setSpacingAfter(10);
		        p2.setIndentationLeft(51);
		     
				document.add(p2);
			
			
			/* PdfPCell cell4 = new PdfPCell(new Paragraph("Number of Students Record  :  "+rs.getRow() +"",myContentStyle));
	        
	        
				cell4.setColspan(select.length + 1);
			
				table.addCell(cell4); */
			
		}
		}
		
		if (select != null && select.length != 0) {
			
			for (int i = 0; i < select.length; i++) {
				                 
				
				//gives number of locations
				
				
								if(select[i].equalsIgnoreCase("pick_point")){
									
									rs = st.executeQuery("select count(DISTINCT pick_point) FROM student WHERE location='"+locations+"'");
									while(rs.next()){
										String no_of_pickpoint = rs.getString(1);
										
										 Paragraph p3=new Paragraph("No of Pick Points "+no_of_pickpoint+"",myContentStyle);
									        p3.setSpacingAfter(10);
									        p3.setIndentationLeft(51);
									     
											document.add(p3);
										/* PdfPCell cell1 = new PdfPCell(new Paragraph("No of Pick Points "+no_of_pickpoint+"",myContentStyle));
								        
								        
										cell1.setColspan(select.length+1);
										
										table.addCell(cell1); */																							
										
									}
								}
		
			}
		}
		
					Phrase sno = new Phrase("S.NO", boldFont);
		
						table.addCell(sno);
						table.setHeaderRows(1);
						if (select != null && select.length != 0) {
					 	 	for (int i = 0; i < select.length; i++) {
					 	 		
					 	 		if(select[i].equalsIgnoreCase("ENROLMENT_NUMBER")){
					 	 			
					 	 			Phrase firstLine = new Phrase("ROLLNO", boldFont);

						 	 		table.addCell(firstLine);
						 	 		table.setHeaderRows(1);
					 	 		}
					 	 		else if(select[i].equalsIgnoreCase("PICK_POINT")){
					 	 			
					 	 			Phrase firstLine = new Phrase("PICKPOINT", boldFont);

						 	 		table.addCell(firstLine);
						 	 		table.setHeaderRows(1);
					 	 		}
								else if(select[i].equalsIgnoreCase("RESIDENCE_ADDRESS")){
					 	 			
					 	 			Phrase firstLine = new Phrase("ADDRESS", boldFont);

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
		 rs = st.executeQuery("SELECT * FROM student WHERE location='"+locations+"' order by pick_point");

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
