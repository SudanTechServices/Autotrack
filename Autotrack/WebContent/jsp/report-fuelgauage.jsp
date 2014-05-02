   
    <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.Date" import="java.text.*" import="java.util.Calendar"%>
     <%@page import="java.sql.*"%>
     <%@ page import ="java.util.Arrays"%>
    <%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
    <%@ page import=" org.apache.commons.math.util.MathUtils"%>
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

<!-- Fuel Chart -->
 <script type='text/javascript' src='https://www.google.com/jsapi'></script>

    <script type='text/javascript'>
      google.load('visualization', '1', {packages:['gauge']});

      google.setOnLoadCallback(drawChart);
      
        
        <%
      //  DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      //  Calendar cal = Calendar.getInstance();
      //  String Current_time = dateFormat.format(cal.getTime());
        
        
  	  
  	  String imeinumber = request.getParameter("vehicle_number");
  	  System.out.println("imeinumber"+imeinumber);
  	  
  	  double fuel_from_db=0.00;
  	  double prev_fuel_from_db=0.00;
  	double	additional_fuel_from_db=0.00;
  	  double fuel_tank_capacity = 0.00;
  	 double empty_fuel_voltage = 0.00;
  	 double full_fuel_voltage = 0.00;
  	// double calculated_current_fuel = 0.00;
  	int current_fuel = 0;
  	//float fuel=.
  	 //int actual_fuel;
  	  
  	  try{
  	  DBTransaction dbtranobj=new DBTransaction();
  	  Connection connection=dbtranobj.connect();
  	  ResultSet rs = null;
  	//ResultSet rs1 = null;
  	  Statement st=null;
  	  st=connection.createStatement();
  	  rs = st.executeQuery("SELECT fuel FROM tracking WHERE imei_no ='"+imeinumber+"' and mile >='10' order by date_time desc limit 25 ");
  		while(rs.next()){ 
  	  	 
    	  fuel_from_db=(Double.parseDouble(rs.getString(1)));
    	//  if(prev_fuel_from_db=fuel_from_db;)
    	  System.out.println("actual fuel "+fuel_from_db);
    	  additional_fuel_from_db+=fuel_from_db;
    	 // System.out.println("additional fuel "+fuel_from_db);
    	 // System.out.println(fuel_from_db);
    	  //prev_fuel_from_db=fuel_from_db;
    	  }
  		fuel_from_db=additional_fuel_from_db/25;//average fuel
  		System.out.println("avg fuel "+fuel_from_db);
    		  
  	   rs = st.executeQuery("SELECT fuel_tank_capacity FROM vehicle_information WHERE imei_no ='"+imeinumber+"'");
  	  
  	while(rs.next()){ 
  	  	 
  		  //empty_fuel_voltage = (Double.parseDouble(rs.getString(1)));
  	     // full_fuel_voltage = (Double.parseDouble(rs.getString(2)));
    	  fuel_tank_capacity=rs.getDouble("fuel_tank_capacity");
    	  }
  		

	connection.close();
	st.close();
	rs.close();
  	  } catch(SQLException e) { 
  		  System.err.println(e.getMessage());
		} 
  	  
  	 /*  if(fuel_from_db>0.00)
  	  {
  		//calculated_current_fuel = (fuel_from_db - empty_fuel_voltage)/(full_fuel_voltage - empty_fuel_voltage)*100;
  	  } */
  	  if(fuel_from_db!=0.00)
  	  {
  	//calculated_current_fuel = (fuel_from_db - empty_fuel_voltage)/(full_fuel_voltage - empty_fuel_voltage)*100;
  	current_fuel = (int)(fuel_from_db*fuel_tank_capacity);
  	System.out.println("before round "+current_fuel);
  	current_fuel=(int)(MathUtils.round(current_fuel, -1));
  	System.out.println("After round "+current_fuel);
 	//System.out.println(MathUtils.round(current_fuel, -1));


  	  }
  	  
  	  else
  		  current_fuel=0;
  	  %>
        
        
        
  	
    function drawChart() {
  	  
      var data = google.visualization.arrayToDataTable([
        ['Label', 'Value'],
        ['Fuel', <%=current_fuel%>]
     ]);

     var maximum = <%=fuel_tank_capacity%>;
     //var redfrm = 0 - 10;
    // var redto = 0 - 20;
    // var yellowfrm = 0 - 20;
    // var yellowto = 0-25;


        var options = {
 	  max:maximum,
          width: 600, height: 300,
          redFrom:0, redTo: 15,
          yellowFrom:15, yellowTo:25,
	 
          minorTicks: 10
        };

        var chart = new google.visualization.Gauge(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>
</head>
<body>
<div class="mainwrapper">
	
    <!-- START OF LEFT PANEL -->
    <div class="leftpanel">
    	
        <div class="logopanel">
        	<h1><a href="dashboard.jsp"><img src="../images/pro_logo.png" /></a></h1>
        </div><!--logopanel-->
        
        <div class="datewidget"><span id="date"></span></div>
    
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
                <li class="active dropdown"><a href="#"><span class="icon-signal"></span> Reports</a>
                	<ul>
                    	<li><a href="generalreports.jsp"><span class="icon-pencil"></span>General Reports</a></li>
                        <li><a href="userdefined.jsp"><span class="icon-pencil"></span>User Defined</a></li>
                    </ul>
                	
                </li>
                <li class="dropdown"><a href="#"><span class="icon-briefcase"></span>Management</a>
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
                <li><a href="#">Report</a> <span class="divider">/</span></li>
                <li class="active">General Reports</li>
            </ul>
        </div><!--breadcrumbs-->
        <div class="pagetitle">
        	<h1>General Reports</h1> <span>This is the General Reports page</span>
        </div><!--pagetitle-->
        
        <div class="maincontent">
        	<div class="contentinner">
            	<h4 class="widgettitle nomargin shadowed">General Reports</h4>
                <div class="widgetcontent bordered shadowed">     
                
                <form class="stdform" action="#" method="post">
                	                   
                    	<div class="span3">                    
                        <p>
                        	<label>Device Vehicle No</label>
                            <span class="field">
                            <select name="select" class="uniformselect">
                            	<option value="">Please Select One</option>
                            	<option value="" >TN 03 C 4286</option>
                            	<option value="">TN 76 U 3086</option>
                                <option value="">TN 76 Z 3445</option>
                            </select>      
                                                
                            </span>
                           	
                        </p> 
                         <p>
                        	<label>Select Report Type</label>
                            <span class="field">
                            <select name="select" class="uniformselect">
                            	<option value="">Please Select One</option>
                            	<option value="">Speed</option>
                                <option value="">Speed (Exception)</option>
                                <option value="">Engine Status</option>
                                <option value="">Halt Time</option>
                                <option value="">Trip Info</option>
                                <option value="">Fuel(Grid View)</option>                            
                                <option value="">Fuel(Dynamic Reports)</option>
                                <option value="">Course Taken(Map View)</option>
                                <option value="">Out of fence(Map View)</option>
                                <option value="">Out of fence report</option>
                            </select>      
                                                
                            </span>
                           	
                        </p> 
                       
                            </div>
                            
                            <div class="span5">
                            	 <p>
                               		 <label>Start Date</label>
                               		 <input id="datepicker" type="text" name="date" placeholder="Start Date" class="input-small" /> &nbsp; <small><em>mm / dd / yyyy</em></small>
                            <div class="widgetsource">
                            	<div class="divider15"></div>
                            	<pre class="prettyprint linenums">&lt;input id=&quot;datepicker&quot; type=&quot;text&quot; name=&quot;date&quot; /&gt;</pre>
                              <div class="divider15"></div>
                                <pre class="prettyprint linenums">jQuery( &quot;#datepicker&quot; ).datepicker();</pre>
                            </div><!--widgetsource-->
                            	</p>
                         	   <p>
                               		 <label>End Date</label>
                                	 <input id="datepicker1" type="text" name="date" placeholder="End Date" class="input-small" /> &nbsp; <small><em>mm / dd / yyyy</em></small>
                            <div class="widgetsource">
                            	<div class="divider15"></div>
                            	<pre class="prettyprint linenums">&lt;input id=&quot;datepicker&quot; type=&quot;text&quot; name=&quot;date&quot; /&gt;</pre>
                              <div class="divider15"></div>
                                <pre class="prettyprint linenums">jQuery( &quot;#datepicker&quot; ).datepicker();</pre>
                            </div><!--widgetsource-->
                            </p>
                            </div>
                            
                            <div class="span2">
                            	<p>                            	
                                 	<button class="btn">Get Report</button> 
                                </p>                                
                            </div>                                              	
                       
                  </form>    
                   
                   
                   <table cellpadding="0" cellspacing="0" border="0" width="100%" align="center">
				  		<tr>
				  			<td align="center">
				  				<div id='chart_div'></div>
				  			</td>
				  		</tr>
				  </table>
                                       
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