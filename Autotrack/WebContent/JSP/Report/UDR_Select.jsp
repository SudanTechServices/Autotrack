		<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		<%@ page errorPage="../errorpage.jsp" %>
		 <%@page import="java.sql.*"%>
		 <%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
		<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
		<html>
		<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>User Defined Routes</title>
		
		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
		 <link href="../../CSS/SyntaxHighlighter.css" rel="stylesheet" type="text/css" />
		    <script type="text/javascript" src="../../JS/shCore.js" language="javascript"></script>
		    <script type="text/javascript" src="../../JS/shBrushJScript.js" language="javascript"></script>
		    <script type="text/javascript" src="../../JS/ModalPopups.js" language="javascript"></script>
		    <link rel="stylesheet" type="text/css" href="../../CSS/style.css" />
		     <script type="text/javascript" src="../../JS/DatePick.js"></script>
			 <link rel="stylesheet" type="text/css" href="../../CSS/DatePick.css" />
			  <script language="javascript" type="text/javascript" src="../../JS/datetimepicker_css.js"></script><!-- Date and Time Format  -->
			  <script language="javascript" type="text/javascript" src="../../JS/date_picker_css.js"></script> <!-- only for date format -->
			  <script type="text/javascript" src="../../JS/validate.js"></script>
			  			  		   
		<script type="text/javascript">
		<!-- JQuery hide and visibility functionality -->
		$(document).ready(function(){
		 $('.box').hide();
		  $('#dropdown').change(function() {
			 $('.box').hide();
		    $('#div' + $(this).val()).slideToggle();
		   
		 });
		});
		
		</script>
		<script type="text/javascript">
		var driver_arr = new Array();
		var route_arr = new Array();
		var vehicle_arr = new Array();
		var standard_arr = new Array();
		var location_arr = new Array();
		
		<%
		int counter=0;
		String drivername= null, vehiclenumber=null,busroute=null,standard=null, locations = null;
		DBTransaction dbtranobj=new DBTransaction();
		Connection connection=dbtranobj.connect();
		ResultSet set = null;
		Statement mystatement = connection.createStatement();
		
		set = mystatement.executeQuery("select DISTINCT driver_name from driver_info where driver_name <> ''");
		while(set.next())
		{
			drivername = set.getString("driver_name");
				%>
			driver_arr[<%=counter%>]='<%=drivername%>';
				<%
			counter++;
		}
		
		set = mystatement.executeQuery("select DISTINCT route_number from student where route_number <> ''");
		while(set.next())
		{
			busroute=set.getString("route_number");
			
				%>
			route_arr[<%=counter%>]='<%=busroute%>';
			
			
				<%
			counter++;
		}
		%>

		<%
		set = mystatement.executeQuery("select DISTINCT standard from student where standard <> '' order by standard");
		while(set.next())
		{
			standard = set.getString("standard");
				%>
			standard_arr[<%=counter%>]='<%=standard%>';
			
				<%
			counter++;
		}
		
		
		set = mystatement.executeQuery("select DISTINCT location from student where location <> '' order by location");
		while(set.next())
		{
			locations = set.getString("location");
				%>
				location_arr[<%=counter%>]='<%=locations%>';
			
				<%
			counter++;
		}
		
		%>
		
		function print_driver(id){
			// given the id of the <select> tag as function argument, it inserts <option> tags
			var option_str = document.getElementById(id);
			var x, i=0;
			for(x in driver_arr){
				
				option_str.options[i++] = new Option(driver_arr[x],driver_arr[x]);
			}
		}
		
		function print_routes(id){
			// given the id of the <select> tag as function argument, it inserts <option> tags
			var option_str = document.getElementById(id);
			var x, i=0;
			for(x in route_arr){
				
				option_str.options[i++] = new Option(route_arr[x],route_arr[x]);
			}
		}
		
		
		 function print_standard(id){
			 var option_str = document.getElementById(id);
				var x, i=0;
				for(x in standard_arr){
					
					option_str.options[i++] = new Option(standard_arr[x],standard_arr[x]);
				}
			 }
		 
		 function print_locations(id){
			 var option_str = document.getElementById(id);
				var x, i=0;
				for(x in location_arr){
					
					option_str.options[i++] = new Option(location_arr[x],location_arr[x]);
				}
			 }
		    
		 function show_UDR_Driver(){
				
				var chks = document.getElementsByName('d_id');
				  var hasChecked = false;
				  for (var i = 0; i < chks.length; i++)
				  {
				  if (chks[i].checked)
				  {
				  hasChecked = true;
				  break;
				  }
				  }
				  if (hasChecked == false)
				  {
				  alert("Please select at least one CheckBox.");
				 
				  return false;
				  }
				
			 	document.driverdependent.action="AJAX_UDR_Driver.jsp";
			  	document.driverdependent.target="_blank";
				document.driverdependent.submit();
			
			} 
			
		function show_UDR_Route(){
			   
			      var chks = document.getElementsByName('r_id');
				  var hasChecked = false;
				  for (var i = 0; i < chks.length; i++)
				  {
				  if (chks[i].checked)
				  {
				  hasChecked = true;
				  break;
				  }
				  }
				  if (hasChecked == false)
				  {
				  alert("Please select at least one CheckBox.");
				  return false;
				  }
		 	 	document.routedependent.action="AJAX_UDR_Route.jsp";
		 	  	document.routedependent.target="_blank";
		 		document.routedependent.submit();
		 	
		 } 
		
		function show_UDR_Vehicle(){
			   var chks = document.getElementsByName('v_id');
				  var hasChecked = false;
				  for (var i = 0; i < chks.length; i++)
				  {
				  if (chks[i].checked)
				  {
				  hasChecked = true;
				  break;
				  }
				  }
				  if (hasChecked == false)
				  {
				  alert("Please select at least one CheckBox.");
				  return false;
				  }
			
			 	document.vehicledependent.action="AJAX_UDR_Vehicle.jsp";
			  	document.vehicledependent.target="_blank";
				document.vehicledependent.submit();
			} 
		
		function show_UDR_Standard(){
			   var chks = document.getElementsByName('s_id');
				  var hasChecked = false;
				  for (var i = 0; i < chks.length; i++)
				  {
				  if (chks[i].checked)
				  {
				  hasChecked = true;
				  break;
				  }
				  }
				  if (hasChecked == false)
				  {
				  alert("Please select at least one CheckBox.");
				  return false;
				  }
			   	
			 	document.standarddependent.action="AJAX_UDR_Standard.jsp";
			  	document.standarddependent.target="_blank";
				document.standarddependent.submit();
			}
		
		function show_UDR_Locations(){
			   var chks = document.getElementsByName('l_id');
				  var hasChecked = false;
				  for (var i = 0; i < chks.length; i++)
				  {
				  if (chks[i].checked)
				  {
				  hasChecked = true;
				  break;
				  }
				  }
				  if (hasChecked == false)
				  {
				  alert("Please select at least one CheckBox.");
				  return false;
				  }
			   	
			 	document.locationdependent.action="AJAX_UDR_Locations.jsp";
			  	document.locationdependent.target="_blank";
				document.locationdependent.submit();
			}
		
		function show_UDR_TripSheet(){
			   
			   var date = document.tripsheet.date.value;
			  if(date == ""){
				  alert("select a date");
			  }
			  else{
				  var chks = document.getElementsByName('t_id');
				  var hasChecked = false;
				  for (var i = 0; i < chks.length; i++)
				  {
				  if (chks[i].checked)
				  {
				  hasChecked = true;
				  break;
				  }
				  }
				  if (hasChecked == false)
				  {
				  alert("Please select at least one CheckBox.");
				  return false;
				  }
				document.tripsheet.action="AJAX_UDR_TripSheet.jsp";
			  	document.tripsheet.target="_blank";
				document.tripsheet.submit();
			  }
			   
		}
		
		
		     function checkAll(field){
		       var i;
			   for(i=0;i<field.length;i++)
				   field[i].checked = true;
		   }  
		   
		   function uncheckAll(field){
			   var i;
			   for(i=0;i<field.length;i++)
				   field[i].checked = false;
		   }
		   
		   
		   function consolidated_trip(){ 
			   if(UDR_validation()){
				   
				  document.consolidate_report.action="consolidated_report.jsp";
				  document.consolidate_report.target="_blank"; 
				  document.consolidate_report.submit();
			   }
			}
		   
		   function Round_trip(){
			   if(round_Trip_validation()){
			   document.Round_trip_report.action="round_trip_report.jsp";
				  document.Round_trip_report.target="_blank"; 
				  document.Round_trip_report.submit();
			   }
			   
			   
			}		   
		   function sblt_trip_sheet(){
			   if(sbltValidation()){
			      document.Sblt_trip_sheet.action="Sblt_tripSheet_report.jsp";
				  document.Sblt_trip_sheet.target="_blank"; 
				  document.Sblt_trip_sheet.submit();
			   }
			   
			   
			}
		   
		    </script>
		    </head>
		  
		  
		  
		  
		<body>
		<div class="content_bg">
				<div class="content_headning">User Defined Report</div>
			</div>
		<div>

					<table cellspacing="0" cellpadding="4" class="table_content"
		style="width: 100%; background-color: #fff; border: 1px solid #dfdbdb;">
					
					
					<tr>
						<td>
							<table cellpadding="2px;" cellspacing="4px;" class="table_content"
								style="width: 46%; background-color: #fff;">
								<tr>
									<td>Search By</td>
									<td>:</td>
			<td align="left">
										<form>
											<select id="dropdown" name="dropdown" style="width: 150px; height: 25px;"
												class="tb">
												<option value="default">--select your option--</option>
												<option value="area1">Driver's Name</option>
												<option value="area2">Trip Sheet</option>
												<option value="area3">Consolidated Trip Report</option>
												<option value="area4">Round Trip Report</option>
															<%
	                        					if(session.getAttribute("belongs").equals("sivalingam")){
											%>
	                        					<option value="area9">SBLT Trip Sheet</option>
	                        				<%
	                        					}
	                        				%>
										
												
											</select>
										</form>
									</td>
									<td>&nbsp;</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div> <!-- Drop down functionality got over -->
			
			
			
			
		<div id="divarea1" class="box">
		
				<!-- Search by Driver_Name Report Starts here -->
		
	<!-- 1 -->	<form name="driverdependent" method="post">
		
					<table cellpadding="2px;" cellspacing="4px;"
						style="width: 100%; background-color: #f9f7f5; border: 1px solid #dfdbdb;">
						<tr>
							<td>
								<table cellpadding="2px;" cellspacing="4px;" class="table_content"
									style="width: 50%; background-color: #f9f7f5;">
									<tr>
										<td colspan="3">
											<table style="width:100%;" cellpadding="2px;"
												cellspacing="4px;">
												<tr>
													<td>Select Driver's Name</td>
													<td>:</td>
					 								<td><select class="dropdow" id="driver"	name="driver_name" style="width: 150px;">
														<option>--Select Route --</option>
														</select>
														<script language="javascript">print_driver("driver");</script>
													</td>
													<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
												</tr>
											</table>
		
		
										</td>
									</tr>
									<tr>
										<td colspan="4" class="frmheading">Select Fields For Report
										</td>
					 </tr>
									<tr>
										<td><input type="checkbox" name="d_id" value="license_number">
											Driver's Licence Number</td>
										<td><input type="checkbox" name="d_id" value="vehicle_number">
											Vehicle Number</td>
									</tr>
		
									<tr>
										<td><input type="checkbox" name="d_id" value="shift_number">
											Shift Number</td>
										<td><input type="checkbox" name="d_id" value="route_number">
											Route Number</td>
		
									</tr>
		
									<tr>
										<td><input type="checkbox" name="d_id" value="address">
											Driver's Address</td>
										<td><input type="checkbox" name="d_id" value="doj">
											Date of Joining this Company</td>
									</tr>
		
									<tr>
										<td><input type="checkbox" name="d_id" value="doe">
											Driver's License Expiry Date</td>
										<td><a href="#"
											onclick="checkAll(document.driverdependent.d_id)"> Select All
										</a> | <a href="#" onclick="uncheckAll(document.driverdependent.d_id)">
												Deselect All </a></td>
		
									</tr>
		
									<tr>
										<td><input type="button" name="search"
											value="Get Driver Report" onclick="show_UDR_Driver();">
										</td>
									</tr>
								</table>
							</td>
						</tr>
		
					</table>
				</form>
				<!-- Search by Driver_Name Report ends here -->
		
		
			</div>
		<!-- Search by Route_Number Report Starts here -->
		<!--<div id="divarea2" class="box">
				
 		<form name="routedependent" method="post">
						<table cellspacing="0" cellpadding="4" class="table_content"
		style="width: 100%; background-color: #f9f7f5; border: 1px solid #dfdbdb;">
						<tr>
							<td>
								<table cellpadding="2" cellspacing="0" class="table_content"
									style="width: 50%; background-color: #f9f7f5;">
									<tr>
										<td>
											<table style="width: 50%;" cellpadding="2" cellspacing="0" >
												<tr>
													<td>Select Route Number&nbsp;&nbsp;</td>
													<td>:</td>											
													<td>&nbsp;</td>
													<td><select id="route" name="route" class="tb"
														style="width: 150px;">
															<option>--Select Route --</option>
													</select> <script language="javascript">print_routes("route");</script>
													</td>
													<td></td>
		
												</tr>
		
											</table>
										</td>
									</tr>
									<tr>
										<td colspan="2" class="frmheading">Select Fields For Report
										</td>
									</tr>
									<tr>
										<td><input type="checkbox" name="r_id" value="name">
											Student Name</td>
										<td><input type="checkbox" name="r_id" value="location">
											Student Locations</td>
									</tr>
		
									<tr>
										<td><input type="checkbox" name="r_id"
											value="enrolment_number"> Student r_id Number</td>
										<td><input type="checkbox" name="r_id" value="pick_point">
											Pick Point</td>
		
									</tr>
		
									<tr>
										<td><input type="checkbox" name="r_id" value="standard">
											Class</td>
										<td><input type="checkbox" name="r_id" value="category">
											Bus Fare</td>
									</tr>
		
									<tr>
										<td><input type="checkbox" name="r_id"
											value="residence_address"> Student Address</td>
		
										<td></td>
									</tr>
									<tr>
										<td></td>
										<td><a href="#"
											onclick="checkAll(document.routedependent.r_id)"> Select All
										</a> | <a href="#" onclick="uncheckAll(document.routedependent.r_id)">
												Deselect All </a></td>
									</tr>
									<tr>
		
									</tr>
									<tr>
										<td><input type="button" name="search"
											value="Get Route Report" onclick="show_UDR_Route();"></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</form>
				
			</div>
		-->
		<!-- Search by Route_Number Report ends here -->
		
		<div id="divarea3" class="box">
		
				<!-- Search by Vehicle_Number Report Starts here -->
		
	<!-- 3 -->	<form name="vehicledependent" method="post">
		
					<table cellspacing="0" cellpadding="4" class="table_content"
		style="width: 100%; background-color: #f9f7f5; border: 1px solid #dfdbdb;">
						<tr>
							<td>
								<table cellpadding="2" cellspacing="0" class="table_content"
									style="width: 50%; background-color: #f9f7f5;">
									<tr>
										<td>
											<table style="width: 50%;" cellpadding="2" cellspacing="0" >
												<tr>
													<td>Select Vehicle Number</td>
													<td>:</td>
													<td></td>
													<td><select class="tb" id="vehicle"
														style="width: 150px;" name="vehicle_number">
															<option>Select Vehicle</option>
													</select> <script language="javascript">
														print_vehicle("vehicle");
													</script>
													</td>
												</tr>
											</table>
		
		
										</td>
		
									</tr>
		
									<tr>
										<td colspan="2" class="frmheading">Select Fields For Report</td>
									</tr>
									<tr>
										<td><input type="checkbox" name="v_id" value="license_number">
											License Number <BR></td>
		
										<td><input type="checkbox" name="v_id" value="driver_name">
											Driver's Name <BR></td>
									</tr>
									<tr>
										<td><input type="checkbox" name="v_id" value="customer_name">
											Owner's Name <BR></td>
										<td><input type="checkbox" name="v_id"
											value="fuel_tank_capacity"> Fuel Tank Capacity <BR>
										</td>
									</tr>
									<tr>
										<td><input type="checkbox" name="v_id" value="max_speed">
											Maximum Speed <BR></td>
										<td><input type="checkbox" name="v_id" value="vehicle_type">
											Vehicle Type <BR></td>
									</tr>
									<tr>
										<td><input type="checkbox" name="v_id" value="vehicle_mfg">
											Vehicle Manufacturer <BR></td>
										<td><a href="#"
											onclick="checkAll(document.vehicledependent.v_id)"> Select
												All </a> | <a href="#"
											onclick="uncheckAll(document.vehicledependent.v_id)">
												Deselect All </a></td>
									</tr>
									<tr>
										<td><input type="button" name="search" value="Get Report"
											onclick="show_UDR_Vehicle();"></td>
		
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</form>
				<!-- Search by Vehicle_Number Report ends here -->
			</div>
			<!-- Search by Student_Standard Report Starts here -->
			
	<!--<div id="divarea4" class="box">
				
		
	 <form name="standarddependent" method="post">
		
					<table cellspacing="0" cellpadding="4" class="table_content"
		style="width: 100%; background-color: #f9f7f5; border: 1px solid #dfdbdb;">
						<tr>
							<td>
								<table cellpadding="2" cellspacing="0" class="table_content"
									style="width: 50%; background-color: #f9f7f5;">
									<tr>
										<td>
											<table style="width: 50%;" cellpadding="2" cellspacing="0" >
												<tr>
													<td>Select Standard's Name</td>
													<td>:</td>
													<td>&nbsp;</td>
													<td><select class="tb" id="standard" name="standard">
															<option>--Select Standard --</option>
													</select> <script language="javascript">
														print_standard("standard");
													</script></td>
												</tr>
		
											</table>
		
										</td>
									</tr>
		
									<tr>
										<td colspan="2" class="frmheading">Select Fields For Report
										</td>
									</tr>
									<tr>
										<td><input type="checkbox" name="s_id" value="name">
											Student Name</td>
										<td><input type="checkbox" name="s_id" value="location">
											Student Locations</td>
									</tr>
		
									<tr>
										<td><input type="checkbox" name="s_id"
											value="enrolment_number"> Student Id Number</td>
										<td><input type="checkbox" name="s_id" value="pick_point">
											Pick Point</td>
		
									</tr>
		
									<tr>
										<td><input type="checkbox" name="s_id" value="route_number">
											Route Number</td>
										<td><input type="checkbox" name="s_id" value="category">
											Bus Fare</td>
									</tr>
		
									<tr>
										<td><input type="checkbox" name="s_id"
											value="residence_address"> Student Address</td>
		
										<td></td>
									</tr>
									<tr>
										<td></td>
										<td><a href="#"
											onclick="checkAll(document.standarddependent.s_id)"> Select
												All </a> | <a href="#"
											onclick="uncheckAll(document.standarddependent.s_id)">
												Deselect All </a></td>
		
									</tr>
									<tr>
		
									</tr>
									<tr>
										<td><input type="button" name="search" value="Get Report"
											onclick="show_UDR_Standard();"></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</form>
		
		
				
			</div>
		 -->	
		<!-- Search by Student_Standard Report ends here -->
		
		<!-- Search by Student_Locations Report Starts here -->
		
		<!--<div id="divarea5" class="box">
				
		
	 <form name="locationdependent" method="post">
		
					<table cellspacing="0" cellpadding="4" class="table_content"
		style="width: 100%; background-color: #f9f7f5; border: 1px solid #dfdbdb;">
						<tr>
							<td>
								<table cellpadding="2" cellspacing="0" class="table_content"
									style="width: 50%; background-color: #f9f7f5;">
									<tr>
										<td>
											<table style="width: 50%;" cellpadding="2" cellspacing="0" >
												<tr>
													<td>Select Standard's location</td>
													<td>:</td>
													<td><select class="tb" id="locations" name="locations"
														style="width: 150px;">
															<option>--Select Standard --</option>
													</select> <script language="javascript">
														print_locations("locations");
													</script></td>
												</tr>
											</table>
		
										</td>
									</tr>
		
									<tr>
										<td colspan="2" class="frmheading">Select Fields For Report
										</td>
									</tr>
									<tr>
										<td><input type="checkbox" name="l_id" value="name">
											Student Name</td>
										<td><input type="checkbox" name="l_id" value="standard">
											Class</td>
									</tr>
		
									<tr>
										<td><input type="checkbox" name="l_id"
											value="enrolment_number"> Student ID Number</td>
										<td><input type="checkbox" name="l_id" value="pick_point">
											Pick Point</td>
		
									</tr>
		
									<tr>
										<td><input type="checkbox" name="l_id" value="route_number">
											Route Number</td>
										<td><input type="checkbox" name="l_id" value="Category">
											Category</td>
									</tr>
		
									<tr>
										<td><input type="checkbox" name="l_id"
											value="residence_address"> Student Address</td>
		
										<td></td>
									</tr>
									<tr>
										<td></td>
										<td><a href="#"
											onclick="checkAll(document.locationdependent.l_id)"> Select
												All </a> | <a href="#"
											onclick="uncheckAll(document.locationdependent.l_id)">
												Deselect All </a></td>
		
									</tr>
									<tr>
		
									</tr>
									<tr>
										<td><input type="button" name="search" value="Get Report"
											onclick="show_UDR_Locations();"></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</form>
		
		
				
			</div>
		 -->
		 <!-- Search by Student_Locations Report ends here -->
		 
		 <!-- Search by Trip_Sheet Report Starts here -->
		 
		<div id="divarea2" class="box">
				
		
