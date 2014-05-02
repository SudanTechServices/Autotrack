<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="java.sql.*"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.concurrent.TimeUnit" %>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction" %>
<%@ page errorPage="errorpage.jsp" %>

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

<script language="javascript">
function goLite(FRM,BTN)
{
   window.document.forms[FRM].elements[BTN].style.color = "#FFFF99";
   window.document.forms[FRM].elements[BTN].style.backgroundColor = "#11AAEE";
}

function goDim(FRM,BTN)
{
   window.document.forms[FRM].elements[BTN].style.color = "#EEFFFF";
   window.document.forms[FRM].elements[BTN].style.backgroundColor = "#0088DD";
}
geo = new GClientGeocoder();
function get_address(lat1,lang,noofid){
	//alert(noofid);
	//alert(lat1);
	//alert(lang);
	 var lat = lat1;
	    var lon = lang;
	    
       var search =''+lat+','+lon+'';
      
       // ====== Perform the Geocoding ======        
       geo.getLocations(search, function (result)
         { 
       	
           if (result.Status.code == G_GEO_SUCCESS) {
           
             for (var i=0; i<result.Placemark.length; i++) {
              /// var p = result.Placemark[i].Point.coordinates;
              // var marker = new GMarker(new GLatLng(p[1],p[0]));
              
              var addres=result.Placemark[i].address;
      
       if(addres=="")
    	   {
    	  // alert('blank');
    	   document.getElementById("msg"+noofid).innerHTML="Unable to find location";
    	   }
       else
    	   {
              document.getElementById("msg"+noofid).innerHTML =result.Placemark[i].address;
    	   }
        //alert("address");
             }
       
           }
           // ====== Decode the error status ======
           else {
             var reason="Code "+result.Status.code;
             if (reasons[result.Status.code]) {
               reason = reasons[result.Status.code];
             } 
             alert('Could not find "'+search+ '" ' + reason);
           }
         }
       );
	
}


</script>
 

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
                <li><a href="summary.jsp"><span class="icon-picture"></span> Summary</a></li>
                <li class="active"><a href="quickview.jsp"><span class="icon-th-list"></span> Quick View</a></li>                
                <li><a href="livetracking.jsp"><span class="icon-pencil"></span> Live Tracking by Vehicle </a></li>
                <li><a href="allvehicle_tracking.jsp"><span class="icon-font"></span> All Vehicle Live Tracking</a></li>
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
                <li class="active">Quick View</li>
            </ul>
        </div><!--breadcrumbs-->
        <div class="pagetitle">
        	<h1>Quick View</h1> <span>This is the new Quick View page</span>
        </div><!--pagetitle-->
        
        <div class="maincontent">
        	<div class="contentinner">
            	<h4 class="widgettitle nomargin shadowed">Quick View</h4>
                
                
                <div class="widgetcontent bordered shadowed">
  
            	<table class="table table-bordered">
                    <colgroup>
                        <col class="con0">
                        <col class="con1">
                        <col class="con0">
                        <col class="con1">
                        <col class="con0">
                        <col class="con1">
                        <col class="con0">
                        
                    </colgroup>
                    <thead>                       
                        <tr>
							<th class="center">Vehicle Number</th>
							<th class="center">Date/Time</th>
							<th class="center">Engine Status</th>
							<th class="center">Speed (km/hr)</th>
							<th class="center">GEO-Fence</th>
							<th class="center">Fuel %</th>
							<th class="center">Idle Time</th>
						</tr>
                    </thead>
                    <tbody>
                        <tr class="gradeX odd">
                        <%
//String belongs=(String)session.getAttribute("belongs");
                        String belongs="owner";
String vehicle_number,engine_status,mile,fuel,alarm_type,fence;
String date_time,halt_time,imei_no;




