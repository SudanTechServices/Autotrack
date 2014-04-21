<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.lowagie.text.*"%>
<%@page import=" com.lowagie.text.pdf.*"%>
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

String startdate = request.getParameter("start_date");
String enddate = request.getParameter("end_date");
String imeinumber = request.getParameter("imeinumber");
String vehicle_number="";
String am_pm;
String ses_hour;String date;
String fin_hr;String time;
response.setContentType("application/pdf");
String filename="speed_report.pdf";
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
	
	Document document=new Document();
	 PdfWriter.getInstance(document,response.getOutputStream());
	 
	 
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
    myContentStyle.setSize(10);
    myContentStyle.isBold();
    Image image = Image.getInstance("PDF_Logo.jpg");
    image.setAlignment(Element.ALIGN_RIGHT); 
    image.setAbsolutePosition(80f, 820f); 
  // Image headImage = Image.getInstance("GetImagePath");
   
	   document.add(image);
   
	   /* document.add(image); */
    //document.add(new Paragraph("Speed Report",myContentStyle));
	
    Paragraph paragraph1=new Paragraph("Speed Report for "+vehicle_number+"",myContentStyle);
    paragraph1.setSpacingAfter(10);
	paragraph1.setIndentationLeft(51);
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
   
     
     /* PdfPCell imgcell = new PdfPCell(image);
     imgcell.setColspan(3);
     table.addCell(imgcell); 
 */
    /*  PdfPCell cell = new PdfPCell(new Paragraph("Speed Report for "+vehicle_number+"",myContentStyle));
     
		cell.setColspan(3);
		table.addCell(cell); */
    table.addCell(new Paragraph("Date",heading_style));
    table.addCell(new Paragraph("Time",heading_style));
    table.addCell(new Paragraph("Speed(Km/hr)",heading_style));
    table.setHeaderRows(1);
    /* DBTransaction dbtranobj=new DBTransaction();
	Connection connection=dbtranobj.connect();
	ResultSet rs = null;
	Statement st=null;
	st=connection.createStatement(); */
    //Class.forName("org.postgresql.Driver").newInstance();
    //Connection con = DriverManager.getConnection("jdbc:postgresql://182.72.167.34:5432/master_database","postgres", "postgres");
     rs = st.executeQuery("SELECT tracking.latitude_value,tracking.longitude_value,tracking.mile,tracking.date_time FROM public.tracking WHERE tracking.imei_no ='"+imeinumber+"' and date_time>='"+startdate+"' and date_time<='"+enddate+"'");


//int i=0; 
//int count = 0;
while(rs.next()){ 

String date_time = rs.getString("date_time");

//String vehicle_no = rs.getString("vehicle_number");
//String location=rs.getString("mile");
/* String fuel = rs.getString("fuel"); */
String speed=rs.getString("mile");
String date_in_db=date_time.substring(0,10);
String day=date_in_db.substring(8,10);
String month=date_in_db.substring(6, 7);
String year=date_in_db.substring(0,4);
String hr=date_time.substring(11,13);
String min=date_time.substring(14,16);
int hour = Integer.parseInt(hr);
if( hour > 12){
	am_pm = "PM";
	hour = hour - 12;
	if(hour < 10){
		fin_hr = "0"+hour;
	}else{ fin_hr = ""+hour; }
	time = fin_hr + ":"+min+" "+am_pm;
}
else{ 
	am_pm = "AM";
	if(hour < 10){
		fin_hr = "0"+hour;
	}else{ fin_hr = ""+hour; }
	
	time = fin_hr + " : "+min+" "+am_pm;
}
date=day+"-"+month+"-"+year;
System.out.println("Date "+day+" "+month+" "+year);
System.out.println("Time "+time);
float speed_from_db = Float.parseFloat(speed);
double one_mile = 1609.344;


double calculated_speed_value = ((speed_from_db)*(one_mile));
  	   table.addCell(new Paragraph(date,data_style));
  	   table.addCell(new Paragraph(time,data_style));
  	   table.addCell(new Paragraph(speed,data_style));
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
	

    
    
}
%>
</body>
</html>
