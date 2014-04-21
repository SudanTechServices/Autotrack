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

String imeinumber = request.getParameter("imeinumber");
String distance ="Total Distance Travelled";
String columnValue =request.getParameter("values");


System.out.println("Column name : "+distance+"  column values : "+columnValue);
String vehicle_number = null;
response.setContentType("application/pdf");
String filename="RoundTrip.pdf";
int pagenumber=1;
int counter=1;
int splitCounter=(Integer)session.getAttribute("splitCount");
int hrs=0;
int mins=0;
ResultSet rs = null;
Statement st=null;
Connection connection=null;
response.setHeader("Content-Disposition", "attachment;filename=" + filename);
try{   
	  DBTransaction dbtranobj=new DBTransaction();
		connection=dbtranobj.connect();
		
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
	    
	    float[] widths ={6,3,6,3,3,2 };
	    PdfPTable table=new PdfPTable(widths); //Table column metioning
	    
	    
	    Paragraph paragraph1=new Paragraph("Round Report for : "+vehicle_number+"",myContentStyle);
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
    	table.addCell(new Paragraph("Start Position",heading_style));
	    table.addCell(new Paragraph("Start Time",heading_style));
	    table.addCell(new Paragraph("Halt Position",heading_style));
	    table.addCell(new Paragraph("Stopped At",heading_style));
	    table.addCell(new Paragraph("Halted Time",heading_style));
	    table.addCell(new Paragraph("KM",heading_style));
	    
	    table.setHeaderRows(1);
	    List<Halt_time> ht = (List<Halt_time>)request.getAttribute("round_trip_record");  
	    PdfPCell cell; 
	     for(Halt_time h : ht)
		{  
	    String hr = h.getHalt_time();
	    String[] token=  hr.split(" ");
	           if(!token[0].equals("Round")){		  
		       		hrs = Integer.parseInt(token[0]);
	    			 mins =Integer.parseInt( token[2]);
		  
	             }
		  
	          System.out.println("PDF HRRRRRRRR :"+hrs+"   hours "+mins+" mins");    	
	         if(hrs > 2 || (hrs==2 && mins>30) ){
	        	 if(counter == splitCounter ){
	        		 cell=new PdfPCell(new Paragraph(h.getPlace(),data_style)); 
		    		    table.addCell(cell);
		    			table.addCell(new Paragraph(h.getStart_time(),data_style));	    			
		    			cell = new PdfPCell(new Paragraph(h.getHalt_position(),heading_style)); //------------ Adding Bold for this column--------------//
		    			table.addCell(cell);	    			
		    			//table.addCell(new Paragraph(h.getHalt_position(),data_style));
		    			table.addCell(new Paragraph(h.getStoped_at(),data_style));
		    			table.addCell(new Paragraph(h.getHalt_time(),heading_style));
		    		    table.addCell(new Paragraph(h.getDistance(),data_style)); 
		    		    counter++;
	        		 }
	        	 else{
	    		    System.out.println("Hrs inside less than 2 "+ hrs);
	    		    cell=new PdfPCell(new Paragraph(h.getPlace(),data_style)); 
				    table.addCell(cell);
					//table.addCell(new Paragraph(h.getPlace(),data_style));
					table.addCell(new Paragraph(h.getStart_time(),data_style));
					table.addCell(new Paragraph(h.getHalt_position(),data_style));
					table.addCell(new Paragraph(h.getStoped_at(),data_style));
					table.addCell(new Paragraph(h.getHalt_time(),heading_style));
				    table.addCell(new Paragraph(h.getDistance(),data_style)); 
				    counter++;
	        	 }
	    	 }
	         else if(counter == splitCounter ){
	    		    cell=new PdfPCell(new Paragraph(h.getPlace(),data_style)); 
	    		    table.addCell(cell);
	    			table.addCell(new Paragraph(h.getStart_time(),data_style));	    			
	    			cell = new PdfPCell(new Paragraph(h.getHalt_position(),heading_style)); //------------ Adding Bold for this column--------------//
	    			table.addCell(cell);	    			
	    			//table.addCell(new Paragraph(h.getHalt_position(),data_style));
	    			table.addCell(new Paragraph(h.getStoped_at(),data_style));
	    			table.addCell(new Paragraph(h.getHalt_time(),data_style));
	    		    table.addCell(new Paragraph(h.getDistance(),data_style)); 
	    		    counter++;
	    		 
	    	 }
	    	 else if(counter != splitCounter ){
					cell=new PdfPCell(new Paragraph(h.getPlace(),data_style)); 
				    table.addCell(cell);
					//table.addCell(new Paragraph(h.getPlace(),data_style));
					table.addCell(new Paragraph(h.getStart_time(),data_style));
					table.addCell(new Paragraph(h.getHalt_position(),data_style));
					table.addCell(new Paragraph(h.getStoped_at(),data_style));
					table.addCell(new Paragraph(h.getHalt_time(),data_style));
				    table.addCell(new Paragraph(h.getDistance(),data_style)); 
				    counter++;
	    	 }
	    	
	    	/*  else if(hrs ==2 && mins >= 30 ){
	    		    cell=new PdfPCell(new Paragraph(h.getPlace(),data_style)); 
				    table.addCell(cell);//.,
					//table.addCell(new Paragraph(h.getPlace(),data_style));
					table.addCell(new Paragraph(h.getStart_time(),data_style));
					table.addCell(new Paragraph(h.getHalt_position(),data_style));
					table.addCell(new Paragraph(h.getStoped_at(),data_style));
					table.addCell(new Paragraph(h.getHalt_time(),heading_style));
				    table.addCell(new Paragraph(h.getDistance(),data_style)); 
				    counter++;
	    	 } */
	    	 
	    	 
	    	 
	    System.out.println("Export to pdf... Counter :"+counter +"  haltposistion : " +h.getHalt_position()+ "  split counter is : "+splitCounter);
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
	    float[] widths1 ={6,1,6,3,3,2 };
	    PdfPTable Secondtable=new PdfPTable(widths1	);
	    PdfPCell cell1;
	    
	    cell1 = new PdfPCell(new Paragraph(distance,heading_style));
	    cell1.setBorder(Rectangle.NO_BORDER);
	    	    
	    Secondtable.addCell(cell1);	 
	    cell1 = new PdfPCell(new Paragraph(":",heading_style));
	    cell1.setBorder(Rectangle.NO_BORDER);
	    Secondtable.addCell(cell1);	
	    cell1 = new PdfPCell(new Paragraph(columnValue,heading_style));
	    cell1.setBorder(Rectangle.NO_BORDER);
	    cell1.setHorizontalAlignment(Element.ALIGN_LEFT);
	    cell1.setColspan(4);
	    Secondtable.addCell(cell1);	
	    
	    
	    cell1 = new PdfPCell(new Paragraph("Total Spend Time ",heading_style));
	    cell1.setBorder(Rectangle.NO_BORDER);
	    cell1.setHorizontalAlignment(Element.ALIGN_LEFT);	    
	    Secondtable.addCell(cell1);	    
	    cell1 = new PdfPCell(new Paragraph(":",heading_style));
	    cell1.setBorder(Rectangle.NO_BORDER);
	    Secondtable.addCell(cell1);	    
	    cell1 = new PdfPCell(new Paragraph((String)session.getAttribute("totalSpendTime"),heading_style));
	    cell1.setBorder(Rectangle.NO_BORDER);	    
	    cell1.setColspan(4);
	    Secondtable.addCell(cell1);	
	    
	    cell1 = new PdfPCell(new Paragraph("Total Halt Time ",heading_style));
	    cell1.setBorder(Rectangle.NO_BORDER);
	    cell1.setHorizontalAlignment(Element.ALIGN_LEFT);	    
	    Secondtable.addCell(cell1);
	    cell1 = new PdfPCell(new Paragraph(":",heading_style));
	    cell1.setBorder(Rectangle.NO_BORDER);
	    Secondtable.addCell(cell1);
	    cell1 = new PdfPCell(new Paragraph((String)session.getAttribute("totalHalt"),heading_style));
	    cell1.setBorder(Rectangle.NO_BORDER);
	    // cell1.setHorizontalAlignment(Element.ALIGN_LEFT);	
	    cell1.setColspan(4);
	    Secondtable.addCell(cell1);	
	    
	    cell1 = new PdfPCell(new Paragraph("Total Travelled Time ",heading_style));
	    cell1.setBorder(Rectangle.NO_BORDER);
	    cell1.setHorizontalAlignment(Element.ALIGN_LEFT);	    
	    Secondtable.addCell(cell1);
	    cell1 = new PdfPCell(new Paragraph(":",heading_style));
	    cell1.setBorder(Rectangle.NO_BORDER);
	    Secondtable.addCell(cell1);
	    cell1 = new PdfPCell(new Paragraph((String)session.getAttribute("totalTravelled"),heading_style));
	    cell1.setBorder(Rectangle.NO_BORDER);
	    // cell1.setHorizontalAlignment(Element.ALIGN_LEFT);	
	    cell1.setColspan(4);
	    Secondtable.addCell(cell1);	
	    
	    document.add(table);
	    document.add(Secondtable);
	    
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
finally{
	if(connection!=null){
		connection.close();
		st.close();
		rs.close();
	}
}
%>
</body>

</html>