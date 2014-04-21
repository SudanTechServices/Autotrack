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

public class ExcelExportServlet extends CommonService{
	
	public void run() throws ServletException, IOException{
		
		
		System.out.println("************** doGet ************");
		OutputStream out = null;
		  try {
		   response.setContentType("application/vnd.ms-excel");
		   response.setHeader
		     ("Content-Disposition", "attachment; filename=sampleName.xls");
		   HSSFWorkbook wb = new HSSFWorkbook();
		   HSSFSheet sheet = wb.createSheet("new sheet");
		   for(int i =0; i<1000;i++)
		   {
			   
			   /*HSSFRow row = sheet.createRow((short)i);
			   row.createCell((short)0).setCellValue(i);*/
			   HSSFRow row1=sheet.createRow((short)i);
			   
               row1.createCell((short)0).setCellValue("Samantha");
               System.out.println("Inside for loop:"+i);
		   }
		   
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
