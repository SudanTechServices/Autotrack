
<%@ page import="java.io.InputStream" %>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@ page import="java.io.*" %>
<%@page import="java.sql.*"%>
<%@page import= "javax.servlet.http.*" %>
<%@page import= "javax.servlet.*" %>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction;" %>

<%out.println("<b>Excel Successfully saved!!"); %>
<center>
		<div style="width: 400px; height: 400px; padding-top: 35px"><img src="../images/reports.jpg">
		</div>
		</center>	

<%

String file="reportinexcel.xls";
String startdate = request.getParameter("startdate");
String enddate = request.getParameter("enddate");

int index=1;

response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "attachment;filename=" + file); 

  try {
	  
	  
	 /*  Connection conn = null;
	   Class.forName("org.postgresql.Driver").newInstance();
	   conn = DriverManager.getConnection("jdbc:postgresql://182.72.167.34:5432/master_database","postgres", "postgres");
	   ResultSet rs = null;
	   Statement st=null;
	   st=conn.createStatement(); */
	   
	   
	   DBTransaction dbtranobj=new DBTransaction();
		Connection connection=dbtranobj.connect();
		ResultSet rs = null;
		Statement st=null;
		st=connection.createStatement();
	   //rs = st.executeQuery("select * from tracking where imei_no='"+imeinumber+"' and  date_time >='"+startdate+"' and date_time <='"+enddate+"' ");
	   /* rs = st.executeQuery("SELECT tracking.latitude_value,tracking.longitude_value,tracking.mile,vehicle_information.vehicle_number,tracking.date_time FROM  public.tracking,public.vehicle_information WHERE tracking.imei_no = vehicle_information.imei_no AND tracking.date_time >= '"+startdate+"' AND tracking.date_time <= '"+enddate+"';"); */
	   HSSFWorkbook wb = new HSSFWorkbook();

	   HSSFSheet sheet = wb.createSheet("new sheet");
	   HSSFRow row = sheet.createRow((short)0);
	   HSSFCell cell = row.createCell((short)0);
	   row.createCell((short)1).setCellValue("");
	   row.createCell((short)2).setCellValue("Date");
	   row.createCell((short)3).setCellValue("Vehicle Number");
	   row.createCell((short)4).setCellValue("Latitude");
	   row.createCell((short)5).setCellValue("Longitude");
	   row.createCell((short)6).setCellValue("Speed");
	  
  
	   
	   
	   rs = st.executeQuery("SELECT tracking.latitude_value,tracking.longitude_value,tracking.mile,vehicle_information.vehicle_number,tracking.date_time FROM  public.tracking,public.vehicle_information WHERE tracking.imei_no = vehicle_information.imei_no AND tracking.date_time >= '"+startdate+"' AND tracking.date_time <= '"+enddate+"';");
       while(rs.next()){
    	   String date_time=rs.getString("date_time");
    	   String date=date_time.substring(0,10);
    	   String time=date_time.substring(10,19);
    	   String speed=rs.getString("mile");
	   /* HSSFWorkbook wb = new HSSFWorkbook(); */
  
  HSSFRow row1 = sheet.createRow((short)index);
  HSSFCell cell1 = row1.createCell((short)index);
  row1.createCell((short)1).setCellValue(index);
  row1.createCell((short)2).setCellValue(date);
  row1.createCell((short)3).setCellValue(time);
/*   row1.createCell((short)4).setCellValue();
  row1.createCell((short)5).setCellValue(fuel); */
  row1.createCell((short)4).setCellValue(speed);
  
  index++;
 
	   }
	   OutputStream out1=response.getOutputStream();
	   /* try{
		   out1 = new FileOutputStream("/tmp/Report.xls");
		    }catch(Exception e){
		    out1 = new FileOutputStream("C:/Report.xls");
		    	
		    } */
	   
	   wb.write(out1);
	   out1.close();
	   
	   /*  FileOutputStream fileOut = new FileOutputStream("/home/aatman4/Desktop/rajesh.xls"); 
	   wb.write(fileOut);
	   fileOut.close();  */ 
 /* out.println("Your file has been created succesfully");   */

connection.close();
st.close();
rs.close();
 } catch ( Exception ex ) { 
  }  


%>