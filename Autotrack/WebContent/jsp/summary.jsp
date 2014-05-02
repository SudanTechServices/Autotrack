<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
<!--[if le IE 8]>
<script language="javascript" type="text/javascript" src="../js/excanvas.min.js"></script><![endif]-->


<!--Current Date and Time-->
<script type="text/javascript" src="../js/current_date.js"></script>
<link rel="stylesheet" type="text/css" href="../CSS/style.css" />

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


<%
		int count=0;
		String counter;
		int rowcount=0;
		%>
<script
	src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M"
	type="text/javascript"></script>

<script type="text/javascript">
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
			 var lat = lat1;
			    var lon = lang;
			    
		       var search =''+lat+','+lon+'';
		      
		       // ====== Perform the Geocoding ======        
		       geo.getLocations(search, function (result)
		         { 
		       	
		           if (result.Status.code == G_GEO_SUCCESS) {		           
		             for (var i=0; i<result.Placemark.length; i++) {		              
		              var addres=result.Placemark[i].address;
		              document.getElementById("firstlat"+noofid).innerHTML=addres;
		      
		       if(addres=="")
		    	   { 
		    	   document.getElementById("msg"+noofid).innerHTML="Unable to find location";
		    	   }
		       else
		    	   {
		              document.getElementById("msg"+noofid).innerHTML =result.Placemark[i].address;
		    	   }		       
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
		
		function previous(count){
			var counter = parseInt(count);

		//var counter='<%=count-10%>';
			counter=counter-10;

			 document.vehiclesummary.action="../jsp/summary.jsp?offset="+counter+"";//it go to controllerservlet and after that it go to LoginService
				document.vehiclesummary.submit();
				
		}
		function next(count){
			var counter = parseInt(count);

		//	var counter='<%=count+10%>';
		counter=counter+10;

					
			 document.vehiclesummary.action="../jsp/summary.jsp?offset="+counter+"";//it go to controllerservlet and after that it go to LoginService
				document.vehiclesummary.submit();
			
			
		}		
		</script>


</head>
<!-- <script type="text/javascript">
		 
			function redirect_to_pdf(startdate,enddate,imeinumber)
			{
			    //alert('jhgdsfhjsdvgf');
				document.pdf.action="Engine_Report_PDF.jsp?start_date="+startdate+"&end_date="+enddate+"&imeinumber="+imeinumber+"";
				document.pdf.submit();
			}
			 function redirect_to_excel(startdate,enddate,imeinumber)
			{
				document.pdf.action="/Autotrack/Excel_Engine_Status_Report?startdate="+startdate+"&enddate="+enddate+"&imeinumber="+imeinumber+"";
				document.pdf.submit();
			} 
			</script> -->

</head>
<body>
	<div class="mainwrapper">

		<!-- START OF LEFT PANEL -->
		<div class="leftpanel">

			<div class="logopanel">
				<h1>
					<a href="dashboard.jsp"><img src="../images/pro_logo.png" /></a>
				</h1>
			</div>
			<!--logopanel-->

			<div class="datewidget">
				<span id="date"></span>
			</div>

			<div class="searchwidget">
				<form action="livetracking.jsp" method="post">
					<div class="input-append">
						<input type="text" class="span2 search-query"
							placeholder="Search here...">
						<button type="submit" class="btn">
							<span class="icon-search"></span>
						</button>
					</div>
				</form>
			</div>
			<!--searchwidget-->

			<div class="leftmenu">
				<ul class="nav nav-tabs nav-stacked">
					<li class="nav-header">Main Navigation</li>
					<li><a href="dashboard.jsp"><span
							class="icon-align-justify"></span> Dashboard</a></li>
					<li class="active"><a href="Summary.jsp"><span
							class="icon-picture"></span> Summary</a></li>
					<li><a href="quickview.jsp"><span class="icon-th-list"></span>
							Quick View</a></li>
					<li><a href="livetracking.jsp"><span class="icon-pencil"></span>
							Live Tracking by Vehicle </a></li>
					<li><a href="allvehicle_tracking.jsp"><span
							class="icon-font"></span> All Vehicle Live Tracking</a></li>
					<li class="dropdown"><a href="#"><span class="icon-signal"></span>
							Reports</a>
						<ul>
							<li><a href="generalreports.jsp"><span class="icon-signal"></span>General Reports</a></li>
							<li><a href="userdefined.jsp"><span class="icon-signal"></span>User Defined</a></li>
						</ul></li>
					<li class="dropdown"><a href="#"><span
							class="icon-briefcase"></span>Management</a>
						<ul>
							<li><a href="user_account.jsp"><span
							class="icon-briefcase"></span>User Account</a></li>
							<li><a href="driver_information.jsp"><span
							class="icon-briefcase"></span>Driver Information</a></li>
							<li><a href="customer_information.jsp"><span
							class="icon-briefcase"></span>Customer Information</a></li>
							<li><a href="vehicle_register.jsp"><span
							class="icon-briefcase"></span>Vehicle Information</a></li>
						</ul></li>

				</ul>
			</div>
			<!--leftmenu-->




		</div>
		<!--mainleft-->
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
			
			</div>
			</form>
			<!--headerpanel-->
			<div class="breadcrumbwidget">
				<ul class="breadcrumb">
					<li><a href="dashboard.jsp">Home</a> <span class="divider">/</span></li>
					<li class="active">Summary</li>
				</ul>
			</div>
			<!--breadcrumbs-->
			<div class="pagetitle">
				<h1>Summary</h1>
				<span>This is the new Summary page</span>
			</div>
			<!--pagetitle-->

			<div class="maincontent">
				<div class="contentinner">
					<h4 class="widgettitle nomargin shadowed">Vehicle Summary</h4>
					<div class="widgetcontent bordered shadowed">

						<div id="tabs">
							<ul>
								<li><a href="#tabs-1" style="color: #87c703;"><span
										class="icon-eye-open"></span> ACTIVE</a></li>
								<li><a href="#tabs-2" style="color: red;"><span
										class="icon-eye-open"></span> INACTIVE</a></li>
							</ul>
							<div id="tabs-1">
								<table class="table table-bordered">
									<colgroup>
				                        <col class="con0">
				                        <col class="con1">
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
											<th class="center">Start Date and Time</th>
											<th class="center">Vehicle<br/>Start Point</th>
											<th class="center">Current Status</th>
											<th class="center">Start Fuel(Ltr)</th>
											<th class="center">Current Fuel(Ltr)</th>
											<th class="center">Fuel Consumed(Ltr)</th>
											<th class="center">Fuel Summary</th>
											<th class="center">Fuel Gauge</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<%
		
		
		counter=request.getParameter("offset");
		System.out.println("counter value="+counter);
		if(counter==null)
		{
			count=0;
			System.out.println("counter="+count+"");
		}
		else
		{
			count=Integer.parseInt(counter);
			System.out.println("else counter="+count+"");
			if(count<0)
				count=0;
			
		}
		Date date=new Date();
		Date date2=new Date();
		int diff,intfuel,intcurrentfuel;
		SimpleDateFormat df=null;
		String imei_no="",firstlat="",firstlong="",currentfuel="",currentlat="",currentlong="",currentengine="",fuelconsumed="";
		int fuelconsume;
		double fuel_tank_capacity;
		int fuelinltr,currentfuelinltr,consumefuelinltr;
		String belongs=(String)session.getAttribute("belongs");
		//String belongs="owner";
		String vehicle_number,engine_status,mile,fuel,alarm_type,fence;
		String date_time,halt_time,newtime;
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//   Date d1=new Date();
		// System.out.println(d1);
		String datetime=sdf.format(cal.getTime());
		datetime=datetime.concat(" 00:00:00");
	//	System.out.println(datetime);
		
		int noofid=1;
		/* System.out.println(vehiclenumber);
		System.out.println(startdate);
		System.out.println(enddate); */
		
		try{
			DBTransaction dbtranobj=new DBTransaction();
			Connection connection=dbtranobj.connect();
		//Connection conn = null;
		//Class.forName("org.postgresql.Driver").newInstance();
		//conn = DriverManager.getConnection("jdbc:postgresql://192.168.1.95:5432/master_database","postgres", "postgres");
		ResultSet rs = null;
		Statement st=null;
		st=connection.createStatement();
		//System.out.println("belongs to ="+belongs);
		String SQL;
		
		if(belongs.equals("owner"))
		{
			SQL="SELECT DISTINCT ON (vehicle_information.vehicle_number) vehicle_information.vehicle_number,vehicle_information.fuel_tank_capacity, tracking.imei_no, tracking.date_time,tracking.engine_status,tracking.fuel,tracking.mile,tracking.latitude_value,tracking.longitude_value,recent.engine_status newengine,recent.fuel newfuel,recent.latitude_value newlat,recent.longitude_value newlong,recent.date_time newtime FROM tracking inner join vehicle_information on tracking.imei_no=vehicle_information.imei_no and engine_status='1' and tracking.date_time>'2013-10-04 00:00:00' left join recent on tracking.imei_no=recent.imei_no ORDER BY vehicle_information.vehicle_number, tracking.date_time limit 10 offset "+count+"";
		}
		else
		{
			SQL="SELECT DISTINCT ON (vehicle_information.vehicle_number) vehicle_information.vehicle_number,vehicle_information.fuel_tank_capacity, tracking.imei_no, tracking.date_time,tracking.engine_status,tracking.fuel,tracking.mile,tracking.latitude_value,tracking.longitude_value,recent.engine_status newengine,recent.fuel newfuel,recent.latitude_value newlat,recent.longitude_value newlong,recent.date_time newtime FROM tracking inner join vehicle_information on tracking.imei_no=vehicle_information.imei_no and vehicle_information.customer_id='"+belongs+"' and engine_status='1' and tracking.date_time >'"+datetime+"' left join recent on tracking.imei_no=recent.imei_no ORDER BY vehicle_information.vehicle_number, tracking.date_time limit 10 offset "+count+"";
		}
		rs = st.executeQuery(SQL);
		//rs = st.executeQuery("SELECT latitude_value,longitude_value,engine_status,date_time FROM tracking WHERE imei_no ='"+imeinumber+"' and date_time>='"+startdate+"' and date_time<='"+enddate+"'");
		//int count = 1;
		
		while(rs.next()){ 
			
		vehicle_number=rs.getString("vehicle_number");
		fuel_tank_capacity=rs.getDouble("fuel_tank_capacity");
		imei_no=rs.getString("imei_no");
		date_time=rs.getString("date_time");
		firstlat=rs.getString("latitude_value");
		firstlong=rs.getString("longitude_value");
		engine_status=rs.getString("engine_status");
		//mile=rs.getString("mile");
		fuel=rs.getString("fuel");
		
		currentengine=rs.getString("newengine");
		currentfuel=rs.getString("newfuel");
		
		currentlat=rs.getString("newlat");
		currentlong=rs.getString("newlong");
		newtime=rs.getString("newtime");
		//alarm_type=rs.getString("alarm_type");
		
		date_time=date_time.substring(0,16);
		
			if(currentengine.equals("1"))//it will find the eliminate the engine status ON data which is from last more than 5 min
			{
			df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			
			//date= df.parse(date_time);
			date2= df.parse(newtime);
			diff = (int)(Math.abs(date.getTime() - date2.getTime()) / 1000)/60;
			
		//	System.out.println(diff);
				if(diff>5)
					currentengine="0";
			}
		
		fuel=fuel.substring(2);
			if(fuel.length()==1)
				fuel=fuel+"0";
		intfuel=Integer.parseInt(fuel);
		
		currentfuel=currentfuel.substring(2);
			if(currentfuel.length()==1)
				currentfuel=currentfuel+"0";
			intcurrentfuel=Integer.parseInt(currentfuel);
			
		fuelconsume=Integer.parseInt(fuel)-Integer.parseInt(currentfuel);
		  	 
			fuelinltr=(int)(fuel_tank_capacity*intfuel)/100;
			fuel=fuelinltr+"";	
			
			currentfuelinltr=(int)(fuel_tank_capacity*intcurrentfuel)/100;
			currentfuel=currentfuelinltr+"";
			
			consumefuelinltr=(int)(fuel_tank_capacity*fuelconsume)/100;
			fuelconsumed=consumefuelinltr+"";
			
		//fuelconsumed=""+fuelconsume+"";
		
		%>
		<script type="text/javascript">
			
	 get_address(<%=firstlat%>,<%=firstlong%>,<%=noofid%>); 
		 
		</script>


											<!-- <td><a
												href="../JSP/dashboardlivetracking.jsp?IMEI=<%=imei_no%>"
												target="Content"><%=vehicle_number %></a></td> -->
											<td><%=vehicle_number %></td>
											<td><%=date_time %></td>
											<td id="firstlat<%=noofid%>"><%=firstlat+","+firstlong %></td>
											<%if(currentengine.equals("0")) 
		{
			fuelconsumed="NA";
		%>
											<td class="center"><span class="btn btn-success" title="Engine Off">Off</span></td>
											<%}
		else
		{
		//	halt_time="Running";
		%>

											<td><span class="btn btn-danger" title="Engine On">On</span></td>
											<%
		}
		%>
											<td><%= fuel%></td>
											<td><%=currentfuel %></td>

											<td><%=fuelconsumed %></td>
											<td><a href="#" target="Content">Fuel Summary</a></td>

											<td><a
												href="../JSP/Report/fuelgauge.jsp?vehicle_number=<%=imei_no%>"
												target="Content">Fuel Guage</a></td>
										</tr>
										<%
		noofid++;
		rowcount++;
	}//while
	//	System.out.println("row count"+rowcount);
			%>
									
								</table><br/>
								
								<table width="98%" >
									<tr>
										<%
					 		if(count!=0){
						 %>
						 				<td><input type="image" src="../images/previous.png"
											value="Next" style="float: right;"
											onclick="previous('<%=count%>')"></td>						 
										
										<%
							}
					 		else
					 		{
					 	%>
										<td style="width: 97%;"><img
											src="../images/previousdull.PNG" style="float: right;"></td>
										<%
					 		}
						 if(rowcount==10){
						%>
										<td width="20px;">&nbsp;</td>

										<td><input type="image" src="../images/next.png"
											value="Next" style="float: right;"
											onclick="next('<%=count%>')"></td>
										<%
							}
						 else
						 {
							%>
										<td><img src="../images/nextdull.png"
											style="float: right;"></td>
										<%
							}
					 	%>
									</tr>
								</table>


								<%
									connection.close();
									rs.close();
									st.close();
									}catch(SQLException e){ System.out.println(e.getMessage()); } 
								%>

								
							</div>

						</div>
						<!--#tabs-->


					</div>
					<!--widgetcontent-->




				</div>
				<!--contentinner-->
			</div>
			<!--maincontent-->

		</div>
		<!--mainright-->
		<!-- END OF RIGHT PANEL -->

		<div class="clearfix"></div>

		<div class="footer">
			<div class="footerleft">Auto Track</div>
			<div class="footerright">
				&copy; 2014,&nbsp;<a href="www.sudantechservices.com">Sudan Tech
					Services</a>
			</div>
		</div>
		<!--footer-->


	</div>
	<!--mainwrapper-->
</body>
</html>