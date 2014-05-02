
    <%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*" import="java.sql.*" %>
<%@ page errorPage="errorpage.jsp" %> 
<%@ page import="com.ts.service.dropdown" %> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction;" %>
<META HTTP-EQUIV="REFRESH" CONTENT="2000">

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Welcome to AutoTrack</title>
 

<link rel="stylesheet" href="../css/style.default.css" type="text/css" />
<link rel="stylesheet" href="../prettify/prettify.css" type="text/css" />
<link rel="shortcut icon" href="../images/fav_icon.ico" />

<script type="text/javascript" src="../prettify/prettify.js"></script>
<script type="text/javascript" src="../js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="../js/jquery-migrate-1.1.1.min.js"></script>
<script type="text/javascript" src="../js/jquery-ui-1.9.2.min.js"></script>
<script type="text/javascript" src="../js/jquery.flot.min.js"></script>
<script type="text/javascript" src="../js/jquery.flot.resize.min.js"></script>
<script type="text/javascript" src="../js/bootstrap.min.js"></script>
<script type="text/javascript" src="../js/jquery.cookie.js"></script>
<script type="text/javascript" src="../js/custom.js"></script>

<!--Current Date and Time-->    
<script type="text/javascript" src="../js/current_date.js"></script>


<script type="text/javascript">
function Logout()
{	
	
	self.parent.location="logout.jsp";	
}
function reset()
{
	
	document.dashboard.action="/Autotrack_new/jsp/resetpassword.jsp";
	document.dashboard.submit();
}
</script>


<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" type="text/javascript"></script>

 <script type="text/javascript">

if (GBrowserIsCompatible()) { 

      // A function to create the marker and set up the event window 
      // Dont try to unroll this function. It has to be here for the function closure 
      // Each instance of the function preserves the contends of a different instance 
      // of the "marker" and "html" variables which will be needed later when the event triggers.    
      function createMarker(point,html,status) {
    	
  	  //Start Icon
      
      var myIcon = new GIcon(G_DEFAULT_ICON);
      myIcon.image = "../images/dd-start.png";
      var markerOptions = { icon:myIcon };
     
      //Stop Icon
        var myIcon1 = new GIcon(G_DEFAULT_ICON);
        myIcon1.image = "../images/dd-end.png";
     	var markerOptions1 = { icon:myIcon1 };
      
      if(status == "ON"){
            var marker = new GMarker(point,markerOptions);
      }
      if(status == "OFF"){
          var marker = new GMarker(point,markerOptions1);
    }
      GEvent.addListener(marker, "mouseover", function() {
        marker.openInfoWindowHtml(html);
      });
      return marker;
    }
}


/*  This script and more from http://www.rainbow.arch.scriptmania.com */ 

function waitPreloadPage() { //DOM
if (document.getElementById){
document.getElementById('prepage').style.visibility='hidden';
}else{
if (document.layers){ //NS4
document.prepage.visibility = 'hidden';
}
else { //IE4
document.all.prepage.style.visibility = 'hidden';
}
}
}
// End -->
</SCRIPT>

