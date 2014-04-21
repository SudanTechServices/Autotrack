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
String sex=request.getParameter("sex");
String dob=request.getParameter("dob");
String classess=request.getParameter("class");
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


<html xmlns="http://www.w3.org/1999/xhtml"> 
 
<head> 
<SCRIPT type="text/javascript">

window.history.forward();
function noBack() { window.history.forward(); }


	function save()
	{
		
		document.StudentInfo.action="/Autotrack/ControllerServlet/StudentInfoService?firstname="+'<%=firstname%>'+"&middlename="+'<%=middleintial%>'+"&lastname="+'<%=lastname%>'+"&age="+'<%=age%>'+"&middlename="+'<%=middleintial%>'+"&sex="+'<%=sex%>'+"&dob="+'<%=dob%>'+"&classess="+'<%=classess%>'+"&middlename="+'<%=middleintial%>'+"&section="+'<%=section%>'+"&idnumber="+'<%=idnumber%>'+"&middlename="+'<%=middleintial%>'+"&transidnumber="+'<%=transidnumber%>'+"&middlename="+'<%=middleintial%>'+"&parentname="+'<%=parentname%>'+"&address="+'<%=address%>'+"&route="+'<%=route%>'+"&points="+'<%=points%>'+"";
		document.StudentInfo.submit();

	}
	
	
</SCRIPT>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" type="text/javascript"></script>


	<meta http-equiv="Content-type" content="text/html; charset=utf-8" /> 
	<title>Autotrack</title> 
	
	<link rel="stylesheet" href="../css/reset.css" type="text/css" media="screen" title="no title" />
	<link rel="stylesheet" href="../css/text.css" type="text/css" media="screen" title="no title" />
	<link rel="stylesheet" href="../css/form.css" type="text/css" media="screen" title="no title" />
	<link rel="stylesheet" href="../css/buttons.css" type="text/css" media="screen" title="no title" />
	<link rel="stylesheet" href="../css/grid.css" type="text/css" media="screen" title="no title" />	
	<link rel="stylesheet" href="../css/layout1.css" type="text/css" media="screen" title="no title" />	
	<link rel="stylesheet" href="../css/custom.css" type="text/css" media="screen" title="no title" />	
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
<script type="text/javascript">
	

 </script>
 

	
</head> 
 
<body onload="refresh();">
<form name="StudentInfo" method="post">
<div id="wrapper">
	
	<div id="top">
		
		<div class="content_pad">
			<ul class="left">
			<li><a href="#" class=""><span class="ui-icon ui-icon-person"></span>Last login: <%=session.getAttribute("sessionuser")%></a></li>
			</ul>
			<ul class="right">
				<li><a href="#" class=""><span class="ui-icon ui-icon-person"></span>Logged in as <%=session.getAttribute("user")%></a></li>
				
	<!-- 			<li><a href="./pages/settings.html">Settings</a></li> -->
				<li><a href="../JSP/Logout.jsp">Logout</a></li>
			</ul>
		</div> <!-- .content_pad -->
		
	</div> <!-- #top -->	
	
	<div id="header">
		
		<div class="content_pad">
			<h1><a href="#">Trans Workx</a></h1>
				<ul id="nav">
				<li class="nav_icon"><a href="../JSP/home.jsp" target="_top"><span class="ui-icon ui-icon-home"></span>Home</a></li>
				<li class="nav_icon "><a href="../HTML/frames_livetracking.html" target="_top"><span class="ui-icon ui-icon-gripsmall-diagonal-se"></span>Live Tracking</a>	
				</li>
				<li class="nav_icon"><a href="../HTML/frames_dashboard.html" target="_top"><span class="ui-icon ui-icon-gear"></span>DashBoard</a></li>
				<li class="nav_icon"><a href="../HTML/frames_allvehiclelivetracking.html" target="_top"><span class="ui-icon ui-icon-gear"></span>All Vehicle Live Tracking</a></li>
				<li class="nav_icon "><a href="../HTML/frames_reports.html" target="_top"><span class="ui-icon ui-icon-signal"></span>Reports</a></li>
				
				<!-- <div class="nav_menu">
						 <ul>
							<li><a href="frames.html" target="_top" >Basic Reports</a></li>
							<li><a href="#" target="_top">User Defined Reports</a></li>
						
						</ul>
					</div> -->
					
					
				<%if ((session.getAttribute("privilage").equals("Owner")) || (session.getAttribute("privilage").equals("Admin"))) {%>
				<li class="nav_icon  nav_current"><a href="StudentRegistration.jsp" target="_top"><span class="ui-icon ui-icon-signal"></span>CRM</a>
				<li class="nav_icon "><a href="../HTML/frames_management.html" target="_top"><span class="ui-icon ui-icon-signal"></span>Management</a>
									 
				</li>
				<%} %>
			</ul><!-- .content_pad -->
	</div> <!-- #masthead -->			
		</div> <!-- .content_pad -->
		
	</div> <!-- #header -->	
	
		
	<div id="content" class="xgrid" style="height: 345px;">
		
		<div id="welcome" class="x12">	


