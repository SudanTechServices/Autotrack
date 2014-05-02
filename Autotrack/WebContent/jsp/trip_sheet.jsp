<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page errorPage="errorpage.jsp" %>
 <%@ page import="java.util.*" %>
 <%@page import="java.sql.*"%>
 <%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
 <%@ page import="com.ts.service.dropdown" %> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Welcome to AutoTrack</title>


<link rel="stylesheet" href="../css/style.default.css" type="text/css" />
<link rel="stylesheet" href="../prettify/prettify.css" type="text/css" />
<script type="text/javascript" src="../prettify/prettify.js"></script>
<script type="text/javascript" src="../js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="../js/jquery-migrate-1.1.1.min.js"></script>
<script type="text/javascript" src="../js/jquery-ui-1.9.2.min.js"></script>
<script type="text/javascript" src="../js/jquery.flot.min.js"></script>
<script type="text/javascript" src="../js/jquery.flot.resize.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<script type="text/javascript" src="../js/jquery.cookie.js"></script>
<script type="text/javascript" src="../js/custom.js"></script>
<link rel="shortcut icon" href="../images/fav_icon.ico" />
<!--[if lte IE 8]>
<script language="javascript" type="text/javascript" src="../js/excanvas.min.js"></script><![endif]-->


<!--Current Date and Time-->    
<script type="text/javascript" src="../js/current_date.js"></script>

</head>
<body>
<div class="mainwrapper">
	
    <!-- START OF LEFT PANEL -->
    <div class="leftpanel">
    	
       <div class="logopanel">
        	<h1><a href="dashboard.jsp"><img src="../images/pro_logo.png" /></a></h1>
        </div><!--logopanel--><div class="datewidget"><span id="date"></span></div>
    
    	<div class="searchwidget">
        	<form action="livetracking.jsp" method="post">
            	<div class="input-append">
                    <input type="text" class="span2 search-query" placeholder="Search here...">
                    <button type="submit" class="btn"><span class="icon-search"></span></button>
                </div>
            </form>
        </div><!--searchwidget-->
        
        <div class="leftmenu">        
            <ul class="nav nav-tabs nav-stacked">
            	<li class="nav-header">Main Navigation</li>
                <li><a href="dashboard.jsp"><span class="icon-align-justify"></span> Dashboard</a></li>
                <li><a href="summery.jsp"><span class="icon-picture"></span> Summary</a></li>
                <li><a href="quickview.jsp"><span class="icon-th-list"></span> Quick View</a></li>                
                <li><a href="livetracking.jsp"><span class="icon-pencil"></span> Live Tracking by Vehicle </a></li>
                <li><a href="allvehicle_tracking.jsp"><span class="icon-font"></span> All Vehicle Live Tracking</a></li>
                <li class="dropdown"><a href="#"><span class="icon-signal"></span> Reports</a>
                	<ul>
                    	<li><a href="generalreports.jsp"><span class="icon-pencil"></span>General Reports</a></li>
                        <li><a href="userdefined.jsp"><span class="icon-pencil"></span>User Defined</a></li>
                    </ul>
                	
                </li>
                <li class="active dropdown"><a href="#"><span class="icon-briefcase"></span>Management</a>
                	<ul>
                    	<li><a href="user_account.jsp"><span class="icon-th-list"></span>User Account</a></li>
                        <li><a href="driver_information.jsp"><span class="icon-th-list"></span>Driver Information</a></li>
                        <li><a href="customer_information.jsp"><span class="icon-th-list"></span>Customer Information</a></li>
                        <li><a href="vehicle_register.jsp"><span class="icon-th-list"></span>Vehicle Information</a></li>
                        <li><a href="trip_sheet.jsp"><span class="icon-th-list"></span>Trip Sheet</a></li>
                        <li><a href="tcss_information.jsp"><span class="icon-th-list"></span>TCSS Information</a></li>
                         <li><a href="sblt_tripsheet.jsp"><span class="icon-th-list"></span>SBLT Trip Sheet</a></li>
                    </ul>
                </li>
                
            </ul>
        </div><!--leftmenu-->
        
        
       
        
    </div><!--mainleft-->
    <!-- END OF LEFT PANEL -->
    
    <!-- START OF RIGHT PANEL -->
    <div class="rightpanel">
    	<div class="headerpanel">
        	<a href="" class="showmenu"></a>
            
            <div class="headerright">
            	<div class="dropdown notification">
                    <a class="dropdown-toggle" data-toggle="dropdown" data-target="#" href="/page.jsp">
                    	<span class="iconsweets-globe iconsweets-white"></span>
                    </a>
                    <ul class="dropdown-menu">
                    	<li class="nav-header">Notifications</li>
                        <li>
                        	<a href="">
                        	<strong>3 people viewed your profile</strong><br />
                            <img src="../images/thumbs/thumb1.png" alt="" />
                            <img src="../images/thumbs/thumb2.png" alt="" />
                            <img src="../images/thumbs/thumb3.png" alt="" />
                            </a>
                        </li>
                        <li><a href=""><span class="icon-envelope"></span> New message from <strong>Saamy GM</strong> <small class="muted"> - 19 hours ago</small></a></li>
                        <li><a href=""><span class="icon-envelope"></span> New message from <strong>VJ Vasu</strong> <small class="muted"> - 2 days ago</small></a></li>
                        <li><a href=""><span class="icon-user"></span> <strong>Thiru</strong> is now following you <small class="muted"> - 2 days ago</small></a></li>
                        <li class="viewmore"><a href="">View More Notifications</a></li>
                    </ul>
                </div><!--dropdown-->
                
    			<div class="dropdown userinfo">
                    <a class="dropdown-toggle" data-toggle="dropdown" data-target="#" href="/page.jsp">Hi, Saamy GM! <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="editprofile.jsp"><span class="icon-edit"></span> Edit Profile</a></li>
                        <li class="divider"></li>
                        <li><a href=""><span class="icon-wrench"></span> Account Settings</a></li>
                        <li><a href=""><span class="icon-eye-open"></span> Privacy Settings</a></li>
                        <li class="divider"></li>
                        <li><a href="index.jsp"><span class="icon-off"></span> Sign Out</a></li>
                    </ul>
                </div><!--dropdown-->
    		
            </div><!--headerright-->
            
    	</div><!--headerpanel-->
        <div class="breadcrumbwidget">
        	<ul class="breadcrumb">
                <li><a href="dashboard.jsp">Home</a> <span class="divider">/</span></li>
                <li><a href="#">Management</a> <span class="divider">/</span></li>
                <li class="active">Trip Sheet</li>
            </ul>
        </div><!--breadcrumbs-->
        <div class="pagetitle">
        	<h1>Trip Sheet</h1> <span>This is the new trip sheet creation page</span>
        </div><!--pagetitle-->
        
        <div class="maincontent">
        	<div class="contentinner">
            	<h4 class="widgettitle nomargin shadowed">Create Trip Sheet</h4>
                <div class="widgetcontent bordered shadowed"> 
                
                <form class="stdform" name="TripSheet" method="post" action="tripsheet_insertrecord.jsp">
                
                		<p>
                        	<label>Trip Sheet For</label>
                        	<%
							java.text.DateFormat df = new java.text.SimpleDateFormat("dd/MM/yyyy");
							String todaysdate = df.format(new java.util.Date());
							%>
                            <span class="field"><input type="text" id="date" name="date" class="input-medium"  /></span>
                        </p>
                        
                        <p>
                        	<label>Day</label>
                        	<% 
								int s_no = 1;
							 	String day = null;
								Date date = new Date(); 
							   int dayno = date.getDay();
							   if(dayno == 0){ day = "Sunday";}
							   else if(dayno == 1){ day = "Monday";}
							   else if(dayno == 2){ day = "Tuesday";}
							   else if(dayno == 3){ day = "Wednesday";}
							   else if(dayno == 4){ day = "Thursday";}
							   else if(dayno == 5){ day = "Friday";}
							   else if(dayno == 6){ day = "Saturday";}
