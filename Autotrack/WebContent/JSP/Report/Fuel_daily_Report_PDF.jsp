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
 String imeinumber = request.getParameter("imeinumber");
//String startdate = request.getParameter("start_date");
//String enddate = request.getParameter("end_date");
//System.out.println(startdate);
DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//Calendar cal = Calendar.getInstance();
//String Current_time = dateFormat.format(cal.getTime());
String strdate = dateFormat.format(new Date());
strdate = strdate.substring(0,10);
String enddate = dateFormat.format(new Date());
String startdate = strdate+" 00:00:00";
   
   System.out.println(startdate);
   System.out.println(enddate);

System.out.println("imei" + imeinumber);
String vehicle_number = null;
double fuel_from_db=0.00;
double first_good_fuel_value_double=0.00;
double current_good_fuel_value=0.00;
double empty_fuel_voltage = 0.0;
double full_fuel_voltage=0.0;
double fuel_tank_capacity=0.0;
double calculated_fuel_value = 0.0;
double fuel_in_liters =0.0;
int counter=0;
String am_pm;
String ses_hour;String date;
String fin_hr;String time;
String fuel_in_ltr=null;
response.setContentType("application/pdf");
String filename="fuel_daily_report.pdf";
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
    
    
    Paragraph paragraph1=new Paragraph("Fuel Daily Report for : "+vehicle_number+"",myContentStyle);
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
	
    
     PdfPTable table=new PdfPTable(4);
   
     
     //PdfPCell imgcell = new PdfPCell(image);
     //imgcell.setColspan(4);
     //table.addCell(imgcell); 

    /*  PdfPCell cell = new0 PdfPCell(new Paragraph("Fuel Daily Report for : "+vehicle_number+"",myContentStyle));
     
		cell.setColspan(4);
		table.addCell(cell); */
		table.addCell(new Paragraph("Date",heading_style));
	    table.addCell(new Paragraph("Time",heading_style));
	    table.addCell(new Paragraph("Fuel Voltage",heading_style));
	    table.addCell(new Paragraph("Fuel In Liters",heading_style));
	    table.setHeaderRows(1);
	  
	   
    //Class.forName("org.postgresql.Driver").newInstance(); 
    //Connection con = DriverManager.getConnection("jdbc:postgresql://182.72.167.34:5432/master_database","postgres", "postgres");
     
	 rs = st.executeQuery("SELECT empty_fuel_voltage,full_fuel_voltage,fuel_tank_capacity from vehicle_information where imei_no='"+imeinumber+"';");
     if(rs.next())
     {
     	empty_fuel_voltage=(Double.parseDouble(rs.getString(1)));
     	full_fuel_voltage=(Double.parseDouble(rs.getString(2)));
     	fuel_tank_capacity=(Double.parseDouble(rs.getString(3)));
     	
     }
     rs = st.executeQuery("SELECT vehicle_information.vehicle_number,tracking.latitude_value,tracking.longitude_value,tracking.fuel,tracking.date_time FROM public.vehicle_information,public.tracking WHERE vehicle_information.imei_no = tracking.imei_no and tracking.imei_no ='"+imeinumber+"'and date_time>='"+startdate+"' and date_time<='"+enddate+"'");
     if(rs.next())
    {
    	first_good_fuel_value_double= (Double.parseDouble(rs.getString("fuel")));
    	current_good_fuel_value= (Double.parseDouble(rs.getString("fuel")));
    	System.out.println("first_good="+first_good_fuel_value_double);
    } 
    while(rs.next()){ 
    	
    String date_time = rs.getString("date_time");
    String latitude = rs.getString("latitude_value"); 
    String longitude = rs.getString("longitude_value");
    vehicle_number = rs.getString("vehicle_number");
    fuel_from_db=(Double.parseDouble(rs.getString("fuel")));
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
     String fuel_val=String.valueOf(fuel_from_db);
     System.out.println("String:"+fuel_val);
     System.out.println("from db"+fuel_from_db);
     if(fuel_from_db==0.00)
     {
     	
     	if(counter==0)
     	{
     
     		table.addCell(new Paragraph(date,data_style));
      	   table.addCell(new Paragraph(time,data_style));
      	   table.addCell(new Paragraph(fuel_val,data_style));
      	   table.addCell(new Paragraph("Engine is Off",data_style));
     
     	}
     	counter++;
     	first_good_fuel_value_double= fuel_from_db;//engine is still off
     }
     else if((fuel_from_db>=full_fuel_voltage) && (fuel_from_db<=empty_fuel_voltage))
     	{
     		if(first_good_fuel_value_double==0.00)
     		{
     			
     			//first_good_fuel_value_double=fuel_from_db;//it become new voltage after engine start
     			current_good_fuel_value=fuel_from_db;
     			System.out.println("current_good after engine start="+current_good_fuel_value);
     			first_good_fuel_value_double=fuel_from_db;
     			
     		}
     		//if(fuel_from_db>first_good_fuel_value_double)
     		if((fuel_from_db>=current_good_fuel_value) && (fuel_from_db<=current_good_fuel_value+0.10))
     		{
     			current_good_fuel_value=fuel_from_db;
     			String current_fuel_val=String.valueOf(current_good_fuel_value);
     			System.out.println("current_good="+current_good_fuel_value);
     			System.out.println("Current fuel val in String"+current_fuel_val);
     		//maximum_fuel_value = 0.5;
     		calculated_fuel_value = ((current_good_fuel_value - empty_fuel_voltage)/(full_fuel_voltage - empty_fuel_voltage))*100;
     		fuel_in_liters = (calculated_fuel_value/100)*fuel_tank_capacity;
     		fuel_in_liters=Math.round(fuel_in_liters*100.0)/100.0;
     		fuel_in_ltr=""+fuel_in_liters+" ";
     		counter=0;
     		table.addCell(new Paragraph(date,data_style));
	       	table.addCell(new Paragraph(time,data_style));
	       	table.addCell( new Paragraph(current_fuel_val,data_style));
	       	table.addCell(new Paragraph(fuel_in_ltr,data_style));
     	
     
     	
     	
     	}//if +0.10
     	}//else if
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
rs.close();
st.close();
}
// FOR LINUX...............................................................................................




catch(Exception e)
{

}
%>
</body>
</html>
	

