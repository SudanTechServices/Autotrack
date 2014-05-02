
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.*"%>
 <%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
 <%@ page errorPage="errorpage.jsp" %>
 <!DOCTYPE html>
  <html xmlns="http://www.w3.org/1999/xhtml"> 
<head> 
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" /> 

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
<script type="text/javascript" src="../js/vehicle_validate.js"></script> 
<SCRIPT type="text/javascript">
window.history.forward();
function noBack() { window.history.forward(); }
	
	function update()
{
		
		if(vehicleFormValidator())
			{
			
			var vehicle_number=document.VehicleInfo.vehicle_number.value;
			
			
		document.VehicleInfo.action="/Autotrack/ControllerServlet/VehicleInfoUpdateDeleteService?vehicle_number="+vehicle_number+"&action1=update";//it go to controllerservlet and after that it go to UpdateDeleteService
		document.VehicleInfo.submit();
		
			}
	}
	
	function delete1()
	{
		var vehicle_number=document.VehicleInfo.vehicle_number.value;
		document.VehicleInfo.action="/Autotrack/ControllerServlet/VehicleInfoUpdateDeleteService?vehicle_number="+vehicle_number+"&action1=delete";//it go to controllerservlet and after that it go to UpdateDeleteService
		document.VehicleInfo.submit();
	
	}
	
</script>

</head> 

<%

String vehicle_number=request.getParameter("vehicle_number");

String customer_id  = "customer_id";
String customer_name ="customer_name";
String vehicle_type = "vehicle_type";
String fuel_tank_capacity="fuel_tank_capacity";
String sim_no="sim_no";
String imei_no= "imei_no";
String camera_id= "camera_id";
String vehicle_mfg= "vehicle_mfg";
String max_speed= "max_speed";
String fuel_sender= "fuel_sender";
String empty_fuel_voltage= "empty_fuel_voltage";
String full_fuel_voltage= "full_fuel_voltage";


try{
DBTransaction dbtranobj=new DBTransaction();
Connection connection=dbtranobj.connect();
  ResultSet rs = null;
  Statement st=null;
  st=connection.createStatement();
  rs = st.executeQuery("SELECT * from vehicle_information WHERE vehicle_number='"+vehicle_number+"'");
  
  while(rs.next()){ 
	  customer_id = rs.getString("customer_id");
	 // System.out.print(customer_id);
	  vehicle_number = rs.getString("vehicle_number");
	  customer_name = rs.getString("customer_name"); 
	  //System.out.println(customer_name);
	  
	  vehicle_type = rs.getString("vehicle_type");
	  fuel_tank_capacity = rs.getString("fuel_tank_capacity");
	  sim_no = rs.getString("sim_no");

	  imei_no = rs.getString("imei_no");
	  //System.out.println(imei_no);
	  camera_id = rs.getString("camera_id");
	  vehicle_mfg = rs.getString("vehicle_mfg");
	  max_speed = rs.getString("max_speed");
	  fuel_sender = rs.getString("fuel_sender");
	 // System.out.println(fuel_sender);
	  empty_fuel_voltage = rs.getString("empty_fuel_voltage");
	  full_fuel_voltage = rs.getString("full_fuel_voltage");
	 
  
}
	
	connection.close();
	st.close();
	rs.close();


}catch(SQLException e){ System.err.println(e.getMessage()); } 

%>

<body onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">

<%

String message = request.getParameter("message");
String mode=request.getParameter("mode");


if(message == null){
	message = "";
}
else if(message.equalsIgnoreCase("success")){
	message = "Vehicle Registered Successfully !!";
}
else if(message.equalsIgnoreCase("updated")){
	message = "Vehicle Information Updated Successfully !!";
}
else if(message.equalsIgnoreCase("deleted")){
	message = "Vehicle Information Deleted Successfully !!";
	
}
else if(message.equalsIgnoreCase("exist")){
	message = "Vehicle Number Already Exist !!";
}

%>

