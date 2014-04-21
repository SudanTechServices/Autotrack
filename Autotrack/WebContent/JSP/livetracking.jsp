<%-- <%@page import="org.apache.naming.java.javaURLContextFactory"%> --%>
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

<head>

<link rel="stylesheet" type="text/css" href="../CSS/style.css" />

<!-- ..//JQuery Source\\.. -->
<script type="text/javascript" src="../JS/jquery-1.4.2.min.js"></script>
	
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" type="text/javascript"></script>
 
<!-- ..//JavaScript Code for this page\\.. -->

	<title>Live Tracking</title> 
	

</head>
<body onload="loadmap()">
<div class="content_bg"><span class="content_headning">Live Tracking</span></div>

<% String IMEI=request.getParameter("vehicle_no");
					System.out.println("IMEI"+IMEI);
					if (IMEI==null)
					{
					%>

	<div class="map">
		<div class="post">
			<div style="width:100%; height: 50%; padding-top: 1%;"><img src="../images/worldmap.png" width="100%" height="375px"></div>
		</div>
	</div>

		<%}
		else
		{
		%>
					
<div class="map">
    <div style="padding: 5px;" class="table_content"><label id="msg"></label><label id="speed"></label></div>
	<div class="post">
		<div id="map"  style="width: 100%; height:375px;  border:1px solid #dfdbdb;"></div>
	</div>
</div>	
				<%
				String adr=null;
					try {
						
				
						
						DBTransaction dbtranobj=new DBTransaction();
						Connection connection=dbtranobj.connect();
					//System.out.println(connection.isClosed());
					//System.out.println("PostgreSQL JDBC Driver Registered!");
					String customer_name=null,fuel=null,mile=null,engine_status=null,vehicle_number=null,SQL=null,Driver_name=null;
					ResultSet set = null;
					
					
					SQL="select customer_name,vehicle_number from vehicle_information where imei_no='"+IMEI+"'";				
					String GetData = "SELECT latitude_value,longitude_value,fuel,mile,engine_status FROM recent where imei_no='"+IMEI+"'order by date_time desc limit 1";
					Statement mystatement = connection.createStatement();
					set = mystatement.executeQuery(SQL);
					if(set.next())
					{
						customer_name=set.getString(1);
						vehicle_number=set.getString(2);
						SQL="select driver_name from driver_info where vehicle_number='"+vehicle_number+"'";
						set = mystatement.executeQuery(SQL);
						if(set.next())
						{
							Driver_name=set.getString("driver_name");
							
						}
					}
					set = mystatement.executeQuery(GetData);
					
					if(set.next()){
					String latitude = set.getString("latitude_value");
					String longitude = set.getString("longitude_value");
					fuel=set.getString("fuel");
					mile=set.getString("mile");
					engine_status = set.getString("engine_status");
					
					if(engine_status.equalsIgnoreCase("1")){ engine_status = "ON"; }
					else { engine_status = "OFF" ; }
					
					
					%>
					
<script type="text/javascript">
					
				// Gets The Google Map in That ID 
					
					 var map = new GMap2(document.getElementById("map"));
					
	   			//Creates The Marker 
					 
					function createMarker(point,HTML,status,speed) {
				        
	   				var marker="";
				    	   
				    	  //Start Icon 
				        
				        var myIcon = new GIcon(G_DEFAULT_ICON);
				        myIcon.image = "../images/dd-start.png";
				        var markerOptions = { icon:myIcon };
				        
				        //idle icon 
				        
				        var myIcon1 = new GIcon(G_DEFAULT_ICON);
				        myIcon1.image = "../images/dd-idle.png";
				        var markerOptions1 = { icon:myIcon1 };
				        
				        //Stop Icon 
				        
				         var myIcon2 = new GIcon(G_DEFAULT_ICON);
				        myIcon2.image = "../images/dd-end.png";
				        var markerOptions2 = { icon:myIcon2 };
				        
				        if(status == "ON" && speed > 0){
				              marker = new GMarker(point,markerOptions);
				        	}
				        else if(status == "ON" && speed == 0){
				              marker = new GMarker(point,markerOptions1);
			        	}
				        else{
				            marker = new GMarker(point,markerOptions2);
				     	    }
				        
				       // marker.openInfoWindowHtml(HTML);
				        
				         GEvent.addListener(marker, "mouseover", function() {
				          marker.openInfoWindowHtml(HTML);
				          }); 
				         
				         
				         
				        return marker;
				   }
				
				
									
				//AJAX To Get the Lat And Lang From  another jsp....
	
					function check(IMEI){

						$(document).ready(function(){
						this.timer = setTimeout(function () {
						$.ajax({
						url: 'livetracking_latlng.jsp',
						data: 'imei='+IMEI,
						type: 'POST',
						success: function(msg){ 
							
							var msg = msg.trim();
							
							alerting(msg);
							
						} }); }, 600);

						return true;
						});
				}
						
		 			//Function That loads the Google Map  
		 
							function loadmap(msg){
								
							 if (GBrowserIsCompatible()) { 
								 					     
						     self.setInterval("check('<%=IMEI%>')",3000);
						     
						  	  map.setCenter(new GLatLng(<%=latitude%>,<%=longitude%>),15);
						  
						  	  var point = new GLatLng(<%=latitude%>,<%=longitude%>);
						  	 
						  	//Customised Marker 
						  	
						  	var HTML = "<table style='font-family:arial; font-size:12px;'>"+
						  					"<tr><td>Vehicle Number </td><td> : </td><td> <%=vehicle_number%> </td></tr>"+
							 				"<tr><td>Owned by </td><td> : </td><td> <%=customer_name%></td></tr>"+
							 				"<tr><td>Engine Status </td><td> : </td><td> <%=engine_status%></td></tr>"+
							 				
							 				"<tr><td>Speed </td><td> : </td><td> <%=mile%> km/hr</td></tr>"+
							 				
							 				"</table>";
							  	
					     var marker = createMarker(point,HTML,'<%=engine_status%>','<%=mile%>');
							  	
					
						     	map.addOverlay(marker);
						     
						     	map.setCenter(point);
						     	
						     	
						     	
						      	map.addControl(new GMapTypeControl());
						     	map.addControl(new GLargeMapControl());
						   
						     	get_address(<%=latitude%>,<%=longitude%>,<%=mile%>);
						     	
							 }
							 
								
						}     
							
				// Function Gets the  new lat lang value and loads in the map 
		
							function alerting(msg){
								 
								var msg = msg.trim();
										
									var split = msg.split(',');
									var lat = split[0];
									var lang = split[1];
									var speed = split[2];
									var fuel = split[3];
									var engine_status = split[4];
									 
									if(engine_status == "1"){ engine_status = "ON"; }
									else{ engine_status = "OFF"; }
																						
								 	 map.clearOverlays();

									// map.setCenter(new GLatLng(lat,lang));
								
								  	 var point = new GLatLng(lat,lang);
								  	 
								 	//Customised Marker 
								  	
								 	var HTML = "<table style='font-family:arial; font-size:12px;'>"+
									 				"<tr><td>Vehicle Number </td><td> : </td><td> <%=vehicle_number%> </td></tr>"+
									 				"<tr><td>Owned by </td><td> : </td><td> <%=customer_name%> </td></tr>"+
									 				"<tr><td>Engine Status </td><td> : </td><td> "+engine_status+" </td></tr>"+
									 				
									 				"<tr><td>Speed </td><td> : </td><td> "+speed+ " km/hr</td></tr>"+
									 				
									 				"</table>";
								 	

									 	var marker = createMarker(point,HTML,engine_status,speed);
									  	
									 	
								 	//Simple Marker 
									 	
									 	//var marker = new GMarker(point);
									 				
									 	//marker.openInfoWindowHtml(HTML);
									 	
								     	map.addOverlay(marker);
								     
								     	map.setCenter(point);
								     	
								    get_address(lat, lang,speed);
								     
								   
							}
							
				function get_address(lat1,lang,speed){
					 var lat = lat1;
					    var lon = lang;
					    
				        var search =''+lat+','+lon+'';
				        var geo = new GClientGeocoder();
				        // ====== Perform the Geocoding ======        
				        geo.getLocations(search, function (result)
				          { 
				        	
				            if (result.Status.code == G_GEO_SUCCESS) {
				            
				              for (var i=0; i<result.Placemark.length; i++) {
				               /// var p = result.Placemark[i].Point.coordinates;
				               // var marker = new GMarker(new GLatLng(p[1],p[0]));
				                document.getElementById("msg").innerHTML = "<b>Location </b>: "+result.Placemark[i].address+"  | ";
				                document.getElementById("speed").innerHTML = "<b>Speed </b>: "+speed+" km/hr";
				               
				                
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
					
		<%
		
		
					
					}//if close
					else
					{%>
						<div class="map">
						<div class="post">
							<div style="width: 100%; height: 80%; padding-top: 35px"><img src="../images/breakdown.jpg"></div>
							
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
