	<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	    pageEncoding="ISO-8859-1"%>
	    <%@ page import="java.io.IOException" %>
	    <%@ page import="java.io.OutputStream" %>
	    <%@ page import="java.sql.Connection" %>
	    <%@ page import="java.sql.ResultSet" %>
	    <%@ page import="java.sql.SQLException" %>
	    <%@ page import="java.sql.Statement" %>
	    <%@ page import="java.text.DateFormat" %>
	    <%@ page import="java.text.ParseException" %>
	    <%@ page import="java.text.SimpleDateFormat" %>
	    <%@ page import="java.util.Date" %>
	    <%@ page import="javax.servlet.ServletException" %>	    
	    <%@ page import="javax.servlet.http.HttpServlet" %>
	    <%@ page import="javax.servlet.http.HttpServletRequest" %>
	    <%@ page import="javax.servlet.http.HttpServletResponse" %>
	    
	    <%@ page import="org.apache.poi.hssf.usermodel.HSSFCell" %>
	    <%@ page import="org.apache.poi.hssf.usermodel.HSSFCellStyle" %>
	    <%@ page import="org.apache.poi.hssf.usermodel.HSSFFont" %>
	    <%@ page import="org.apache.poi.hssf.usermodel.HSSFRichTextString" %>
	    <%@ page import="org.apache.poi.hssf.usermodel.HSSFRow" %>
	    <%@ page import="org.apache.poi.hssf.usermodel.HSSFSheet" %>
	    <%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook" %>
	    <%@ page import="org.apache.poi.hssf.util.HSSFColor" %>
	    <%@ page import="org.apache.poi.hssf.util.Region" %>
	    <%@ page import="org.apache.poi.ss.usermodel.Cell" %>
	    <%@ page import="com.ts.dbtransactionmgr.DBTransaction" %>
	    <%@ page import="com.ts.excelservlet.Excel_Consolidated_Trip_report" %>

	
	
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Engine Report Excel</title>
	</head>
	<body>
	<%
	
	
	DBTransaction dbtranobj=new DBTransaction();	
	String startdate = request.getParameter("startdate");
	System.out.println("Start Date1   "+startdate);
	String enddate = request.getParameter("enddate"); 
	System.out.println("End Date1    "+enddate); 
	String imeinumber = request.getParameter("imeinumber");
    System.out.println("IMEI"+imeinumber);
    String input_halt =request.getParameter("input_halt_time");
    
    int input_halt_time =Integer.parseInt(input_halt);
    String Start_Address =null;
    String start_latlng =null;
	int offcounter=0,oncounter=0;
	String vehicle_number=""; 
	String am_pm;
    String date;
    String fin_hr;String time;
    int index=2;
	OutputStream output = null;	
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
	//int noofid = -1;
	//int counter=1;
	 ResultSet rs = null;
	 Statement st=null;
	 Connection con=null;
	try{
		   response.setContentType("application/vnd.ms-excel");
		   response.setHeader("Content-Disposition", "attachment; filename=engine_status_grid.xls");
		   con=dbtranobj.connect();			  
		  
		   st=con.createStatement();
		   rs = st.executeQuery("SELECT vehicle_number from vehicle_information where imei_no='"+imeinumber+"'");
		    if(rs.next())
		    {
		    	 vehicle_number = rs.getString("vehicle_number");
		    	
		    }
			
	 //Heading
	 
	   HSSFWorkbook wb = new HSSFWorkbook();
	   HSSFSheet sheet = wb.createSheet("Engine Status Report");		   
	   sheet.addMergedRegion(new Region(0,(short)0,0,(short)1)); 	//return type int
	   sheet.addMergedRegion(new Region(0,(short)0,0,(short)2));
	   HSSFRow rowhead = sheet.createRow((short)0);
	   rowhead.setHeight((short)500);		   
	   HSSFCell cell2B = rowhead.createCell(0);  
       cell2B.setCellValue(new HSSFRichTextString("Engine Status Information For " +vehicle_number));  	        
        HSSFCellStyle cellStyle = wb.createCellStyle();
        cellStyle = wb.createCellStyle();  
        HSSFFont hSSFFont = wb.createFont();  
        hSSFFont.setFontName(HSSFFont.FONT_ARIAL);  
        hSSFFont.setFontHeightInPoints((short) 14);  
        hSSFFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);  
        hSSFFont.setColor(HSSFColor.BLUE.index);  
        cellStyle.setFont(hSSFFont);  
        cell2B.setCellStyle(cellStyle);  
	   HSSFRow rowhead1 = sheet.createRow((short)1);
	   rowhead1.setHeight((short)600);
	   Cell cell = rowhead1.createCell((short) 0);
	   HSSFCellStyle cellStyle1 = wb.createCellStyle();
	   cellStyle1 = wb.createCellStyle(); 
	    HSSFFont hSSFFont1 = wb.createFont();  
        hSSFFont1.setFontName(HSSFFont.FONT_ARIAL);  
        hSSFFont1.setFontHeightInPoints((short) 12);  
        hSSFFont1.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);  
        hSSFFont1.setColor(HSSFColor.BLACK.index); 
        cellStyle1.setFont(hSSFFont1);  
        cell.setCellStyle(cellStyle1); 
	   cell.setCellValue("DATE");
	   sheet.setColumnWidth(0, 7000);
	  // rowhead.createCell((short) 0).setCellValue("Date");
	   Cell cell1 = rowhead1.createCell((short) 1);
	   cell1.setCellStyle(cellStyle1); 
	   cell1.setCellValue("TIME");
	   sheet.setColumnWidth(1, 7000);
	   
	   Cell cell2 = rowhead1.createCell((short) 2);
	   cell2.setCellStyle(cellStyle1); 
	   cell2.setCellValue("ENGINE STATUS");
	   sheet.setColumnWidth(2, 7000);
	   
	   Cell cell3 =rowhead1.createCell(3);
	   cell3.setCellStyle(cellStyle1); 
	   cell3.setCellValue("Place");
	   sheet.setColumnWidth(3, 7000);
	   
	   rs = st.executeQuery("SELECT latitude_value,longitude_value,engine_status,date_time FROM tracking WHERE imei_no ='"+ imeinumber+ "' and date_time>='"+ startdate+ "' and date_time<='" + enddate + "'");
	   						//SELECT tracking.engine_status,tracking.date_time FROM public.tracking WHERE tracking.imei_no ='"+imeinumber+"' and date_time>='"+startdate+"' and date_time<='"+enddate+"'");
