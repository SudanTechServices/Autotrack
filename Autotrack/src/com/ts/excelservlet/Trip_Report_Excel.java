package com.ts.excelservlet;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

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
import com.ts.domain.Halt_time;

/**
 * Servlet implementation class Trip_Report_Excel
 */
@WebServlet("/Trip_Report_Excel")
public class Trip_Report_Excel extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Trip_Report_Excel() {
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

		 String am_pm;
	      String ses_hour;String date;
	      String fin_hr;String time;
int index=2;
	
		OutputStream out = null;
		try{
			response.setContentType("application/vnd.ms-excel");
			   response.setHeader("Content-Disposition", "attachment; filename=trip_report_grid.xls");
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
							 HSSFRow row = sheet.createRow((short)index);
								row.setHeight((short)500);		
							   row.createCell((short)0).setCellValue(h.getPlace());
							   row.createCell((short)1).setCellValue(h.getStart_time());
							   row.createCell((short)2).setCellValue(h.getHalt_position());
							   row.createCell((short)3).setCellValue(h.getStoped_at());
							   row.createCell((short)4).setCellValue(h.getHalt_time());
							   row.createCell((short)5).setCellValue(h.getDistance());
							   index++;
							   System.out.println("INDEX VAL "+index);
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
