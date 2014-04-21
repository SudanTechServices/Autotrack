<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="errorpage.jsp" %>
<%@page import="java.sql.*"%>
 <%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
 
<!DOCTYPE html>



<html xmlns="http://www.w3.org/1999/xhtml"> 
 
<head> 
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" /> 
	<title>Autotrack</title> 
<link rel="stylesheet" type="text/css" href="../CSS/style.css" />

<SCRIPT type="text/javascript">

window.history.forward();
function noBack() { window.history.forward(); }

var vehiclenumber_arr = new Array();
<%
int counter=0;
String licence= null, vehiclenumber=null,busroute=null,standard=null, locations = null;
try{
DBTransaction dbtranobj=new DBTransaction();
Connection connection=dbtranobj.connect();
ResultSet set = null;
Statement mystatement = connection.createStatement();

set = mystatement.executeQuery("select DISTINCT vehicle_number from vehicle_information where vehicle_number <> '' order by vehicle_number");
while(set.next())
{
	vehiclenumber = set.getString("vehicle_number");
		%>
		vehiclenumber_arr[<%=counter%>]='<%=vehiclenumber%>';
		<%
	counter++;
}
connection.close();
mystatement.close();
set.close();
}catch(Exception e){}
%>

	function print_vehiclenumber(id){
		// given the id of the <select> tag as function argument, it inserts <option> tags
		var option_str = document.getElementById(id);
		var x, i=0;
		for(x in vehiclenumber_arr){
			
			option_str.options[i++] = new Option(vehiclenumber_arr[x],vehiclenumber_arr[x]);
		}
	}
	
	function search()
	{
		
		
		document.VehicleInfo.action="../JSP/MGMT_vehiclereg_update.jsp";
		document.VehicleInfo.submit();
		
    	
	}

</SCRIPT>
 <script type="text/javascript" src="../JS/validate.js"></script>	
</head> 
 
<body>

<div class="content_bg"><span class="content_headning">Vehicle Information</span></div>
		
<form name="VehicleInfo">
<table cellpadding="0" cellspacing="0" class="table_content" style="width: 100%; background-color: #f8f8f8; border: 1px solid #dfdddb;">
<tr>
<td>
<table cellpadding="4" cellspacing="0" class="table_content" style="width: 35%; background-color: #f8f8f8;">
<tr>
<td width="5%"></td>
<td colspan="4" style="color: red;" width="90%">* Enter the Vehicle Number </td></tr>
<tr height=15px>
<td></td>
<td>
Vehicle Number
</td>
<td>:</td>
<td>
<select id="vehicle_number" name ="vehicle_number" style="width: 200px;" class="tb" >
			 		<option>--Select Route --</option>
			 	</select>
			 	<script type="text/javascript">print_vehiclenumber("vehicle_number");</script>
</td>
<td align="left" width="10%"><input type="button" value="Search" onclick="search();"></td>
<td></td>
</tr>
<tr>
	<td colspan="3" height="20px"></td>
</tr>
</table>
</td>
</tr>
</table>
</form>		


</body> 
 
</html>