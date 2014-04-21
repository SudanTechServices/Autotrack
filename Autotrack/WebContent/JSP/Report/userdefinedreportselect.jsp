<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script language="javascript" type="text/javascript" src="../../JS/datetimepicker.js"></script>

<script type="text/javascript">
function show_UserDefinedReport(){
	
	 	document.userdefinedreport.action="AJAX_UserDefinedReport.jsp";
	   	document.userdefinedreport.target="ReportWindow";
		document.userdefinedreport.submit();
	
}
</script>


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
<body>
<form name="userdefinedreport">
<table>
	<tr><td>Vehicle:</td></tr>
	<tr><td>

<%@ page import="com.ts.service.dropdown" %> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*" %>
<%	
String belongs=(String)session.getAttribute("belongs");
dropdown up=new dropdown();     
TreeMap hashmap = up.getName(belongs);  
Set set=hashmap.entrySet();
  
Iterator iterator = set.iterator();   
  
out.println("<select name='vehicle_number' class='dropdown'>");   

while(iterator.hasNext()){   
     //String temp = iterator.next().toString();
     Map.Entry me = (Map.Entry)iterator.next();
     out.println("<option class='blue' value=\"" + me.getValue() + "\">" + me.getKey() + "</option>");   
}   
  
out.println("</select>");   

%>

 </td></tr>
 
 <tr>
	   <td id="start_date_label">
	  <label> Start Date And Time</label>
	  </td>
	  </tr>
	  <tr>
	 
	  	<td id="start_date_input">
	  		<input class="field" type="Text" id="demo1" maxlength="25" size="10" name="start_date"><a href="javascript:NewCal('demo1','mmmddyyyy',true,24)"><img src="../../images/calendar_icon.gif" width="16" height="16" border="0" alt="Pick a date"></a>
	  		
	  	</td>
	  </tr>
	  <tr>
	   <td id="end_date_label">
	  <label> End Date And Time</label>
	  </td>
	  </tr>
	  <tr>
	 
	  	<td id="end_date_input">
	  		<input class="field" type="Text" id="demo2" maxlength="25" size="10" name="end_date"><a href="javascript:NewCal('demo2','mmmddyyyy',true,24)"><img src="../../images/calendar_icon.gif" width="16" height="16" border="0" alt="Pick a date"></a>
	  		
	  	</td>
	  </tr>
 
 <tr><td>Select fields</td></tr>
 <tr>
 	<td>
		 <input type="checkbox" name="id" value="imei_no"> IMEI <BR>
		 <input type="checkbox" name="id" value="latitude_value"> Latitude <BR>
		 <input type="checkbox" name="id" value="longitude_value"> Longitude <BR>
		 <input type="checkbox" name="id" value="date_time"> Date <BR>
		 <input type="checkbox" name="id" value="fuel"> Fuel <BR>
		 <input type="checkbox" name="id" value="mile"> Miles <BR>
		 <input type="checkbox" name="id" value="device_battery"> Device Battery <BR>
		 <input type="checkbox" name="id" value="vehicle_battery"> Vehicle Battery <BR>
 	</td>
 </tr>
 	
 
 <tr>
	 <td><input class="groovybutton" type="button" name="search" value="Get Report" onclick="show_UserDefinedReport();"></td>
</tr>
</table>
</form>
</body>
</html>