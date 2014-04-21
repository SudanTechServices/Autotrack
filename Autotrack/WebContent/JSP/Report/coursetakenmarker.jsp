
<%@page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
<%@ page errorPage="errorpage.jsp"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>

<html>
<!DOCTYPE head PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" type="text/javascript"></script>


<style type="text/css">
.post {

border:1px solid silver;
float:left;
padding:5px;
width:80%;
}
.posts {

border:1px solid silver;
float:left;
padding:3px;
width:15%;
}

</style>
  <link rel="stylesheet" type="text/css" href="../../CSS/style.css" />
</head>

<body onunload="GUnload()" onload="directions()"> 

	<div class="content_bg"><span class="content_headning">Course Taken</span></div><br/>
		
<div style="width: 100%; float: left;">


<div class="post">  

    <div id="map"  style="height: 96%; border:1px solid black;"></div>
</div>

 <div class="posts">
    <table>
    <tr><td><img src="../../images/dd-start.png"></td><td></td><td>Start</td></tr>
    <tr><td><img src="../../images/pauseIcon.png"></td><td></td><td>Pause</td></tr>
    <tr><td><img src="../../images/dd-end.png"></td><td></td><td>End</td></tr>
   <!--  <tr><td><img src="../../images/ReverseIcon.png"></td><td></td><td>Reverse</td></tr> -->
   <!--  <tr><td style="background-color: #8685F7"></td><td></td><td>Defined Route</td></tr> -->
    <tr><td style="background-color: green"></td><td></td><td>Route Taken</td></tr>
    </table>
 </div>
    <div id="distance_travelled" class="posts">
    </div>
 
