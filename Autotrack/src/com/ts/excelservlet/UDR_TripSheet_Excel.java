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
import javax.servlet.http.HttpSession;

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
@WebServlet("/UDR_TripSheet_Excel")
public class UDR_TripSheet_Excel extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UDR_TripSheet_Excel() {
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
		String IMEI = request.getParameter("IMEI");
		HttpSession session = ((HttpServletRequest) request).getSession(); 
		String[] select =(String[]) session.getValue("id");
		String date = request.getParameter("date");
		int index=5;
		System.out.println("************** doGet ************");
		OutputStream out = null;
		  try {
			  response.setContentType("application/vnd.ms-excel");
			   response.setHeader("Content-Disposition", "attachment; filename=TripSheet_grid.xls");
			   Connection con=dbtranobj.connect();
			   
			  // Class.forName("org.postgresql.Driver").newInstance();
			   //conn = DriverManager.getConnection("jdbc:postgresql://182.72.167.34:5432/master_database","postgres", "postgres");
			   ResultSet rs = null;
			   Statement st=null;
			   st=con.createStatement();
			   HSSFWorkbook wb = new HSSFWorkbook();
			   HSSFSheet sheet = wb.createSheet("Trip Sheet Report");
			  
			    
			   
			   sheet.addMergedRegion(new Region(0,(short)0,0,(short)1));
			   sheet.addMergedRegion(new Region(0,(short)0,0,(short)2));
			   sheet.addMergedRegion(new Region(1,(short)0,1,(short)1));
			   sheet.addMergedRegion(new Region(1,(short)0,1,(short)2));
			   sheet.addMergedRegion(new Region(2,(short)0,2,(short)1));
			   sheet.addMergedRegion(new Region(2,(short)0,2,(short)2));
			   sheet.addMergedRegion(new Region(3,(short)0,3,(short)1));
			   sheet.addMergedRegion(new Region(3,(short)0,3,(short)2));
			   /*sheet.addMergedRegion(new Region(0,(short)0,0,(short)3));
			   sheet.addMergedRegion(new Region(0,(short)0,0,(short)4));
			   sheet.addMergedRegion(new Region(0,(short)0,0,(short)5));*/
			   
			   HSSFRow rowhead = sheet.createRow((short)0);
			   rowhead.setHeight((short)500);
			   /*rowhead.createCell((short) 0).setCellValue("Fuel Information For " +vehicle_number);
			    * */
			   HSSFCell cell2B = rowhead.createCell(0);  
		        cell2B.setCellValue(new HSSFRichTextString("Trip Sheet for " +date));  
		        
		        
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
		        rs = st.executeQuery("SELECT * FROM trip_sheet WHERE date='"+date+"' order by sno");
			   HSSFRow rowhead1 = sheet.createRow((short)1);
			   rowhead1.setHeight((short)500);
			   /*rowhead.createCell((short) 0).setCellValue("Fuel Information For " +vehicle_number);
			    * */
			   HSSFCell cell2 = rowhead1.createCell(0);  
			   cell2.setCellStyle(cellStyle);  
			   while(rs.next()){ 
					if(rs.isLast()){
						
						cell2.setCellValue(new HSSFRichTextString("Number of Records  " +rs.getRow())); 
					}
				}
		   
			
			   HSSFRow rowhead2 = sheet.createRow((short)2);
			   rowhead2.setHeight((short)500);
			   
			   HSSFCell cell3 = rowhead2.createCell(0); 
			   cell3.setCellStyle(cellStyle);
			   
				if (select != null && select.length != 0) {
					
					for (int i = 0; i < select.length; i++) {
						                 
			   if(select[i].equalsIgnoreCase("vehicle_number")){
					
					rs = st.executeQuery("select count(DISTINCT vehicle_number) FROM trip_sheet WHERE date='"+date+"'");
					while(rs.next()){
						                 
						
						String no_of_vehicle = rs.getString(1);
						
										
													
												cell3.setCellValue(new HSSFRichTextString("No of Locations  " +no_of_vehicle)); 
		
											}
											
										}
					}
					
			   }
			   HSSFRow rowhead3 = sheet.createRow((short)3);
			   rowhead3.setHeight((short)500);
			   /*rowhead.createCell((short) 0).setCellValue("Fuel Information For " +vehicle_number);
			    * */
			   HSSFCell cell4 = rowhead3.createCell(0); 
			   cell4.setCellStyle(cellStyle);
			   if (select != null && select.length != 0) {
					
					for (int i = 0; i < select.length; i++) {
						                 
						rs = st.executeQuery("select count(DISTINCT driver_name) FROM trip_sheet WHERE date='"+date+"'");
						while(rs.next()){
						
							String no_of_driver = rs.getString(1);
												cell4.setCellValue(new HSSFRichTextString("No of Different Drivers  " +no_of_driver)); 																						
												
											}
										}
					
			   }
			   HSSFRow rowhead4 = sheet.createRow((short)4);
			   rowhead4.setHeight((short)600);
			   HSSFCellStyle cellStyle1 = wb.createCellStyle();
			   cellStyle1 = wb.createCellStyle(); 
			    HSSFFont hSSFFont1 = wb.createFont();  
		        hSSFFont1.setFontName(HSSFFont.FONT_ARIAL);  
		        hSSFFont1.setFontHeightInPoints((short) 12);  
		        hSSFFont1.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);  
		        hSSFFont1.setColor(HSSFColor.BLACK.index); 
		        cellStyle1.setFont(hSSFFont1);  
			   if (select != null && select.length != 0) {
					
					for (int i = 0; i < select.length; i++) {
						
						if(select[i].equalsIgnoreCase("enrolment_number")){
							   
							   Cell cell1= rowhead4.createCell((short) i);
							   cell1.setCellStyle(cellStyle1); 
							   cell1.setCellValue("ROLL NUMBER");
							   sheet.setColumnWidth(i, 7000);
							
						}
						else if(select[i].equalsIgnoreCase("pick_point")){
							   
							   Cell cell1= rowhead4.createCell((short) i);
							   cell1.setCellStyle(cellStyle1); 
							   cell1.setCellValue("PICK POINT");
							   sheet.setColumnWidth(i, 7000);
							
						}
						
						else if(select[i].equalsIgnoreCase("name")){
							   
							   Cell cell1= rowhead4.createCell((short) i);
							   cell1.setCellStyle(cellStyle1); 
							   cell1.setCellValue("NAME");
							   sheet.setColumnWidth(i, 7000);
							
						}
						
						else if(select[i].equalsIgnoreCase("location")){
							   
							   Cell cell1= rowhead4.createCell((short) i);
							   cell1.setCellStyle(cellStyle1); 
							   cell1.setCellValue("LOCATION");
							   sheet.setColumnWidth(i, 7000);
							
						}
						
						else if(select[i].equalsIgnoreCase("route_number")){
							   
							   Cell cell1= rowhead4.createCell((short) i);
							   cell1.setCellStyle(cellStyle1); 
							   cell1.setCellValue("ROUTE NO");
							   sheet.setColumnWidth(i, 7000);
							
						}
						
						else if(select[i].equalsIgnoreCase("category")){
							   
							   Cell cell1= rowhead4.createCell((short) i);
							   cell1.setCellStyle(cellStyle1); 
							   cell1.setCellValue("CATEGORY");
							   sheet.setColumnWidth(i, 7000);
							
						}
						else if(select[i].equalsIgnoreCase("standard")){
							   
							   Cell cell1= rowhead4.createCell((short) i);
							   cell1.setCellStyle(cellStyle1); 
							   cell1.setCellValue("STANDARD");
							   sheet.setColumnWidth(i, 7000);
							
						}
						else if(select[i].equalsIgnoreCase("residence_address")){
							   
							   Cell cell1= rowhead4.createCell((short) i);
							   cell1.setCellStyle(cellStyle1); 
							   
							   cell1.setCellValue("ADDRESS");
							   sheet.setColumnWidth(i,30000);
							
						}
						else if(select[i].equalsIgnoreCase("vehicle_number")){
							   
							   Cell cell1= rowhead4.createCell((short) i);
							   cell1.setCellStyle(cellStyle1); 
							   
							   cell1.setCellValue("VEHICLE_NO");
							   sheet.setColumnWidth(i,7000);
							
						}
						else if(select[i].equalsIgnoreCase("days")){
							   
							   Cell cell1= rowhead4.createCell((short) i);
							   cell1.setCellStyle(cellStyle1); 
							   
							   cell1.setCellValue("DAYS");
							   sheet.setColumnWidth(i,7000);
							
						}
						else if(select[i].equalsIgnoreCase("start_KM")){
							   
							   Cell cell1= rowhead4.createCell((short) i);
							   cell1.setCellStyle(cellStyle1); 
							   
							   cell1.setCellValue("START_KM");
							   sheet.setColumnWidth(i,7000);
							
						}
						else if(select[i].equalsIgnoreCase("close_KM")){
							   
							   Cell cell1= rowhead4.createCell((short) i);
							   cell1.setCellStyle(cellStyle1); 
							   
							   cell1.setCellValue("CLOSE_KM");
							   sheet.setColumnWidth(i,7000);
							
						}
						else if(select[i].equalsIgnoreCase("run_KM")){
							   
							   Cell cell1= rowhead4.createCell((short) i);
							   cell1.setCellStyle(cellStyle1); 
							   
							   cell1.setCellValue("RUN_KM");
							   sheet.setColumnWidth(i,7000);
							
						}
						else if(select[i].equalsIgnoreCase("present_children")){
							   
							   Cell cell1= rowhead4.createCell((short) i);
							   cell1.setCellStyle(cellStyle1); 
							   
							   cell1.setCellValue("PRESENT_CHILDREN");
							   sheet.setColumnWidth(i,7000);
							
						}
						else if(select[i].equalsIgnoreCase("vehicle_outtime")){
							   
							   Cell cell1= rowhead4.createCell((short) i);
							   cell1.setCellStyle(cellStyle1); 
							   
							   cell1.setCellValue("VEHICLE_OUTTIME");
							   sheet.setColumnWidth(i,7000);
							
						}
						else if(select[i].equalsIgnoreCase("vehicle_intime")){
							   
							   Cell cell1= rowhead4.createCell((short) i);
							   cell1.setCellStyle(cellStyle1); 
							   
							   cell1.setCellValue("VEHICLE_INTIME");
							   sheet.setColumnWidth(i,7000);
							
						}
						else if(select[i].equalsIgnoreCase("driver_name")){
							   
							   Cell cell1= rowhead4.createCell((short) i);
							   cell1.setCellStyle(cellStyle1); 
							   
							   cell1.setCellValue("DRIVER_NAME");
							   sheet.setColumnWidth(i,7000);
							
						}
						else if(select[i].equalsIgnoreCase("tcss_name")){
							   
							   Cell cell1= rowhead4.createCell((short) i);
							   cell1.setCellStyle(cellStyle1); 
							   
							   cell1.setCellValue("TCSS_NAME");
							   sheet.setColumnWidth(i,7000);
							
						}
						else if(select[i].equalsIgnoreCase("inserted_by")){
							   
							   Cell cell1= rowhead4.createCell((short) i);
							   cell1.setCellStyle(cellStyle1); 
							   
							   cell1.setCellValue("ENTERD_BY");
							   sheet.setColumnWidth(i,7000);
							
						}
						else
						{ 
							Cell cell1= rowhead4.createCell((short) i);
							cell1.setCellStyle(cellStyle1); 
							cell1.setCellValue(select[i]);
							sheet.setColumnWidth(i, 7000); }
			   
				}
			}
		    
			   
			   rs = st.executeQuery("SELECT * FROM trip_sheet WHERE date='"+date+"' order by sno");

