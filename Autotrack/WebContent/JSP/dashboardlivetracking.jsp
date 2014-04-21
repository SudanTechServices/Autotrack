<%-- <%@page import="org.apache.naming.java.javaURLContextFactory"%> --%>
<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*" import="java.sql.*" import="java.util.Date" import="java.util.Calendar"%>
    <%@ page errorPage="errorpage.jsp" %>
<%@ page import="com.ts.service.dropdown" %> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*" %>

<%@ page import="com.ts.dbtransactionmgr.DBTransaction;" %>
<%
//String IMEI=(String)session.getAttribute("IMEI");
String IMEI=request.getParameter("IMEI");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<!-- ..//JQuery Source\\.. -->

	<script type="text/javascript" src="../JS/jquery-1.4.2.min.js"></script>
	<link href="../CSS/SyntaxHighlighter.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../JS/shCore.js" language="javascript"></script>
    <script type="text/javascript" src="../JS/shBrushJScript.js" language="javascript"></script>
    <script type="text/javascript" src="../JS/ModalPopups.js" language="javascript"></script>
    <script type="text/javascript" src="../JS/shInit.js" language="javascript"></script>	
    <script type="text/javascript" src="../JS/validate.js" language="javascript"></script>
    <link rel="stylesheet" type="text/css" href="../CSS/style.css" />
     
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" type="text/javascript"></script>
 
<!-- ..//JavaScript Code for this page\\.. -->

	<title>DashBoard Live Tracking</title> 

<script type="text/javascript">

function cam_popup(){
	
	myWindow=window.open("http://182.74.73.29/cmsgps/monitor/video/<%=IMEI%>.html",'','width=725,height=600');

	myWindow.focus();
	
}
function camera_popup(frame){
	
		
	ModalPopups.Confirm("jsAlert1","<center><div style='padding-left:45px;'>Camera 1 </div></center>","klgjhkgh",
             
            {
                    titleBackColor: "#0088DD",
                    titleFontColor: "white",
                    popupBackColor: "#BDE6FC",
                    popupFontColor: "black",
                    footerBackColor: "#0088DD",
                    footerFontColor: "white",
                    fontFamily: "Courier New",                 
                    yesButtonText: "Delete",
                    noButtonText: "Cancel",
                    onYes: "DeletePopupConfirmYes("+sno+")",
                    onNo: "DeletePopupConfirmNo()"
            }
        );
	
}

</script>

</head>
<body onload="loadmap()">

	<div class="content_bg">
		<span class="content_headning">Dashboard Live Tracking</span>
	</div>