<!-- 6 -->	<form name="tripsheet" method="post">
		
					<table cellspacing="0" cellpadding="4" class="table_content"
		style="width: 100%; background-color: #f9f7f5; border: 1px solid #dfdbdb;">
						<tr>
							<td>
								<table cellpadding="2" cellspacing="0" class="table_content"
									style="width: 50%; background-color: #f9f7f5;">
									<tr>
										<td>
											<table style="width: 60%;" cellpadding="2" cellspacing="0" >
												<tr>
													<td>Select Date</td>
													<td></td>
													<td style="width: 2%;">:</td>
													<td style="width: 1%;"></td>
													<td style="width: 20%;">
														<input type="text" name="date" size="22" onclick="displayDatePicker('date');" /></td>
													<td style="width: 1%;">
													<img src="../../images/calendar_icon.gif" width="16" height="16" border="0" alt="Pick a date" onclick="displayDatePicker('date');" /></td>
												</tr>
											</table>
									</tr>
		
									<tr>
										<td colspan="2" class="frmheading">Select Fields For Report
										</td>
									</tr>
									<tr>
										<td><input type="checkbox" name="t_id" value="vehicle_number">
											Vehicle Number</td>
										<td><input type="checkbox" name="t_id" value="route_number">
											Route Number</td>
									</tr>
		
									<tr>
										<td><input type="checkbox" name="t_id" value="days">
											Day</td>
										<td><input type="checkbox" name="t_id" value="start_km">
											Started Kilometer</td>
		
									</tr>
		
									<tr>
										<td><input type="checkbox" name="t_id" value="close_km">
											Closed Kilometer</td>
										<td><input type="checkbox" name="t_id" value="run_km">
											Total Kilometer Run</td>
									</tr>
		
									<tr>
										<td><input type="checkbox" name="t_id"
											value="present_children"> No of Students Present</td>
		
										<td><input type="checkbox" name="t_id"
											value="vehicle_outtime"> Vehicle OutTime</td>
									</tr>
									<tr>
										<td><input type="checkbox" name="t_id" value="vehicle_intime">
											Vehicle InTime</td>
											<td><input type="checkbox" name="t_id" value="tcss_name">
											TCSS Name</td>
		
									</tr>
									<tr>
										
										<td><a href="#" onclick="checkAll(document.tripsheet.t_id)">
												Select All </a> | <a href="#"
											onclick="uncheckAll(document.tripsheet.t_id)"> Deselect All </a>
										</td>
		
									</tr>
									<tr>
		
									</tr>
									<tr>
										<td><input type="button" name="search" value="Get Report"
											onclick="show_UDR_TripSheet();"></td>
									</tr>
								</table>
							</td>
						</tr>
		
					</table>
				</form>

				<!-- Search by Student_Locations Report ends here -->
			</div>
			
			
			
			
			
				<div id="divarea3" class="box">
				<!-- Search by Trip_Sheet Report Starts here -->
		
