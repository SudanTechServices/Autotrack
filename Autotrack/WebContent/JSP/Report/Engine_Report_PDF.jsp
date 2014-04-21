<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.lowagie.text.*"%>
<%@page import=" com.lowagie.text.pdf.*"%>
<%@page import="com.ts.dbtransactionmgr.DBTransaction" %>
<%@page import="com.lowagie.text.pdf.PdfReader" %>
<%@page import="java.text.DateFormat" %>
<%@page import="java.text.ParseException" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
<%@page import="com.ts.excelservlet.Excel_Consolidated_Trip_report" %>

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
String Start_Address =null;
String start_latlng =null;
int offcounter=0,oncounter=0;
String vehicle_number=""; 
String am_pm;
String date;
String fin_hr;String time;
int index=2;
OutputStream out1 = null;	
String latitude = null;
String longitude = null;
String date_time, next_date_time;
String engine_status, next_engine_status;		
String date_in_db;
String day;
String month;
String year;
String hr;
String min;
DateFormat df = null;
Date date1 = null, date2 = null;


String startdate = request.getParameter("start_date");
String enddate = request.getParameter("end_date"); 
String timeee = request.getParameter("input_halt_time");
int input_halt_time =Integer.parseInt(timeee);
System.out.println("Timesssssssssssssssss : "+input_halt_time );

System.out.println("Start Date1"+startdate);
System.out.println("End Date1"+enddate);
String imeinumber = request.getParameter("imeinumber");
System.out.println("IMEI1:"+imeinumber);
String ses_hour;

response.setContentType("application/pdf");
String filename="engineStausReport.pdf";

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
		Image image = Image.getInstance("E:/workspace/Autotrack/WebContent/images/PDF_Logo.jpg");
	    image.setAlignment(Element.ALIGN_JUSTIFIED_ALL); 
	    image.setAbsolutePosition(80f, 820f); 	   	    
	    document.add(image);
	    	    
	 	Font myContentStyle=new Font();
	    myContentStyle.setStyle("bold");
	    myContentStyle.setColor(0, 143, 235);
	    myContentStyle.setSize(12);
	    myContentStyle.isBold();
	    
	    float[] widths ={3,3,3,9 };
		   PdfPTable table=new PdfPTable(widths);
	     
	            Paragraph paragraph1=new Paragraph("Engine Status Report for : "+vehicle_number+"",myContentStyle);
	            paragraph1.setSpacingAfter(10);
	        	paragraph1.setIndentationLeft(54);
	        	document.add(paragraph1);
	        	 
	        	
	        	Font heading_style=new Font();
	        	heading_style.setStyle("bold");
	        	heading_style.setFamily("TIMES_ROMAN");
	        	heading_style.setSize(10);
	        	
	        	
	        	Font no_data_style=new Font();	        	
	        	no_data_style.setFamily("TIMES_ROMAN");
	        	no_data_style.setSize(10);
	        	no_data_style.setColor(255, 0, 0);	        	
	       
	        	Font data_style=new Font();	        	
	        	data_style.setFamily("TIMES_ROMAN");
	        	data_style.setSize(10);	     
	    table.addCell(new Paragraph("Date",heading_style));
	    table.addCell(new Paragraph("Time",heading_style));
	    table.addCell(new Paragraph("Engine Status",heading_style));
	    table.addCell(new Paragraph("Address ",heading_style));
	    table.setHeaderRows(1);	   	    
		rs = st.executeQuery("SELECT latitude_value,longitude_value,engine_status,date_time FROM tracking WHERE imei_no ='"+ imeinumber+ "' and date_time>='"+ startdate+ "' and date_time<='" + enddate + "'");

	
	while(rs.next()){ 
		date_time = rs.getString("date_time");
		engine_status = rs.getString("engine_status");
		latitude = rs.getString("latitude_value");
		longitude = rs.getString("longitude_value");
		date_in_db = date_time.substring(0, 10);
		day = date_in_db.substring(8, 10);
		month = date_in_db.substring(5, 7);
		year = date_in_db.substring(0, 4);
		hr = date_time.substring(11, 13);
		min = date_time.substring(14, 16);
		int hour = Integer.parseInt(hr);
		if (hour > 12) {
			am_pm = "PM";
			hour = hour - 12;
			if (hour < 10) {
				fin_hr = "0" + hour;
			} else {
				fin_hr = "" + hour;
			}
			time = fin_hr + ":" + min + " " + am_pm;
		} else {
			am_pm = "AM";
			if (hour < 10) {
				fin_hr = "0" + hour;
			} else {
				fin_hr = "" + hour;
			}

			time = fin_hr + " : " + min + " " + am_pm;
		}
		date = day + "-" + month + "-" + year;
		if (engine_status.equals("0")) {
		
			while (rs.next())//  Difference between Engine on and Engine off
			{								
				next_date_time = rs.getString("date_time");
				next_engine_status = rs.getString("engine_status");
				if (next_engine_status.equals("1")) {
					df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");									
					date1 = df.parse(date_time);
					System.out.println("date1 date vale : " + date1);
					System.out.println("date1 date vale : "+ (int) (Math.abs(date1.getTime()) / 1000));
					date2 = df.parse(next_date_time);
					System.out.println("date2 date vale : "	+ (int) (Math.abs(date2.getTime()) / 1000));
					System.out.println("date1 date vale : " + date2);
					int diff = (int) (Math.abs(date1.getTime()
							- date2.getTime()) / 1000) / 60;
					System.out.println(diff);
					if (diff > input_halt_time ) //if time differece between on and off is greater than given time then shows
					{
						offcounter = 0; //The Engine is on state and the difference is more than 15 min
						
					} else
						offcounter = 1;
					break;
				} else
					continue;
			
			} // second while
			if (offcounter == 0) {
				
				start_latlng = latitude +","+longitude;
				Excel_Consolidated_Trip_report excelObj = new Excel_Consolidated_Trip_report();
				Start_Address = excelObj.getStartAddress(start_latlng);				
		     	   table.addCell(new Paragraph(date,data_style));
		     	   table.addCell(new Paragraph(time,data_style));		     	  		     	
		     	   table.addCell("Engine is on");
		     	   table.addCell(new Paragraph(Start_Address,data_style));
				   index++;
				   //System.out.println(latitude+"   "+longitude);
				   offcounter++;
				   oncounter=0;
					}

				}
		else{ 
				if(oncounter==0)
					{
						start_latlng = latitude +","+longitude;
						Excel_Consolidated_Trip_report excelObj = new Excel_Consolidated_Trip_report();
						Start_Address = excelObj.getStartAddress(start_latlng);						
				     	   table.addCell(new Paragraph(date,data_style));
				     	   table.addCell(new Paragraph(time,data_style));		     	  		     	
				     	   table.addCell("Engine is off");
				     	   table.addCell(new Paragraph(Start_Address,data_style));
				     	   
				     	  index++;
						oncounter++;
						offcounter=0;
					}

				} 
		}// first while
		
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
			     connection.close();
			     rs.close();
			     st.close();
		     }
	
	catch(SQLException e){ System.out.println(e.getMessage()); } %>
	
	
	</body>
	</html> 
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
