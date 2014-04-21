<%@page import="java.io.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>
<%@page import="com.lowagie.text.*"%>
<%@page import=" com.lowagie.text.pdf.*"%>
<%@page import=" java.text.*" %>
<%@ page import ="java.util.Arrays"%>
 <%@page import="java.util.*"%>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction;" %>
<html>
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
       <body bgcolor="#2ECCFA">
<%

String month_selected = request.getParameter("month_selected").trim();
System.out.println(month_selected);

String vehicle_number="";
	String month = "01";
	int count =1;
	int mon = 1;
	int lastdate=0;
	String imeinumber = request.getParameter("imeinumber");
     double fuel_tank_capacity = 0.00;
	 double empty_fuel_voltage = 0.00;
	 double full_fuel_voltage = 0.00;
     double fuel_from_db=0.00;
      double calculated_current_fuel = 0.0;
      double current_fuel = 0.00;
      String am_pm;
      String ses_hour;String date;
      String fin_hr;String time;
 	String fuel_in_ltr=null;
 	response.setContentType("application/pdf");
 	String filename="fuel_monthly_report.pdf";
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
	
	System.out.println(vehicle_number);
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
    Font myContentStyle=new Font();
    myContentStyle.setStyle("bold");
    myContentStyle.setColor(0, 143, 235);
    myContentStyle.setSize(12);
    myContentStyle.isBold();
    Image image = Image.getInstance("/home/administrator/workspace_Test/Autotrack/WebContent/images/PDF_Logo.jpg");
    image.setAlignment(Element.ALIGN_RIGHT); 
    image.setAbsolutePosition(80f, 820f); 
   // Image headImage = Image.getInstance("GetImagePath");
    
    
    
   
	    document.add(image);
    //document.add(new Paragraph("Speed Report",myContentStyle));
    
    
    Paragraph paragraph1=new Paragraph("Fuel Report of "+ month_selected + " for " +vehicle_number+"",myContentStyle);
    
    paragraph1.setSpacingAfter(10);
	paragraph1.setIndentationLeft(53);
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
    
    
     PdfPTable table=new PdfPTable(3);
   
     
     //PdfPCell imgcell = new PdfPCell(image);
     //imgcell.setColspan(4);
     //table.addCell(imgcell); 

     /*  PdfPCell cell = new PdfPCell(new Paragraph("Fuel Report of "+ month_selected + "for " +vehicle_number+"",myContentStyle));
     
      cell.setColspan(3);
		table.addCell(cell); */
		 table.addCell(new Paragraph("Day",heading_style));
    //table.addCell("Time");
      table.addCell(new Paragraph("Fuel Voltage",heading_style));
    table.addCell(new Paragraph("Fuel In Liters",heading_style));
     table.setHeaderRows(1);
     //DBTransaction dbtranobj=new DBTransaction();
 	//Connection connection=dbtranobj.connect();
 	//ResultSet rs = null;
 	//Statement st=null;
 		//st=connection.createStatement();
     //Class.forName("org.postgresql.Driver").newInstance();
     //Connection con = DriverManager.getConnection("jdbc:postgresql://182.72.167.34:5432/master_database","postgres", "postgres");
      
      rs = st.executeQuery("SELECT empty_fuel_voltage,full_fuel_voltage,fuel_tank_capacity from vehicle_information where imei_no='"+imeinumber+"';");
         if(rs.next())
	       {
	       	empty_fuel_voltage=(Double.parseDouble(rs.getString(1)));
	       	full_fuel_voltage=(Double.parseDouble(rs.getString(2)));
	       	fuel_tank_capacity=(Double.parseDouble(rs.getString(3)));
	       	
	       }
         if(month_selected.equalsIgnoreCase("January")){
     		mon = 1;
     		lastdate = 31;
     	 } else if(month_selected.equalsIgnoreCase("February")){
      		mon = 2;
      		lastdate = 29;
      	 } 
     	 else if(month_selected.equalsIgnoreCase("March")){
       		mon = 3;
       		lastdate = 31;
       	 } 
     	 else if(month_selected.equalsIgnoreCase("April")){
       		mon = 4;
       		lastdate = 30;
       	 } 
     	 else if(month_selected.equalsIgnoreCase("May")){
       		mon = 5;
       		lastdate = 31;
       	 } 
     	 else if(month_selected.equalsIgnoreCase("June")){
       		mon = 6;
       		lastdate = 30;
       	 } 
     	 else if(month_selected.equalsIgnoreCase("July")){
       		mon = 7;
       		lastdate = 31;
       	 } 
     	 else if(month_selected.equalsIgnoreCase("August")){
       		mon = 8;
       		lastdate = 31;
       	 } 
     	 else if(month_selected.equalsIgnoreCase("September")){
       		mon = 9;
       		lastdate = 30;
       	 } 
     	 else if(month_selected.equalsIgnoreCase("October")){
       		mon = 10;
       		lastdate = 31;
       	 } 
     	 else if(month_selected.equalsIgnoreCase("November")){
       		mon = 11;
       		lastdate = 30;
       	 } 
     	 else if(month_selected.equalsIgnoreCase("December")){
        		mon = 12;
        		lastdate = 31;
        	 } 
     	 
     	  	
     	  	
     	  for(count = 1; count<=lastdate; count++){
     		  
     	    System.out.println(count);
     	    System.out.println("month : "+mon);
     	    System.out.println("last date: "+lastdate);
     	    
     	    String day = count+"-"+mon+"-2012";
     	    
     	    
     	  rs = st.executeQuery("SELECT fuel FROM tracking WHERE imei_no ='"+imeinumber+"' and date_time>='"+mon+"-"+count+"-2012 09:00:00' and date_time<='"+mon+"-"+count+"-2012 20:00:00' and fuel>'0.00' order by date_time desc limit 1");
     	  
     	  if(rs.next()){ 
     	 
     	  fuel_from_db=(Double.parseDouble(rs.getString("fuel")));
     	String fuel_val=String.valueOf(fuel_from_db);
 	
 	    	  		calculated_current_fuel = (fuel_from_db - empty_fuel_voltage)/(full_fuel_voltage - empty_fuel_voltage)*100;
 	  	            current_fuel = (calculated_current_fuel/100)*fuel_tank_capacity;
 	  	            current_fuel = Math.round(current_fuel*100.0)/100.0;
 	  	            fuel_in_ltr=""+current_fuel+" ";
 	  	         table.addCell(new Paragraph(day,data_style));
 	  	         table.addCell(new Paragraph(fuel_val,data_style));
 	  	      table.addCell(new Paragraph(fuel_in_ltr,data_style));
		       
	       	
	       
	       	
	       	
	       	}//if +0.10
	       	}//else if
     
	       	
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
// FOR LINUX...............................................................................................



catch(Exception e)
{
	

} 
	

%>
</body>
</html>