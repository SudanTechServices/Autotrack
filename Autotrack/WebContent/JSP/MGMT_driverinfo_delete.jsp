<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page errorPage="errorpage.jsp" %>
     <%@ page import="com.ts.service.dropdown" %> 
     <%@ page import="com.ts.service.ShiftNumberDropdown" %> 
	<%@ page import="java.util.ArrayList" %>
	<%@ page import="java.util.*" %>
	 <%@page import="java.sql.*"%>
 <%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
	
<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml"> 
 
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

<script type="text/javascript">


     function noBack() 
     { 
    	 window.history.forward(); 
     }
   
     function diver_info_delete()
     {
     	    	
    	
    			var license_number=document.DriverInfo.license_number.value;
    			document.DriverInfo.action="/Autotrack/ControllerServlet/DriverInfoDeleteService?license_number="+license_number;
    			document.DriverInfo.submit();
    
    			
     }
     
     function refresh()
     {
 		document.getElementById("licencenum").disabled = true;
 	 }
    
</script>	
</head> 


<%
String license_number  = request.getParameter("license_number");
System.out.println(license_number);
String driver_name ="";
String gender = "";
String contact_no=" ";
String address = "";
String date_of_birth= "";
String date_of_joining=" ";
String date_of_issue = "";
String date_of_expiry="";
String vehicle_number="";
String shift_number= "";
String route_number="";



try{
	  DBTransaction dbtranobj=new DBTransaction();
	  Connection connection=dbtranobj.connect(); 
	  ResultSet rs = null;
	  Statement st=null;
	  st=connection.createStatement();
	  rs = st.executeQuery("SELECT * from driver_info WHERE license_number = '"+license_number+"'");
	  
	  while(rs.next()){ 
		  license_number = rs.getString("license_number");
		  driver_name = rs.getString("driver_name"); 
		  gender = rs.getString("gender");
		  contact_no = rs.getString("contact_no");
		  address = rs.getString("address");
		  date_of_birth = rs.getString("dob");
		  date_of_joining = rs.getString("doj");
		  date_of_issue = rs.getString("doi");
		  date_of_expiry = rs.getString("doe");
		  vehicle_number = rs.getString("vehicle_number");
		  shift_number = rs.getString("shift_number");
		  route_number = rs.getString("route_number");
		 
	  
   }

		 connection.close();
		 rs.close();
			st.close();
}catch(SQLException e){ System.err.println(e.getMessage()); } 

%>

<body onload="refresh();">
<div class="content_bg"><span class="content_headning">Driver Information</span></div>				 
<form method="post" name="DriverInfo">
                     
<table cellpadding="5px;" cellspacing="5px;" style="font-family:Comic Sans MS,sans-serif; font-size: 14px;">
<tr>
<td>
License Number
</td>
<td>
<input class="field" type="text" id="licencenum" name="license_number" size="50" value="<%=license_number %>"/>
</td>
</tr>

<tr>
<td>
Name
</td>
<td>
<input class="field" type="text" name="driver_name" size="50" value="<%=driver_name %>"/>
</td>
</tr>

<tr>
<td>
Sex
</td>
<td>
<input class="field" type="text" name="gender" size="50" value="<%= gender %>"/>
</td>
</tr>

<tr>
<td>
Contact Number
</td>
<td>
<input class="field" type="text" name="contact_no" size="50" value="<%=contact_no %>"/>
</td>
</tr>
<tr>
<td>Address
</td>
<td>
<input class="field" type="text" name="address" size="50" value="<%=address %>"/>
</td>
</tr>
<tr>
<td>
Date Of Birth
</td>
<td>
<input class="field" type="text" name="date_of_birth" size="50" value="<%=date_of_birth %>"/>Date format :DD/MM/YY
</td>
</tr>
<tr>
<td>
Date Of Joining
</td>
<td>
<input class="field" type="text" name="date_of_joining" size="50" value="<%=date_of_joining %>"/>Date format :DD/MM/YY
</td>
</tr>
<tr>
<td>
Date Of issue
</td>
<td>
<input class="field" type="text" name="date_of_issue" size="50" value="<%=date_of_issue %>"/>Date format :DD/MM/YY
</td>
</tr>

<tr>
<td>
Date Of Expiry
</td>
<td>
<input class="field" type="text" name="date_of_expiry" size="50" value="<%=date_of_expiry %>"/>Date format :DD/MM/YY
</td>
</tr>
<tr>
<td>
Vehicle Number
</td>
<td>
<select name="vehicle_number" class="dropdown">
                       <%	
                       String belongs=(String)session.getAttribute("belongs");
								dropdown dd=new dropdown();     
								TreeMap hm1 = dd.getName(belongs);
								Set sets1 = hm1.entrySet(); 
								Iterator iterator1 = sets1.iterator();   
								  
								
								out.println("<option class='blue'>"+vehicle_number+"</option>"); 
								while(iterator1.hasNext()){   
								     //String temp = iterator.next().toString();
								     Map.Entry me1 = (Map.Entry)iterator1.next();
								     out.println("<option class='blue'>" + me1.getKey() + "</option> ");   
								}   
  

%>
</select>
</td>
</tr>
<tr>
<td>
Shift Number
</td>
<td>
<select name="shift_number" class="dropdown">
                       <%	
								ShiftNumberDropdown SD=new ShiftNumberDropdown();     
								HashMap hm = SD.getName();
								Set sets = hm.entrySet(); 
								Iterator iterator = sets.iterator();   
								  
								
								out.println("<option class='blue'>"+shift_number+"</option>"); 
								while(iterator.hasNext()){   
								     //String temp = iterator.next().toString();
								     Map.Entry me = (Map.Entry)iterator.next();
								     out.println("<option class='blue'>" + me.getKey() + "</option> ");   
								}   
  

							%>
</select>
</td>
</tr>

<tr>
<td>
Route Number
</td>
<td>
<input class="field" type="text" name="Route_number" size="50" value="<%= route_number %>"/>
</td>
</tr>

<tr>
<td></td>
<td>

<input class="groovybutton" type="button" class="submit" value="Delete" onclick="diver_info_delete();"/>
</td>
</tr>
</table>

</form> 
          				

</body> 
 
</html>