package com.ts.excelservlet;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;

import java.util.Calendar;
import java.util.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

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

import com.ts.dbtransactionmgr.DBTransaction;


/**
 * Servlet implementation class Fuel_Daily_Excel
 */
@WebServlet("/Fuel_Monthly_Excel")
public class Fuel_Monthly_Excel extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Fuel_Monthly_Excel() {
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
		String month_selected = request.getParameter("month_selected").trim();
		System.out.println(month_selected);
		 String month = "01";
   	  int count =1;
   	  int mon = 1;
   	  int lastdate=0;
   	   //imeinumber = request.getParameter("vehicle_number");
   	  
   	     String imeinumber = request.getParameter("imeinumber");
   	     System.out.println(imeinumber);
   	    int index=2;
     	 double fuel_tank_capacity = 0.00;
     	 double empty_fuel_voltage = 0.00;
     	 double full_fuel_voltage = 0.00;
      double fuel_from_db=0.00;
   	  double calculated_current_fuel = 0.0;
   	  double current_fuel = 0.00;
   	  String fuel_in_ltr=null;
   	 OutputStream out = null;
   	 String vehicle_number="";
		
		try{
			response.setContentType("application/vnd.ms-excel");
			   response.setHeader("Content-Disposition", "attachment; filename=fuel_monthly_grid.xls");
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
			   
	
			   rs = st.executeQuery("SELECT empty_fuel_voltage,full_fuel_voltage,fuel_tank_capacity FROM vehicle_information WHERE imei_no ='"+imeinumber+"'");
			   
			   HSSFWorkbook wb = new HSSFWorkbook();
			   HSSFSheet sheet = wb.createSheet("Fuel sheet");
			   
			   sheet.addMergedRegion(new Region(0,(short)0,0,(short)1));
			   sheet.addMergedRegion(new Region(0,(short)0,0,(short)2));
			   /*sheet.addMergedRegion(new Region(0,(short)0,0,(short)3));
			   sheet.addMergedRegion(new Region(0,(short)0,0,(short)4));
			   sheet.addMergedRegion(new Region(0,(short)0,0,(short)5));
			   */
			   
			   
			   HSSFRow rowhead = sheet.createRow((short)0);
			   rowhead.setHeight((short)500);
			   
			   
			   
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
			   cell1.setCellValue("FUEL IN VOLTAGE");
			   sheet.setColumnWidth(1, 7000);
			   Cell cell2 = rowhead1.createCell((short) 2);
			   cell2.setCellStyle(cellStyle1); 
			   cell2.setCellValue("FUEL IN LITRES");
			   sheet.setColumnWidth(2, 7000);
			 
			   
	    	  	while(rs.next()){ 
	    	  	  	 
	    	  		  empty_fuel_voltage = (Double.parseDouble(rs.getString(1)));
	    	  	      full_fuel_voltage = (Double.parseDouble(rs.getString(2)));
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
	    	    System.out.println(day);
	    	    
	    	  rs = st.executeQuery("SELECT fuel FROM tracking WHERE imei_no ='"+imeinumber+"' and date_time>='"+mon+"-"+count+"-2012 09:00:00' and date_time<='"+mon+"-"+count+"-2012 20:00:00' and fuel>'0.00' order by date_time desc limit 1");
	    	  
	    	  if(rs.next()){ 
	    	 
	    	  fuel_from_db=(Double.parseDouble(rs.getString("fuel")));
		
		    	  		calculated_current_fuel = (fuel_from_db - empty_fuel_voltage)/(full_fuel_voltage - empty_fuel_voltage)*100;
		  	            current_fuel = (calculated_current_fuel/100)*fuel_tank_capacity;
		  	            current_fuel = Math.round(current_fuel*100.0)/100.0;
		  	            fuel_in_ltr=""+current_fuel+" ";
		  	            
		  	            HSSFRow row = sheet.createRow((short)index);
		  	            row.setHeight((short)500);
					   row.createCell((short)0).setCellValue(day);
					   row.createCell((short)1).setCellValue(fuel_from_db+" V");
				     //	   row.createCell((short)2).setCellValue(current_good_fuel_value);
					   row.createCell((short)2).setCellValue(fuel_in_ltr);
					   index++;
					   System.out.println("Index:"+index);
	    	  }  
	    	  System.out.println("for loop ends");
	    	  }
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
