<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="errorpage.jsp" %>
 <%@page import="java.sql.*"%>
 <%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"> 
 
<head> 
<SCRIPT type="text/javascript">

window.history.forward();
function noBack() { window.history.forward(); }
	function delete1()
	{
		var idnumber=document.StudentRegInfo.idnumber.value;
		document.StudentRegInfo.action="/Autotrack/ControllerServlet/StudentRegDeleteService?idnumber="+idnumber;
		document.StudentRegInfo.submit();
		
	}
	/* function refresh(){
		
		document.getElementById("transportnum").disabled = true;
	} */
	
	
function refresh(){
		
		
		document.getElementById("inum").disabled = true;
	} 
	
 
</script>

 
 

 

	<meta http-equiv="Content-type" content="text/html; charset=utf-8" /> 
	<title>Autotrack</title> 
<link rel="stylesheet" type="text/css" href="../CSS/style.css" />

</head> 
 
<%
String idnumber  = request.getParameter("idnumber");
String first_name ="";
String middle_name = "";
String last_name = "";
String age=" ";
String sex=" ";
String date_of_birth= "";
String clas = "";
String section = "";
String parent_name="";
String id_card_number="";
String transport_number="";
String bus_route_number= "";
String stopping_limits="";
String address="";


try{
	
	DBTransaction dbtranobj=new DBTransaction();
	Connection connection=dbtranobj.connect();  
	  ResultSet rs = null;
	  Statement st=null;
	  st=connection.createStatement();
	  rs = st.executeQuery("SELECT * from student WHERE id_card_number = '"+idnumber+"'");
	  
	  while(rs.next()){ 
		  bus_route_number = rs.getString("bus_route_number");
		  first_name = rs.getString("first_name"); 
		  middle_name = rs.getString("middle_name");
		  last_name = rs.getString("last_name");
		  age = rs.getString("age");
		  sex = rs.getString("sex");
		  date_of_birth = rs.getString("date_of_birth");
		  clas = rs.getString("class");
		  section = rs.getString("section");
		  parent_name = rs.getString("parent_name");
		  id_card_number = rs.getString("id_card_number");
		  transport_number = rs.getString("transport_id_number");
		  stopping_limits = rs.getString("stopping_limits");
		  address = rs.getString("address");
	  
   }
	  connection.close();
		st.close();
		rs.close();
}catch(SQLException e){ System.err.println(e.getMessage()); } 

%>

 
<body onload="refresh();">

<div class="content_bg"><span class="content_headning">Student Transport Form</span></div>	
		
<form name="StudentRegInfo" method="post">

<table cellpadding="2px;" cellspacing="4px;" class="table_content" style="width: 50%; background-color: #f1fafc;">
<tr>
<td>
<table cellpadding="2px;" cellspacing="4px;" class="table_content" style="width: 50%; background-color: #f1fafc;">
<tr>
<td>
ID Card Number
</td>
<td>:</td>
<td>
<input class="field" id="inum" type="text" name="idnumber" value="<%= idnumber %>"/>
</td>
</tr>
<tr>
<td>
First Name   
</td>
<td>:</td>
<td>
<input class="field" type="text" name="firstname" value="<%= first_name %>"/>
</td>
</tr>

<tr>
<td>
Middle Initial   
</td>
<td>:</td>
<td>
<input class="field" type="text" name="middleinitial" value="<%= middle_name %>"/>
</td>
</tr>
<tr>

<td>
Last Name    
</td>
<td>:</td>
<td>
<input class="field" type="text" name="lastname" value="<%= last_name %>"/>
</td>
</tr>

<tr>
<td>
Age           
</td>
<td>:</td>
<td>
<input class="field" type="text" name="age" value="<%= age %>"/>
</td>

</tr>
<tr>
<td>
Sex           
</td>
<td>:</td>
<td>
<input class="field" type="text" name="gender"  value="<%= sex %>"/>
</td>
</tr>

<tr>
<td>
Date Of Birth           
</td>
<td>:</td>
<td>
<input class="field" type="text" name="dob" value="<%= date_of_birth %>"/>
</td>
</tr>

<tr>
<td>
Class         
</td>
<td>:</td>
<td>
<input type="text" name="clas" size="4x;" value="<%= clas %>"/>

  Section  &nbsp;<input type="text" name="section" size="4px;" value="<%= section %>"/></td>
</tr>
<tr>
<td>
Transport ID Card Number
</td>
<td>:</td>
<td>
<input  type="text" name="transidnumber" value="<%= transport_number %>"  />
</td>
</tr>

<tr>
<td>
Parents/Guardian's Name  
</td>
<td>:</td>
<td>
<input type="text" name="parentname" value="<%= parent_name %>"/>
</td>
</tr>

<tr>
<td>
Address      
</td>
<td>:</td>
<td>
<textarea name="address" rows="3" cols="20"  style="resize: none; background-color:#B8E2FA;" ><%= address %></textarea>
</td>
</tr>
<tr>
<td>Select Route</td><td><input type="text" name ="route" value="<%=bus_route_number %>"/>
			
Pick Points &nbsp;<input type="text"  class="field" name ="pickpoint" value="<%=stopping_limits %>"/></td>
			 
			 
		
</tr>



<tr>
<td>
</td>
<td><input type="button"  class="submit" value="Delete" onclick="delete1();"></td></tr>
</table>
</td>
</tr>
</table>
</form>	


</body> 
 
</html>