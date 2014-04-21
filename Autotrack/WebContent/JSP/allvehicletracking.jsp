<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*" import="java.sql.*" %>
<%@ page errorPage="errorpage.jsp" %> 
<%@ page import="com.ts.service.dropdown" %> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*" %>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction;" %>
<META HTTP-EQUIV="REFRESH" CONTENT="2000">
<!DOCTYPE html>
 
<html> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 

<head> 
	<title>Live Tracking</title> 
	<link rel="stylesheet" type="text/css" href="../CSS/style.css" />
	<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" type="text/javascript"></script>
 </head>
 <script type="text/javascript">

if (GBrowserIsCompatible()) { 

      // A function to create the marker and set up the event window 
      // Dont try to unroll this function. It has to be here for the function closure 
      // Each instance of the function preserves the contends of a different instance 
      // of the "marker" and "html" variables which will be needed later when the event triggers.    
      function createMarker(point,html,status) {
      
  	  //Start Icon
      
      var myIcon = new GIcon(G_DEFAULT_ICON);
      myIcon.image = "../images/dd-start.png";
      var markerOptions = { icon:myIcon };
      
      //Stop Icon
        var myIcon1 = new GIcon(G_DEFAULT_ICON);
        myIcon1.image = "../images/dd-end.png";
     	var markerOptions1 = { icon:myIcon1 };
      
      if(status == "ON"){
            var marker = new GMarker(point,markerOptions);
      }
      if(status == "OFF"){
          var marker = new GMarker(point,markerOptions1);
    }
      GEvent.addListener(marker, "mouseover", function() {
        marker.openInfoWindowHtml(html);
      });
      return marker;
    }
}</script>
<SCRIPT TYPE="text/javascript" LANGUAGE="javascript">

<!-- PreLoad Wait - Script -->
/*  This script and more from http://www.rainbow.arch.scriptmania.com */ 

function waitPreloadPage() { //DOM
if (document.getElementById){
document.getElementById('prepage').style.visibility='hidden';
}else{
if (document.layers){ //NS4
document.prepage.visibility = 'hidden';
}
else { //IE4
document.all.prepage.style.visibility = 'hidden';
}
}
}
// End -->
</SCRIPT>

</head>
 
<body onLoad="waitPreloadPage();" onunload="GUnload()"> 
<div class="content_bg"><span class="content_headning">All Vehicle Live Tracking</span></div>
<br/>
<div>
		<form>
	
			<div id="map"  style="width: 100%; height: 98%;  border:1px solid black; ">
		
				<%
				//double calculated_fuel_value=0.0;
				//double fuel_in_liters=0.0;
				String belongs=(String)session.getAttribute("belongs");
				String SQL=null;
				dropdown dd=new dropdown();     
				TreeMap hm = dd.getName(belongs);
				Set sets = hm.entrySet(); 
				Iterator iterator = sets.iterator();   
				int fullsize=hm.size();
				System.out.println("fullsize"+fullsize);
				int count=0;
				int i=0;
				String IMEI[]=new String[fullsize];
				String latitude[]=new String[fullsize];
				String longitude[]=new String[fullsize];
				String customer_name[]=new String[fullsize];
				//String fuel[]=new String[fullsize];
				String mile[]=new String[fullsize];
				String vehicle_number[]=new String[fullsize];
				String Driver_name[]=new String[fullsize];
				String engine_status[]=new String[fullsize];
				String GetData;
				//String fuel_in_ltr[]=new String[fullsize];
				//double empty_fuel_voltage[]=new double[fullsize];
				//double full_fuel_voltage[]=new double[fullsize];
				//double fuel_tank_capacity[]=new double[fullsize];
				try {
						DBTransaction dbtranobj=new DBTransaction();
						Connection connection=dbtranobj.connect();
						Statement mystatement = connection.createStatement();
						Statement stmt = connection.createStatement();
						ResultSet set = null;
						ResultSet rs = null;
			
				// System.out.println(belongs);
				if(belongs.equals("owner"))
				{
					GetData = "select vehicle_information.vehicle_number,vehicle_information.customer_name,recent.imei_no,recent.engine_status,recent.latitude_value,recent.longitude_value,recent.mile from recent inner join vehicle_information on vehicle_information.imei_no=recent.imei_no order by date_time";
				}
				else
				{
					GetData = "select vehicle_information.vehicle_number,vehicle_information.customer_name,recent.imei_no,recent.engine_status,recent.latitude_value,recent.longitude_value,recent.mile from recent inner join vehicle_information on vehicle_information.imei_no=recent.imei_no where vehicle_information.customer_id='"+belongs+"'  order by date_time";
				}
				
				set = mystatement.executeQuery(GetData);
				 //System.out.println(belongs);
				while(set.next())
				{
					IMEI[count]=set.getString("imei_no");
				//	System.out.println(IMEI[count]);
					customer_name[count]=set.getString("customer_name");
					vehicle_number[count]=set.getString("vehicle_number");
					//System.out.println(IMEI[count]);
			
					
					//if(set.next()){
					 latitude[count] = set.getString("latitude_value");
					longitude[count] = set.getString("longitude_value");
					//fuel[i]=set.getString("fuel");
					mile[count]=set.getString("mile");
			//		System.out.println(mile[count]);
					engine_status[count] = set.getString("engine_status");
			//		System.out.println(engine_status[count]);
					if(engine_status[count].equals("0"))
					{
						engine_status[count]="OFF";
						//fuel_in_ltr[i] = "----";
					}
					else
					{
						engine_status[count]="ON";
				
					}
					
					count++;
					
					}//while
					//if close
					if(count==0)
					{%>
						
				<div style="width: 600px; height: 500px; padding-top: 35px"><img src="../images/breakdown.jpg"></div>
						
						
				<%	}
					//for loop
					connection.close();
					mystatement.close();
					set.close();
					} catch (SQLException e) {
					//System.out.println("Connection Failed! Check output console");
					e.printStackTrace();
					//return;	
					}
					catch (ClassNotFoundException e) {
					System.out.println("Where is your PostgreSQL JDBC Driver? "
							+ "Include in your library path!");
					e.printStackTrace();
					return;}
					catch(Exception ee)
					{
						ee.printStackTrace();
					}
%> 
<script type="text/javascript">

	//alert("sdf");
	var marker=new Array();
	var point=new Array();				
	var map = new GMap2(document.getElementById("map"));			
	if (GBrowserIsCompatible()) { 
	    map.setCenter(new GLatLng(13.03243,80.23232),7);
	    map.addControl(new GLargeMapControl());
	      map.addControl(new GMapTypeControl());
	      var i=0;
		<%
		for (int j=0;j<count;j++)
		{
		%>
		
		var HTML = "<table style='font-family:arial; font-size:12px;'>"+
			"<tr><td>Vehicle Number </td><td>:</td><td> <%=vehicle_number[j]%> </td></tr>"+
			"<tr><td>Owned By </td><td>:</td><td> <%=customer_name[j]%></td></tr>"+
			
			"<tr><td>Speed </td><td>:</td><td> <%=mile[j]%> km/hr</td></tr>"+
			
			"<tr><td>Engine Status </td><td>:</td><td> <%=engine_status[j]%> </td></tr>"+
			"</table>";
			
		      point[i] = new GLatLng(<%=latitude[j]%>,<%=longitude[j]%>);
		      marker[i] = createMarker(point[i],HTML,'<%=engine_status[j]%>');
		      map.addOverlay(marker[i]);
		      i++;
		<%}%>
									}  
					</script>
			</div>
			
</form>
	</div>

</body> 
 
</html>