<!-- 6 -->	<form name="consolidate_report" method="post">
		
					<table cellspacing="0" cellpadding="4" class="table_content"
		style="width: 100%; background-color: #f9f7f5; border: 1px solid #dfdbdb;">
						<tr>
							<td>
								<table cellpadding="2" cellspacing="0" class="table_content"
									style="width: 50%; background-color: #f9f7f5;">
									<tr>
										<td colspan="2" class="frmheading">Select Fields For Report
										</td>
									</tr>
									<tr>
										<td>
											<table style="width: 50%;" cellpadding="2" cellspacing="0" >
											<tr>
													<td>Device Vehicle No</td>
													<td style="width: 3%;"></td>
													<td style="width: 2%;">:</td>
													<td style="width: 1%;"></td>
													<td>
													<%@ page import="com.ts.service.dropdown"%>
													<%@ page import="java.util.ArrayList"%> 
													<%@ page import="java.util.*"%>
													<%
													String belongs = (String) session.getAttribute("belongs");
													dropdown up= new dropdown();
													TreeMap<String,String> tm= up.getName(belongs);												
													Set set1 = tm.entrySet();
													Iterator itr = set1.iterator();
													out.println("<select name='vehicle_number' class='tb' style='width: 150px;'>");
													while(itr.hasNext()){
														Map.Entry me = (Map.Entry) itr.next();
												 		out.println("<option class='blue' value=\"" + me.getValue()+ "\">" + me.getKey() + "</option>");
													}
													out.println("</select>");
													 
													 %>
													
													
													
													</td>
												</tr>												
									<tr>
											<td id="start_date_label" style="width: 34%;"><label> Start Date And Time</label></td>
											<td style="width: 3%;"></td>
													<td style="width: 2%;">:</td>
													<td style="width: 1%;"></td>
												
											<td id="start_date_input" style="width: 20%;"><a href="javascript:NewCssCal('cons_date','yyyyMMdd','dropdown',true,'24')">
											<!-- <img src="../../images/calendar_icon.gif" width="16" height="16" border="0" alt="Pick a date"> -->
											<input type ="radio" name="date" id="dateTime">Date Time</a>
										  <a href="javascript:DatePick('cons_date','yyyyMMdd')"><input type ="radio" name="date" id="dateOnly">Date</a></td></tr>											
											 <tr>
													<td>&nbsp;</td>
												    <td style="width: 3%;">&nbsp;</td>
													<td style="width: 2%;"></td>
													<td style="width: 1%;"></td>
													<td><input class="tb" type="Text" id="cons_date"  size="20" name="cons_date"></td></tr>																									 					 
												<tr>
													<td>Source</td>
													<td style="width: 3%;"></td>
													<td style="width: 2%;">:</td>
													<td style="width: 1%;"></td>
													<td>
													<%@ page import="com.ts.service.DropDownForAddress"%>
													<%@ page import="java.util.ArrayList"%> 
													<%@ page import="java.util.*"%>
													<%												
													DropDownForAddress dda= new DropDownForAddress();
													TreeMap<String,String> tree_map= dda.getName();												
													Set address_set = tree_map.entrySet();
													Iterator address_itr = address_set.iterator();
													
													out.println("<select name='source' id='source' class='tb' style='width: 150px;'>");
													while(address_itr.hasNext()){
														Map.Entry me = (Map.Entry) address_itr.next();
												 		out.println("<option value=\"" + me.getValue()+ "\">" + me.getKey() + "</option>");
												 			
													}
													out.println("</select>");
													
													 %>
													
													
													
													</td>
												 </tr>
												 
												 <tr>
													<td>Destination</td>
													<td style="width: 3%;"></td>
													<td style="width: 2%;">:</td>
													<td style="width: 1%;"></td>
													<!-- <td><select id="destination" name="destination"  style="width: 150px;" class="tb"> -->
													<td>
													<%@ page import="com.ts.service.DropDownForAddress"%>
													<%@ page import="java.util.ArrayList"%> 
													<%@ page import="java.util.*"%>
													<%
													DropDownForAddress dda1= new DropDownForAddress();
													TreeMap<String,String> tree_map1= dda1.getName();												
													Set address_set1 = tree_map1.entrySet();
													Iterator address_itr1 = address_set1.iterator();
													
													out.println("<select name='destination' id='destination' class='tb' style='width: 150px;'>");
													while(address_itr1.hasNext()){
														Map.Entry me = (Map.Entry) address_itr1.next();
												 		out.println("<option value=\"" + me.getValue()+ "\">" + me.getKey() + "</option>");
												 			
													}
													out.println("</select>");
													
													 %>
													
													
													
													</td>
													
												 </tr>
												  <tr>
													<td>Halt Time</td>
												 <td style="width: 3%;"></td>
													<td style="width: 2%;">:</td>
													<td style="width: 1%;"></td>
													<td><input type="text"  class="tb" id="inputHaltTime" name="inputHaltTime" placeholder ="Enter the Halt time(Min)"></td></tr>
											</table>
									</tr>
		
									
									<tr>
										<td><input type="button" name="search" value="Get Report"
											onclick="consolidated_trip()"></td>
									</tr>
								</table>
							</td>
						</tr>
		
					</table>
				</form>
				</div>
				
				
				<!-- Search by Round trip sheet Starts here -->
			 <div id="divarea4" class="box">
			
			<form name="Round_trip_report" method="post">
						
						<table cellspacing="0" cellpadding="0" class="table_content"
		style="width: 100%; background-color: #f9f7f5; border: 1px solid #dfdbdb;">
						<tr>
							<td  width="50%" class="frmheading">Select Fields For Report	</td>
							<td width="50%" ></td>
						</tr>
						<tr>
							<td width="50%">
								<table cellpadding="4" cellspacing="0" class="table_content"
									style="width: 100%; background-color: #f9f7f5;">
									<tr>
										<td width="2%"></td>
										<td width="48%">
											<table style="width: 50%;">
											<tr>
													<td>Device Vehicle No</td>
													<td style="width: 3%;"></td>
													<td style="width: 2%;">:</td>
													<td style="width: 1%;"></td>
													<td id="vehic">
													<%@ page import="com.ts.service.dropdown"%>
													<%@ page import="java.util.ArrayList"%> 
													<%@ page import="java.util.*"%>
													<%
													String belongs1 = (String) session.getAttribute("belongs");
													dropdown up1= new dropdown();
													TreeMap<String,String> tm1= up1.getName(belongs1);												
													Set set2 = tm1.entrySet();
													Iterator itr1 = set2.iterator();
													out.println("<select name='vehicle_number' class='tb' id='vehicle_number' style='width: 150px;'>");
													while(itr1.hasNext()){
														Map.Entry me = (Map.Entry) itr1.next();
												 		out.println("<option class='blue' value=\"" + me.getValue()+ "\">" + me.getKey() + "</option>");
													}
													out.println("</select>");
													 
													 %>
													
													</tr>												
									<tr>
											<td id="start_date_label" style="width: 34%;"><label> Start Date</label></td>
											<td style="width: 3%;"></td>
													<td style="width: 2%;">:</td>
													<td style="width: 1%;"></td>
												
											<td id="start_date_input" style="width: 20%;"><a href="javascript:NewCssCal('round_trip_date','yyyyMMdd','dropdown',true,'24')">
											<!-- <img src="../../images/calendar_icon.gif" width="16" height="16" border="0" alt="Pick a date"> -->
											<input type ="radio" name="date" id="dateTime">Date Time</a>
										  <a href="javascript:DatePick('round_trip_date','yyyyMMdd')"><input type ="radio" name="date" id="dateOnly">Date</a></td></tr>																				
											
											
									  <tr>
													<td>&nbsp;</td>
												 <td style="width: 3%;">&nbsp;</td>
													<td style="width: 2%;"></td>
													<td style="width: 1%;"></td>
													<td><input class="tb" type="Text" id="round_trip_date"  size="20" name="round_trip_date"></td></tr>		
											
																																		 					
												<tr>
													<td>Starting place</td>
													<td style="width: 3%;"></td>
													<td style="width: 2%;">:</td>
													<td style="width: 1%;"></td>
													<!-- <td><select id="source_address" name="source_address"  style="width: 150px;" class="tb">
												 -->	
													<td>
													<%@ page import="com.ts.service.DropDownForAddress"%>
													<%@ page import="java.util.ArrayList"%> 
													<%@ page import="java.util.*"%>
													<%
													DropDownForAddress dda2= new DropDownForAddress();
													TreeMap<String,String> tree_map2= dda2.getName();												
													Set address_set2 = tree_map2.entrySet();
													Iterator address_itr2 = address_set2.iterator();
													
													out.println("<select name='source_address' id='source_address' class='tb' style='width: 150px;'>");
													while(address_itr2.hasNext()){
														Map.Entry me = (Map.Entry) address_itr2.next();
												 		out.println("<option value=\"" + me.getValue()+ "\">" + me.getKey() + "</option>");
												 		System.out.println("map key plus vlaue is  :::::"+me.getValue()+" ::::: "+me.getKey());	
												 		
													}
													out.println("</select>");
													
													 %>																										
													
													</td>																																				
												 </tr>
												  <tr>
													<td>Halt Time</td>
												 <td style="width: 3%;"></td>
													<td style="width: 2%;">:</td>
													<td style="width: 1%;"></td>
													<td><input type="text"  class="tb" id="halt_time" name="halt_time" placeholder ="Enter the Halt time(Min)"></td></tr>
											</table>
									</tr>
		
									
									<tr>
										<td></td>
										<td><input type="button" name="search" value="Get Report"
											onclick="Round_trip()"></td>
									</tr>
								</table>
							</td>
							<td width="50%" ></td>
						</tr>
		
					</table>
				</form>
								
				
			</div>
			
			<!-- Search by Student_Locations Report ends here -->
			