while(rs.next()){ 			
	date_time = rs.getString("date_time");
	engine_status = rs.getString("engine_status");
	latitude = rs.getString("latitude_value");
	longitude = rs.getString("longitude_value");
	date_in_db = date_time.substring(0, 10);
	day = date_in_db.substring(8, 10);
	month = date_in_db.substring(6, 7);
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
			
			
			   HSSFRow row = sheet.createRow((short)index);
			   row.setHeight((short)500);		
			   row.createCell(0).setCellValue(date);
			   row.createCell(1).setCellValue(time);
			   row.createCell(2).setCellValue("Engine Is Off");
			   row.createCell(3).setCellValue(Start_Address);
			   index++;
			   System.out.println(latitude+"   "+longitude);
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
					   HSSFRow row = sheet.createRow((short)index);
					   row.setHeight((short)500);		
					   row.createCell(0).setCellValue(date);
					   row.createCell(1).setCellValue(time);
					   row.createCell(2).setCellValue("Engine Is ON");
					   row.createCell(3).setCellValue(Start_Address);
					   index++;
					oncounter++;
					offcounter=0;
				}

			} 
	}// first while
	
	   output=response.getOutputStream();
	   wb.write(output);
	   
	}
	catch(SQLException e){ System.err.println(e.getMessage()); } catch (InstantiationException e) {			
		e.printStackTrace();
	} catch (IllegalAccessException e) {		
		e.printStackTrace();
	} catch (ClassNotFoundException e) {			
		e.printStackTrace();
	} catch (ParseException e) {			
		e.printStackTrace();
	} 
	  finally{
	   if (output != null && con!=null)
		   con.close();
	       rs.close();
	       st.close();
	       output.close();
	  }
	
	
	
	
	
	
	
	
	
	
	%>
	</body>
	</html>