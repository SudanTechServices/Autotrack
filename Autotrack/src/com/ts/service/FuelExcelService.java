package com.ts.service;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

public class FuelExcelService extends CommonService{
	
	public void run() throws ServletException, IOException {

	
			
			String imeinumber = request.getParameter("imeinumber");
		     System.out.println(imeinumber);
			String startdate = request.getParameter("startdate");
			System.out.println("Start Date:"+startdate);
			String enddate = request.getParameter("enddate"); 
			String fuel_in_ltr=null;

			int count = 0;
			//String imeinumber = request.getParameter("vehicle_number");
			double array_of_fuel[]=new double[10];
			//String startdate = request.getParameter("start_date");
			//String enddate = request.getParameter("end_date");
			double fuel_from_db=0.00;
			double first_good_fuel_value_double=0.00;
			double current_good_fuel_value=0.00;
			double empty_fuel_voltage = 0.0;
			double full_fuel_voltage=0.0;
			double fuel_tank_capacity=0.0;
			double calculated_fuel_value = 0.0;
			double fuel_in_liters =0.0;
			int counter=0;
			String vehiclenumber="";

	int index=1;
			System.out.println("************** doGet ************");
			OutputStream out = null;
			  try {
			   response.setContentType("application/vnd.ms-excel");
			   response.setHeader("Content-Disposition", "attachment; filename=sampleName.xls");
			   Connection conn = null;
			   Class.forName("org.postgresql.Driver").newInstance();
			   conn = DriverManager.getConnection("jdbc:postgresql://182.72.167.34:5432/master_database","postgres", "postgres");
			   ResultSet rs = null;
			   Statement st=null;
			   st=conn.createStatement();
			   HSSFWorkbook wb = new HSSFWorkbook();
			   System.out.println("In fuel excel");
			   HSSFSheet sheet = wb.createSheet("new sheet");
			   HSSFRow rowhead = sheet.createRow((short)0);
			   rowhead.createCell((short) 0).setCellValue("Date");
			   rowhead.createCell((short) 1).setCellValue("Time");
			   rowhead.createCell((short) 2).setCellValue("Fuel Voltage");
			   rowhead.createCell((short) 3).setCellValue("Fuel in Litres");
			   //rs = st.executeQuery("select * from tracking where imei_no='"+imeinumber+"' and  date_time >='"+startdate+"' and date_time <='"+enddate+"' ");
			   rs = st.executeQuery("SELECT empty_fuel_voltage,full_fuel_voltage,fuel_tank_capacity,vehicle_number from vehicle_information where imei_no='"+imeinumber+"'");
			   if(rs.next())
			   {
			   	empty_fuel_voltage=(Double.parseDouble(rs.getString(1)));
			   	full_fuel_voltage=(Double.parseDouble(rs.getString(2)));
			   	fuel_tank_capacity=(Double.parseDouble(rs.getString(3)));
			   	vehiclenumber=rs.getString(4);
			   }
			   rs = st.executeQuery("SELECT tracking.latitude_value,tracking.longitude_value,tracking.fuel,tracking.date_time FROM public.tracking WHERE tracking.imei_no ='"+imeinumber+"' and date_time>='"+startdate+"' and date_time<='"+enddate+"'");
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
			   fuel_from_db=(Double.parseDouble(rs.getString("fuel")));

			   String date=date_time.substring(0,10);
			   String time=date_time.substring(10,19);
			   System.out.println("from db"+fuel_from_db);
			   
			   
			   if(fuel_from_db==0.00)
			   {
			   	
			   	if(counter==0)
			   	{
			   		
			   
			   for(int i =0; i<32800;i++)
			   {
				  
				   while(rs.next()){
					   date_time=rs.getString("date_time");
			    	   date=date_time.substring(0,10);
			    	   time=date_time.substring(10,19);
			    	   String speed=rs.getString("mile");
					   HSSFRow row = sheet.createRow((short)index);
					   row.createCell((short)0).setCellValue(date);
					   row.createCell((short)1).setCellValue(time);
					   row.createCell((short)2).setCellValue(speed);
					  
					   
					   System.out.println("Row :"+i);
					   }
				  // row.createCell((short)0).setCellValue("Samantha");
	   
			   }
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
						System.out.println("current_good="+current_good_fuel_value);
					//maximum_fuel_value = 0.5;
					calculated_fuel_value = ((current_good_fuel_value - empty_fuel_voltage)/(full_fuel_voltage - empty_fuel_voltage))*100;
					fuel_in_liters = (calculated_fuel_value/100)*fuel_tank_capacity;
					fuel_in_liters=Math.round(fuel_in_liters*100.0)/100.0;
					fuel_in_ltr=""+fuel_in_liters+" Ltrs.";
					counter=0;
					for(int j =0; j<32800;j++)
					   {
						  
						 
							   HSSFRow row = sheet.createRow((short)index);
							   row.createCell((short)0).setCellValue(date);
							   row.createCell((short)1).setCellValue(time);
							   row.createCell((short)2).setCellValue(current_good_fuel_value);
							   row.createCell((short)3).setCellValue(fuel_in_ltr);
							  
							   
							   System.out.println("Row :"+j);
							   }
						  // row.createCell((short)0).setCellValue("Samantha");
			   
					   }
//			   FileOutputStream fileOut = new FileOutputStream("workbook.xls");
			   out=response.getOutputStream();
			   wb.write(out);
			  
			  } 
			   
			   index++;
			   System.out.println("Index:"+index);
			   
			   
			   }
			  }
			  
			  catch (Exception e){
			   throw new ServletException("Exception in Excel Sample Servlet", e);
			  } 
			  finally{
			   if (out != null)
			    out.close();
			  }
			
			
		}

	

	
	
}
