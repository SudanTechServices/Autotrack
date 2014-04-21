
<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*" import="java.sql.*" import="java.util.Date" import="java.util.Calendar"%>
    <%@ page errorPage="errorpage.jsp" %>
<%@ page import="com.ts.service.dropdown" %> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*" %>

<%@ page import="com.ts.dbtransactionmgr.DBTransaction;" %>
<META HTTP-EQUIV="REFRESH" CONTENT="">
<!DOCTYPE html>
 
<html> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head> 

<head> 

	<title>Live Tracking</title> 
	
<link rel="stylesheet" type="text/css" href="../CSS/style.css" />	
	<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" type="text/javascript"></script>
 
 
 <script type="text/javascript">
   
      function createMarker(point,html,status) {
        
    	  
    	  //Start Icon
        
        var myIcon = new GIcon(G_DEFAULT_ICON);
        myIcon.image = "../images/car_start_icon.gif";
        myIcon.iconSize = new GSize(27,30);
        myIcon.shadow = "../images/car_shadow_icon.png";
        myIcon.shadowSize = new GSize(36, 45);
        var markerOptions = { icon:myIcon };
        
        //Stop Icon
         var myIcon1 = new GIcon(G_DEFAULT_ICON);
        myIcon1.image = "../images/car_stop_icon.png";
        myIcon1.iconSize = new GSize(27,30);
        myIcon1.shadow = "../images/car_shadow_icon.png";
        myIcon1.shadowSize = new GSize(36, 45);
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

      
      
 </script>
 
 
</head>
 
<body onload="loadmap()"> 

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
					
					function check(message){
						
						alert(message);

				    	  $(document).ready(function(){
				    	  		this.timer = setTimeout(function () {
								    	  $.ajax({
								    	  url: 'latlngcheck.jsp',
								    	  data: '',
								    	  type: 'POST',
								    	  success: function(msg){ alert(msg);} }); }, 600);
				    	  		return true;
				    	 	 });
				    }
					
					function loadmap(){
						
				if (GBrowserIsCompatible()) { 
				
					      var map = new GMap2(document.getElementById("map"));
					      
					      map.setCenter(new GLatLng(<%=latitude%>,<%=longitude%>), 15);
					  
					      var point = new GLatLng(<%=latitude%>,<%=longitude%>);
					      
					      var marker = createMarker(point,'IMEI = <%=IMEI%> <br> Fuel = <%=fuel%> <br> Speed = <%=mile%> <br> Engine Status = <%=engine_status%> <br> Owner = <%=customer_name%> <br> Driver = <%=Driver_name%>','<%=engine_status%>');
					      
					     map.addOverlay(marker);
					      
					     //map.addControl(new GMapTypeControl());
					    // map.addControl(new GLargeMapControl());
					     
					     check('jhgsdfhjhdf');
					     
					     self.setInterval("check('naseer')",100);	
					      
						}  
					}     
					</script>
					<%
					connection.close();
					mystatement.close();
					set.close();
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