</head>
<body onLoad="waitPreloadPage();" onunload="GUnload()">
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
                <li class="active"><a href="allvehicle_tracking.jsp"><span class="icon-font"></span> All Vehicle Live Tracking</a></li>
                <li class="dropdown"><a href="#"><span class="icon-signal"></span> Reports</a>
                	<ul>
                    	<li><a href="generalreports.jsp"><span class="icon-signal"></span>General Reports</a></li>
                        <li><a href="userdefined.jsp"><span class="icon-signal"></span>User Defined</a></li>
                    </ul>
                	
                </li>
                <li class="dropdown"><a href="#"><span class="icon-briefcase"></span>Management</a>
                	<ul>
                    	<li><a href="user_account.jsp"><span class="icon-briefcase"></span>User Account</a></li>
                        <li><a href="driver_information.jsp"><span class="icon-briefcase"></span>Driver Information</a></li>
                        <li><a href="customer_information.jsp"><span class="icon-briefcase"></span>Customer Information</a></li>
                        <li><a href="vehicle_register.jsp"><span class="icon-briefcase"></span>Vehicle Information</a></li>
                    </ul>
                </li>
                
            </ul>
        </div><!--leftmenu-->
        
        
       
        
    </div><!--mainleft-->
    <!-- END OF LEFT PANEL -->
    
     <!-- START OF RIGHT PANEL -->
    <div class="rightpanel">
    
      <form name="dashboard" method="post">
    	<div class="headerpanel">
        	<a href="" class="showmenu" title="Close Menu"></a>            
                      
            <div class="headerright">            	
                
    			<div class="dropdown userinfo">
                    <a class="dropdown-toggle" data-toggle="dropdown" data-target="#" href="#">Welcome <%=session.getAttribute("user")%> <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="#"  onclick="reset();"><span class="icon-wrench"></span>Reset Password</a></li>
                        <li class="divider"></li>
                        <li><a href="#" onclick="Logout();"><span class="icon-off" ></span> Sign Out</a></li>
                    </ul>
                </div><!--dropdown-->
    		
            </div><!--headerright-->
            
    	</div><!--headerpanel-->
    	</form>
        <div class="breadcrumbwidget">
        	<ul class="breadcrumb">
                <li><a href="dashboard.jsp">Home</a> <span class="divider">/</span></li>
                <li class="active">All Vehicle Tracking</li>
            </ul>
        </div><!--breadcrumbs-->
        <div class="pagetitle">
        	<h1>All Vehicle Tracking</h1> <span>This is the vehicle live tracking page</span>
        </div><!--pagetitle-->
        
        <div class="maincontent">
        	<div class="contentinner">
            	<h4 class="widgettitle nomargin shadowed">All Vehicle Tracking</h4>
                <div class="widgetcontent bordered shadowed">     
                
               		<div id="map"  style="width: 100%; height: 98%;  border:1px solid black; ">
		
				<%
				//double calculated_fuel_value=0.0;
				//double fuel_in_liters=0.0;
				//String belongs=(String)session.getAttribute("belongs");
				String belongs="owner";
				System.out.println(belongs+"belongs");
				String SQL=null;
				dropdown dd=new dropdown();     
				TreeMap hm = dd.getName(belongs);
				Set sets = hm.entrySet(); 
				Iterator iterator = sets.iterator();   
				int fullsize=hm.size();
				System.out.println("fullsize"+fullsize);
				int count=0;
				int i=0;
				String IMEI[]=new String[fullsize];
				String latitude[]=new String[fullsize];
				String longitude[]=new String[fullsize];
				String customer_name[]=new String[fullsize];
				//String fuel[]=new String[fullsize];
				String mile[]=new String[fullsize];
				String vehicle_number[]=new String[fullsize];
				String Driver_name[]=new String[fullsize];
				String engine_status[]=new String[fullsize];
				String GetData;
				//String fuel_in_ltr[]=new String[fullsize];
				//double empty_fuel_voltage[]=new double[fullsize];
				//double full_fuel_voltage[]=new double[fullsize];
				//double fuel_tank_capacity[]=new double[fullsize];
				try {
						DBTransaction dbtranobj=new DBTransaction();
						Connection connection=dbtranobj.connect();
						Statement mystatement = connection.createStatement();
						Statement stmt = connection.createStatement();
						ResultSet set = null;
						ResultSet rs = null;
			
				// System.out.println(belongs);
				if(belongs.equals("owner"))
				{
					GetData = "select vehicle_information.vehicle_number,vehicle_information.customer_name,recent.imei_no,recent.engine_status,recent.latitude_value,recent.longitude_value,recent.mile from recent inner join vehicle_information on vehicle_information.imei_no=recent.imei_no order by date_time";
				}
				else
				{
					GetData = "select vehicle_information.vehicle_number,vehicle_information.customer_name,recent.imei_no,recent.engine_status,recent.latitude_value,recent.longitude_value,recent.mile from recent inner join vehicle_information on vehicle_information.imei_no=recent.imei_no where vehicle_information.customer_id='"+belongs+"'  order by date_time";
				}
				
				set = mystatement.executeQuery(GetData);
				 //System.out.println(belongs);
				while(set.next())
				{
					IMEI[count]=set.getString("imei_no");
				//	System.out.println(IMEI[count]);
					customer_name[count]=set.getString("customer_name");
					vehicle_number[count]=set.getString("vehicle_number");
					//System.out.println(IMEI[count]);
			
					
					//if(set.next()){
					 latitude[count] = set.getString("latitude_value");
					longitude[count] = set.getString("longitude_value");
					//fuel[i]=set.getString("fuel");
					mile[count]=set.getString("mile");
			//		System.out.println(mile[count]);
					engine_status[count] = set.getString("engine_status");
			//		System.out.println(engine_status[count]);
					if(engine_status[count].equals("0"))
					{
						engine_status[count]="OFF";
						//fuel_in_ltr[i] = "----";
					}
					else
					{
						engine_status[count]="ON";
				
					}
					
					count++;
					
					}//while
					//if close
					if(count==0)
					{%>
						
				<div style="width: 600px; height: 500px; padding-top: 35px"><img src="../images/breakdown.jpg"></div>
						
						
				<%	}
					//for loop
					connection.close();
					mystatement.close();
					set.close();
					} catch (SQLException e) {
					//System.out.println("Connection Failed! Check output console");
					e.printStackTrace();
					//return;	
					}
					catch (ClassNotFoundException e) {
					System.out.println("Where is your PostgreSQL JDBC Driver? "
							+ "Include in your library path!");
					e.printStackTrace();
					return;}
					catch(Exception ee)
					{
						ee.printStackTrace();
					}
%> 
<script type="text/javascript">

	//alert("sdf");
	var marker=new Array();
	var point=new Array();				
	var map = new GMap2(document.getElementById("map"));			
	if (GBrowserIsCompatible()) { 
	    map.setCenter(new GLatLng(13.03243,80.23232),7);
	    map.addControl(new GLargeMapControl());
	      map.addControl(new GMapTypeControl());
	      var i=0;
		<%
		for (int j=0;j<count;j++)
		{
		%>
		
		var HTML = "<table style='font-family:arial; font-size:12px;'>"+
			"<tr><td>Vehicle Number </td><td>:</td><td> <%=vehicle_number[j]%> </td></tr>"+
			"<tr><td>Owned By </td><td>:</td><td> <%=customer_name[j]%></td></tr>"+
			
			"<tr><td>Speed </td><td>:</td><td> <%=mile[j]%> km/hr</td></tr>"+
			
			"<tr><td>Engine Status </td><td>:</td><td> <%=engine_status[j]%> </td></tr>"+
			"</table>";
			
		      point[i] = new GLatLng(<%=latitude[j]%>,<%=longitude[j]%>);
		      marker[i] = createMarker(point[i],HTML,'<%=engine_status[j]%>');
		      map.addOverlay(marker[i]);
		      i++;
		<%}%>
									}  
					</script>
			</div>
                       
                     
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