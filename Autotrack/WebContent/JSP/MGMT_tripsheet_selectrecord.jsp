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
String serialnumber = null,vehicle_number = null,route_number = null,date = null,days = null;
String start_km = null,close_km = null,run_km = null,present_children = null,vehicle_outtime = null;
String vehicle_intime = null,driver_name = null,tcss_name = null;
ResultSet set = null;
ResultSet set2 = null;
String longitude=null;
Statement mystatement = connection.createStatement();
set = mystatement.executeQuery("select * from trip_sheet where date = '"+todaysdate+"'");

while(set.next()){
	
	
	
	if(sno_integer == count_sno){
		
		Statement mystatement2 = connection.createStatement();
		set2 = mystatement2.executeQuery("select * from trip_sheet where sno = '"+sno+"' and date = '"+todaysdate+"'");
		
		if(set2.next()){		
		serialnumber = set2.getString("sno");
		vehicle_number = set2.getString("vehicle_number");
		route_number = set2.getString("route_number");
		date = set2.getString("date");
		days = set2.getString("sno");
		start_km = set2.getString("start_km");
		close_km = set2.getString("close_km");
		run_km = set2.getString("run_km");
		present_children = set2.getString("present_children");
		vehicle_outtime = set2.getString("vehicle_outtime");
		vehicle_intime = set2.getString("vehicle_intime");
		driver_name = set2.getString("driver_name");
		tcss_name = set2.getString("tcss_name");	
		
		out.println(serialnumber+","+vehicle_number+","+route_number+","+date+","+days+","+start_km+","+close_km+","+run_km+","+present_children+","+vehicle_outtime+","+vehicle_intime+","+driver_name+","+tcss_name);


			mystatement2.close();
			set2.close();
		
		}	
	}
	count_sno++;
}



mystatement.close();
connection.close();
set2.close();
set.close();



} catch (SQLException e) { e.printStackTrace();	}
catch (ClassNotFoundException e) { e.printStackTrace(); }

%>
