<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page errorPage="errorpage.jsp" %>
     <%@page import="java.sql.*"%>
 <%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
    
<!DOCTYPE html>
<head> 
<link rel="stylesheet" type="text/css" href="../CSS/style.css" />
<script type="text/javascript" src="../JS/validate.js"></script>	
	<title>Autotrack</title> 
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
width:150px;
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
width:200px;
color:#000;
}
</style>
<SCRIPT type="text/javascript">
    window.history.forward();
    function noBack() { window.history.forward(); }
    
    function refresh()
    {
		document.getElementById("shiftid").disabled = true;
	 }
   
    function shift_info_update()
    {
    
    	var shift_id=document.ShiftInfo.shift_id.value;
		document.ShiftInfo.action="/Autotrack/ControllerServlet/ShiftInfoUpdateService?shift_id="+shift_id;
		document.ShiftInfo.submit();

    	
    }
    
</SCRIPT>
</head> 

<%
String shift_id  = request.getParameter("shift_id");
System.out.println(shift_id);
String start_time ="";
String end_time = "";
try{
	  DBTransaction dbtranobj=new DBTransaction();
	  Connection connection=dbtranobj.connect(); 
	  ResultSet rs = null;
	  Statement st=null;
	  st=connection.createStatement();
	  rs = st.executeQuery("SELECT * from shift_info WHERE shift_id = '"+shift_id+"'");
	  
	  while(rs.next()){ 
		  shift_id = rs.getString("shift_id");
		  start_time = rs.getString("start_time"); 
		  end_time = rs.getString("end_time");
		  
	   }
	  connection.close();
	  rs.close();
	  st.close();
    }
   catch(SQLException e)
   { 
	System.err.println(e.getMessage()); 
	} 

%>


<body onload="refresh();">

<div class="content_bg"><span class="content_headning">Driver Information</span></div>		
<form method="post" name="ShiftInfo">
                        
<table cellpadding="5px;" cellspacing="5px;" style="font-family:Comic Sans MS,sans-serif; font-size: 14px;">
<tr>
<td style="padding:10px">
Shift ID
</td>
<td>
<input class="field" id="shiftid" type="text" name="shift_id" size="50" value="<%=shift_id %>"/>
</td>
</tr>
<tr>
<td>
Start Time
</td>
<td>
<select name="start_time" class="dropdown">
                           	<option><%=start_time %></option><option>00:30</option><option>01:00</option>
                        	<option>01:30</option><option>02:00</option><option>02:30</option>
                        	<option>03:00</option><option>03:30</option><option>04:00</option>
                        	<option>04:30</option><option>05:00</option><option>05:30</option>
                        	<option>06:00</option><option>06:30</option><option>07:00</option>
                        	<option>07:30</option><option>08:00</option><option>08:30</option>
                        	<option>09:00</option><option>09:30</option><option>10:00</option>
                        	<option>10:30</option><option>11:00</option><option>11:30</option>
                        	<option>12:00</option><option>12:30</option><option>13:00</option>
                        	<option>13:30</option><option>14:00</option><option>14:30</option>
                        	<option>15:00</option><option>15:30</option><option>16:00</option>
                        	<option>16:30</option><option>17:00</option><option>17:30</option>
                        	<option>18:00</option><option>18:30</option><option>19:00</option>
                        	<option>19:30</option><option>20:00</option><option>20:30</option>
                        	<option>21:00</option><option>21:30</option><option>22:00</option>
                        	<option>22:30</option><option>23:00</option><option>23:30</option>
</select>
</td>
</tr>
<tr>
<td>
End Time
</td>
<td>
<select name="end_time" class="dropdown">
                           	<option><%=end_time %></option><option>00:30</option><option>01:00</option>
                        	<option>01:30</option><option>02:00</option><option>02:30</option>
                        	<option>03:00</option><option>03:30</option><option>04:00</option>
                        	<option>04:30</option><option>05:00</option><option>05:30</option>
                        	<option>06:00</option><option>06:30</option><option>07:00</option>
                        	<option>07:30</option><option>08:00</option><option>08:30</option>
                        	<option>09:00</option><option>09:30</option><option>10:00</option>
                        	<option>10:30</option><option>11:00</option><option>11:30</option>
                        	<option>12:00</option><option>12:30</option><option>13:00</option>
                        	<option>13:30</option><option>14:00</option><option>14:30</option>
                        	<option>15:00</option><option>15:30</option><option>16:00</option>
                        	<option>16:30</option><option>17:00</option><option>17:30</option>
                        	<option>18:00</option><option>18:30</option><option>19:00</option>
                        	<option>19:30</option><option>20:00</option><option>20:30</option>
                        	<option>21:00</option><option>21:30</option><option>22:00</option>
                        	<option>22:30</option><option>23:00</option><option>23:30</option>
</select>
</td>
</tr>
<tr>
<td>
</td>
<td>

<input class="groovybutton" type="button" class="submit" value="Update" onclick="shift_info_update();"/>

</td>
</tr>
</table>

</form> 

</body> 
 
</html>