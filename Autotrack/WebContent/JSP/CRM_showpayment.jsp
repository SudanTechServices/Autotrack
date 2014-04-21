<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="errorpage.jsp" %>
 <%@page import="java.sql.*"%>
 <%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>

<!DOCTYPE html>
<%
String firstname=request.getParameter("firstname");
String middleintial=request.getParameter("middleinitial");
//System.out.println(middleintial);
String lastname=request.getParameter("lastname");
String age=request.getParameter("age");
String sex=request.getParameter("gender");
String dob=request.getParameter("dob");
String classess=request.getParameter("clas");
String section=request.getParameter("section");
String idnumber=request.getParameter("idnumber");
String transidnumber=request.getParameter("transidnumber");
String parentname=request.getParameter("parentname");
String address=request.getParameter("address");
String route=request.getParameter("route");
String points=request.getParameter("points");
String rate= "";
//String point1 = "",point2 = "",point3 = "",point4 = "",point5 = "";
%>
<SCRIPT type="text/javascript">

window.history.forward();
function noBack() { window.history.forward(); }
function save()
{
	
	document.StudentInfo.action="/Autotrack/ControllerServlet/StudentInfoService?firstname="+'<%=firstname%>'+"&middlename="+'<%=middleintial%>'+"&lastname="+'<%=lastname%>'+"&age="+'<%=age%>'+"&middlename="+'<%=middleintial%>'+"&sex="+'<%=sex%>'+"&dob="+'<%=dob%>'+"&classess="+'<%=classess%>'+"&middlename="+'<%=middleintial%>'+"&section="+'<%=section%>'+"&idnumber="+'<%=idnumber%>'+"&middlename="+'<%=middleintial%>'+"&transidnumber="+'<%=transidnumber%>'+"&middlename="+'<%=middleintial%>'+"&parentname="+'<%=parentname%>'+"&address="+'<%=address%>'+"&route="+'<%=route%>'+"&points="+'<%=points%>'+"";
	document.StudentInfo.submit();

}
	
</SCRIPT>

<html xmlns="http://www.w3.org/1999/xhtml"> 
 
<head> 
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" type="text/javascript"></script>


	<meta http-equiv="Content-type" content="text/html; charset=utf-8" /> 
	<title>Autotrack</title> 
	<link rel="stylesheet" type="text/css" href="../CSS/style.css" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
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
 
<body onload="refresh();">

	


<div class="content_bg"><span class="content_headning">Your Transportation Fees Details</span></div>
<form name="StudentInfo" method="post">
<table border="1" style="background-color:#BDE6FC; font-family:Comic Sans MS,sans-serif; borderColor="black" cellPadding="0" cellSpacing="0" height="63">
<tr>
<td style="color:#ffffff; background-color:#0088DD; padding: 10px">
First Name   
</td>
<td style="font-size: 15; color: blue; padding-left:8px;">
<%= firstname %>
</td>
</tr>

<tr>
<td style="color:#ffffff; background-color:#0088DD; padding: 10px">
Middle Initial   
</td>
<td style="font-size: 15; color: blue; padding-left:8px;">
<%= middleintial %>
</td>
</tr>
<tr>

<td style="color:#ffffff; background-color:#0088DD; padding: 10px">
Last Name    
</td>
<td style="font-size: 15; color: blue; padding-left:8px;">
<%= lastname %>
</td>
</tr>

<tr>
<td style="color:#ffffff; background-color:#0088DD; padding: 10px">
Age           
</td>
<td style="font-size: 15; color: blue; padding-left:8px;">
<%= age %>
</td>

</tr>
<tr>
<td style="color:#ffffff; background-color:#0088DD; padding: 10px">
Gender           
</td>
<td style="font-size: 15; color: blue; padding-left:8px;">
<%= sex %>
</td>
</tr>

<tr>
<td style="color:#ffffff; background-color:#0088DD; padding: 10px">
Data Of Birth           
</td>
<td style="font-size: 15; color: blue; padding-left:8px;">
<%= dob %>
</td>
</tr>

<tr>
<td style="color:#ffffff; background-color:#0088DD; padding: 10px">
Class         
</td>
<td style="font-size: 15; color: blue; padding-left:8px;">
<%= classess %>
</td><tr><td style="color:#ffffff; background-color:#0088DD; padding: 10px">
Section : </td>
<td style="font-size: 15; color: blue; padding-left:8px;">
<%= section %></td>
</tr>

<tr>
<td style="color:#ffffff; background-color:#0088DD; padding: 10px">
ID Card Number
</td>
<td style="font-size: 15; color: blue; padding-left:8px;">
<%= idnumber %>
</td>
</tr>

<tr>
<td style="color:#ffffff; background-color:#0088DD; padding: 10px">
Transport ID Card Number
</td>
<td style="font-size: 15; color: blue; padding-left:8px;">
<%= transidnumber %>
</td>
</tr>

<tr>
<td style="color:#ffffff; background-color:#0088DD; padding: 10px">
Parents/Guardian's Name  
</td>
<td style="font-size: 15; color: blue; padding-left:8px;">
<%= parentname %>
</td>
</tr>

<tr>
<td style="color:#ffffff; background-color:#0088DD; padding: 10px">
Address      
</td>
<td style="font-size: 15; color: blue; padding-left:8px;">
<%= address %>
</td>
</tr>

<tr>
<td style="color:#ffffff; background-color:#0088DD; padding: 10px">Selected Route</td><td style="font-size: 15; color: blue; padding-left:8px;"><%= route %></td>
</tr>
<tr>			
<td style="color:#ffffff; background-color:#0088DD; padding: 10px">Your Pick point Comes Under </td><td style="font-size: 15; color: blue; padding-left:8px;"><%= points %></td>
			
			 <script language="javascript">print_routes("route");</script>
		
</tr>
<tr><td style="color:#ffffff; background-color:#0088DD; padding: 10px"> Your Should Pay a Fee of Rs : </td><td style="font-size: 25; color: red; padding-left:8px;"> 
<%
try{
	 DBTransaction dbtranobj=new DBTransaction();
	 Connection connection=dbtranobj.connect();
	 ResultSet set = null;
	 Statement mystatement = connection.createStatement();
	 set = mystatement.executeQuery("select * from route_registration where bus_route_number='"+route+"'");
	 while(set.next())
	 {
		 if(points.equalsIgnoreCase(set.getString(4)))
		 rate = set.getString(5);
		 else if(points.equalsIgnoreCase(set.getString(6)))
		 rate = set.getString(7);
		 else if(points.equalsIgnoreCase(set.getString(8)))
			 rate = set.getString(9);
		 else if(points.equalsIgnoreCase(set.getString(10)))
			 rate = set.getString(11);
		 else if(points.equalsIgnoreCase(set.getString(12)))
			 rate = set.getString(13);
	 }
	 connection.close();
	 mystatement.close();
	 set.close();
}
catch(SQLException e){
	
}
%>
<%=rate %> 
</td></tr></table>

<div style="padding: 20px;"><input type="button" value="Pay Your Fees" onclick="save();"></div>

</form>		
		
</body> 
 
</html>