%>
                            <span class="field"><input type="text" name="day" class="input-medium" id="days" value="<%=day %>" disabled="disabled" /></span>
                        </p>
                                            
                        <p>
                        	<label>Vehicle</label>
                            <span class="field"><input type="text" name="vehicle" class="input-xlarge" placeholder="Vehicle" /></span>
                        </p>
                        
                        <p>
                        	<label>Route</label>
                            <span class="field"><input type="text" name="route" class="input-xlarge" placeholder="Route" /></span>
                        </p>
                        
                        <p>
                        	<label>Start KM</label>
                            <span class="field"><input type="text" name="startkm" class="input-xlarge" placeholder="Start KM" /></span>
                        </p>
                        
                         <p>
                        	<label>Close KM</label>
                            <span class="field"><input type="text" name="closekm" class="input-xlarge" placeholder="Close KM" /></span>
                        </p>
                        
                         <p>
                        	<label>Run KM</label>
                            <span class="field"><input type="text" name="runkm" class="input-xlarge" placeholder="Run KM" /></span>
                        </p>
                                                
                         <p>
                        	<label>Present Children</label>
                            <span class="field"><input type="text" name="presentchildren" class="input-xlarge" placeholder="Present Children" /></span>
                        </p>   
                        <p>
                        	<label>Out Time</label>
                            <span class="field"><input type="text" name="outtime" class="input-xlarge" placeholder="Out Time" /></span>
                        </p>   
                        
                        <p>
                        	<label>In Time</label>
                            <span class="field"><input type="text" name="intime" class="input-xlarge" placeholder="In Time" /></span>
                        </p>   
                        
                        <p>
                        	<label>Driver Name</label>
                            <span class="field"><input type="text" name="drivername" class="input-xlarge" placeholder="Driver Name" /></span>
                        </p>   
                        
                        <p>
                        	<label>TCSS</label>
                            <span class="field"><input type="text" name="tcss" class="input-xlarge" placeholder="TCSS" /></span>
                        </p>   
                        
                        <p>
                        	<label>Inserted By</label>
                            <span class="field"><input type="text" name="insertedby" class="input-xlarge" placeholder="Inserted By" /></span>
                        </p>                         
                         	                 
                                                
                        <p class="stdformbutton">
                            <button class="btn btn-success">Save</button>
                        </p>
                                                
                    </form>  
                       
                </div><!--widgetcontent-->                
               
               
            </div><!--contentinner-->
        </div><!--maincontent-->
        
    </div><!--mainright-->
    <!-- END OF RIGHT PANEL -->
    
    <div class="clearfix"></div>
    
   <div class="footer">
    	<div class="footerleft">Auto Track</div>
    	<div class="footerright">&copy; 2014,&nbsp;<a href="www.sudantechservices.com">Sudan Tech Services</a> </div>
    </div><!--footer-->

    
</div><!--mainwrapper-->
</body>
</html>