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

String sno = request.getParameter("sno");
System.out.println("SNO : "+sno);
String vehicle_number = request.getParameter("vehicle_number");
System.out.println("Vehicle : "+vehicle_number);
String route_number = request.getParameter("route_number");
System.out.println("Route : "+route_number);
String start_km = request.getParameter("start_km");
System.out.println("Start KM : "+start_km);
String close_km = request.getParameter("close_km");
System.out.println("Close KM : "+close_km);
String present_children = request.getParameter("present_children");
System.out.println("present  : "+present_children);
String vehicle_outtime = request.getParameter("vehicle_outtime");
System.out.println("V out time : "+vehicle_outtime);
String vehicle_intime = request.getParameter("vehicle_intime");
System.out.println("V In Time : "+vehicle_intime);
String driver_name = request.getParameter("driver_name");
System.out.println("Driver Name : "+driver_name);
String tcss_name = request.getParameter("tcss_name");
System.out.println("TCSS : "+tcss_name);
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
	


mystatement.executeUpdate("UPDATE trip_sheet set sno = '"+sno+"',vehicle_number = '"+vehicle_number+"',route_number = '"+route_number+"',date = '"+todaysdate+"',days = '"+day+"',start_km = '"+start_km+"',close_km = '"+close_km+"',run_km ='"+total_km+"',present_children ='"+present_children+"',vehicle_outtime ='"+vehicle_outtime+"',vehicle_intime ='"+vehicle_intime+"',driver_name = '"+driver_name+"',tcss_name = '"+tcss_name+"',inserted_by = '"+inserted_by+"' WHERE date = '"+todaysdate+"' and sno = '"+sno+"'");



//out.println("Updated Successfully !!");
response.sendRedirect("MGMT_tripsheet.jsp");
mystatement.close();
connection.close();
set.close();
} catch (SQLException e) { e.printStackTrace();	}
catch (ClassNotFoundException e) { e.printStackTrace(); }

%>
