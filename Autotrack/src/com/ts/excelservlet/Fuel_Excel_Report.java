package com.ts.excelservlet;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.hssf.util.Region;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;

import com.ts.dbtransactionmgr.DBTransaction;



/**
 * Servlet implementation class Fuel_Excel_Report
 */
@WebServlet("/Fuel_Excel_Report")
public class Fuel_Excel_Report extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Fuel_Excel_Report() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		DBTransaction dbtranobj=new DBTransaction();
		System.out.println("Success");
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
		double last_fuel_value_before_engine_stop=0.0;
		int counter=0,engine_start=0;
		String vehiclenumber="";
		String vehicle_number=""; 
		String am_pm;
	      String ses_hour;String date;
	      String fin_hr;String time;

int index=2;
	
		OutputStream out = null;
		try{
			response.setContentType("application/vnd.ms-excel");
			   response.setHeader("Content-Disposition", "attachment; filename=fuel_grid.xls");
			   Connection con=dbtranobj.connect();
			   
			  // Class.forName("org.postgresql.Driver").newInstance();
			   //conn = DriverManager.getConnection("jdbc:postgresql://182.72.167.34:5432/master_database","postgres", "postgres");
			   ResultSet rs = null;
			   Statement st=null;
			   st=con.createStatement();
			   
			   
			   
			   rs = st.executeQuery("SELECT vehicle_number from vehicle_information where imei_no='"+imeinumber+"'");
			    if(rs.next())
			    {
			    	 vehicle_number = rs.getString("vehicle_number");
			    	
			    }
				
	
		rs = st.executeQuery("SELECT empty_fuel_voltage,full_fuel_voltage,fuel_tank_capacity from vehicle_information where imei_no='"+imeinumber+"'");
		if(rs.next())
		{
			empty_fuel_voltage=(Double.parseDouble(rs.getString(1)));
			full_fuel_voltage=(Double.parseDouble(rs.getString(2)));
			fuel_tank_capacity=(Double.parseDouble(rs.getString(3)));
			System.out.println(fuel_tank_capacity);
		}
		rs = st.executeQuery("SELECT latitude_value,longitude_value,fuel,date_time FROM tracking WHERE imei_no ='"+imeinumber+"' and date_time>='"+startdate+"' and date_time<='"+enddate+"'");
		 if(rs.next())
		{
			first_good_fuel_value_double= (Double.parseDouble(rs.getString("fuel")));
			current_good_fuel_value= (Double.parseDouble(rs.getString("fuel")));
			System.out.println("first_good="+first_good_fuel_value_double);
		} 
		 //Heading
		 
		 	HSSFWorkbook wb = new HSSFWorkbook();
		   HSSFSheet sheet = wb.createSheet("Fuel sheet");
		   
		   sheet.addMergedRegion(new Region(0,(short)0,0,(short)1));
		   sheet.addMergedRegion(new Region(0,(short)0,0,(short)2));
		   /*sheet.addMergedRegion(new Region(0,(short)0,0,(short)3));
		   sheet.addMergedRegion(new Region(0,(short)0,0,(short)4));
		   sheet.addMergedRegion(new Region(0,(short)0,0,(short)5));*/
		   
		   
		   /*CellStyle cs = wb.createCellStyle();
		   Font f = wb.createFont();
		   f.setBoldweight(Font.BOLDWEIGHT_BOLD);
		   cs.setFont(f);
		   sheet.setDefaultColumnStyle(0,cs);*/
		   
		   
		   HSSFRow rowhead = sheet.createRow((short)0);
		   rowhead.setHeight((short)500);
		   /*rowhead.createCell((short) 0).setCellValue("Fuel Information For " +vehicle_number);
		    * */
		   HSSFCell cell2B = rowhead.createCell(0);  
	        cell2B.setCellValue(new HSSFRichTextString("Fuel Information For " +vehicle_number));  
	  
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
		   cell.setCellValue("DATE");
		   sheet.setColumnWidth(0, 7000);
		  // rowhead.createCell((short) 0).setCellValue("Date");
		   Cell cell1 = rowhead1.createCell((short) 1);
		   cell1.setCellStyle(cellStyle1); 
		   cell1.setCellValue("TIME");
		   sheet.setColumnWidth(1, 7000);
		   Cell cell2 = rowhead1.createCell((short) 2);
		   cell2.setCellStyle(cellStyle1); 
		   cell2.setCellValue("FUEL IN LITRES");
		   sheet.setColumnWidth(2, 7000);
	        
	         // HSSFRow rowhead1 = sheet.createRow((short)2);
	        //rowhead1.createCell((short) 0).setCellValue("Date");
		  // rowhead1.createCell((short) 1).setCellValue("Time");
		   //rowhead.createCell((short) 2).setCellValue("Fuel In Voltage");
		   //rowhead1.createCell((short) 2).setCellValue("Fuel In Litres");
		   //rowhead1.setRowStyle(cellStyle);
		 
		 
		while(rs.next()){ 
		String date_time = rs.getString("date_time");
		String latitude = rs.getString("latitude_value"); 
		String longitude = rs.getString("longitude_value");
		fuel_from_db=(Double.parseDouble(rs.getString("fuel")));

		String date_in_db=date_time.substring(0,10);
		String day=date_in_db.substring(8,10);
		String month=date_in_db.substring(5, 7);
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
	  
		System.out.println("from db"+fuel_from_db);
		if(fuel_from_db==0.00)
		{
			if(counter==0)
			{
				HSSFRow row = sheet.createRow((short)index);
				row.setHeight((short)500);
				   row.createCell((short)0).setCellValue(date);
				   row.createCell((short)1).setCellValue(time);
			     //	   row.createCell((short)2).setCellValue(current_good_fuel_value);
				   row.createCell((short)2).setCellValue("Engine Is Off");
				
				
			}
			counter++;
			first_good_fuel_value_double= fuel_from_db;//engine is still off
		}
		 else if((fuel_from_db>=empty_fuel_voltage) && (fuel_from_db<=full_fuel_voltage))
	     {

	     	if(first_good_fuel_value_double==0.00)
	     	{
	     		if(!(engine_start>4))//after engine start just remove 5 transcation
	     		{
	     			engine_start++;
	     			System.out.println("skipping");
	     			continue;
	     		}
	     		//engine_start++;
	     		last_fuel_value_before_engine_stop=current_good_fuel_value;
	     		System.out.println("last value= "+last_fuel_value_before_engine_stop);
	     		/* if(last_fuel_value_before_engine_stop==0)
	     		{
	     			current_good_fuel_value=fuel_from_db;
	     			//System.out.println("current_good after engine start="+current_good_fuel_value);
	     			first_good_fuel_value_double=fuel_from_db;
	     		} */
	     		if((fuel_from_db>=last_fuel_value_before_engine_stop+1))//if they pour fuel in bulk ammount
	     		{
	     			current_good_fuel_value=fuel_from_db;
	     			//System.out.println("current_good after engine start and pour fuel="+current_good_fuel_value);
	     			first_good_fuel_value_double=fuel_from_db;
	     		}
	     		  else if(fuel_from_db<=last_fuel_value_before_engine_stop-1)//if they theft fuel from tank
	     		{
	     			current_good_fuel_value=fuel_from_db;
	     			//System.out.println("current_good after engine start and theft fuel="+current_good_fuel_value);
	     			first_good_fuel_value_double=fuel_from_db;
	     		}  
	     		else if((fuel_from_db<=last_fuel_value_before_engine_stop) && (fuel_from_db>=last_fuel_value_before_engine_stop-0.05))
	     		{
	     			current_good_fuel_value=fuel_from_db;
	     			//System.out.println("current_good after engine start="+current_good_fuel_value);
	     			first_good_fuel_value_double=fuel_from_db;
	     		}
	     		else
	     			continue;
	     		//first_good_fuel_value_double=fuel_from_db;//it become new voltage after engine start
	     		
	     		
	     	}
	     	//if(fuel_from_db>first_good_fuel_value_double)
	     	if((fuel_from_db<=current_good_fuel_value) && (fuel_from_db>=current_good_fuel_value-0.10))
	     	{
	     		current_good_fuel_value=fuel_from_db;	
	     		String current_fuel_val=String.valueOf(current_good_fuel_value);

	     		System.out.println("current_good="+current_good_fuel_value);
	     	//maximum_fuel_value = 0.5;
	     	calculated_fuel_value = ((current_good_fuel_value - empty_fuel_voltage)/(full_fuel_voltage - empty_fuel_voltage))*100;
	     	fuel_in_liters = (calculated_fuel_value/100)*fuel_tank_capacity;
	     	fuel_in_liters=Math.round(fuel_in_liters*100.0)/100.0;	
	     	fuel_in_ltr=""+fuel_in_liters+" ";
	     	counter=0;		
				   HSSFRow row = sheet.createRow((short)index);
				   row.setHeight((short)500);
				   row.createCell((short)0).setCellValue(date);
				   row.createCell((short)1).setCellValue(time);
			     //	   row.createCell((short)2).setCellValue(current_good_fuel_value);
				   row.createCell((short)2).setCellValue(fuel_in_ltr);
				   index++;
				   System.out.println("Index:"+index);
				}//if +0.10
			}//else if
		//count++;
		
		  
		
		}//while
		
		out=response.getOutputStream();
		   wb.write(out);
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
		   if (out != null)
		    out.close();
		  }
		
		
		

	}
}
