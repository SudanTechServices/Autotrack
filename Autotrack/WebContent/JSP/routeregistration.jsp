<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="errorpage.jsp" %>
   <%@ page import="com.ts.service.dropdown" %> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml"> 
 
<head> 
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" /> 
	<title>Trans Workx</title> 
<SCRIPT type="text/javascript">

window.history.forward();
function noBack() { window.history.forward(); }
	function save()
	{   
		if(routeregistrationvalidation())
			{
		document.BusRouteInfo.action="/Autotrack/ControllerServlet/BusRouteInfoService";
		document.BusRouteInfo.submit();
			}

	}
	function search_by_route()
	{
		document.BusRouteInfo.action="../JSP/searchbyroute.jsp";
		document.BusRouteInfo.submit();
	}
	function delete_by_route()
	{
		document.BusRouteInfo.action="../JSP/deletebyroute.jsp";
		document.BusRouteInfo.submit();
	}
</SCRIPT>	
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
<script type="text/javascript" src="../JS/validate.js"></script>
	
</head> 
<%
String message = request.getParameter("message");
if(message == null){
	message = "";
}
else if(message.equalsIgnoreCase("sucesss")){
	message = "Route Saved Successfully";
}
else if(message.equalsIgnoreCase("updated")){
	message = "Route Updated Successfully";
}
else if(message.equalsIgnoreCase("Deleted")){
	message = "Route Deleted Successfully";
}

%>
 
<body>

<div class="content_bg"><span class="content_headning">Route Registration</span></div>

<form name="BusRouteInfo">
 <center><div style="color: blue; font: 20px;"><%=message %></div></center>
 <br><br>

<div style="color: red">* Enter the route Number and Fix the bus fare upto that limited points</div>
<table cellspacing="10" style="font-family:Comic Sans MS,sans-serif; font-size: 14px;">
<tr>
<td>
Route Number   
</td>
<td>
<input class="field" type="text" name="route_number"/>
</td>
<td></td>
<td>
<label>Select a vehicle</label>
</td>
<td>
<select name="vehicle_no" class="dropdown">
                       <%	
                       String belongs=(String)session.getAttribute("belongs");
								dropdown dd=new dropdown();     
								TreeMap hm = dd.getName(belongs);
								Set sets = hm.entrySet(); 
								Iterator iterator = sets.iterator();  
								  
								
								out.println("<option class='blue'>Select a vehicle</option>"); 
								while(iterator.hasNext()){   
								     //String temp = iterator.next().toString();
								     Map.Entry me = (Map.Entry)iterator.next();
								     out.println("<option class='blue'>" + me.getKey() + "</option> ");   
								}   
  

%>
                        </select>

</td>
<td colspan="2" ></td>

</tr>

<tr>
<td>
Source  
</td>
<td>
<input class="field" type="text" name="source"/>
</td>
<td></td>
<td>
Destination
</td>
<td>
<input class="field" type="text" name="destination"/>
</td>
</tr>

<tr>
<td>
Pickup Point 1   
</td>
<td>
<input class="field" type="text" name="limit1"/>
</td>
<td></td>
<td>Rate 1</td>
<td>
<input class="field" type="text" name="rate1"/>
</td>
</tr>

<tr>
<td>
Pickup Point 2   
</td>
<td>
<input class="field" type="text" name="limit2"/>
</td>
<td></td>
<td>Rate 2</td>
<td>
<input class="field" type="text" name="rate2"/>
</td>
</tr>

<tr>
<td>
Pickup Point 3   
</td>
<td>
<input class="field" type="text" name="limit3"/>
</td>
<td></td>
<td>Rate 3</td>
<td>
<input class="field" type="text" name="rate3"/>
</td>
</tr>

<tr>
<td>
Pickup Point 4   
</td>
<td>
<input class="field" type="text" name="limit4"/>
</td>
<td></td>
<td>Rate 4</td>
<td>
<input class="field" type="text" name="rate4"/>
</td>
</tr>

<tr>
<td>
Pickup Point 5   
</td>
<td>
<input class="field" type="text" name="limit5"/>
</td>
<td></td>
<td>Rate 5</td>
<td>
<input class="field" type="text" name="rate5"/>
</td>
</tr>
<tr></tr>
<tr></tr>
<tr align="center">
<td></td>
<td><input class="groovybutton" type="button" class="submit" value="Save" onclick="save();" /></td>
<td><input class="groovybutton" type="button" class="submit" value="Update" onclick="search_by_route();" /></td>
<td><input class="groovybutton" type="button" class="submit" value="Delete" onclick="delete_by_route();" /></td>
</tr>

</table>
</form>		
</body> 
 
</html>