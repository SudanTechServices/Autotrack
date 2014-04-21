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
		    <%@ page import="java.util.List" %>	  
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
		    <%@ page import="com.ts.domain.Halt_time;" %>
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>trip report excel</title>
	</head>
	<body>
	
		<%
		
		
		DBTransaction dbtranobj=new DBTransaction();
		System.out.println("Success");		
		String startdate = request.getParameter("startdate");
		System.out.println("Start Date1   "+startdate);
		String enddate = request.getParameter("enddate"); 
		System.out.println("End Date1    "+enddate); 
		String imeinumber = request.getParameter("imeinumber");
	    System.out.println("IMEI"+imeinumber);
		String latitude = null;
		String longitude = null;
		int offcounter=0,oncounter=0;
		String vehicle_number=""; 
		int hrs =0;
		int mins =0;
		
		 String am_pm;
	      String ses_hour;String date;
	      String fin_hr;String time;
			int index=2;
	
		OutputStream output = null;
		 ResultSet rs = null;
		   Statement st=null;
		   Connection con=null;
		try{
			response.setContentType("application/vnd.ms-excel");
			   response.setHeader("Content-Disposition", "attachment; filename=trip_report_grid.xls");
			   con=dbtranobj.connect();
			   
			  // Class.forName("org.postgresql.Driver").newInstance();
			   //conn = DriverManager.getConnection("jdbc:postgresql://182.72.167.34:5432/master_database","postgres", "postgres");
			  
			   st=con.createStatement();
			   
			   
			   
			   rs = st.executeQuery("SELECT vehicle_number from vehicle_information where imei_no='"+imeinumber+"'");
			    if(rs.next())
			    {
			    	 vehicle_number = rs.getString("vehicle_number");
			    	
			    }
				
	
	
		 //Heading
		 
		 	HSSFWorkbook wb = new HSSFWorkbook();
		   HSSFSheet sheet = wb.createSheet("Trip Report");		   
		   sheet.addMergedRegion(new Region(0,(short)0,0,(short)1));
		   sheet.addMergedRegion(new Region(0,(short)0,0,(short)2));
		   sheet.addMergedRegion(new Region(0,(short)0,0,(short)3));
		   /*Ssheet.addMergedRegion(new Region(0,(short)0,0,(short)4));
		   sheet.addMergedRegion(new Region(0,(short)0,0,(short)5));*/
		   
		   
		  
		   
		   
		   HSSFRow rowhead = sheet.createRow((short)0);
		   rowhead.setHeight((short)500);
		   /*rowhead.createCell((short) 0).setCellValue("Fuel Information For " +vehicle_number);
		    * */
		   
		   HSSFCell cell2B = rowhead.createCell(0);  
	        cell2B.setCellValue(new HSSFRichTextString("Trip Report Information For " +vehicle_number));  
	 // System.out.println("Row 0");
	        // Style Font in Cell 2B  
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
	        
	        
		   cell.setCellValue("Start Position");
		   sheet.setColumnWidth(0, 7000);
		  // rowhead.createCell((short) 0).setCellValue("Date");
		   Cell cell1 = rowhead1.createCell((short) 1);
		   cell1.setCellStyle(cellStyle1); 
		   cell1.setCellValue("Start Time");
		   sheet.setColumnWidth(1, 7000);
		   Cell cell2 = rowhead1.createCell((short) 2);
		   cell2.setCellStyle(cellStyle1); 
		   cell2.setCellValue("Halt Position");
		   sheet.setColumnWidth(2, 7000);
		   Cell cell3 = rowhead1.createCell((short) 3);
		   cell3.setCellStyle(cellStyle1);
		   cell3.setCellValue("Stoped At");
		   sheet.setColumnWidth(3, 7000);
		   
		   Cell cell4 = rowhead1.createCell((short) 4);
		   cell4.setCellStyle(cellStyle1);
		   cell4.setCellValue("Stoped At");
		   sheet.setColumnWidth(4, 7000);
		   
		   Cell cell5 = rowhead1.createCell((short) 5);
		   cell5.setCellStyle(cellStyle1);
		   cell5.setCellValue("Distance");
		   sheet.setColumnWidth(5, 7000);
		   
		   
	      //  System.out.println("Row 1");
	         // HSSFRow rowhead1 = sheet.createRow((short)2);
	        //rowhead1.createCell((short) 0).setCellValue("Date");
		  // rowhead1.createCell((short) 1).setCellValue("Time");
		   //rowhead.createCell((short) 2).setCellValue("Fuel In Voltage");
		   //rowhead1.createCell((short) 2).setCellValue("Fuel In Litres");
		   //rowhead1.setRowStyle(cellStyle);
		 
	        
		  
					 
					 
						
						 List<Halt_time> ht = (List<Halt_time>)request.getAttribute("halt_time_record"); 
						 for(Halt_time h : ht)
							{  
							 String hr = h.getHalt_time();
						 	    String[] token=  hr.split(" ");
						 	           if(!token[0].equals("Stoped")){		  
						 		       		hrs = Integer.parseInt(token[0]);
						 	    			 mins =Integer.parseInt(token[2]);
						 		  
						 	             }
						 	          HSSFRow row = sheet.createRow((short)index);
										row.setHeight((short)500);	
						 	          if(hrs > 2 || (hrs==2 && mins>30) ){
						 	        		
										   row.createCell(0).setCellValue(h.getPlace());										   
										   row.createCell(1).setCellValue(h.getStart_time());
										   row.createCell(2).setCellValue(h.getHalt_position());
										   row.createCell(3).setCellValue(h.getStoped_at());
										 //  row.createCell((short)4).setCellValue(h.getHalt_time());
										 	Cell cel = row.createCell(4);
							   				cel.setCellStyle(cellStyle1); //------------Content Style-----------------//
							   				cel.setCellValue(h.getHalt_time());
										   row.createCell(5).setCellValue(h.getDistance());
										   index++;					 	        			
					 	        		 }	
						 	          else{
										   row.createCell(0).setCellValue(h.getPlace());
										   row.createCell(1).setCellValue(h.getStart_time());
										   row.createCell(2).setCellValue(h.getHalt_position());
										   row.createCell(3).setCellValue(h.getStoped_at());
										   row.createCell(4).setCellValue(h.getHalt_time());
										   row.createCell(5).setCellValue(h.getDistance());
										   index++;
										   System.out.println("INDEX VAL "+index);
									 	   }
							} 
						  /* HSSFRow row = sheet.createRow((short)index);
							row.setHeight((short)500);		
						   row.createCell((short)0).setCellValue(date);
						   row.createCell((short)1).setCellValue(time);
						   row.createCell((short)2).setCellValue("Engine Is Off");
						   index++;*/
					
				
				  // System.out.println("Row 2");
				/*index++;
				System.out.println("Index:"+index);*/
				
				HSSFRow row1 = sheet.createRow((short)index+1);
				row1.setHeight((short)300);
				
				Cell cell10=	row1.createCell(0);
				cell10.setCellValue("Total Distance Travelled");  
				cell10.setCellStyle(cellStyle1);
				    
				Cell cell20=row1.createCell(1);
				cell20.setCellValue(request.getParameter("totalDistance"));
				cell20.setCellStyle(cellStyle1);
				
				
				HSSFRow row2 = sheet.createRow((short)index+2);
				row2.setHeight((short)300);
				
				Cell cell12=	row2.createCell(0);
				cell12.setCellValue("Total Spend Time");  
				cell12.setCellStyle(cellStyle1);
				    
				Cell cell13=row2.createCell(1);
				cell13.setCellValue((String)session.getAttribute("totalSpendTime"));
				cell13.setCellStyle(cellStyle1);
				
				HSSFRow row3 = sheet.createRow((short)index+3);
				row3.setHeight((short)300);
				Cell cell15=	row3.createCell(0);
				cell15.setCellValue("Total Halt Time");  
				cell15.setCellStyle(cellStyle1);
				    
				Cell cell14=row3.createCell(1);
				cell14.setCellValue((String)session.getAttribute("totalHalt"));
				cell14.setCellStyle(cellStyle1);
				
				HSSFRow row4 = sheet.createRow((short)index+4);
				row4.setHeight((short)300);
				Cell cell16=	row4.createCell(0);
				cell16.setCellValue("Total Travelled Time");  
				cell16.setCellStyle(cellStyle1);
				    
				Cell cell17=row4.createCell(1);
				cell17.setCellValue((String)session.getAttribute("totalTravelled"));
				cell17.setCellStyle(cellStyle1);
		
		
		output=response.getOutputStream();
		   wb.write(output);
		}
		catch(SQLException e){ System.err.println(e.getMessage()); } catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		  finally{
		   if (output != null && con!=null)
		    output.close();
		   con.close();
		   st.close();
		   rs.close();
		  }
		
		
		
		%>
	
	</body>
	</html>