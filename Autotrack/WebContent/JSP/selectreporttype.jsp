<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="errorpage.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
<head>
<title>Reports</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="javascript" type="text/javascript" src="../JS/datetimepicker_css.js"></script>
 <link rel="stylesheet" type="text/css" href="../CSS/style.css" /> 
<script type="text/javascript" src="../JS/validate.js"></script>
<SCRIPT type="text/javascript">
	function refresh() {		
		document.getElementById('halt_timing').style.display = "none";
		document.getElementById('halt_time_label').style.display = "none";
		document.getElementById('show_dynamic').style.display = "none";
		document.getElementById('show_months').style.display = "none";
		document.speedreport.action = "showreport.jsp";
		document.speedreport.target = "ReportWindow";
		document.speedreport.submit();
	}

	function showGrid() {
		var report_type = (document.speedreport.report_type.value);
		
		var fuel_type = (document.speedreport.fuel_type.value);
		   
	   if (report_type == "Fuel(Dynamic Reports)") {
				report_type = "";
				document.speedreport.action = "../JSP/Report/fuelgauge.jsp";
				document.speedreport.target = "ReportWindow";
				document.speedreport.submit();
		 }
		    
		
		
		if(report_type == "Speed" || report_type=="Speed (Exception)" || report_type == "Fuel(Grid View in Details)" ||report_type == "Fuel(Grid View)" || report_type == "Full Fuel Status" || report_type == "Out of fence(Map View)" || report_type == "Out of fence report" ){
						
	    if(notnull()){
		if (report_type == "Speed") {
			fuel_type = "";

			document.speedreport.action = "../JSP/Report/AJAX_Speed_report_grid.jsp";
			document.speedreport.target = "ReportWindow";
			document.speedreport.submit();

		}
		else if(report_type=="Speed (Exception)"){
			
			fuel_type ="";
			document.speedreport.action="../JSP/Report/AJAX_Speed_exception_report_grid.jsp";
			document.speedreport.target="ReportWindow";
			document.speedreport.submit();	
			
		}			
		
		else if(report_type == "Fuel(Grid View in Details)"){
		fuel_type ="";
		
		document.speedreport.action="../JSP/Report/AJAX_Fuel_report_grid.jsp";
		document.speedreport.target="ReportWindow";
		document.speedreport.submit();
		}
		else if(report_type == "Fuel(Grid View)"){
		fuel_type ="";
		
		document.speedreport.action="../JSP/Report/AJAX_Fuel_report_grid_brief.jsp";
		document.speedreport.target="ReportWindow";
		document.speedreport.submit();
		}
		else if(report_type == "Full Fuel Status"){
			fuel_type ="";
			
			document.speedreport.action="../JSP/Report/AJAX_Full_fuel_report.jsp";
			document.speedreport.target="ReportWindow";
			document.speedreport.submit();
			}
		else if (report_type == "Fuel(Chart View)") {
			fuel_type = "";

			document.speedreport.action = "../JSP/Report/AJAX_Fuel_report_chart.jsp";
			document.speedreport.target = "ReportWindow";
			document.speedreport.submit();
		}
		
		else if (report_type == "Out of fence(Map View)") {
			fuel_type = "";

			document.speedreport.action = "../JSP/Report/AJAX_CourseTakenMarkerFence.jsp";
			document.speedreport.target = "ReportWindow";
			document.speedreport.submit();
		}
		
		
		
		else if (report_type == "Out of fence report") {
			fuel_type = "";	
			document.speedreport.action = "../JSP/Report/OutOfFence.jsp";
			document.speedreport.target = "ReportWindow";
			document.speedreport.submit();
		}
		
		else if (report_type == "Fuel(Dynamic Reports)") {
			fuel_type = "";	
			document.speedreport.action = "../JSP/Report/LoadGauge.jsp";
			document.speedreport.target = "ReportWindow";
			document.speedreport.submit();
		}

		
		
		
		if (fuel_type == "Fuel(Live Chart)") {
			report_type = "";

			document.speedreport.action = "../JSP/Report/AJAX_Fuel_live_chart.jsp";
			document.speedreport.target = "ReportWindow";
			document.speedreport.submit();

		} else if (fuel_type == "Fuel(Live Grid)") {
			report_type = "";

			document.speedreport.action = "../JSP/Report/AJAX_Fuel_live_grid.jsp";
			document.speedreport.target = "ReportWindow";
			document.speedreport.submit();

		}

		else if (fuel_type == "Fuel(Monthly Chart)") {
			report_type = "";

			document.speedreport.action = "../JSP/Report/AJAX_Fuel_monthly_chart.jsp";
			document.speedreport.target = "ReportWindow";
			document.speedreport.submit();
		}

		else if (fuel_type == "Fuel(Monthly Grid)") {
			report_type = "";

			document.speedreport.action = "../JSP/Report/AJAX_Fuel_monthly_grid.jsp";
			document.speedreport.target = "ReportWindow";
			document.speedreport.submit();
		}

		else if (fuel_type == "Fuel(Daily Chart)") {
			report_type = "";

			document.speedreport.action = "../JSP/Report/AJAX_Fuel_Daily_chart.jsp";
			document.speedreport.target = "ReportWindow";
			document.speedreport.submit();
		}

		else if (fuel_type == "Fuel(Daily Grid)") {
			report_type = "";

			document.speedreport.action = "../JSP/Report/AJAX_Fuel_Daily_grid.jsp";
			document.speedreport.target = "ReportWindow";
			document.speedreport.submit();

		} 
		
		
	}
	    
	else{
		return false;
	}
	}
		if(report_type=="Engine Status" || report_type=="Halt Time" || report_type=="Trip Info" || report_type == "Course Taken(Map View)" ){
		if(reportVaildaion()){			
		 if(report_type=="Engine Status"){			
			fuel_type ="";
			document.speedreport.action="../JSP/Report/engine_report_grid.jsp";
			document.speedreport.target="ReportWindow";
			document.speedreport.submit();	
			
			}
		else if(report_type=="Halt Time"){
            
            fuel_type ="";
            document.speedreport.action="../JSP/Report/halt_time_report.jsp";
            document.speedreport.target="ReportWindow";
            document.speedreport.submit();    
            
        }
		else if(report_type=="Trip Info"){
			fuel_type="";
			document.speedreport.action="../JSP/Report/tripReport.jsp";
			document.speedreport.target = "ReportWindow";
			document.speedreport.submit();
		}
		
		else if (report_type == "Course Taken(Map View)") {
			fuel_type = "";

			document.speedreport.action = "../JSP/Report/coursetakenmarker.jsp";
			document.speedreport.target = "ReportWindow";
			document.speedreport.submit();
		}
		}
		else{
			return false;
		}
		}
		
		
		report_type = "";
		fuel_type = "";
	}

	function month() {

		var month = document.speedreport.fuel_type.value;

		if (month == "Fuel(Monthly Chart)" || month == "Fuel(Monthly Grid)") {

			document.getElementById("show_months").style.display = "block";
		} else {

			document.getElementById("show_months").style.display = "none";
		}

	}

	function dynamic() {

		var report_type = (document.speedreport.report_type.value);
		//alert(report_type);
		if (report_type == "Fuel(Dynamic Reports)") {			
			document.getElementById('show_dynamic').style.display = "block";  //block ==show     none ==hidden 			
			document.getElementById('start_date_label').style.display = "none";			
			document.getElementById('start_date_input').style.display = "none";			
			document.getElementById('end_date_label').style.display = "none";			
			document.getElementById('end_date_input').style.display = "none";			
			document.getElementById('halt_timing').style.display = "none";
			document.getElementById('halt_time_label').style.display = "none";
		}
		
		else if(report_type =="Halt Time" || report_type =="Engine Status" || report_type =="Trip Info" || report_type =="Course Taken(Map View)"){
			
			document.getElementById('halt_timing').style.display = "block";
			document.getElementById('halt_time_label').style.display = "block";
			document.getElementById('start_date_label').style.display = "block";
			document.getElementById('start_date_input').style.display = "block";
			document.getElementById('end_date_label').style.display = "block";
			document.getElementById('end_date_input').style.display = "block";
			document.getElementById('show_dynamic').style.display =  "none";
		}
		else {
			document.getElementById('show_dynamic').style.display = "none";
			//document.getElementById('show_months').style.display = "none";
			document.getElementById('start_date_label').style.display = "block";
			document.getElementById('start_date_input').style.display = "block";
			document.getElementById('end_date_label').style.display = "block";
			document.getElementById('end_date_input').style.display = "block";
			document.getElementById('halt_timing').style.display = "none";
			document.getElementById('halt_time_label').style.display = "none";

		}

	}