</head>
<body>
<div class="mainwrapper">
	
    <!-- START OF LEFT PANEL -->
    <div class="leftpanel">
    	
       <div class="logopanel">
        	<h1><a href="dashboard.jsp"><img src="../images/pro_logo.png" /></a></h1>
        </div><!--logopanel--><div class="datewidget"><span id="date"></span></div>
    
    	<div class="searchwidget">
        	<form  method="post">
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
                <li class="active">Vehicle Information</li>
            </ul>
        </div><!--breadcrumbs-->
        <div class="pagetitle">
        	<h1>Vehicle Information</h1> <span>This is the new user creation page</span>
        </div><!--pagetitle-->
        
        <div class="maincontent">
        	<div class="contentinner">
            	<h4 class="widgettitle nomargin shadowed">Vehicle Registeration</h4>
                <div class="widgetcontent bordered shadowed">
                
                	
                    <form name="VehicleInfo" method="post"  class="stdform">
                    	<p>
                        	<label>Customer ID </label>
                            <span class="field"><input type="text" name="customer_id" id="customer_id" value="<%=customer_id %>" class="input-xlarge" placeholder="Customer ID" />
                     
			 	<script language="javascript">print_customerid("customer_id");</script>
                            
                            </span>
                        </p>
                    	
                        
                        <p>
                        	<label>Vehicle Number</label>
                            <span class="field"><input type="text" name="vehicle_number" id="vehicle_number" value="<%=vehicle_number %>"  class="input-xlarge" placeholder="Vehicle Number" /></span>
                        </p>
                        
                        <p>
                        	<label>Customer Name </label>
                            <span class="field"><input type="text" name="customer_name" id="customer_name" value="<%=customer_name %>" class="input-xlarge" placeholder="Customer Name" /></span>
                        </p>
                        
                        <p>
                        	<label>Mobile Number</label>
                            <span class="field"><input type="text" name="sim_no" id="sim_no" value="<%=sim_no %>" class="input-xlarge" placeholder="Mobile Number" /></span>
                        </p>
                        
                         <p>
                        	<label>IMEI Number </label>
                            <span class="field"><input type="text" name="IMEI_no" id="IMEI_no" value="<%=imei_no %>" class="input-xlarge" placeholder="IMEI Number" /></span>
                        </p>
                        
                         <p>
                        	<label>Camera ID</label>
                            <span class="field"><input type="text" name="camera_id" id="camera_id" value="<%=camera_id %>" class="input-xlarge" placeholder="Camera ID" /></span>
                        </p>
                        <p>
                        	<label>Vehicle Type </label>
                            <span class="field"><input type="text" name="vehicle_type" id="vehicle_type" value="<%=vehicle_type %>" class="input-xlarge" placeholder="Vehicle Type " /></span>
                        </p>
                        
                         <p>
                        	<label>Vehicle Manufacturer</label>
                            <span class="field"><input type="text" name="vehicle_mfg" id="vehicle_mfg" value="<%=vehicle_mfg %>" class="input-xlarge" placeholder="Vehicle Manufacturer" /></span>
                        </p>
                        
                        <p>
                        	<label>Vehicle Fuel Tank Capacity</label>
                            <span class="field"><input type="text" name="fuel_tank_capacity" id="fuel_tank_capacity" value="<%=fuel_tank_capacity %>" class="input-xlarge" placeholder="Tank Capacity" /></span>
                        </p>
                         
                         <p>
                        	<label>Fuel Sender Unit</label>
                          <span class="field">
                           
                              <select
									 name="select" class="uniformselect" name="fuel_sender" id="fuel_sender" >
									 <option><%=fuel_sender %></option>
										<option value="">Select One</option>
										<option value="">Potentiometric N</option>
										<option value="">Capacitance N</option>
								</select>
                            
                          
                            </span>
                        </p>
                        
                        <p>
                        	<label>Max Speed </label>
                            <span class="field"><input type="text" name="max_speed" id="max_speed" value="<%=max_speed %>" class="input-xlarge" placeholder="Max Speed" /></span>
                        </p>
                        
                        <p>
                        	<label>Empty Fuel Voltage</label>
                            <span class="field"><input type="text" name="empty_fuel_voltage" id="empty_fuel_voltage" value="<%=empty_fuel_voltage %>" class="input-xlarge" placeholder="Empty Fuel Voltage" /></span>
                        </p>
                        
                        <p>
                        	<label>Full Fuel Voltage </label>
                            <span class="field"><input type="text" name="full_fuel_voltage" id="full_fuel_voltage" value="<%=full_fuel_voltage %>" class="input-xlarge" placeholder="Full Fuel Voltage " /></span>
                        </p>
			                 
                                                
                        <p class="stdformbutton">
                       			<input type="submit" class="btn btn-success" value="Update" onclick="update();"/>
		                        <input type="submit" class="btn btn-success" value="Delete" onclick="delete1();"/>
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