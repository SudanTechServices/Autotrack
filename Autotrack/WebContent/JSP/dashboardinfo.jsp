<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page errorPage="errorpage.jsp" %>    
    <%@ page import="com.ts.dbtransactionmgr.DBTransaction;"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Welcome to Autotrack</title>
<script src="//maps.google.com/maps?file=api&amp;v=2&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" 
            type="text/javascript"></script> 
<link rel="stylesheet" type="text/css" href="../CSS/style.css" />

<style type="text/css">
tr:nth-child(even) {background: #eee}
tr:nth-child(odd) {background: #FFF}
</style>
</head>
<body>
<div class="content_bg"><span class="content_headning">Dashboard Info</span></div>
<%
String IMEI,GetData,lat=null,lon=null;
String vehicle_number = null,engine_status = null;
String fuel_in_ltr=null;
double calculated_fuel_value=0.0;
double fuel_in_liters=0.0;
double fuel_value=0.0;
double empty_fuel_voltage = 0.0;
double full_fuel_voltage=0.0;
double fuel_tank_capacity=0.0;
int current_fuel;
IMEI=request.getParameter("value");
//System.out.println("servlet "+request.getServerName());
if(IMEI==null)
{
	IMEI=(String)session.getAttribute("IMEI");
}
else
{
session.setAttribute("IMEI", IMEI);
}
//System.out.println(IMEI);
try{
	DBTransaction dbtranobj=new DBTransaction();
	Connection connection=dbtranobj.connect();
	GetData = "SELECT latitude_value,longitude_value,mile,device_battery,vehicle_battery,fuel,engine_status FROM tracking where imei_no='"+IMEI+"' order by date_time desc limit 1";
	Statement mystatement = connection.createStatement();
	
	ResultSet set = null;
	set= mystatement.executeQuery("SELECT fuel_tank_capacity,vehicle_number from vehicle_information where imei_no='"+IMEI+"'");
	if(set.next())
	{
		//empty_fuel_voltage=(Double.parseDouble(set.getString(1)));
		//full_fuel_voltage=(Double.parseDouble(set.getString(2)));
		fuel_tank_capacity=(Double.parseDouble(set.getString("fuel_tank_capacity")));
		vehicle_number = set.getString("vehicle_number");
	}
	set = mystatement.executeQuery(GetData);
	while(set.next())
	{
		lat=set.getString(1);
		lon=set.getString(2);
		fuel_value=(Double.parseDouble(set.getString("fuel")));
		engine_status=set.getString("engine_status");
		
		if(engine_status.equalsIgnoreCase("1")){engine_status = "ON";}
		else{ engine_status = "OFF"; }
		
		if(fuel_value==0.00)
		{
			fuel_in_ltr="----";
		}
		else
		{
			//calculated_fuel_value = ((fuel_value - empty_fuel_voltage)/(full_fuel_voltage - empty_fuel_voltage))*100;
			//fuel_in_liters = (calculated_fuel_value/100)*fuel_tank_capacity;
		//fuel_in_liters=Math.round(fuel_in_liters*100.0)/100.0;
		System.out.println(fuel_value);
		current_fuel = (int)(fuel_value*fuel_tank_capacity);
		fuel_in_ltr=""+current_fuel+" Ltrs.";
		}
 		%>
 		
		<table border="0" cellPadding="4" cellSpacing="0" class="table_content" style="background-color: #fff; border: 1px solid #dfdbdb;">
		<tr><th align='left' style='background-color:#e78c39; color:#fff;' colspan="3">Vehicle Details</th></tr>
		
		<tr><td style="width: 50%; border-bottom: 1px solid #dfdbdb; border-right: 1px solid #dfdbdb;" ><label>Vehicle No </label></td><td style="width: 50%; border-bottom: 1px solid #dfdbdb; border-right: 1px solid #dfdbdb;"><%=vehicle_number%></td></tr>
		
		<tr><td valign="top" style="width: 50%; border-bottom: 1px solid #dfdbdb; border-right: 1px solid #dfdbdb;"><label>Address </label></td><td style="width: 50%; border-bottom: 1px solid #dfdbdb; border-right: 1px solid #dfdbdb;"><b id="msg"></b></td></tr>
		
		<tr><td style="width: 50%; border-bottom: 1px solid #dfdbdb; border-right: 1px solid #dfdbdb;"><label>Speed </label></td><td style="width: 50%; border-bottom: 1px solid #dfdbdb; border-right: 1px solid #dfdbdb;"><%=set.getString(3)%> km/hr</td></tr>
		
		<tr><td style="width: 50%; border-bottom: 1px solid #dfdbdb; border-right: 1px solid #dfdbdb;"><label>Device Battery </label></td><td style="width: 50%; border-bottom: 1px solid #dfdbdb; border-right: 1px solid #dfdbdb;"><%=set.getString(4)%></td></tr>
		
		<tr><td style="width: 50%; border-bottom: 1px solid #dfdbdb; border-right: 1px solid #dfdbdb;"><label>Vehicle Battery </label></td><td style="width: 50%; border-bottom: 1px solid #dfdbdb; border-right: 1px solid #dfdbdb;"><%=set.getString(5)%></td></tr>
		
		<tr><td style="width: 50%; border-bottom: 1px solid #dfdbdb; border-right: 1px solid #dfdbdb;"><label>Total Tank Capacity </label></td><td style="width: 50%; border-bottom: 1px solid #dfdbdb; border-right: 1px solid #dfdbdb;"><%=fuel_tank_capacity%></td></tr>
		
		<tr><td style="width: 50%; border-bottom: 1px solid #dfdbdb; border-right: 1px solid #dfdbdb;"><label>Current Fuel Status </label></td><td style="width: 50%; border-bottom: 1px solid #dfdbdb; border-right: 1px solid #dfdbdb;"><%=fuel_in_ltr%></td></tr>
		
		<tr><td style="width: 50%; border-right: 1px solid #dfdbdb;"><label>Engine Status </label></td><td style="width: 50%; border-bottom: 1px solid #dfdbdb; border-right: 1px solid #dfdbdb;"><%=engine_status%></td></tr>
		
		
		</table>
		
		<%
	}//while
	 connection.close();
	 mystatement.close();
	 set.close();
}//try
catch(Exception e){}
%>


<script type="text/javascript">
 
	 var lat=<%=lat%>;
	    var lon=<%=lon%>;
	    
        var search =''+lat+','+lon+'';
        var geo = new GClientGeocoder();
        // ====== Perform the Geocoding ======        
        geo.getLocations(search, function (result)
          { 
        	
            if (result.Status.code == G_GEO_SUCCESS) {
            
              for (var i=0; i<result.Placemark.length; i++) {
               /// var p = result.Placemark[i].Point.coordinates;
               // var marker = new GMarker(new GLatLng(p[1],p[0]));
                document.getElementById("msg").innerHTML = result.Placemark[i].address;
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
      
     
    </script>

 </body>
</html>