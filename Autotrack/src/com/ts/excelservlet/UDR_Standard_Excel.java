package com.ts.excelservlet;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.mail.Session;
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
@WebServlet("/UDR_Standard_Excel")
public class UDR_Standard_Excel extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UDR_Standard_Excel() {
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
		HttpSession session = request.getSession(true);
		String[] select = (String[])session.getAttribute("id"); 
		String standard = request.getParameter("standard");

//System.out.println("IMEI : " +imeinumber);

//String vehicle_number="";
int index=5;
		System.out.println("************** doGet ************");
		OutputStream out = null;
		  try {
			  response.setContentType("application/vnd.ms-excel");
			   response.setHeader("Content-Disposition", "attachment; filename=Standard_UDR.xls");
			   Connection con=dbtranobj.connect();
			   
			  // Class.forName("org.postgresql.Driver").newInstance();
			   //conn = DriverManager.getConnection("jdbc:postgresql://182.72.167.34:5432/master_database","postgres", "postgres");
			   ResultSet rs = null;
			   Statement st=null;
			   st=con.createStatement();
			   rs = st.executeQuery("SELECT * FROM student WHERE standard='"+standard+"' order by enrolment_number");
		   
		   HSSFWorkbook wb = new HSSFWorkbook();
		   HSSFSheet sheet = wb.createSheet("Student Standard Sheet");
		  
		    
		   
		   sheet.addMergedRegion(new Region(0,(short)0,0,(short)1));
		   sheet.addMergedRegion(new Region(0,(short)0,0,(short)2));
		   sheet.addMergedRegion(new Region(1,(short)0,1,(short)1));
		   sheet.addMergedRegion(new Region(1,(short)0,1,(short)2));
		   sheet.addMergedRegion(new Region(2,(short)0,2,(short)1));
		   sheet.addMergedRegion(new Region(2,(short)0,2,(short)2));
		   sheet.addMergedRegion(new Region(3,(short)0,3,(short)1));
		   sheet.addMergedRegion(new Region(3,(short)0,3,(short)2));
		  
		   
		   HSSFRow rowhead = sheet.createRow((short)0);
		   rowhead.setHeight((short)500);
		   
		   HSSFCell cell2B = rowhead.createCell(0);  
	        cell2B.setCellValue(new HSSFRichTextString("Report for Standard : " +standard));  
	      
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
		   HSSFRow rowhead1 = sheet.createRow((short)4);
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
		  // cell.setCellValue("SNO");
		   sheet.setColumnWidth(0, 7000);
		  // rowhead.createCell((short) 0).setCellValue("Date");
		   
		   
		   HSSFRow rowhead2 = sheet.createRow((short)1);
		   rowhead2.setHeight((short)500);
		   
		   HSSFCell cell2C = rowhead2.createCell(0);  
		   cell2C.setCellStyle(cellStyle); 
		   HSSFRow rowhead3 = sheet.createRow((short)2);
		   rowhead3.setHeight((short)500);
		   
		   HSSFCell cell2D = rowhead3.createCell(0);  
		   cell2D.setCellStyle(cellStyle); 
		   HSSFRow rowhead4 = sheet.createRow((short)3);
		   rowhead4.setHeight((short)500);
		   
		   HSSFCell cell2E = rowhead4.createCell(0);  
		   cell2E.setCellStyle(cellStyle);
		   
		   while(rs.next()){ 
			   
			    if(rs.isLast()){
			    	
			    	cell2C.setCellValue(new HSSFRichTextString("Number Of Students Record : "+rs.getRow()));  
				
				//PdfPCell cell4 = new PdfPCell(new Paragraph("Number of Students Record :  "+rs.getRow() +"",myContentStyle));
		        
			     }
			}
		   
		   
		   if (select != null && select.length != 0) {
				
				for (int i = 0; i < select.length; i++) {
					                 
					
					
					if(select[i].equalsIgnoreCase("pick_point")){
										
										rs = st.executeQuery("select count(DISTINCT pick_point) FROM student WHERE standard='"+standard+"'");
										while(rs.next()){
											String no_of_pickpoint = rs.getString(1);
											
											cell2D.setCellValue(new HSSFRichTextString("No of Pick Points : "+no_of_pickpoint));
											//PdfPCell cell1 = new PdfPCell(new Paragraph("No of Pick Points "+no_of_pickpoint+"",myContentStyle));
									        
									        
								}
									 }
					
					
					if(select[i].equalsIgnoreCase("route_number")){
						
						rs = st.executeQuery("select count(DISTINCT route_number) FROM student WHERE standard='"+standard+"'");
						while(rs.next()){
							String route_number = rs.getString(1);
							
							cell2E.setCellValue(new HSSFRichTextString("No of Different Routes : "+route_number));
							
							
				// PdfPCell cell2 = new PdfPCell(new Paragraph("No of Different Routes "+route_number+"",myContentStyle));
					
						}
					}

}
}
		   
   
	         if (select != null && select.length != 0) {
				
				for (int i = 0; i < select.length; i++) {
					
					if(select[i].equalsIgnoreCase("enrolment_number")){
						   
						   Cell cell1= rowhead1.createCell((short) i);
						   cell1.setCellStyle(cellStyle1); 
						   cell1.setCellValue("ROLL NUMBER");
						   sheet.setColumnWidth(i, 7000);
						
					}
					else if(select[i].equalsIgnoreCase("pick_point")){
						   
						   Cell cell1= rowhead1.createCell((short) i);
						   cell1.setCellStyle(cellStyle1); 
						   cell1.setCellValue("PICK POINT");
						   sheet.setColumnWidth(i, 7000);
						
					}
					
					else if(select[i].equalsIgnoreCase("name")){
						   
						   Cell cell1= rowhead1.createCell((short) i);
						   cell1.setCellStyle(cellStyle1); 
						   cell1.setCellValue("NAME");
						   sheet.setColumnWidth(i, 7000);
						
					}
					
					else if(select[i].equalsIgnoreCase("location")){
						   
						   Cell cell1= rowhead1.createCell((short) i);
						   cell1.setCellStyle(cellStyle1); 
						   cell1.setCellValue("LOCATION");
						   sheet.setColumnWidth(i, 7000);
						
					}
					
					else if(select[i].equalsIgnoreCase("route_number")){
						   
						   Cell cell1= rowhead1.createCell((short) i);
						   cell1.setCellStyle(cellStyle1); 
						   cell1.setCellValue("ROUTE NO");
						   sheet.setColumnWidth(i, 7000);
						
					}
					
					else if(select[i].equalsIgnoreCase("category")){
						   
						   Cell cell1= rowhead1.createCell((short) i);
						   cell1.setCellStyle(cellStyle1); 
						   cell1.setCellValue("CATEGORY");
						   sheet.setColumnWidth(i, 7000);
						
					}
					
					else if(select[i].equalsIgnoreCase("residence_address")){
						   
						   Cell cell1= rowhead1.createCell((short) i);
						   cell1.setCellStyle(cellStyle1); 
						   
						   cell1.setCellValue("ADDRESS");
						   sheet.setColumnWidth(i,30000);
						
					}
					
		   
					else
					{ 
						Cell cell1= rowhead1.createCell((short) i);
						cell1.setCellStyle(cellStyle1); 
						cell1.setCellValue(select[i]);
						sheet.setColumnWidth(i, 7000); }
		   
			}
		}

	         rs = st.executeQuery("SELECT * FROM student WHERE standard='"+standard+"' order by enrolment_number");

		   while(rs.next()){ 
			   
			   HSSFRow row = sheet.createRow((short)index);
				row.setHeight((short)500);		
			   
			   if (select != null && select.length != 0) {
					
					for (int i = 0; i < select.length; i++) {
			   
						row.createCell((short)i).setCellValue(rs.getString(select[i]));
						
					}
			}	
			  
			   index++;
		   }
		   
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