				 int count = 1;

				 while(rs.next()){ 
					 HSSFRow row = sheet.createRow((short)index);
					   row.setHeight((short)500);
					 count  ++;	
					 if (select != null && select.length != 0) {
					 	 	for (int i = 0; i < select.length; i++) {
					 	 		
					 	 		row.createCell((short)i).setCellValue(rs.getString(select[i]));
					 	 		
					 	 		
					 	 	}
				 	 		
			 	    	}
					 index++;
					 System.out.println("Index"+index);
				 }
					/* if (select != null && select.length != 0) {
							
							for (int i = 0; i < select.length; i++) {
								if(select[i].equalsIgnoreCase("residence_address")){
									HSSFCellStyle cellStyle2 = wb.createCellStyle();
									   cellStyle2 = wb.createCellStyle(); 
									    HSSFFont hSSFFont1 = wb.createFont();  
								        hSSFFont1.setFontName(HSSFFont.FONT_ARIAL);  
								        hSSFFont1.setFontHeightInPoints((short) 12);  
								        hSSFFont1.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);  
								        hSSFFont1.setColor(HSSFColor.BLACK.index); 
								        cellStyle2.setFont(hSSFFont1); 
									   Cell cell5= rowhead4.createCell((short) i);
									   cell5.setCellStyle(cellStyle2); 
									   
									   cell5.setCellValue("ADDRESS");
									   sheet.setColumnWidth(i,30000);
									
								}
							}*/
					
					/* } 	*/		
				
					 	 	
			
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
