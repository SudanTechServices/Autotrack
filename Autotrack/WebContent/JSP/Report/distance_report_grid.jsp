<%@page import="java.sql.*"%>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction;" %>
 <link rel="stylesheet" type="text/css" href="../../CSS/style.css" />    
 <script src="//maps.google.com/maps?file=api&amp;v=2&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" 
            type="text/javascript"></script>
 
 
<center>
<div class="content_bg"><span class="content_headning">Distance Report</span></div>

<table border="1" style="background-color:#BDE6FC; font-family:Comic Sans MS,sans-serif; borderColor="black" cellPadding="0" cellSpacing="0" width="100%" height="63">

 
<%
String imeinumber = request.getParameter("vehicle_number");
String startdate = request.getParameter("start_date");
String enddate = request.getParameter("end_date");

String latitude1=null ,latitude2 = null;
String longitude1=null,longitude2 = null;

try{
	DBTransaction dbtranobj=new DBTransaction();
	Connection connection=dbtranobj.connect();

ResultSet rs = null;
Statement st=null;
st=connection.createStatement();

rs = st.executeQuery("SELECT tracking.latitude_value,tracking.longitude_value FROM public.tracking WHERE tracking.imei_no ='"+imeinumber+"' and date_time>='"+startdate+"' and date_time<='"+enddate+"';");



//while(rs.next()){ 
if(rs.next()){
//String date = rs.getString("date_time");
 latitude1 = rs.getString("latitude_value");
longitude1 = rs.getString("longitude_value");
System.out.println(latitude1+","+longitude1);
%>
</tr>
<%
}
while(rs.next()){
	
//System.out.println("loop");
	latitude2 = rs.getString("latitude_value");
	longitude2 = rs.getString("longitude_value");
}
System.out.println(latitude2+","+longitude2);
connection.close();
rs.close();
st.close();
}catch(SQLException e){ System.out.println(e.getMessage()); } %>

<body>
<script type="text/javascript">
 
	 var lat1=<%=latitude1%>;
	 var lon1=<%=longitude1%>;
	 var search1 =''+lat1+','+lon1+'';
     
        var lat2=<%=latitude2%>;
	    var lon2=<%=longitude2%>;
	    var search2 =''+lat2+','+lon2+'';
	 
	    var geocoder, location1, location2;
	   		
		geocoder = new GClientGeocoder();
				
		
			geocoder.getLocations(search1, function (response) {
	
				if (!response || response.Status.code != 200)
				{
					alert("Sorry, we were unable to geocode the first address");
				}
				else
				{
					location1 = {lat: response.Placemark[0].Point.coordinates[1], lon: response.Placemark[0].Point.coordinates[0], address: response.Placemark[0].address};
					geocoder.getLocations(search2, function (response) {
	
						if (!response || response.Status.code != 200)
						{
							alert("Sorry, we were unable to geocode the second address");
						}
						else
						{
							location2 = {lat: response.Placemark[0].Point.coordinates[1], lon: response.Placemark[0].Point.coordinates[0], address: response.Placemark[0].address};
							calculateDistance();
						}
					});
				}
			});
		
		
		function calculateDistance()
		{
			try
			{
				var glatlng1 = new GLatLng(location1.lat,location1.lon);

				var glatlng2 = new GLatLng(location2.lat,location2.lon);

				var miledistance = glatlng1.distanceFrom(glatlng2, 3959).toFixed(1);
				var kmdistance = (miledistance * 1.609344).toFixed(1);
				
				if(location1.address == "Null, Campbell River, BC, Canada"){
					
					location1.address = "No Records Found";				
					}
				if(location2.address == "Null, Campbell River, BC, Canada"){
					
					location2.address = "No Records Found";				
					}
	 
				document.getElementById('results').innerHTML = '<table border="1" style="background-color:#BDE6FC; font-family:Comic Sans MS,sans-serif; borderColor="black" cellPadding="0" cellSpacing="0" width="100%" height="63"><tr><td style="color:#ffffff; background-color:#0088DD; padding: 10px"><center><strong>Start Address: </strong></center></td><td><center>' + location1.address + '</center></td></tr><tr><td style="color:#ffffff; background-color:#0088DD; padding: 10px"><center><strong>End Address:</strong></center></td><td><center>' + location2.address + '</center></td></tr><tr><td style="color:#ffffff; background-color:#0088DD; padding: 10px"><center><strong>Distance Travelled: </strong></center></td><td><center>' + miledistance + ' miles (or ' + kmdistance + ' kilometers)</center></td></tr></table>';
			}
			catch (error)
			{
				alert(error);
			}
		}
	   
	    </script>
	    </body>
</table>
</center>

  <p id="results"></p>
 
<table><tr><td></td></tr></table>