<!-- SBLT Report type -->
<!-- 
	 <div id="divarea9" class="box">
		<form name="Sblt_trip_sheet" method="post">
					<table cellspacing="0" cellpadding="4" class="table_content"
		style="width: 100%; background-color: #fff; border: 1px solid #dfdbdb;">
						<tr>
							<td>
								<table cellpadding="2px;" cellspacing="2px;" class="table_content"
									style="width: 50%; background-color: #f9f7f5;">
									<tr>
										<td>
											<table style="width: 95%;">
											<tr>
													<td>Device Vehicle NO</td>
													<td style="width: 3%;"></td>
													<td style="width: 2%;">:</td>
													<td style="width: 1%;"></td>
													<td id="vehic"></td>
											</tr>	
											<tr>
											<td id="start_date_label" style="width: 34%;"><label>Date and Time</label></td>
											<td style="width: 3%;"></td>
													<td style="width: 2%;">:</td>
													<td style="width: 1%;"></td>												
											 <td id="start_date_input" style="width: 20%;"><a href="javascript:NewCssCal('sblt_trip_date','yyyyMMdd','dropdown',true,'24')">
											<img src="../../images/calendar_icon.gif" width="16" height="16" border="0" alt="Pick a date">
											<img src="../../images/calendar_icon.gif " width="16" height="16" border="0"></a>
										  <a href="javascript:DatePick('sblt_trip_date','yyyyMMdd')"><input type ="radio" name="date" id="dateOnly">Date</a></td></tr>	
										   
										   <td id="start_date_input" style="width: 20%;"><a href="javascript:NewCssCal('sblt_trip_date','yyyyMMdd','dropdown',true,'24')">
											 <img src="../../images/calendar_icon.gif" width="16" height="16" border="0" alt="Pick a date"> 
											<input type ="radio" name="date" id="dateTime">Date Time</a>
										  <a href="javascript:DatePick('sblt_trip_date','yyyyMMdd')"><input type ="radio" name="date" id="dateOnly">Date</a></td></tr>																				
											
										   
										  		
									  <tr>
													<td>&nbsp;</td>
												 <td style="width: 3%;">&nbsp;</td>
													<td style="width: 2%;"></td>
													<td style="width: 1%;"></td>
													<td><input class="tb" type="Text" id="sblt_trip_date"  size="20" name="sblt_trip_date"></td></tr>
													
													<td><input type="button" name="search" value="Get Report"
											onclick="sblt_trip_sheet()"></td>																																
													</table>
													</td>
													</tr>
													</table>
													</td>
													</tr>
													</table>
													</form>
													</div>
													
													-->
															
		
		</body>
		</html>