<div><h2>Your Transportation Fees Details</h2></div>
<table cellspacing="10">
<tr>
<td>
First Name   
</td>
<td style="font-size: 15; color: blue">
<%= firstname %>
</td>
</tr>

<tr>
<td>
Middle Initial   
</td>
<td style="font-size: 15; color: blue">
<%= middleintial %>
</td>
</tr>
<tr>

<td>
Last Name    
</td>
<td style="font-size: 15; color: blue">
<%=lastname%>
</td>
</tr>

<tr>
<td>
Age           
</td>
<td style="font-size: 15; color: blue">
<%= age %>
</td>

</tr>
<tr>
<td>
Gender           
</td>
<td style="font-size: 15; color: blue">
<%= sex %>
</td>
</tr>

<tr>
<td>
Data Of Birth           
</td>
<td style="font-size: 15; color: blue">
<%= dob %>
</td>
</tr>

<tr>
<td>
Class         
</td>
<td style="font-size: 15; color: blue">
<%= classess %>
</td><tr><td>
Section : </td>
<td style="font-size: 15; color: blue">
<%= section %></td>
</tr>

<tr>
<td>
ID Card Number
</td>
<td style="font-size: 15; color: blue">
<%= idnumber %>
</td>
</tr>

<tr>
<td>
Transport ID Card Number
</td>
<td style="font-size: 15; color: blue">
<%= transidnumber %>
</td>
</tr>

<tr>
<td>
Parents/Guardian's Name  
</td>
<td style="font-size: 15; color: blue">
<%= parentname %>
</td>
</tr>

<tr>
<td>
Address      
</td>
<td style="font-size: 15; color: blue">
<%= address %>
</td>
</tr>

<tr>
<td>Selected Route</td><td style="font-size: 15; color: blue"><%= route %></td>
</tr>
<tr>			
<td>Your Pick point Comes Under </td><td style="font-size: 15; color: blue"><%= points %></td>
			
			 <script language="javascript">print_routes("route");</script>
		
</tr>
<tr><td> Your Should Pay a Fee of Rs : </td><td style="font-size: 25; color: red"> 
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
</td></tr>
<tr><td></td><td></td><td><div id="show_fare" style="color: red"></div></td></tr>

<tr><td></td><td><input type="button"  class="submit" value="Pay Your Fees" onclick="save();"></td></tr>
</table>

		</div> <!-- .x4 -->
				
	</div> <!-- #content -->
	
	<div id="footer">		
		<div class="content_pad">			
			<p>&copy; 2012 Copyright TransNetworkx. Powered by <a href="#">Digital Astraa Solutions Pvt Ltd</a>.</p>
		</div> <!-- .content_pad -->
	</div> <!-- #footer -->		
	
</form>
</body> 
 
</html>