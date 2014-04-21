<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="errorpage.jsp" %>

<!DOCTYPE html>
<SCRIPT type="text/javascript">

window.history.forward();
function noBack() { window.history.forward(); }
	
	function search()
	{    var shiftid=document.DriverShiftInfo.shift_id.value;
	     if(shiftid == "")
	    	 {
	    	 alert("Enter The Shift ID ");
	    	 
	    	 }
	     else
	    	 {
		document.DriverShiftInfo.action="../JSP/DriverShiftInfoUpdate.jsp";
		document.DriverShiftInfo.submit();
	    	 }
	}
	
	
	 function delete1()
	{
		 var shiftid=document.DriverShiftInfo.shift_id.value;
	     if(shiftid == "")
	    	 {
	    	 alert("Enter The Shift ID ");
	    	 
	    	 }
	     else
	    	 {
		document.DriverShiftInfo.action="../JSP/DriverShiftInfoDelete.jsp";
		document.DriverShiftInfo.submit();
	    	 }
	}
	 
	
	
	
</SCRIPT>
<html xmlns="http://www.w3.org/1999/xhtml"> 
 
<head> 
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



 
<body>

<div class="content_bg"><span class="content_headning">Search</span></div>
		
<form name="DriverShiftInfo">
<table cellspacing="10" style="font-family:Comic Sans MS,sans-serif; font-size: 14px;">
<tr>
<td colspan="3" style="color: red">* Enter the Shift ID</td></tr>
<tr height=15px>
<td>
Shift ID   
</td>
<td>
<input class="field" type="text" name="shift_id"/>
</td>
<td colspan="2" ></td>

</tr>
<tr>
</tr>

<tr>
<td><input class="groovybutton" type="button" value="Update By Shift ID" onclick="search();"></td>
<td>
<input class="groovybutton" type="button" value="Delete By Shift ID" onclick="delete1();">
</td>
</tr>

</table>
</form>		


</body> 
 
</html>