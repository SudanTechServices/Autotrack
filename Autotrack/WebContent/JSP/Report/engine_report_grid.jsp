	<%@page import="java.sql.*"%>
	<%@page import="java.text.DateFormat"%>
	<%@page import="java.text.ParseException"%>
	<%@page import="java.text.SimpleDateFormat"%>
	<%@page import="java.util.Calendar"%>
	<%@page import="java.util.Date"%>
	<%@ page import="com.ts.dbtransactionmgr.DBTransaction;" %>
	<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
		
	<html>
	<head>

	 <link rel="stylesheet" type="text/css" href="../../CSS/style.css" />
	 
	 <style type="text/css">
		tr:nth-child(even) {background: #eee}
		tr:nth-child(odd) {background: #FFF}
	</style>
	 
	 <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" type="text/javascript"></script>
	 
	<%
		String imeinumber = request.getParameter("vehicle_number");
    	System.out.println("IMEI"+imeinumber);
	    String startdate,enddate;
	    startdate=request.getParameter("start_date");
	    enddate=request.getParameter("end_date");
		System.out.println("start date is:"+startdate+" enddate is "+enddate); 		
		int input_halt_time=Integer.parseInt(request.getParameter("halt_timing")); 		
	%>
			 	
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
	function get_address(lat1, lang, noofid,counter) {
		var count=counter;
		var color="FF0000";
			if(count >11 && count<=75){
				alert("Printing "+count+"th row Click OK After one Second");
			}
			
	var lat = lat1;
		var lon = lang;
		var search = '' + lat + ',' + lon + '';
	geo.getLocations(search,function(result) {																	
							if (result.Status.code == G_GEO_SUCCESS) {
								for ( var i = 0; i < result.Placemark.length; i++) {
									var addres =result.Placemark[i].address;
									if (reason=="Undefined" ) {
										document.getElementById("msg" + noofid).innerHTML = "<font color=#"+color+">"+"Unable to find the location"+"</font>";								
									}
									if(addres == ""){
										document.getElementById("msg" + noofid).innerHTML = "<font color=#"+color+">"+"Unable to find the location"+"</font>";
									}
									else {									
										document.getElementById("msg" + noofid).innerHTML = result.Placemark[i].address;
									}
								}
	
							}
							// ====== Decode the error status ======
							else {
								var reason = "Code " + result.Status.code;
								document.getElementById("msg" + noofid).innerHTML = "<font color=#"+color+">"+"Unable to find the location"+"</font>";
								if(reason=="Undefined"){
									document.getElementById("msg" + noofid).innerHTML = "<font color=#"+color+">"+"Unable to find the location"+"</font>";
								}							
								 var reason = "Code " + result.Status.code;
								 if (reasons[result.Status.code]) {
									reason = reasons[result.Status.code];	
								} 
								
							}
							
							
						});
	
	}
	</script>
	 
	 
	 </head>
	 <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
	 <script type="text/javascript">
	 
		function redirect_to_pdf(startdate,enddate,imeinumber,input)
		{					
			
			document.pdf.action="Engine_Report_PDF.jsp?start_date="+startdate+"&end_date="+enddate+"&imeinumber="+imeinumber+"&input_halt_time="+input+"";
			document.pdf.submit();
			
		}
		 function redirect_to_excel(startdate,enddate,imeinumber,halt)
		{
			
			document.pdf.action="Engine_Report_Excel.jsp?startdate="+startdate+"&enddate="+enddate+"&imeinumber="+imeinumber+"&input_halt_time="+halt+"";
			document.pdf.submit();
		} 
		</script>
		
	
	
	 
	<body>

	<div class="content_bg"><span class="content_headning">Engine Status Report</span></div><br/>
	
	<div style="float: right;">	
		<form name="pdf" method="post" accept-charset="utf-8">
		  <input type="button" value="Export To Pdf" tabindex="3" id="export_pdf" onclick="redirect_to_pdf('<%=startdate%>','<%=enddate%>','<%=imeinumber%>','<%=input_halt_time%>');"></input>
		 <input type="button" value="Export To Excel" tabindex="3" id="export_excel" onclick="redirect_to_excel('<%=startdate%>','<%=enddate%>','<%=imeinumber%>','<%=input_halt_time%>');"></input> 
		</form>
	</div>
	  <br/><br/>
		
	<table cellspacing="0" cellpadding="4" class="table_content"
		style="width: 100%; background-color: #fff; border: 1px solid #dfdbdb;">	
			<tr>
				<th class="report_heading">Date</th>
				<th class="report_heading">Time</th>
				<th class="report_heading">Engine Status</th>		
				<th class="report_heading">Address</th>			
			</tr>
			
			
	
	
				<%
					int offcounter = 0, oncounter = 0;
					String latitude = null, next_latitude = null;
					String longitude = null, next_longitude = null;
					String date_time, next_date_time;
					String engine_status, next_engine_status;
					String am_pm;
					String ses_hour;
					String date;
					String fin_hr;
					String time;
					String date_in_db;
					String day;
					String month;
					String year;
					String hr;
					String min;
					DateFormat df = null;
					Date date1 = null, date2 = null;
					int noofid = -1;
					int counter=1;
					try {
						DBTransaction dbtranobj = new DBTransaction();
						Connection connection = dbtranobj.connect();
						ResultSet rs = null;
						Statement st = null;
						st = connection.createStatement();
						rs = st.executeQuery("SELECT latitude_value,longitude_value,engine_status,date_time FROM tracking WHERE imei_no ='"+ imeinumber+ "' and date_time>='"+ startdate+ "' and date_time<='" + enddate + "'");
	
						//int count = 1;
						if(rs.next()){
							
						}
						else{
							%>
							<script type="text/javascript">
							document.getElementById("engineReportTable").style.display='none';		
							document.getElementById("export_pdf").style.display='none';
							document.getElementById("export_excel").style.display='none';
							</script>
								<h1><font color="red"><center>No Data Found </center></font></h1>
						<%
						}
	
						while (rs.next()) {
							
							
							noofid++;
							date_time = rs.getString("date_time");
							engine_status = rs.getString("engine_status");
							latitude = rs.getString("latitude_value");
							longitude = rs.getString("longitude_value");
							date_in_db = date_time.substring(0, 10);
							day = date_in_db.substring(8, 10);
							month = date_in_db.substring(5, 7);
	
							year = date_in_db.substring(0, 4);
							hr = date_time.substring(11, 13);
							min = date_time.substring(14, 16);
							int hour = Integer.parseInt(hr);
							if (hour > 12) {
								am_pm = "PM";
								hour = hour - 12;
								if (hour < 10) {
									fin_hr = "0" + hour;
								} else {
									fin_hr = "" + hour;
								}
								time = fin_hr + ":" + min + " " + am_pm;
							} else {
								am_pm = "AM";
								if (hour < 10) {
									fin_hr = "0" + hour;
								} else {
									fin_hr = "" + hour;
								}
	
								time = fin_hr + " : " + min + " " + am_pm;
							}
							date = day + "-" + month + "-" + year;
							if (engine_status.equals("0")) {
							
								while (rs.next())//  Difference between Engine on and Engine off
								{								
									next_date_time = rs.getString("date_time");
									next_engine_status = rs.getString("engine_status");
									if (next_engine_status.equals("1")) {
										df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");									
										date1 = df.parse(date_time);																		
										date2 = df.parse(next_date_time);																		
										int diff = (int) (Math.abs(date1.getTime()
												- date2.getTime()) / 1000) / 60;									
										if (diff > input_halt_time) //if time differece between on and off is greater than given time then shows
										{
											offcounter = 0; //The Engine is on state and the difference is more than 15 min
											
										} else
											offcounter = 1;
										break;
									} else
										continue;
								
								}
								if (offcounter == 0) {
									
									counter++;  //This counter for Engine off loop
									//System.out.println(noofid);
				%><script type="text/javascript">
		
	get_address(<%=latitude%>,<%=longitude%>,<%=noofid%>,<%=counter%>);
	 
	</script>
	<tr>
	<td align="left" class="report_border" style="background: #efefef;"><%= date %></td>
	<td align="left" class="report_border"><%= time %></td>
	<td align="center" class="report_border" style="background: #efefef;"><img alt="Engine Off" src="../../images/off.png"></td>
	<td align="left" class="report_border"><span id="msg<%=noofid%>"></span></td>
		
						
	<%	
	System.out.println(latitude+"   "+longitude);
	offcounter++;
	oncounter=0;
		}
		
	}
	else{ 
		if(oncounter==0)
		{
			counter++;     //This counter for Engine on loop:
	%>
	<script type="text/javascript">
		
	get_address(<%=latitude%>,<%=longitude%>,<%=noofid%>,<%=counter%>);
	 
	</script>
	</tr>
	<tr>
	<td align="left" class="report_border" style="background: #efefef;"><%= date %></td>
	<td align="left" class="report_border"><%= time %></td>
	<td align="center" class="report_border" style="background: #efefef;"><img alt="Engine On" src="../../images/on.png"></td>
	<td align="left" class="report_border"><span id="msg<%=noofid%>"></span></td>
				
	<%
	oncounter++;
	offcounter=0;
		}
		
	} 
	%>
	</tr>
	<%
	
	}
	connection.close();
	rs.close();
	st.close();
	}catch(SQLException e){ System.out.println(e.getMessage()); } %>
	
	</table>
	
	</body>
	</html>