</div>
				<%
				String customer_name=null,vehicle_number=null,driver_name=null,direction="";
				double currentlatitude=0.00f,currentlongitude=0.00f,currentlatitude2=0.00f,previouslatitude=0.00f,previouslongitude=0.00f,nextlatitude=0.00f;;
				String imeinumber = request.getParameter("vehicle_number");
				int input_halt_time=Integer.parseInt(request.getParameter("halt_timing")); 
				
				
				String startdate = request.getParameter("start_date");
				 //System.out.println(request.getParameter("start_date"));
				String enddate = request.getParameter("end_date");
			
				//System.out.println(request.getParameter("end_date"));
				//String DRIVER = "com.mysql.jdbc.Driver";
				int counter=0;
				String engineStatus =null;
				String nextEngineStatus = null;
				ResultSet rst=null;
				Statement stmt=null;
				
				
				try{

				int i=1;
				DBTransaction dbtranobj=new DBTransaction();
				Connection connection=dbtranobj.connect();
				//connection=DriverManager.getConnection("jdbc:postgresql://192.168.1.95:5432/master_database", "postgres","postgres");
				stmt=connection.createStatement();
				/* rst = stmt.executeQuery("select latitude_value ,longitude_value from tracking where imei_no='"+imeinumber+"' and date_time >='"+startdate+"' and date_time <= '"+enddate+"' and engine_status='1';"); */
				 rst = stmt.executeQuery("select latitude_value ,longitude_value,engine_status from tracking where imei_no='"+imeinumber+"' and date_time >='"+startdate+"' and date_time <= '"+enddate+"'"); 
				System.out.println("Starting and ending query: "+"select latitude_value ,longitude_value from tracking where imei_no='"+imeinumber+"' and date_time >='"+startdate+"' and date_time <= '"+enddate+"'");
					
					//int counter=0;
					List<String> array_lat=new ArrayList<String>();
					List<String> array_lng=new ArrayList<String>();
					List<String> breakPoint_lat = new ArrayList<String>();
					List<String> breakPoint_lng = new ArrayList<String>();
						if(rst.next())
						{
							previouslatitude=Double.parseDouble(rst.getString(1));
							previouslongitude=Double.parseDouble(rst.getString(2));
						}
						while(rst.next()){
							counter++;
							currentlatitude=Double.parseDouble(rst.getString(1));
							currentlongitude=Double.parseDouble(rst.getString(2));
							engineStatus=rst.getString("engine_status");
							
							if(previouslatitude > currentlatitude){ //if previous lat is greater than currentlat means vehicle going to north to south
								if(((currentlatitude>=previouslatitude-0.03)) || ((currentlongitude>=previouslongitude-0.03) && (currentlongitude<=previouslongitude+0.03)))
								{         //Here polyline goes north to south                                                                                                     
									array_lat.add(rst.getString(1));
									array_lng.add(rst.getString(2));
									previouslatitude=currentlatitude;
									previouslongitude=currentlongitude;
									
								}
								
							
								
							}
							
							//System.out.println("Engine Status 0 :"+engineStatus.equals("0"));
							if(engineStatus.equals("0")){
								while(rst.next()){	
									nextlatitude=Double.parseDouble(rst.getString(1));
									//System.out.println("off and nextlatitude lat :"+nextlatitude);
								
									if(nextlatitude > currentlatitude){
										breakPoint_lat.add(rst.getString(1));
										
										breakPoint_lng.add(rst.getString(2));
										//System.out.println("breakpoint is :"+breakPoint_lat +";" +breakPoint_lng);
									} break;
									
								}
								
							
						}
						
							//System.out.println("off and previous lat :"+previouslatitude);
							//System.out.println("off and current lat :"+currentlatitude);
								
						
							
							 if(previouslatitude < currentlatitude){  //If previouslat is less than currentlat sense vehicle moves south to north
								if(((currentlatitude<=previouslatitude+0.03)) || ((currentlongitude>=previouslongitude-0.03) && (currentlongitude<=previouslongitude+0.03)))
								{          //Here polyline goes south to north
									while(rst.next()){
									array_lat.add(rst.getString(1));
									array_lng.add(rst.getString(2));
									previouslatitude=currentlatitude;
									previouslongitude=currentlongitude;
									}
								}
							// System.out.println("south to north: "+previouslatitude+": "+previouslongitude);
								
							}						
							 if(engineStatus.equals("0")){
									while(rst.next()){	
										nextlatitude=Double.parseDouble(rst.getString(1));
										//System.out.println(" nextlatitude lat :"+nextlatitude);
									
										if(nextlatitude < currentlatitude){
											breakPoint_lat.add(rst.getString(1));
											breakPoint_lng.add(rst.getString(2));
											//System.out.println("breakpoint is :"+breakPoint_lat +";" +breakPoint_lng);
										} break;
										
									}
									
								
							}

							}
					System.out.println("size="+array_lat.size());		
					System.out.println("full size="+counter);
					String start_address = null;
					String end_address = null;
					ResultSet rst1 = null;
			
			
			rst1 = stmt.executeQuery("select V.customer_name,V.vehicle_number,D.driver_name from vehicle_information V,driver_info D where V.vehicle_number=D.vehicle_number and V.imei_no='"+imeinumber+"'");
			if(rst1.next())
			{
				customer_name=rst1.getString("customer_name");
				vehicle_number=rst1.getString("vehicle_number");
			
				driver_name=rst1.getString("driver_name");
				//System.out.println("c_Driver name :"+driver_name);
			
			}	 
			
			//Pause marker code starts here:
				
			        List<String> ary_lat=new ArrayList<String>();
					List<String> ary_lng=new ArrayList<String>();
					double currentlatitude1=0.00f,currentlongitude1=0.00f,previouslatitude1=0.00f,previouslongitude1=0.00f;;
					
 		  int offcounter = 0, oncounter = 0;
			String latitude = null, next_latitude = null;
			String longitude = null, next_longitude = null;
			String date_time, next_date_time;
			String engine_status, next_engine_status;;
			String ses_hour;
			String time;
			String date_in_db;
			String hr;
			String min;
			DateFormat df = null;
			Date date1 = null, date2 = null;
			int noofid = -1;
			int counter1=1;
			int arraySize;
		  ResultSet rs=null;
		  Statement st= null;
		  String locAddress=null;
		  st=connection.createStatement();
		  rs = st.executeQuery("SELECT latitude_value,longitude_value,engine_status,date_time FROM tracking WHERE imei_no ='"+ imeinumber+ "' and date_time>='"+ startdate+ "' and date_time<='" + enddate +"'");
		  System.out.println("query : "+"SELECT latitude_value,longitude_value,engine_status,date_time FROM tracking WHERE imei_no ='"+ imeinumber+ "' and date_time>='"+ startdate+ "' and date_time<='" + enddate +"'");
		  if(rs.next())
			{
				previouslatitude1=Double.parseDouble(rs.getString(1));
				previouslongitude1=Double.parseDouble(rs.getString(2));
			}
		  while (rs.next()) {
			  counter++;
				noofid++;
				date_time = rs.getString("date_time");
				engine_status = rs.getString("engine_status");
				currentlatitude1=Double.parseDouble(rs.getString(1));
				currentlongitude1=Double.parseDouble(rs.getString(2));
				date_in_db = date_time.substring(0, 10);
				hr = date_time.substring(11, 13);								
				min = date_time.substring(14, 16);				
				int hour = Integer.parseInt(hr);
				if (engine_status.equals("0")) { 				
					while (rs.next()) // Difference between Engine on and Engine off
					{
						next_date_time = rs.getString("date_time");
						next_engine_status = rs.getString("engine_status");
						if (next_engine_status.equals("1")) {
							df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							date1 = df.parse(date_time);							
							date2 = df.parse(next_date_time);							
							int diff = (int) (Math.abs(date1.getTime()- date2.getTime()) / 1000) / 60;		
							//System.out.println("The difference of two timings is ::"+diff);
							if (diff > input_halt_time) //if time differece between on and off is greater than 15 min then shows
							{
								//System.out.println("Current1 lat :"+currentlatitude1);
								//System.out.println("prev lat: "+previouslatitude1); 
								ary_lat.add(rs.getString(1));
								ary_lng.add(rs.getString(2));
									
								 //The Engine is on state and the difference is more than 15 min								
                                 offcounter = 0;
								counter1++;
								System.out.println("lat values : lang values: "+ary_lat+":"+ary_lng);
							System.out.println("after diff loop-------------------------------------Mid Array Size :"+ary_lat.size()+"------------------------------------");
							} else
								offcounter = 1;
							break;
						} else
							continue;
					
					}
					if (offcounter == 0) {
						//System.out.println("inside off counter");
						//counter++;
						offcounter++;
						oncounter=0;

						
						 } // Off counter
	System.out.println("Array size: "+ary_lat.size());
	%>
						<script type="text/javascript">
					<%--  get_address(<%=latitude%>,<%=longitude%>,<%=noofid%>,<%=counter1%>);  --%>
					                  get_address(<%=ary_lat%>,<%=ary_lng%>,<%=noofid%>,<%=counter1%>);
					                 
					</script> 
					
					<script type="text/javascript">
				
				

	function get_address(lat1, lang, noofid,count) {
		geo = new GClientGeocoder();
var lat;
var lng;
var search=[];	
var addres=[];	
var i;
<%	 int k =0;
     for(k=0; k< ary_lat.size()-1; k++) {
	 %>

	 lat=<%=ary_lat.get(k)%>
	 lng=<%=ary_lng.get(k)%>
		//alert("mid point lat: "+lat); 	 	
	    search=new google.maps.LatLng(lat,lng);
	 // alert("midpont value :"+search);
	    geo.getLocations(search,function(result) {	
				 if (result.Status.code == G_GEO_SUCCESS) { 
						 addres=result.Placemark[0].address;								
						
						//createMarker(srch,icon4,'Vehicle comes reverse');
				}
				 // alert("inside Search :"+search);
				 createMidMarker(search,icon2);
				 <%System.out.println("before total array size 0");%>
				/*  if(result.Status.code==620){
				createMidMarker(search,icon2); 		
				//createMarker(srch,icon4,'Vehicle comes reverse');
				
				 }  */
				}); 
	
	
		<%  } 
  				      
  %>
   
} 
	</script>
			
						
	<%System.out.println("before total array size 1");%>
	
<% }// if loop
else{
	System.out.println("before total array size 1-1");
	if(oncounter==0)
	{
		
		System.out.println("inside oncounter");
		counter =ary_lat.size();     //This counter for Engine on loop:
%> 
<%-- <script type="text/javascript">
	
get_address(<%=latitude%>,<%=longitude%>,<%=noofid%>,<%=ary_lat.size()%>); 
 
</script> --%>

<%
oncounter++;
offcounter=0;
	}
	
} 
				System.out.println("before total array size 1-2");
	 }%>
 
		<%System.out.println("before total array size 1-3"); %>				
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
      <%System.out.println("before total array size 2-2");%>
      
      // ====== Geocoding ======
    	 <%System.out.println("before total array size 3");%> 
     var baseIcon = new GIcon(G_DEFAULT_ICON);
      baseIcon.iconSize=new GSize(24,38);

      var icon1 = G_START_ICON;
      icon1.iconSize = new GSize(30,40);
      var icon2 = G_PAUSE_ICON;
      var icon3 = G_END_ICON;
      icon3.iconSize = new GSize(30,40);
      var icon4 = new GIcon(baseIcon,"http://labs.google.com/ridefinder/images/mm_20_white.png");
          icon4.shadow = "http://labs.google.com/ridefinder/images/mm_20_shadow.png";
          icon4.iconSize = new GSize(30, 30);
          icon4.shadowSize = new GSize(22, 20);
          icon4.iconAnchor = new GPoint(6, 20);
          icon4.infoWindowAnchor = new GPoint(4, 1);
          

function createMarker(point,icon,html) {
	//alert("inside createmarker point :"+point);
var marker = new GMarker(point,{draggable:false,icon:icon});
GEvent.addListener(marker, "mouseover", function() {
marker.openInfoWindowHtml(html);
});
map.addOverlay(marker);
}
function createMidMarker(point,icon) {
	//alert("points inside the mid marker :"+point);
	var marker = new GMarker(point,{draggable:false,icon:icon});
	GEvent.addListener(marker, "mouseover", function() {
	});
	map.addOverlay(marker);
	}


      // ===== Array to contain the points of the path =====
      var path = [];
      
      var gmarkers = [];
      var addresses = [];

     

    var gdir=new GDirections();


      var poly;
      
      GEvent.addListener(gdir, "load", function() {
        
        poly = gdir.getPolyline();
        map.addOverlay(poly);
      });
      
     					      
function directions() {
			var pts =[];
				var lat,lng; 
          
         
<%		
				int j =0;
		      for(j=0; j<array_lat.size(); j++) {
		    	 %>
		    			      
		  	lat=<%=array_lat.get(j)%>;
	    	lng=<%=array_lng.get(j)%>;
		    
	    	pts[<%=j%>] = new GLatLng(lat,lng);
	    // PTS has lat lang vaues
	    	<%  } 
		      
		      							      
		      %>				      
		      map.setCenter(new GLatLng(<%=array_lat.get(0)%>,<%=array_lng.get(0)%>),10);							  
	    	 createMarker(pts[0],icon1,'Vehicle Number : <%=vehicle_number%> <br> Owned : <%=customer_name%> <br> Driver name : <%=driver_name%>');
		     createMarker(pts[<%=array_lat.size()%>-1],icon3,'Vehicle Number : <%=vehicle_number%> <br> Owner : <%=customer_name%> <br> Driver name : <%=driver_name%>');
		  <%System.out.println("Total array size is :"+array_lat.size());%>
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
rs.close();
stmt.close();

}
				catch(SQLException se){
					se.printStackTrace();
					System.out.println("Connection Failes! Check output console");
					return;	
				}
				/* catch(IndexOutOfBoundsException ioe)
				{
					System.out.println("Connection Failed! Check output console");
				}
				 catch (Exception e) {
				//System.out.println("Connection Failed! Check output console");
				//e.printStackTrace();
				//return;	
				}  */

%> 

<!-- .x12 -->

<!-- #content -->

</body>
</html>