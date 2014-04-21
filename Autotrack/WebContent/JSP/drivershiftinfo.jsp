<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page errorPage="errorpage.jsp" %>
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
    
    function shift_info()
    {
    	
    	if(ShiftInfoValidator())
    	{
    		document.ShiftInfo.action="/Autotrack/ControllerServlet/ShiftInfoService";
    		document.ShiftInfo.submit();
		}
    }
    function shift_info_update()
    {
    
    	document.ShiftInfo.action="../JSP/DriverShiftInfo_Update.jsp";
		document.ShiftInfo.submit();
    	
    }
    function shift_info_delete()
    {
    
    	document.ShiftInfo.action="../JSP/DriverShiftInfo_Update.jsp";
		document.ShiftInfo.submit();
    	
    }
</SCRIPT>
</head> 
<%
String message = request.getParameter("message");
if(message == null){
	message = "";
}
else if(message.equalsIgnoreCase("success")){
	message = "Shift Information Successfully Inserted !!!";
}
else if(message.equalsIgnoreCase("updated")){
	message = "Shift Information Successfully Updated !!!";
}

%>
<body onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">

<div class="content_bg"><span class="content_headning">Driver Information</span></div>
<div style="color: red; font-size: 15px; padding-left: 15px;"><%=message %></div>			
<form method="post" name="ShiftInfo">
                        
<table cellpadding="5px;" cellspacing="5px;" style="font-family:Comic Sans MS,sans-serif; font-size: 14px;">
<tr>
<td style="padding:10px">
Shift ID
</td>
<td>
<input class="field" type="text" name="shift_id" size="50"/>
</td>
</tr>
<tr>
<td>
Start Time
</td>
<td>
<select name="start_time" class="dropdown">
                           	<option>00:00</option><option>00:30</option><option>01:00</option>
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
                           	<option>00:00</option><option>00:30</option><option>01:00</option>
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
<input class="groovybutton" type="button" class="submit" value="Save" onclick="shift_info();"/></td>
<td><input class="groovybutton" type="button" class="submit" value="Update" onclick="shift_info_update();"/>&nbsp;&nbsp;&nbsp;
<input class="groovybutton" type="button" class="submit" value="Delete" onclick="shift_info_delete();"/>
</td>
</tr>
</table>

</form> 

</body> 
 
</html>