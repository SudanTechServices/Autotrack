<%@page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
<%@ page errorPage="errorpage.jsp"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>



<!DOCTYPE head PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>

<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" type="text/javascript"></script>


<style type="text/css">
.wrapper .post {
-moz-border-radius:7px 7px 7px 7px;
border:1px solid silver;
float:left;
margin:2px;
min-height:100px;
padding:5px;
width:80%;
}
.post1 {
-moz-border-radius:7px 7px 7px 7px;
border:1px solid silver;
float:left;
margin:2px;
min-height:100px;
padding:3px;
width:15%;
}

</style>
</head>

<body onunload="GUnload()" onload="directions()"> 


		
		
<div class="wrapper">
<div class="post">
    <div id="map"  style="height: 96%; border:1px solid black;"></div>
</div>

 <div class="post1">
    <table>
    <tr><td><img src="../../images/dd-start.png"></td><td></td><td>Start</td></tr>
    <tr><td><img src="../../images/dd-end.png"></td><td></td><td>End</td></tr>
   <!--  <tr><td style="background-color: #8685F7"></td><td></td><td>Defined Route</td></tr> -->
    <tr><td style="background-color: green"></td><td></td><td>Route Taken</td></tr>
    </table>
 </div>
    <div id="distance_travelled" class="post1">
    </div>
 