</SCRIPT>
</head>
<body text="#000000" link="#0000FF" vlink="#800080" alink="#FF0000" onload="refresh();">
<div class="content_bg"><span class="content_headning">Select Report</span></div>
	<fieldset>
		
	<form name="speedreport">
		<table cellspacing="0" class="table_content" cellpadding="4" style="width: 100%; background-color: #fff;border: 1px solid #dfdbdb;" summary="">
			<tr><th align='left' style='background-color:#e78c39; color:#fff;'>Report Types</th></tr>
			<tr>
				<td><label>Device Vehicle No</label></td>
			</tr>
			<tr>
				<td><%@ page import="com.ts.service.dropdown"%>
					<%@ page import="java.util.ArrayList"%> 
					<%@ page import="java.util.*"%>
					 <%
					    String belongs = (String) session.getAttribute("belongs");
					 	dropdown up = new dropdown();
					 	TreeMap<String,String> treemap = up.getName(belongs); 
					 	Set set = treemap.entrySet();

					 	Iterator iterator = set.iterator();
					 	System.out.println("Belonging details: :"+belongs);

					 	out.println("<select name='vehicle_number' class='tb' style='width: 180px;'>");

					 	while (iterator.hasNext()) {
					 		//String temp = iterator.next().toString();
					 		Map.Entry me = (Map.Entry) iterator.next();
					 		out.println("<option class='blue' value=\"" + me.getValue()
					 				+ "\">" + me.getKey() + "</option>");
					 	}
 	out.println("</select>");
 %></td>
			</tr>
			<tr>
				<td><label> Select Report Type</label></td>
			</tr>
			<tr>

				<td><select name="report_type" onchange="dynamic();" class="tb" style="width: 180px;">				       
						<option>Speed</option>
						<option>Speed (Exception)</option>
						<option>Engine Status</option>
						<option>Halt Time</option>
						<option>Trip Info</option>
						<option class="blue">Fuel(Grid View)</option>
	  					<!-- <option class="blue">Fuel(Grid View in Details)</option>
	  					<option class="blue">Fuel(Grid View in Brief)</option>
	  					<option>Full Fuel Status</option> -->
						<!-- <option>Fuel(Chart View)</option> -->
						<option>Fuel(Dynamic Reports)</option>
						<option class="blue">Course Taken(Map View)</option>
				</select></td>
			<tr>
				<td id="start_date_label"><label> Start Date And Time </label></td>
			</tr>
			<tr>
				<td id="start_date_input"><a href="javascript:NewCssCal('demo1','yyyyMMdd','dropdown',true,'24')"><img src="../images/calendar_icon.gif" width="16" height="16"
						border="0" alt="Pick a date"></a>&nbsp;<input class="tb" type="Text" id="demo1"  size="20" name="start_date"></td>
			</tr>
			<tr>
				<td id="end_date_label"><label> End Date And Time</label></td>
			</tr>
			<tr>

				<td id="end_date_input">
				
				<a	href="javascript:NewCssCal('demo2','yyyyMMdd','dropdown',true,'24')"><img
						src="../images/calendar_icon.gif" width="16" height="16"
						border="0" alt="Pick a date"></a>&nbsp;<input class="tb" type="Text" id="demo2"  size="20" name="end_date"></td>
			</tr>
			
			 <tr>
					<td id ="halt_time_label">Enter Halt Time Limit</td> </tr>			
					<tr><td><input type="text"  class="tb" id="halt_timing" name="halt_timing" placeholder ="Enter the Halt time(Min)"></td></tr>
			
			

			<tr id="show_dynamic">
				<td>Select a Fuel Type <br> <select name="fuel_type"
					onchange="month();" class="tb">
						<!-- <option class="blue">Fuel(Monthly Chart)</option>
						<option class="blue">Fuel(Monthly Grid)</option>
						<option class="blue">Fuel(Live Chart)</option>
						<option class="blue">Fuel(Live Grid)</option>
						<option class="blue">Fuel(Daily Chart)</option>
						<option class="blue">Fuel(Daily Grid)</option> -->
						<option class="blue">Fuel Gauge</option>
				</select>
				</td>
			</tr>
			
			<tr>
				<td></td>
			</tr>
			<tr>
				<td><input type="button" name="search"
					value="Get Report" onclick="showGrid();"></td>
			</tr>
			
		</table>
		</form>
	</fieldset>


</body>
</html>