<% 
					//System.out.println("IMEI"+IMEI);
					if (IMEI==null)
					{
					%>

	
		<div class="post">
			<div style="width:100%; height: 95%; padding-top: 1%;"><img src="../images/worldmap.png" width="100%" height="95%"></div>
		</div>
	

		<%}
		else
		{
		%>
					
<div class="map">
    <div style="padding: 5px;" class="table_content"><label id="msg"></label><label id="speed"></label><label id="Camera"></label> </div>
	<div class="post">
		<div id="map"  style="width: 100%; height:500px;  border:1px solid #b0b0b0; "></div>
	</div>
</div>	
				<%
				String adr=null;
					try {
						
				
						
						DBTransaction dbtranobj=new DBTransaction();
						Connection connection=dbtranobj.connect();
					
					//System.out.println("PostgreSQL JDBC Driver Registered!");
					String customer_name=null,fuel=null,mile=null,engine_status=null,vehicle_number=null,SQL=null,Driver_name=null,camera_id=null;
					ResultSet set = null;
					
					
					SQL="select customer_name,vehicle_number,camera_id from vehicle_information where imei_no='"+IMEI+"'";				
					String GetData = "SELECT latitude_value,longitude_value,fuel,mile,engine_status FROM tracking where imei_no='"+IMEI+"'order by date_time desc limit 1";
					Statement mystatement = connection.createStatement();
					set = mystatement.executeQuery(SQL);
					if(set.next())
					{
						customer_name=set.getString(1);
						vehicle_number=set.getString(2);
						camera_id=set.getString("camera_id");
						System.out.println(camera_id);
						SQL="select driver_name from driver_info where vehicle_number='"+vehicle_number+"'";
						set = mystatement.executeQuery(SQL);
						if(set.next())
						{
							Driver_name=set.getString(1);
						}
					}
					set = mystatement.executeQuery(GetData);
					
					if(set.next()){
					String latitude = set.getString(1);
					String longitude = set.getString(2);
					
					mile=set.getString(4);
					engine_status = set.getString(5);
					
					
									
					
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
				       // myIcon.iconSize = new GSize(27,30);
				        //myIcon.shadow = "../images/car_shadow_icon.png";
				        //myIcon.shadowSize = new GSize(36, 45);
				        var markerOptions = { icon:myIcon };
				        
				        //idle icon
				        
				        var myIcon1 = new GIcon(G_DEFAULT_ICON);
				        myIcon1.image = "../images/dd-idle.png";
				       // myIcon.iconSize = new GSize(27,30);
				        //myIcon.shadow = "../images/car_shadow_icon.png";
				        //myIcon.shadowSize = new GSize(36, 45);
				        var markerOptions1 = { icon:myIcon1 };
				        
				        //Stop Icon
				         var myIcon2 = new GIcon(G_DEFAULT_ICON);
				        myIcon2.image = "../images/dd-end.png";
				        /* myIcon1.iconSize = new GSize(27,30);
				        myIcon1.shadow = "../images/car_shadow_icon.png";
				        myIcon1.shadowSize = new GSize(36, 45); */
				        var markerOptions2 = { icon:myIcon2 };
				        
				        if(status == "ON" && speed > 0){
				              marker = new GMarker(point,markerOptions);
				        	}
				        else if(status == "ON" && speed == 0){
				              marker = new GMarker(point,markerOptions1);
			        	}
				        if(status == "OFF"){
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
						
						 msg = msg.trim();
						
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
					  					"<tr><td>Vehicle Number </td><td>:</td><td> <%=vehicle_number%> </td></tr>"+
						 				"<tr><td>Owned by </td><td>:</td><td> <%=customer_name%></td></tr>"+
						 				"<tr><td>Engine Status </td><td>:</td><td> <%=engine_status%></td></tr>"+
						 				
						 				"<tr><td>Speed </td><td>:</td><td> <%=mile%> km/hr</td></tr>"+
						 				<%if(!camera_id.equals("0000"))
						 				{%>
						 				"<tr><td>Camera </td><td>:</td><td><a href='#' onclick='cam_popup();'>camera</a></td></tr>"+
						 				<%}%>
						 				"</table>";
						  	
						 	var marker = createMarker(point,HTML,'<%=engine_status%>','<%=mile%>');
						  	
						 	//Simple Marker 
						 	
						 	//var marker = new GMarker(point);
						 				
						 	//marker.openInfoWindowHtml(HTML);
						 	
					     	map.addOverlay(marker);
					     
					     	map.setCenter(point);
					     	
					     	
					     	
					      	map.addControl(new GMapTypeControl());
					     	map.addControl(new GLargeMapControl());
					   
					     	get_address(<%=latitude%>,<%=longitude%>,<%=mile%>,'<%=camera_id%>');
					     	
						 }
						 
							
					}     
						
			// Function Gets the  new lat lang value and loads in the map 
	
						function alerting(msg){
							 
							msg = msg.trim();
									
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
								 				"<tr><td>Vehicle Number</td><td>:</td><td> <%=vehicle_number%> </td></tr>"+
								 				"<tr><td>Owned by </td><td>:</td><td> <%=customer_name%> </td></tr>"+
								 				"<tr><td>Engine Status </td><td>:</td><td> "+engine_status+" </td></tr>"+
								 				
								 				"<tr><td>Speed </td><td>:</td><td> "+speed+ " km/hr</td></tr>"+
								 				<%if(!camera_id.equals("0000"))
								 				{%>
								 				"<tr><td>Camera </td><td>:</td><td><a href='#' onclick='cam_popup();'>camera</a></td></tr>"+
								 				<%}%>
								 				"</table>";
							 	

								 	var marker = createMarker(point,HTML,engine_status,speed);
								  	
								 	
							 	//Simple Marker 
								 	
								 	//var marker = new GMarker(point);
								 				
								 	//marker.openInfoWindowHtml(HTML);
								 	
							     	map.addOverlay(marker);
							     
							     	map.setCenter(point);
							     	
							    get_address(lat, lang,speed,'<%=camera_id%>');
							     
							   
						}
						
			function get_address(lat1,lang,speed,cameraid){
				
				
				
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
			               				if(cameraid != "0000")
			 								{
			            	  document.getElementById("Camera").innerHTML = " |  <a href='#' onclick='cam_popup();'>camera</a>";
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
