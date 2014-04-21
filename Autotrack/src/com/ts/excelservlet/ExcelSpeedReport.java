package com.ts.excelservlet;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
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

import com.ts.dbtransactionmgr.DBTransaction;


/**
 * Servlet implementation class ExcelSpeedReport
 */
@WebServlet("/ExcelSpeedReport")
public class ExcelSpeedReport extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExcelSpeedReport() {
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
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
String imeinumber=request.getParameter("imeinumber");

System.out.println("IMEI : " +imeinumber);

String vehicle_number="";
int index=2;
		System.out.println("************** doGet ************");
		OutputStream out = null;
		String am_pm;
	      String ses_hour;String date;
	      String fin_hr;String time;
		  try {
			  response.setContentType("application/vnd.ms-excel");
			   response.setHeader("Content-Disposition", "attachment; filename=speed_grid.xls");
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
			
		    
		    System.out.println("Vehicle number : "+vehicle_number);
		    
		   //rs = st.executeQuery("select * from tracking where imei_no='"+imeinumber+"' and  date_time >='"+startdate+"' and date_time <='"+enddate+"' ");
		   rs = st.executeQuery("SELECT tracking.latitude_value,tracking.longitude_value,tracking.mile,vehicle_information.vehicle_number,tracking.date_time FROM  tracking,vehicle_information WHERE tracking.imei_no = vehicle_information.imei_no AND tracking.imei_no ='"+imeinumber+"' AND tracking.date_time >= '"+startdate+"' AND tracking.date_time <= '"+enddate+"'");
		   
		   HSSFWorkbook wb = new HSSFWorkbook();
		   HSSFSheet sheet = wb.createSheet("Speed Report Sheet");
		  
		    
		   
		   sheet.addMergedRegion(new Region(0,(short)0,0,(short)1));
		   sheet.addMergedRegion(new Region(0,(short)0,0,(short)2));
		  /* sheet.addMergedRegion(new Region(0,(short)0,0,(short)3));
		   sheet.addMergedRegion(new Region(0,(short)0,0,(short)4));
		   sheet.addMergedRegion(new Region(0,(short)0,0,(short)5));*/
		   
		   HSSFRow rowhead = sheet.createRow((short)0);
		   rowhead.setHeight((short)500);
		   /*rowhead.createCell((short) 0).setCellValue("Fuel Information For " +vehicle_number);
		    * */
		   HSSFCell cell2B = rowhead.createCell(0);  
	        cell2B.setCellValue(new HSSFRichTextString("Speed Information For " +vehicle_number));  
	  
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
		   cell2.setCellValue("SPEED");
		   sheet.setColumnWidth(2, 7000);
		   //rowhead.createCell((short) 1).setCellValue("Time");
		   //rowhead.createCell((short) 2).setCellValue("Speed");
		  /* for(int i =0; i<1000;i++)
		   {*/
			  
			   while(rs.next()){
				   String date_time = rs.getString("date_time");
				   //String vehicle_no = rs.getString("vehicle_number");
				  //String location=rs.getString("mile");
				  /* String fuel = rs.getString("fuel"); */
				  String speed=rs.getString("mile");
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
				  
				   HSSFRow row = sheet.createRow((short)index);
				   row.setHeight((short)500);
				   
				   /*Cell cell = row.createCell((short) 0);
				   HSSFCellStyle cellStyle1 = wb.createCellStyle();
				   cellStyle1 = wb.createCellStyle(); 
				    HSSFFont hSSFFont1 = wb.createFont();  
			        hSSFFont1.setFontName(HSSFFont.FONT_ARIAL);  
			        hSSFFont1.setFontHeightInPoints((short) 12);  
			        hSSFFont1.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);  
			        hSSFFont1.setColor(HSSFColor.BLACK.index); 
			        cellStyle1.setFont(hSSFFont1);  
			        cell.setCellStyle(cellStyle1); 
				   cell.setCellValue(date);*/
				   
				   
				   row.createCell((short)0).setCellValue(date);
				   row.createCell((short)1).setCellValue(time);
				   row.createCell((short)2).setCellValue(speed);
				  
				   index++;
				   //System.out.println("Index:"+index);
				   }
			 
   
		  /* }*/
		   
//		   FileOutputStream fileOut = new FileOutputStream("workbook.xls");
		   out=response.getOutputStream();
		   wb.write(out);
		  
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
