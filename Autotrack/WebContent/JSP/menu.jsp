<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
  "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<link rel="stylesheet" type="text/css" href="../CSS/accodionstyles.css" />
<title> Menu </title>

<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>



<script type="text/javascript" src="../JS/ddaccordion.js">
	/***********************************************
	 * Accordion Content script- (c) Dynamic Drive DHTML code library (www.dynamicdrive.com)
	 * Visit http://www.dynamicDrive.com for hundreds of DHTML scripts
	 * This notice must stay intact for legal use
	 ***********************************************/
</script>


<script type="text/javascript">
	ddaccordion.init({
		headerclass : "submenuheader", //Shared CSS class name of headers group
		contentclass : "submenu", //Shared CSS class name of contents group
		revealtype : "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
		mouseoverdelay : 200, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
		collapseprev : true, //Collapse previous content (so only one open at any time)? true/false 
		defaultexpanded : [], //index of content(s) open by default [index1, index2, etc] [] denotes no content
		onemustopen : false, //Specify whether at least one header should be open always (so never all headers closed)
		animatedefault : false, //Should contents open by default be animated into view?
		persiststate : false, //persist state of opened contents within browser session?
		toggleclass : [ "", "" ], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
		togglehtml : [ "suffix",
				"<img src='../images/plus.gif' class='statusicon' />",
				"<img src='../images/minus.gif' class='statusicon' />" ], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
		animatespeed : "fast", //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"

	});
</script>


</head>

<body>
<form name="menu" method="post" accept-charset="utf-8"> 
	<div class="home"><img src="../images/home.png" style="margin: 3px;"/></div>
	
	<div class="glossymenu">
		<a href="../JSP/VehicleSummary.jsp?" class="menuitem"
			target="Content">Vehicle Summary</a>
		<a href="../HTML/frame_dashboard.htm" class="menuitem"
			target="Content">Dashboard</a>
		<a href="../JSP/QuickView.jsp" class="menuitem"
			target="Content">Quick View</a> 
			<a
			href="../HTML/frame_livetracking.htm" class="menuitem"
			target="Content">Live Tracking</a> <a
			href="allvehicletracking.jsp" class="menuitem"
			target="Content">All Vehicle Live Tracking</a> <a
			href="../HTML/frame_reports.htm" class="menuitem submenuheader"
			target="Content">Reports</a>
		<div class="submenu">
			<ul>
				<li><a href="../HTML/frame_reports.htm" target="Content">General Report</a></li>
<li><a href="./Report/UDR_Select.jsp" target="Content">User Defined</a></li>
				
			</ul>
		</div>
	
		<%		
		if(session.getAttribute("privilage").equals("Owner")){
		%>
		
		<a href="#" class="menuitem submenuheader" target="Content">Management</a>
		<div class="submenu">
			<ul>
				<li><a href="MGMT_userregistration.jsp" target="Content">User
						Account</a></li>
				<li><a href="MGMT_customerinfo.jsp" target="Content">Customer
						Information</a></li>
				<li><a target="Content" href="MGMT_driverinformation.jsp">Driver Information</a></li>
				<li><a href="MGMT_vehiclereg.jsp" target="Content">Vehicle
						Information</a></li>
				<li><a href="MGMT_tripsheet.jsp" target="Content">Trip Sheet</a></li>
				<li><a href="MGMT_tcss.jsp" target="Content">TCSS Information</a></li>
			</ul>
		</div>
		<%} 
		if(session.getAttribute("privilage").equals("Admin")){
		%>
		
		<a href="#" class="menuitem submenuheader" target="Content">Management</a>
		<div class="submenu">
			<ul>
				<li><a href="MGMT_userregistration.jsp" target="Content">User
						Account</a></li>
				<li><a target="Content" href="MGMT_driverinformation.jsp">Driver Information</a></li>

			</ul>
		</div>
		<%}%>
	</div>
	</form>
</body>
</html>