</div>
				<%
				String customer_name=null,vehicle_number=null,driver_name=null,engine_status,next_engine_status;
				double currentlatitude=0.00f,currentlongitude=0.00f,previouslatitude=0.00f,previouslongitude=0.00f;;
				String imeinumber = request.getParameter("vehicle_number");
				 System.out.println("IMEI"+imeinumber);
				String date_time,next_date_time;
				
				String startdate = request.getParameter("start_date");
				 System.out.println(request.getParameter("start_date"));
				String enddate = request.getParameter("end_date");
				System.out.println(request.getParameter("end_date"));
				//String DRIVER = "com.mysql.jdbc.Driver";
				int counter=0,offcounter=0,oncounter=0;
				//Class.forName(DRIVER).newInstance();
				//Connection con=null;
				ResultSet rst=null;
				Statement stmt=null;
				DateFormat df=null;
				Date date1=null,date2=null;
				try
				{
				//String url=("jdbc:postgresql://localhost:5432/productconfiguration", "postgres","aatman");

				int i=1;
				DBTransaction dbtranobj=new DBTransaction();
				Connection connection=dbtranobj.connect();
				//connection=DriverManager.getConnection("jdbc:postgresql://192.168.1.95:5432/master_database", "postgres","postgres");
				stmt=connection.createStatement();
				rst = stmt.executeQuery("select latitude_value ,longitude_value,engine_status,date_time from tracking where imei_no='"+imeinumber+"' and date_time >='"+startdate+"' and date_time <= '"+enddate+"'");
					
					//int counter=0;
					List<String> array_lat=new ArrayList<String>();
					List<String> array_lng=new ArrayList<String>();
						
					while(rst.next())
					{
						
					
						counter++;
						currentlatitude=Double.parseDouble(rst.getString(1));
						currentlongitude=Double.parseDouble(rst.getString(2));
						engine_status=rst.getString("engine_status");
						date_time = rst.getString("date_time");
						
						if(engine_status.equals("0"))
						{
							//if(!rst.last())
							while(rst.next())//once vehicle is off and next is on then it will check the time difference between both
							{
								//System.out.println("going to check");
								next_date_time = rst.getString("date_time");
								next_engine_status = rst.getString("engine_status");
								//next_latitude=rs.getString("latitude_value");
								//next_longitude=rs.getString("longitude_value");
								if(next_engine_status.equals("1"))
								{
									df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
									//date_time="2013-05-23 16:23:44";
									// next_date_time="2013-05-23 16:25:44";
									   date1= df.parse(date_time);
										  date2= df.parse(next_date_time);
										  int diff = (int)(Math.abs(date1.getTime() - date2.getTime()) / 1000)/60;
										  System.out.println(diff);
										  if(diff>15)//if time differece between on and off is greater than 5 min then shows
										  {
											  offcounter=0;
										  }
										  else
											  offcounter=1;
									break;
								}
								else
									continue;
							}
							if(offcounter==0)
							{
							array_lat.add(rst.getString(1));
							array_lng.add(rst.getString(2));
							
							offcounter++;
							oncounter=0;
							}
						}
						else
						{
							
							if(oncounter==0)
							{
							array_lat.add(rst.getString(1));
							array_lng.add(rst.getString(2));
						
							oncounter++;
							offcounter=0;
							}
						}
								
					} 
							//while(rst.next())//once vehicle is off and next is on then it will check the time difference between both
							//{
								//System.out.println("going to check");
							//	next_date_time = rs.getString("date_time");
							//	next_engine_status = rs.getString("engine_status");
								//next_latitude=rs.getString("latitude_value");
								//next_longitude=rs.getString("longitude_value");
							//	if(next_engine_status.equals("1"))
								//{
							//		df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
									//date_time="2013-05-23 16:23:44";
									// next_date_time="2013-05-23 16:25:44";
							//		   date1= df.parse(date_time);
							//			  date2= df.parse(next_date_time);
							//			  int diff = (int)(Math.abs(date1.getTime() - date2.getTime()) / 1000)/60;
							//			  System.out.println(diff);
							//			  if(diff>15)//if time differece between on and off is greater than 5 min then shows
							//			  {
							////				  offcounter=0;
							//			  }
							//			  else
							//				  offcounter=1;
							//		break;
							//	}
						//		else
						//			continue;
							//}
						//	if(offcounter==0)
						//	{
								//System.out.println(noofid);
						
						
					
							
						//}
					//	else{ 
					//		if(oncounter==0)
					//		{
								//System.out.println(noofid);
						
					
						
						
						
						
						//System.out.println(currentlatitude);
					//	System.out.println(currentlongitude);
						/* if(((currentlatitude>=previouslatitude-0.03) && (currentlatitude<=previouslatitude+0.03)) && ((currentlongitude>=previouslongitude-0.02) && (currentlongitude<=previouslongitude+0.02)))
						{
							array_lat.add(rst.getString(1));
							array_lng.add(rst.getString(2));
							previouslatitude=currentlatitude;
							previouslongitude=currentlongitude;
							System.out.println("if"+currentlatitude);
							System.out.println("if"+currentlongitude);
						} */
						
					//array_lat.add(rst.getString(1));
					//array_lng.add(rst.getString(2));
					
						//}
					System.out.println("size="+array_lat.size());
					System.out.println("full size="+counter);
					System.out.println("in fence");
					String start_address = null;
					String end_address = null;
					ResultSet rst1 = null;
			
			/*rst1 = stmt.executeQuery("SELECT route_registration.source,route_registration.destination,vehicle_information.imei_no FROM vehicle_information,route_registration WHERE vehicle_information.vehicle_number = route_registration.vehicle_number and vehicle_information.imei_no='"+imeinumber+"'");
			
			
			while(rst1.next()){
				start_address  = rst1.getString("source");
				end_address  = rst1.getString("destination");
				String imei = rst1.getString("imei_no");
				
				}*/
			rst1 = stmt.executeQuery("select V.customer_name,V.vehicle_number,D.driver_name from vehicle_information V,driver_info D where V.vehicle_number=D.vehicle_number and V.imei_no='"+imeinumber+"'");
			if(rst1.next())
			{
				customer_name=rst1.getString("customer_name");
				vehicle_number=rst1.getString("vehicle_number");
				driver_name=rst1.getString("driver_name");
				
			}	

			
		
			
%> 
<script type="text/javascript">

					var boundaryColor = '#ED1B24'; // initialize color of polyline
					var polyCoordinates =[]; // initialize an array where we store latitude and longitude pair
					var count=0;	
				
					     					 
					 if (GBrowserIsCompatible()) { 

					      var map = new GMap(document.getElementById("map"));
					      map.addControl(new GLargeMapControl());
					      map.addControl(new GMapTypeControl());
					         

					      var bounds = new GLatLngBounds();
					      
					      var geo = new GClientGeocoder(new GGeocodeCache()); 

					      // ====== Array for decoding the failure codes ======
					      var reasons=[];
					      
					      reasons[G_GEO_SUCCESS]            = "Success";
					      reasons[G_GEO_MISSING_ADDRESS]    = "Missing Address: The address was either missing or had no value.";
					      reasons[G_GEO_UNKNOWN_ADDRESS]    = "Unknown Address:  No corresponding geographic location could be found for the specified address.";
					      reasons[G_GEO_UNAVAILABLE_ADDRESS]= "Unavailable Address:  The geocode for the given address cannot be returned due to legal or contractual reasons.";
					      reasons[G_GEO_BAD_KEY]            = "Bad Key: The API key is either invalid or does not match the domain for which it was given";
					      reasons[G_GEO_TOO_MANY_QUERIES]   = "Too Many Queries: The daily geocoding quota for this site has been exceeded.";
					      reasons[G_GEO_SERVER_ERROR]       = "Server error: The geocoding request could not be successfully processed.";
					      reasons[G_GEO_BAD_REQUEST]        = "A directions request could not be successfully parsed.";
					      reasons[G_GEO_MISSING_QUERY]      = "No query was specified in the input.";
					      reasons[G_GEO_UNKNOWN_DIRECTIONS] = "The GDirections object could not compute directions between the points.";
					      
					      // ====== Geocoding ======
					    	  
					     var baseIcon = new GIcon(G_DEFAULT_ICON);
					      baseIcon.iconSize=new GSize(24,38);

					      var icon1 = G_START_ICON;
					      var icon2 = G_PAUSE_ICON;
					      var icon3 = G_END_ICON;
					      var icon4 = new GIcon(baseIcon,"http://labs.google.com/ridefinder/images/mm_20_white.png");
					          icon4.shadow = "http://labs.google.com/ridefinder/images/mm_20_shadow.png";
					          icon4.iconSize = new GSize(12, 20);
					          icon4.shadowSize = new GSize(22, 20);
					          icon4.iconAnchor = new GPoint(6, 20);
					          icon4.infoWindowAnchor = new GPoint(5, 1);
					          
					          

					        
function createMarker(point,i,icon,html) {
					       
	var marker = new GMarker(point,{draggable:false,icon:icon});
	 //gmarkers[i]=marker;
    GEvent.addListener(marker, "mouseover", function() {
      marker.openInfoWindowHtml(html);
    });
   		        map.addOverlay(marker);
	}
					      

					      // ===== Array to contain the points of the path =====
					      var path = [];
					      
					      var gmarkers = [];
					      var addresses = [];

					     
/* 
	function doStart(point1) {
					    	  
					        createMarker(point1,0,icon1,'Source :');
					        path[0] = point1;
					       }

	function doEnd(point2) {
					        createMarker(point2,4,icon3,'Destination :');
					        path[4] = point2;
					        bounds.extend(path[0]);
					        bounds.extend(path[4]);
					      
					        map.setZoom(12);
					        map.setCenter(bounds.getCenter());
					      } */

					    var gdir=new GDirections();


					      var poly;
					      
					      GEvent.addListener(gdir, "load", function() {
					        
					        poly = gdir.getPolyline();
					        map.addOverlay(poly);
					      });
					      
					     
					      
					      
	function directions() {
								var pts =[];
			   					var lat,lng;
			   					
			   		
					     		<%-- var St_address = "'<%=start_address%>'";					       		
					       		var En_address = "'<%=end_address%>'";
   --%>
						         /*  geo.getLatLng(St_address, function (start){
						        	  if(St_address){}
						        });
						          geo.getLatLng(En_address, function (end){
						        	  if(En_address){}
						        });
					       		
					          var line = "from: "+St_address + " to: " + En_address;
					          gdir.load(line, {getPolyline:false}); */
					          
					         
				 <%			
				 int j =0;
							      for(j=0; j<array_lat.size(); j++) {
							    	 %>
							    			      
							  	lat=<%=array_lat.get(j)%>;
						    	lng=<%=array_lng.get(j)%>;
							    
						    	pts[<%=j%>] = new GLatLng(lat,lng);
							    
						    	<%  } 
							      
							      							      
							      %>				      
							 
							      map.setCenter(new GLatLng(<%=array_lat.get(0)%>,<%=array_lng.get(0)%>),10); 		       
						    	
						    	createMarker(pts[0],0,icon1,'Vehicle Number : <%=vehicle_number%> <br> Owned : <%=customer_name%> <br> Driver name : <%=driver_name%>');
							     createMarker(pts[<%=array_lat.size()%>-1],0,icon3,'Vehicle Number : <%=vehicle_number%> <br> Owner : <%=customer_name%> <br> Driver name : <%=driver_name%>');
							  
							     var poly = new GPolyline(pts,"green",4,1);
							     map.addOverlay(poly);  
							     var length = poly.getLength()/1000;
							      roundNumber(length, 2);
						  }
	
	function roundNumber(rnum, rlength) { // Arguments: number to round, number of decimal places
		  var newnumber = Math.round(rnum*Math.pow(10,rlength))/Math.pow(10,rlength);
		   // Output the result to the form field (change for your purposes)
		  document.getElementById("distance_travelled").innerHTML = "<table><tr><td>Distance Travelled:</td></tr><tr><td>"+newnumber+" Kms</td></tr></table>"
		}
	
	
	// Function to create Polyline
	
	function createPolyline(polyC)
	{
							 Path = new google.maps.Polyline({
							 path: polyC,
							 strokeColor: boundaryColor,
							 strokeOpacity: 1.0,
							 strokeWeight: 2
							 });
							 Path.setMap(map);
	}

	function connectPoints()
	{
	 var point_add = []; // initialize an array 
	 
	 var start = polyCoordinates[0]; // storing start point 
	 var end = polyCoordinates[(polyCoordinates.length-1)]; // storing end point 
	 
	 // pushing start and end point to an array 
	// point_add.push(start);
	// point_add.push(end);
	 
	  // function to join points
	 
	 var ptttt = [];
	 
	 for(t=0;t<=polyCoordinates.length-1;t++){
		 
		 ptttt.push(polyCoordinates[t]);
	 }
	 document.getElementById('pts').innerHTML = ptttt;
	}
					   
					      
}
					    
					    // display a warning if the browser was not compatible
					    else {
					      alert("Sorry, the Google Maps API is not compatible with this browser");
					    }
					    
					    
					    
					</script>
				<%
					connection.close();	
			rst.close();
			stmt.close();
					}
		 catch (SQLException e) {
			System.out.println("Connection Failed! Check output console");
			e.printStackTrace();
			
			return;	}
			%>						

			
<!-- .x12 -->
		
	 <!-- #content -->
	
</body>