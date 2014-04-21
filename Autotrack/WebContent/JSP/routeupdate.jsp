<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="errorpage.jsp" %>
 <%@page import="java.sql.*"%>
 <%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"> 
 
<head> 
<script type="text/javascript" src="../JS/validate.js"></script>
<SCRIPT type="text/javascript">

window.history.forward();
function noBack() { window.history.forward(); }
	function update()
	{   
		if(routeregistrationvalidation())
		{
		 var route_number=document.BusRouteInfo.route_number.value;
		document.BusRouteInfo.action="/Autotrack/ControllerServlet/BusRouteUpdateService?route_number="+route_number;
		document.BusRouteInfo.submit();
		}
		
	}
	 function refresh(){
		
		document.getElementById("route").disabled = true;
	} 
</SCRIPT>
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" /> 
	<title>Autotrack</title> 
<link rel="stylesheet" type="text/css" href="../CSS/style.css" />
<style type="text/css">

input.groovybutton
{
   font-size:14px;
   font-family:Trebuchet MS,sans-serif;
   font-weight:bold;
   color:#000;
   width:150px;
   height:30px;
   background-image:url("../images/content_pagetitle_bg.jpg");
   background-repeat: repeat-x;
   border-radius:25px;
}
.dropdown{
font-family:Trebuchet MS,sans-serif;
background-color:#B8E2FA; 
border-radius:10px; 
color:#000;
width:200px;
height: 30px;
padding: 2px;
}
option.blue 
{
background-color:#3B5C9A; 
font-weight: bold; 
font-size: 12px; 
color: white;
padding:3px;
}
input.field{
background-color:#B8E2FA;
font-family:Trebuchet MS,sans-serif;
width:150px;
color:#000;
}
</style>

</head> 
 
<%
String route_number  = request.getParameter("route_number");
String bus_route_number ="";
String source = "";
String destination = "";
String stopping_point_1 = "";
String stopping_point_2 = "";
String stopping_point_3 = "";
String stopping_point_4 = "";
String stopping_point_5="";
String rate_1="";
String rate_2="";
String rate_3= "";
String rate_4="";
String rate_5="";
String vehicle_number="";

try{
	  DBTransaction dbtranobj=new DBTransaction();
	  Connection connection=dbtranobj.connect();
	  ResultSet rs = null;
	  Statement st=null;
	  st=connection.createStatement();
	  rs = st.executeQuery("SELECT * from route_registration WHERE bus_route_number = '"+route_number+"'");
	  
	  while(rs.next()){ 
		  bus_route_number = rs.getString("bus_route_number");
	  source = rs.getString("source"); 
	  destination = rs.getString("destination");
	  stopping_point_1 = rs.getString("stopping_point_1");
	  rate_1 = rs.getString("rate_1");
	  stopping_point_2 = rs.getString("stopping_point_2");
	  rate_2 = rs.getString("rate_2");
      stopping_point_3 = rs.getString("stopping_point_3");
	  rate_3 = rs.getString("rate_3");
	  stopping_point_4 = rs.getString("stopping_point_4");
	  rate_4 = rs.getString("rate_4");
	  stopping_point_5 = rs.getString("stopping_point_5");
	  rate_5 = rs.getString("rate_5");
	  vehicle_number=rs.getString("vehicle_number");
System.out.println(vehicle_number);
	  }
	  connection.close();
		st.close();
		rs.close();
}catch(SQLException e){ System.err.println(e.getMessage()); } 

%>

 
<body onload="refresh();">

<div class="content_bg"><span class="content_headning">Route Update</span></div>
		
		
<form name="BusRouteInfo" method="post">

<table cellspacing="10" style="font-family:Comic Sans MS,sans-serif; font-size: 14px;">
<tr>
<td colspan="3" style="color: red">* Enter the route Number and Fix the bus fare upto that limited points</td></tr>
<tr height=15px>
<td>
Route Number   
</td>
<td>
<input class="field" type="text" name="route_number" id="route" value="<%=route_number%>"/>
</td>
<td>
Vehicle Number
</td>
<td>
<select name="vehicle_number" class="dropdown">
<option class="blue"><%=vehicle_number%></option>
</select>
</td>
</tr>

<tr>
<td>
Source  
</td>
<td>
<input class="field" type="text" name="source" value="<%=source%>"/>
</td>
<td>
Destination
</td>
<td>
<input class="field" type="text" name="destination" value="<%=destination%>"/>
</td>
</tr>

<tr>
<td>
Stopping Point 1   
</td>
<td>
<input class="field" type="text" name="limit1" value="<%=stopping_point_1%>"/>
</td>
<td>Rate 1</td>
<td>
<input class="field" type="text" name="rate1" value="<%=rate_1%>"/>
</td>
</tr>

<tr>
<td>
Stopping Point 2   
</td>
<td>
<input class="field" type="text" name="limit2" value="<%=stopping_point_2%>"/>
</td>
<td>Rate 2</td>
<td>
<input class="field" type="text" name="rate2" value="<%=rate_2%>"/>
</td>
</tr>

<tr>
<td>
Stopping Point 3   
</td>
<td>
<input class="field" type="text" name="limit3" value="<%=stopping_point_3%>"/>
</td>
<td>Rate 3</td>
<td>
<input class="field" type="text" name="rate3" value="<%=rate_3%>"/>
</td>
</tr>

<tr>
<td>
Stopping Point 4   
</td>
<td>
<input class="field" type="text" name="limit4" value="<%=stopping_point_4%>"/>
</td>
<td>Rate 4</td>
<td>
<input class="field" type="text" name="rate4" value="<%=rate_4%>"/>
</td>
</tr>

<tr>
<td>
Stopping Point 5   
</td>
<td>
<input class="field" type="text" name="limit5" value="<%=stopping_point_5%>"/>
</td>
<td>Rate 5</td>
<td>
<input class="field" type="text" name="rate5" value="<%=rate_5%>"/>
</td>
</tr>


<tr><td></td><td>

<input class="groovybutton" type="button" class="submit" value="Update" onclick="update();"></td></tr>

</table>
</form>		


</body> 
 
</html>