<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*" import="java.sql.*" import="java.util.Date" import="java.util.Calendar"%>
    <%@ page errorPage="errorpage.jsp" %>
<%@ page import="com.ts.service.dropdown" %> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction;" %>

<%
String sno = request.getParameter("sno");
int sno_integer = Integer.parseInt(sno);
int count_sno = 1;
java.text.DateFormat df = new java.text.SimpleDateFormat("dd/MM/yyyy");
String todaysdate = df.format(new java.util.Date());
try {
    DBTransaction dbtranobj=new DBTransaction();
	Connection connection=dbtranobj.connect();


String latitude=null,fuel=null,mile=null,SQL=null,Driver_name=null;
ResultSet set = null;
String longitude=null;
Statement mystatement = connection.createStatement();
set = mystatement.executeQuery("select sno from trip_sheet");

while(set.next()){
						
							if(count_sno == sno_integer){
								
								Statement mystatement2 = connection.createStatement();						
								
								mystatement2.execute("DELETE FROM trip_sheet where sno = '"+count_sno+"' and date = '"+todaysdate+"'");
								 
								mystatement2.close();
								
							}
							
							if(count_sno > sno_integer){	
	
							System.out.println("count : "+count_sno);
	
							int new_no = count_sno - 1;
	
					     	Statement mystatement1 = connection.createStatement();						
						
							mystatement1.execute("UPDATE trip_sheet set sno = '"+new_no+"' where sno = '"+count_sno+"' and date= '"+todaysdate+"'");
							 
							mystatement1.close();
							
							System.out.println("new no : "+new_no);
						}
						
	count_sno++;
}



connection.close();
mystatement.close();
set.close();
} catch (SQLException e) { e.printStackTrace();	}
catch (ClassNotFoundException e) { e.printStackTrace(); }



out.println(sno.trim());

%>
