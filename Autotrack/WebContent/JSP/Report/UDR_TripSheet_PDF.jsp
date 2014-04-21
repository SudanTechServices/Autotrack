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
String date = request.getParameter("date");
%>
<%

response.setContentType("application/pdf");
	String filename="TripSheet_Report.pdf";
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
       Font no_data_style=new Font();
   	//no_data_style.setStyle("bold");
   	no_data_style.setFamily("TIMES_ROMAN");
   	no_data_style.setSize(10);
   	no_data_style.setColor(255, 0, 0);


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
 	      
 	      
 	      
 	      Paragraph paragraph1=new Paragraph("Report for Trip Sheet on : "+date+"",myContentStyle);
 	     paragraph1.setSpacingAfter(10);
			paragraph1.setIndentationLeft(51);
			document.add(paragraph1);
 	      
 	      
			rs = st.executeQuery("SELECT * FROM trip_sheet WHERE date='"+date+"' order by sno");
			   while(rs.next()){ 
				   
			    if(rs.isLast()){
				
				Paragraph paragraph2=new Paragraph("Number of Records :  "+rs.getRow() +"",myContentStyle);
				paragraph2.setSpacingAfter(10);
				paragraph2.setIndentationLeft(51);
				document.add(paragraph2);
				
				
			}
			}
			
			   
			   if (select != null && select.length != 0) {
					
					for (int i = 0; i < select.length; i++) {
						                 
						
						
						if(select[i].equalsIgnoreCase("vehicle_number")){
											
							rs = st.executeQuery("select count(DISTINCT vehicle_number) FROM trip_sheet WHERE date='"+date+"'");
							while(rs.next()){
								String no_of_vehicle = rs.getString(1);
								Paragraph paragraph3=new Paragraph("No of Different Vehicles "+no_of_vehicle+"",myContentStyle);
								paragraph3.setSpacingAfter(10);
								paragraph3.setIndentationLeft(51);
								document.add(paragraph3);																						
												
											}
										}
						
						if(select[i].equalsIgnoreCase("driver_name")){
							
							rs = st.executeQuery("select count(DISTINCT driver_name) FROM trip_sheet WHERE date='"+date+"'");
							while(rs.next()){
								String no_of_driver = rs.getString(1);
								Paragraph paragraph4=new Paragraph("Number of Drivers  "+no_of_driver+"",myContentStyle);
								paragraph4.setSpacingAfter(10);
								paragraph4.setIndentationLeft(51);
								document.add(paragraph4);	
											}
										}
				
					}
				}
			
			
 	   
 	    PdfPTable table=new PdfPTable(select.length + 1);
 
 
 	    /* PdfPCell cell = new PdfPCell(new Paragraph("Report for Trip Sheet on : "+date+"",myContentStyle));
        
        
 	   
 			cell.setColspan(select.length + 1);
 			
 			table.addCell(cell); */
		
		
 			/* rs = st.executeQuery("SELECT * FROM trip_sheet WHERE date='"+date+"' order by sno");
		   while(rs.next()){ 
			   
		    if(rs.isLast()){
			
			PdfPCell cell4 = new PdfPCell(new Paragraph("Number of Records :  "+rs.getRow() +"",myContentStyle));
	        
	        
             cell4.setColspan(select.length + 1);
			
			 table.addCell(cell4);
			
			
		} */
		/* } */
		
		/* if (select != null && select.length != 0) {
			
			for (int i = 0; i < select.length; i++) {
				                 
				
				
				if(select[i].equalsIgnoreCase("vehicle_number")){
									
					rs = st.executeQuery("select count(DISTINCT vehicle_number) FROM trip_sheet WHERE date='"+date+"'");
					while(rs.next()){
						String no_of_vehicle = rs.getString(1);
										PdfPCell cell1 = new PdfPCell(new Paragraph("No of Different Vehicles "+no_of_vehicle+"",myContentStyle));
								        
								        
										cell1.setColspan(select.length + 1);
										
										table.addCell(cell1);																						
										
									}
								} */
				/* if(select[i].equalsIgnoreCase("driver_name")){
					
					rs = st.executeQuery("select count(DISTINCT driver_name) FROM trip_sheet WHERE date='"+date+"'");
					while(rs.next()){
						String no_of_driver = rs.getString(1);
   						 PdfPCell cell2 = new PdfPCell(new Paragraph("Number of Drivers  "+no_of_driver+"",myContentStyle));
								        
								        
   							 cell2.setColspan(select.length + 1);
	
									table.addCell(cell2);	
									}
								}
		
			}
		} */
		
           Phrase sno = new Phrase("S.NO", boldFont);
		
		   table.addCell(sno);
		   table.setHeaderRows(1);
		
		   if (select != null && select.length != 0) {
		 	 	for (int i = 0; i < select.length; i++) {
		 	 		
		 	 		if(select[i].equalsIgnoreCase("VEHICLE_NUMBER")){
		 	 			
		 	 			Phrase firstLine = new Phrase("Vehicle  No", boldFont);

			 	 		table.addCell(firstLine);
			 	 		table.setHeaderRows(1);
		 	 		}
		 	 		else if(select[i].equalsIgnoreCase("ROUTE_NUMBER")){
		 	 			
		 	 			Phrase firstLine = new Phrase("Route  No", boldFont);

			 	 		table.addCell(firstLine);
			 	 		table.setHeaderRows(1);
		 	 		}
					else if(select[i].equalsIgnoreCase("START_KM")){
		 	 			
		 	 			Phrase firstLine = new Phrase("Start  KM", boldFont);

			 	 		table.addCell(firstLine);
			 	 		table.setHeaderRows(1);
		 	 		}
					else if(select[i].equalsIgnoreCase("CLOSE_KM")){
		 	 			
		 	 			Phrase firstLine = new Phrase("Close  KM", boldFont);

			 	 		table.addCell(firstLine);
			 	 		table.setHeaderRows(1);
		 	 		}
					else if(select[i].equalsIgnoreCase("RUN_KM")){
							
							Phrase firstLine = new Phrase("Run  KM", boldFont);
					
							table.addCell(firstLine);
							table.setHeaderRows(1);
						}
					else if(select[i].equalsIgnoreCase("PRESENT_CHILDREN")){
							
							Phrase firstLine = new Phrase("PresentStudent", boldFont);
					
							table.addCell(firstLine);
							table.setHeaderRows(1);
						}
					else if(select[i].equalsIgnoreCase("VEHICLE_OUTTIME")){
							
							Phrase firstLine = new Phrase("VehicleOut   Time", boldFont);
					
							table.addCell(firstLine);
							table.setHeaderRows(1);
						}
					else if(select[i].equalsIgnoreCase("VEHICLE_INTIME")){
						
						Phrase firstLine = new Phrase("VehicleInTime", boldFont);
				
						table.addCell(firstLine);
						table.setHeaderRows(1);
					}
					else if(select[i].equalsIgnoreCase("DRIVER_NAME")){
						
						Phrase firstLine = new Phrase("Driver  Name", boldFont);
				
						table.addCell(firstLine);
						table.setHeaderRows(1);
					}
					else if(select[i].equalsIgnoreCase("VEHICLE_OUTTIME")){
						
						Phrase firstLine = new Phrase("VehicleOutTime", boldFont);
				
						table.addCell(firstLine);
						table.setHeaderRows(1);
					}
					else if(select[i].equalsIgnoreCase("TCSS_NAME")){
						
						Phrase firstLine = new Phrase("Tcss    Name", boldFont);
				
						table.addCell(firstLine);
						table.setHeaderRows(1);
					}
					else if(select[i].equalsIgnoreCase("INSERTED_BY")){
						
						Phrase firstLine = new Phrase("Entered  by", boldFont);
				
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
		   rs = st.executeQuery("SELECT * FROM trip_sheet WHERE date='"+date+"' order by sno");



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