try{
	DBTransaction dbtranobj=new DBTransaction();
	Connection connection=dbtranobj.connect();
//Connection conn = null;
//Class.forName("org.postgresql.Driver").newInstance();
//conn = DriverManager.getConnection("jdbc:postgresql://192.168.1.95:5432/master_database","postgres", "postgres");
ResultSet rs = null;
Statement st=null;
st=connection.createStatement();
System.out.println("belongs to ="+belongs);
String SQL;
if(belongs.equals("owner"))
{
	SQL="select vehicle_information.vehicle_number,recent.imei_no,recent.alarm_type,recent.engine_status,date_time,recent.latitude_value,recent.longitude_value,recent.mile,recent.fuel from recent inner join vehicle_information on vehicle_information.imei_no=recent.imei_no order by date_time";
}
else
{
	SQL="select vehicle_information.vehicle_number,recent.imei_no,recent.alarm_type,recent.engine_status,date_time,recent.latitude_value,recent.longitude_value,recent.mile,recent.fuel from recent inner join vehicle_information on vehicle_information.imei_no=recent.imei_no where vehicle_information.customer_id='"+belongs+"'  order by date_time";
}
rs = st.executeQuery(SQL);
//rs = st.executeQuery("SELECT latitude_value,longitude_value,engine_status,date_time FROM tracking WHERE imei_no ='"+imeinumber+"' and date_time>='"+startdate+"' and date_time<='"+enddate+"'");


//int count = 1;

while(rs.next()){ 
	vehicle_number=rs.getString("vehicle_number");
	imei_no=rs.getString("imei_no");
	engine_status=rs.getString("engine_status");
	date_time=rs.getString("date_time");
	mile=rs.getString("mile");
	fuel=rs.getString("fuel");
	alarm_type=rs.getString("alarm_type");
if(alarm_type==null)
	alarm_type="AA";
date_time=date_time.substring(0,16);
fuel=fuel.substring(2);
//System.out.println("after substring "+date_time);



		//System.out.println(noofid);
%>
                        
                        	<!-- <td><a href="../JSP/dashboardlivetracking.jsp?IMEI=<%=imei_no%>"target="Content"><%=vehicle_number %></a></td> -->
                            <td><%=vehicle_number %></td>
                            <td><%=date_time %></td>
                            <%
                            if(engine_status.equals("0"))
{
	
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	Date date=new Date();
	Date date2=new Date();
	//date_time="6/14/2013 11:25";
		date= df.parse(date_time);
	//   System.out.println(date);
		  String cur=df.format(date2);
		  date2= df.parse(cur);
//		  System.out.println(date2);
	//  System.out.println( new java.util.Date().getTime() - date.getTime());
	//  int diff = (int)(Math.abs(date.getTime() - date2.getTime()) / 1000)/60;
	// System.out.println(diff);
	halt_time = String.format("%d hour(s) %d min(s)", TimeUnit.MILLISECONDS.toHours(Math.abs(date.getTime() - date2.getTime())),
	         TimeUnit.MILLISECONDS.toMinutes(Math.abs(date.getTime() - date2.getTime())) - TimeUnit.HOURS.toMinutes(TimeUnit.MILLISECONDS.toHours(Math.abs(date.getTime() - date2.getTime()))));
	
%>
                            
                            <td class="center"><span class="btn btn-danger" title="Engine Off">Engine Off</span></td>
                            <%}
								else
								{
									halt_time="Running";
							%>
                            <td class="center"><span class="btn btn-success" title="Engine Off">Engine On</span></td>
                            <%
								}
							%>
                            <td><%=mile %></td>
                            <%
								if(alarm_type.equals("42"))
								{
									fence="OUT";
								}
								else
								{
									fence="IN";
								}
							%>
                            <td><%=fence %></td>
                            <td><%=fuel %></td>  
                            <td><%=halt_time %></td>
                        </tr>
                        <%

}//while
connection.close();
rs.close();
st.close();
}catch(SQLException e){ System.out.println(e.getMessage()); } 
%>
</tbody>
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