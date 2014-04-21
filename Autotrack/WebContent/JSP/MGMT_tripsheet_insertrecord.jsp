<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*" import="java.sql.*" import="java.util.Date" import="java.util.Calendar"%>
    <%@ page errorPage="errorpage.jsp" %>
<%@ page import="com.ts.service.dropdown" %> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction;" %>
<%
Calendar calendar = new GregorianCalendar();
String am_pm;
String hour = "";
String minute = "";

int hr = calendar.get(Calendar.HOUR);
int min = calendar.get(Calendar.MINUTE);

if(calendar.get(Calendar.AM_PM) == 0)
am_pm = "AM";
else
am_pm = "PM";


if(hr < 10){
	hour = "0"+hr;
}else{
	hour = ""+hr;
}
if(min < 10){
	minute = "0"+hr;
}else{
	minute = ""+min;
}

String Current_Time = hour+":"+minute+" "+am_pm;

%>

<%

String max = null;
String sno = request.getParameter("sno");;

String vehicle_number = request.getParameter("vehicle_number");
System.out.println(vehicle_number);
String route_number = request.getParameter("route_number");
System.out.println(route_number);

String start_km = request.getParameter("start_km");
String close_km = request.getParameter("close_km");
String present_children = request.getParameter("present_children");
String vehicle_outtime = request.getParameter("vehicle_outtime");
String vehicle_intime = request.getParameter("vehicle_intime");
String driver_name = request.getParameter("driver_name");
String tcss_name = request.getParameter("tcss_name");
String inserted_by = (String)session.getAttribute("user") + " | "+Current_Time;
int start = Integer.parseInt(start_km);
int close = Integer.parseInt(close_km);
int run_km = close - start;
String total_km = ""+run_km;


java.text.DateFormat df = new java.text.SimpleDateFormat("dd/MM/yyyy");
String todaysdate = df.format(new java.util.Date());
String day = null;
Date date = new Date(); 

int dayno = date.getDay();
if(dayno == 0){ day = "Sunday";}
else if(dayno == 1){ day = "Monday";}
else if(dayno == 2){ day = "Tuesday";}
else if(dayno == 3){ day = "Wednesday";}
else if(dayno == 4){ day = "Thursday";}
else if(dayno == 5){ day = "Friday";}
else if(dayno == 6){ day = "Saturday";}

try {
    DBTransaction dbtranobj=new DBTransaction();
	Connection connection=dbtranobj.connect();
    ResultSet set = null;
   
	String longitude=null;
	Statement mystatement = connection.createStatement();
	

mystatement.executeUpdate("INSERT INTO trip_sheet values('"+sno+"','"+vehicle_number+"','"+route_number+"','"+todaysdate+"','"+day+"','"+start_km+"','"+close_km+"','"+total_km+"','"+present_children+"','"+vehicle_outtime+"','"+vehicle_intime+"','"+driver_name+"','"+tcss_name+"','"+inserted_by+"')");

mystatement.close();
connection.close();

out.println("Inserted Successfully !!");

connection.close();
mystatement.close();
	set.close();
} catch (SQLException e) { e.printStackTrace();	}
catch (ClassNotFoundException e) { e.printStackTrace(); }

%>
