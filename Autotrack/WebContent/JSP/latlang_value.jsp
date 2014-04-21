
<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*" import="java.sql.*" import="java.util.Date" import="java.util.Calendar"%>
    <%@ page errorPage="errorpage.jsp" %>
<%@ page import="com.ts.service.dropdown" %> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*" %>

<%@ page import="com.ts.dbtransactionmgr.DBTransaction;" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<META HTTP-EQUIV="REFRESH" CONTENT="">
<head>

<!-- ..//JQuery Source\\.. -->
<script type="text/javascript" src="http://jqtouch.googlecode.com/svn-history/r134/trunk/jqtouch/jquery-1.4.2.min.js"></script>
	
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" type="text/javascript"></script>
 
<!-- ..//JavaScript Code for this page\\.. -->


<body onload="loadmap()">

<div id="map"  style="width: 100%; height: 300px;  border:1px solid black; "></div>

<% String IMEI=request.getParameter("vehicle_no");
					System.out.println("IMEI"+IMEI);
					if (IMEI==null)
					{
					%>

	<div class="wrapper">
		<div class="post">
			<div style="width:100%; height: 95%; padding-top: 1%;"><img src="../images/worldmap.png" width="100%" height="95%"></div>
		</div>
	</div>

		<%}
		else
		{
		%>
					
<div class="wrapper">
	<div class="post">
		<div id="map"  style="width: 100%; height: 96%;  border:1px solid black; "></div>
	</div>
</div>	
				<%
				String adr=null;
					try {
						
				
						
						DBTransaction dbtranobj=new DBTransaction();
						Connection connection=dbtranobj.connect();
					
					//System.out.println("PostgreSQL JDBC Driver Registered!");
					String customer_name=null,fuel=null,mile=null,engine_status=null,vehicle_number=null,SQL=null,Driver_name=null;
					ResultSet set = null;
					
					
					SQL="select customer_name,vehicle_number from vehicle_information where imei_no='"+IMEI+"'";				
					String GetData = "SELECT latitude_value,longitude_value,fuel,mile FROM tracking where imei_no='"+IMEI+"'order by date_time desc limit 1";
					Statement mystatement = connection.createStatement();
					set = mystatement.executeQuery(SQL);
					if(set.next())
					{
						customer_name=set.getString(1);
						vehicle_number=set.getString(2);
						SQL="select first_name,middle_name,last_name from driver_information where vehicle_number='"+vehicle_number+"'";
						set = mystatement.executeQuery(SQL);
						if(set.next())
						{
							Driver_name=set.getString(1)+" " +set.getString(2)+" "+set.getString(3);
						}
					}
					set = mystatement.executeQuery(GetData);
					
					if(set.next()){
					String latitude = set.getString(1);
					String longitude = set.getString(2);
					fuel=set.getString(3);
					mile=set.getString(4);
					System.out.println("Latitude =: "+latitude);
					System.out.println("Longitude =: "+longitude);
					float fuels=Float.parseFloat(fuel);
					if(fuels==0.00)
						engine_status="OFF";
					else
						engine_status="ON";
					%>
					
					<script type="text/javascript">
					function check(){

					$(document).ready(function(){
					this.timer = setTimeout(function () {
					$.ajax({
					url: 'latlngcheck.jsp',
					data: '',
					type: 'POST',
					success: function(msg){ 
						
						alerting(msg);
						

					} }); }, 600);

					return false;
					});
					}
					
						function loadmap(msg){
							
						 if (GBrowserIsCompatible()) { 
							 
							 self.setInterval("check()",10000);
							 
					     var map = new GMap2(document.getElementById("map"));
					     map.setCenter(new GLatLng(13,80), 11);
					  	 var point = new GLatLng(13,80);
					  	 
					     var marker = new GMarker(point);
					     
					     map.addOverlay(marker);
					     
					      map.addControl(new GMapTypeControl());
					      map.addControl(new GLargeMapControl());
					   
					  			
					 
					  
						}  
						 
							
					}     
						function alerting(msg){
							
							var msg = msg.trim();
									
								var split = msg.split(',');

								var lat = split[0];
								var lang = split[1];
								
								loadmap1(lat,lang);

						}
						
						function loadmap1(lat,lang){
							
							 if (GBrowserIsCompatible()) { 
								 
						     var map = new GMap2(document.getElementById("map"));
						     
						     map.setCenter(new GLatLng(lat,lang),15);
						     
						  	 var point = new GLatLng(lat,lang);
						  	 
						  	var marker = new GMarker(point);
						     
						      map.addOverlay(marker);
						      map.addControl(new GMapTypeControl());
						      map.addControl(new GLargeMapControl());
						   
						  			
						 
						  
							}  
							
						}     
						
					</script>
					
		<%
					
					}//if close
					else
					{%>
						<div class="wrapper">
						<div class="post">
							<div style="width: 100%; height: 90%; padding-top: 35px"><img src="../images/breakdown.jpg"></div>
							
						</div>
						</div>
						
				<%	}
					connection.close();
					mystatement.close();
					set.close();
					} catch (SQLException e) {
					//System.out.println("Connection Failed! Check output console");
					//e.printStackTrace();
					//return;	
					}
					catch (ClassNotFoundException e) {
					System.out.println("Where is your PostgreSQL JDBC Driver? "
							+ "Include in your library path!");
					e.printStackTrace();
					return;}
}
		%>

</body> 
 
</html>