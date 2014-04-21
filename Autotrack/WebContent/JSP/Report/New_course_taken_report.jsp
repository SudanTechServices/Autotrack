<%@page import="java.sql.*"%>
<%@page import="java.util.Calendar" %>
<%@page import="java.text.DateFormat" %>
<%@page import="java.text.DecimalFormat" %>
<%@page import="java.util.Date"%> 
<%@page import="java.util.concurrent.TimeUnit" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.List" %>
<%@page import="java.util.LinkedList" %>
<%@page import="java.util.Map" %>
<%@page import="java.util.HashMap" %>
<%@page import="java.util.LinkedHashMap" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Iterator" %>
<%@page import="java.util.Set" %>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction;" %>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <link rel="stylesheet" type="text/css" href="../../CSS/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

	 <%!

	 public Map<String,Object> checkLocExists(Map<String,String> mp,String lati,String langi)
	 {
		 boolean r = false;
		 Map<String,Object> res = new HashMap<String,Object>();
		 double dlat = Double.parseDouble(lati);
		 double dlon = Double.parseDouble(langi);
		 DecimalFormat dft = new DecimalFormat("#0.00");
		 String rkey = "";
		 rkey = dft.format(dlat)+"$"+dft.format(dlon);
		 if(mp.containsKey(rkey))
		 {
			 r = true;
			 res.put("eloc", rkey);
		 }
		 rkey = dft.format(dlat+.01)+"$"+dft.format(dlon);
		 if(mp.containsKey(rkey))
		 {
			 r = true;
			 res.put("eloc", rkey);
		 }
		 rkey = dft.format(dlat-.01)+"$"+dft.format(dlon-.01);
		 if(mp.containsKey(rkey))
		 {
			 r = true;
			 res.put("eloc", rkey);
		 }
		 rkey = dft.format(dlat+.01)+"$"+dft.format(dlon+.01);
		 if(mp.containsKey(rkey))
		 {
			 r = true;
			 res.put("eloc", rkey);
		 }
		 rkey = dft.format(dlat+.01)+"$"+dft.format(dlon-.01);
		 if(mp.containsKey(rkey))
		 {
			 r = true;
			 res.put("eloc", rkey);
		 }
		 rkey = dft.format(dlat-.01)+"$"+dft.format(dlon+.01);
		 if(mp.containsKey(rkey))
		 {
			 r = true;
			 res.put("eloc", rkey);
		 }
		 rkey = dft.format(dlat)+"$"+dft.format(dlon+.01);
		 if(mp.containsKey(rkey))
		 {
			 r = true;
			 res.put("eloc", rkey);
		 }
		 rkey = dft.format(dlat-.01)+"$"+dft.format(dlon);
		 if(mp.containsKey(rkey))
		 {
			 r = true;
			 res.put("eloc", rkey);
		 }
		 rkey = dft.format(dlat)+"$"+dft.format(dlon-.01);
		 if(mp.containsKey(rkey))
		 {
			 r = true;
			 res.put("eloc", rkey);
		 }
		 
		 rkey = dft.format(dlat-.01)+"$"+dft.format(dlon+.01);
		 if(mp.containsKey(rkey))
		 {
			 r = true;
			 res.put("eloc", rkey);
		 }
		 rkey = dft.format(dlat+-.01)+"$"+dft.format(dlon-.01);
		 if(mp.containsKey(rkey))
		 {
			 r = true;
			 res.put("eloc", rkey);
		 }
		 res.put("isexist", r);
		 return res;
	 }
	 
	 %>

<%

String s_lati_val = "";
String s_longi_val = "";
String d_lati_val = "";
String d_longi_val = "";
String source_lati_val = "";
String source_longi_val = "";
String des_lati_val = "";
String des_longi_val = "";
String imeinumber = request.getParameter("vehicle_number");
System.out.println("IMEI"+imeinumber);
String startdate_stime,startdate_etime,enddate_stime,enddate_etime;
String startdate,enddate;
startdate_stime=request.getParameter("start_date") + " 00:00";
startdate_etime=request.getParameter("start_date") + " 23:59";
startdate = startdate_stime + startdate_etime;
enddate_stime=request.getParameter("end_date") + " 00:00";
enddate_etime=request.getParameter("end_date") + " 23:59";
enddate = enddate_stime + enddate_etime;
System.out.println("Start DATE Start time  "+startdate_stime);
System.out.println("Start DATE End time  "+startdate_etime);
System.out.println("End Date Start time"+enddate_stime);
System.out.println("End Date End time"+enddate_etime);
String source = request.getParameter("source");
String destination = request.getParameter("destination");
System.out.println("SOURCE "+ source);
System.out.println("DESTI "+ destination);
if(source.equals("Adhanur Dam"))
{
	s_lati_val = "10.387071666666667";
	s_longi_val = "79.78850833333334";
	source_lati_val = s_lati_val.substring(0, 5);
	source_longi_val = s_longi_val.substring(0, 5);
}
if(destination.equals("Thiruporur"))
{
	d_lati_val = "12.72189";
	d_longi_val = "80.20193333333333";
	des_lati_val = d_lati_val.substring(0, 5);
	des_longi_val = d_longi_val.substring(0, 5);
}
 else if(destination.equals("Adhanur Dam"))
{
	d_lati_val = "10.35457";
	d_longi_val = "79.783695";
	des_lati_val = d_lati_val.substring(0, 5);
	des_longi_val = d_longi_val.substring(0, 5);
} 

%>
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<!-- <script src="../../JS/pagination.js" type="text/javascript"></script> -->
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" type="text/javascript"></script> 
<script type="text/javascript">


function getAddress(v,idex)
{
	 var geo = new GClientGeocoder();
	
		// ====== Perform the Geocoding ======        
		geo.getLocations(v, function (result)
		  { 
			
			if (result.Status.code == G_GEO_SUCCESS) {
				 /* alert("GEO CODE SUCCESS PPLACED MARK LENGTH " + result.Placemark.length); */ 
			  for (var i=0; i<result.Placemark.length; i++) {
			   /// var p = result.Placemark[i].Point.coordinates;
			   // var marker = new GMarker(new GLatLng(p[1],p[0]));
			   /* alert("index "+idex); */
			 document.getElementById("message"+idex).innerHTML =result.Placemark[i].address;
			   
			   console.log("parameters : "+v+"  "+result.Placemark[i].address);
			
				/* alert("address  "+result.Placemark[i].address); */
				//cells.push(result.Placemark[i].address);
				//cells.push(this);
				/* $(this).text(result.Placemark[i].address); */
			   /*  document.getElementById("speed").innerHTML = "<b>Speed </b>: "+speed+" km/hr"; */
			   
				
		 //alert("address");
			  }
		
			}
			
			// ====== Decode the error status ======
			else {
			  var reasons="Code "+result.Status.code;
			  if (reasons[result.Status.code]) {
				reasons = reasons[result.Status.code];
			  } 
			  console.log('Could not find "'+v+ '" ' + reasons);
			}
		  }
		);

}

function tabletest()
{
	var cells = new Array();
			
			$('#myTable tbody tr ').each(function(idex){
			
				var v = $(this).find(".latlan").val();
				/* var des_loc =  $(this).find(".latlon").val(); */
				/* alert("INDEX VALUE "+idex);
				alert("LAT LONG VALUE "+v); */
				if(v)
				{
				
					setTimeout(function () {
						getAddress(v,idex);
				    }, 900);			
				
				}
			});
			console.log(cells);
}

function destitest()
{
	var cells = new Array();
			
			$('#myTable tbody tr ').each(function(idex){
			 
				var v = $(this).find(".latlon").val();
				
				
				
					if(v)
					{
						setTimeout(function(){
						 var geo = new GClientGeocoder();
						// ====== Perform the Geocoding ======        
						geo.getLocations(v, function (result)
						{ 
								
							if (result.Status.code == G_GEO_SUCCESS) {
								//alert("GEO CODE SUCCESS"); 
								 for (var i=0; i<result.Placemark.length; i++) {
									  
									document.getElementById("msg"+idex).innerHTML =result.Placemark[i].address;
									cells.push(result.Placemark[i].address);
										
									/* $(this).text(result.Placemark[i].address); */
									  
								 }
								
							} 
									
							// ====== Decode the error status ======
							else {
								var reasons="Code "+result.Status.code;
								if (reasons[result.Status.code]) {
									reasons = reasons[result.Status.code];
								} 
								alert('Could not find destination "'+v+ '" ' + reasons);
							}
						}
						);
						},10000);
					}
			 	
			});
			console.log(cells);
}

function return_sourcetest()
{
	var cells = new Array();
			
			$('#myTable_return tbody tr ').each(function(idex){
			 
				var v = $(this).find(".latlangg").val();
				
				
				
					if(v)
					{
						setTimeout(function(){
						 var geo = new GClientGeocoder();
						// ====== Perform the Geocoding ======        
						geo.getLocations(v, function (result)
						{ 
								
							if (result.Status.code == G_GEO_SUCCESS) {
								//alert("GEO CODE SUCCESS"); 
								 for (var i=0; i<result.Placemark.length; i++) {
									  
									document.getElementById("message_return"+idex).innerHTML =result.Placemark[i].address;
									cells.push(result.Placemark[i].address);
										
									 $(this).text(result.Placemark[i].address); 
									  
								 }
								
							} 
									
							// ====== Decode the error status ======
							else {
								var reasons="Code "+result.Status.code;
								if (reasons[result.Status.code]) {
									reasons = reasons[result.Status.code];
								} 
								console.log('Could not find destination "'+v+ '" ' + reasons);
							}
						}
						);
						},60000);
					}
			 	
			});
			console.log(cells);
} 


 function return_destitest()
{
	var cells = new Array();
			
			$('#myTable_return tbody tr ').each(function(idex){
			 
				var v = $(this).find(".latlongg").val();
				
				
				
					if(v)
					{
						setTimeout(function(){
						 var geo = new GClientGeocoder();
						// ====== Perform the Geocoding ======        
						geo.getLocations(v, function (result)
						{ 
								
							if (result.Status.code == G_GEO_SUCCESS) {
								//alert("GEO CODE SUCCESS"); 
								 for (var i=0; i<result.Placemark.length; i++) {
									  
									document.getElementById("msg_return"+idex).innerHTML =result.Placemark[i].address;
									cells.push(result.Placemark[i].address);
										
									 $(this).text(result.Placemark[i].address); 
									  
								 }
								
							} 
									
							// ====== Decode the error status ======
							else {
								var reasons="Code "+result.Status.code;
								if (reasons[result.Status.code]) {
									reasons = reasons[result.Status.code];
								} 
								console.log('Could not find destination "'+v+ '" ' + reasons);
							}
						}
						);
						},70000);
					}
			 	
			});
			console.log(cells);
}

/** Converts numeric degrees to radians */

if (typeof(Number.prototype.toRad) === "undefined") {
		Number.prototype.toRad = function() {
	return this * Math.PI / 180;
		}
}

function toRad(Value) {
    /** Converts numeric degrees to radians */
    return Value * Math.PI / 180;
}


var total_distance = 0;
	function displayDistance()
	{
		 var cells = new Array();
		
		$('#myTable tbody tr ').each(function(idex){
		/* alert(idex); */
		 var v = $(this).find(".latlong").val();
	/* 	alert(v); */
		if( v)
		{ 
			/* alert("IF "+idex); */
			var lat_lon = v.split(",");
			 var source_lat = lat_lon[0];
			/* int source_long = lat_lon[1]; */
			var dest_lat = lat_lon[2];
			/* int dest_long = lat_lon[3]; */
			var lat_diff = lat_lon[2] - lat_lon[0];
			var long_diff = lat_lon[3] - lat_lon[1];
			/* var source_rad = lat_lon[0];
			var surce_rad = source_rad.toRad(); */
			var lat_dif = 10.531411666666667-10.387071666666667;
			 /* alert("BY VAR "+source_lat);
			alert("BY VAR RAD  "+dest_lat);
			alert("BY VAL "+lat_dif); */
		var R = 6371; // km
		var dLat = lat_diff.toRad();
		var dLon = long_diff.toRad(); 
		var dslat = toRad(source_lat);
		var ddLat = toRad(dest_lat);
		var a = Math.sin(dLat/2) * Math.sin(dLat/2) + 
		        Math.cos(dslat) * Math.cos(ddLat) *
		        Math.sin(dLon/2) * Math.sin(dLon/2); 
		var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
		var d = R * c;
		total_distance = total_distance + d;
		/* alert("Distance " + d);
		alert("Total Distance " + total_distance); */
		/* alert("Distance " +d.toString().substring(0,5)); */
		document.getElementById("demo"+idex).innerHTML=d.toString().substring(0,5);
		 cells.push(d);
		//cells.push(this);
		/* $(this).text(d); */
			}	
		});
		console.log(cells); 
		document.getElementById("total_dis").innerHTML=total_distance.toString().substring(0,5);
	  }
	
	var total_dist = 0;
	function return_displayDistance()
	{
		 var cells = new Array();
		
		$('#myTable_return tbody tr ').each(function(idex){
		/* alert(idex); */
		 var v = $(this).find(".latlonggg").val();
	 	/* alert(v); */ 
		if( v)
		{ 
			/* alert("IF "+idex); */
			var lat_lon = v.split(",");
			 var source_lat = lat_lon[0];
			/* int source_long = lat_lon[1]; */
			var dest_lat = lat_lon[2];
			/* int dest_long = lat_lon[3]; */
			var lat_diff = lat_lon[2] - lat_lon[0];
			var long_diff = lat_lon[3] - lat_lon[1];
			/* var source_rad = lat_lon[0];
			var surce_rad = source_rad.toRad(); */
			var lat_dif = 10.531411666666667-10.387071666666667;
			 /* alert("BY VAR "+source_lat);
			alert("BY VAR RAD  "+dest_lat);
			alert("BY VAL "+lat_dif); */
		var R = 6371; // km
		var dLat = lat_diff.toRad();
		var dLon = long_diff.toRad(); 
		var dslat = toRad(source_lat);
		var ddLat = toRad(dest_lat);
		var a = Math.sin(dLat/2) * Math.sin(dLat/2) + 
		        Math.cos(dslat) * Math.cos(ddLat) *
		        Math.sin(dLon/2) * Math.sin(dLon/2); 
		var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
		var d = R * c;
		
		total_dist = total_dist + d;
		/* alert("Distance " + d);
		alert("Total Distance " + total_dist); */
		document.getElementById("demo_return"+idex).innerHTML=d.toString().substring(0,5);
		 cells.push(d);
		//cells.push(this);
		/* $(this).text(d); */
			}	
		});
		console.log(cells);
		/* alert("Total " + total_dist); */
		document.getElementById("total_d").innerHTML=total_dist.toString().substring(0,5);
	  }
	
	
	
	</script>


</head>
<body  onload="tabletest(); destitest(); displayDistance(); return_sourcetest(); return_destitest(); return_displayDistance()">
<div class="content_bg"><span class="content_headning">Consolidated Report</span></div>
<form name="pdf"  method="post" accept-charset="utf-8">
<div>
<input class="submit" type="submit" name="action" value="Export To Pdf" tabindex="3" onclick="redirect_to_pdf('<%=startdate%>','<%=enddate%>','<%=imeinumber%>');"></input>
<input class="submit" type="submit" name="action" value="Export To Excel" tabindex="3" onclick="redirect_to_excel('<%=startdate%>','<%=enddate%>','<%=imeinumber%>');"></input>
</div> 
<%

String source_min_time = "";
String destin_max_time = "";
String desti_max_time = "";
String lattitude = "";
String longitude = "";
String enginestatus = "";
String dateStr = "";
Date datetime = new Date();
/* Date datetime = new Date();
DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
DateFormat hdf = new SimpleDateFormat("HH:mm:ss"); */
Date mintime = null;
Date maxtime;
String srcLat = "";
String srcLong = "";
String destLat = "";
String destLong = "";
String hlt_time = "";
String minimum_time = "";
String maximum_time = "";
String hlt_time_result = "";
String lat = "";
String lon = "";
int cnt = 1;
int one_way_end_count = 1;
int one_way_count = 1;
int end_count = 1;
int count = 1;
boolean isNewMin = true;
boolean isStarted = false;
Map haltTimeMap = new LinkedHashMap();
List<Map<String,Object>> courseList = new LinkedList<Map<String,Object>>();
List<Map<String,Object>> return_courseList = new LinkedList<Map<String,Object>>();

try{
	DBTransaction dbtranobj=new DBTransaction();
	Connection connection=dbtranobj.connect();
//Connection conn = null;
//Class.forName("org.postgresql.Driver").newInstance();
//conn = DriverManager.getConnection("jdbc:postgresql://192.168.1.95:5432/master_database","postgres", "postgres");
ResultSet rs = null;
Statement st=null;
st=connection.createStatement();
//rs = st.executeQuery("select * from tracking where imei_no='"+imeinumber+"' and  date_time >='"+startdate+"' and date_time <='"+enddate+"' ");
rs = st.executeQuery("select date_time from tracking where imei_no='"+imeinumber+"' and (latitude_value LIKE '"+source_lati_val+"%' and longitude_value LIKE '"+source_longi_val+"%') and date_time >='"+startdate_stime+"' and date_time <='"+startdate_etime+"' and engine_status='0' ORDER BY date_time DESC LIMIT 1");
while(rs.next())
{
	source_min_time = rs.getString("date_time");
}


if(destination.equals("Adhanur Dam"))
{
	
	rs = st.executeQuery("select date_time from tracking where imei_no='"+imeinumber+"' and (latitude_value LIKE '12.72%' and longitude_value LIKE '80.20%') and date_time >='"+source_min_time+"' and engine_status='0' LIMIT 1");
	while(rs.next())
	{
		destin_max_time = rs.getString("date_time");
	}
	
	rs = st.executeQuery("select date_time from tracking where imei_no='"+imeinumber+"' and (latitude_value LIKE '"+des_lati_val+"%' and longitude_value LIKE '"+des_longi_val+"%') and date_time >='"+destin_max_time+"' and engine_status='0' LIMIT 1");
	while(rs.next())
	{
		desti_max_time = rs.getString("date_time");
	}
}
else
{
	rs = st.executeQuery("select date_time from tracking where imei_no='"+imeinumber+"' and (latitude_value LIKE '"+des_lati_val+"%' and longitude_value LIKE '"+des_longi_val+"%') and date_time >='"+source_min_time+"' and engine_status='0' LIMIT 1");
	while(rs.next())
	{
		desti_max_time = rs.getString("date_time");
	}
}
rs = st.executeQuery("SELECT latitude_value,longitude_value,tracking.engine_status,tracking.date_time FROM tracking WHERE tracking.imei_no ='"+imeinumber+"' and date_time>='"+source_min_time+"' and date_time<='"+desti_max_time+"'");
DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//int count = 1;
int datacnt = 1;
while(rs.next()){ 
    lattitude = rs.getString("latitude_value");
    longitude = rs.getString("longitude_value");
    enginestatus = rs.getString("engine_status");
    dateStr = rs.getString("date_time");
    try {
        datetime = df.parse(dateStr);
    } catch (Exception e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }
   
    if(enginestatus.equals("1"))
    {
//        System.out.println("ES : "+isNewMin);
        if(isNewMin)
        {
           
            mintime = datetime;
            //System.out.println("Min Time  : "+mintime);
            srcLat = lattitude;
            srcLong = longitude;
            isStarted = true;
            isNewMin = false;
        }
       
    }
//    System.out.println(" check cd : "+isStarted+"  &  "+enginestatus.equals("0")+"  =  "+(isStarted && enginestatus.equals("0")));
    if(isStarted && enginestatus.equals("0"))
    {
    	long timeDiff = Math.abs(datetime.getTime() - mintime.getTime());
    	System.out.println("TIME DIFFERENCE " + timeDiff);
    	/* lat = lattitude.substring(0,5);
		lon = longitude.substring(0,5);
		Map<String,Object> cr = checkLocExists(haltTimeMap, lat, lon);
		boolean rt = (Boolean)cr.get("isexist");
		if(rt)
		{ */
    	if(timeDiff > 900000 )
    	{
    		
	        if(courseList.size() > 0)
	            {
	               
	                Map<String,Object> prevRecord = courseList.get(courseList.size() - 1);
	                Date prevTime = (Date) prevRecord.get("max_time");
	                long htimDiff =  Math.abs(mintime.getTime() - prevTime.getTime());
	                /* long timeDifference = Math.abs(mintime.getTime() - prevTime.getTime()); */
					hlt_time =  String.format("%d hour(s) %d min(s)", TimeUnit.MILLISECONDS.toHours(Math.abs(mintime.getTime() - prevTime.getTime())),
								TimeUnit.MILLISECONDS.toMinutes(Math.abs(mintime.getTime() - prevTime.getTime())) - TimeUnit.HOURS.toMinutes(TimeUnit.MILLISECONDS.toHours(Math.abs(mintime.getTime() - prevTime.getTime())))); 
	                //System.out.println("Halt Time : "+mintime+" - "+prevTime+" = "+parseTime(htimDiff));
	                if(htimDiff > 900000)
	                {
	                    maxtime = datetime;
	                    destLat = lattitude;
	                    destLong = longitude;
	                    isStarted = false;
	                    Map<String,Object> record = new HashMap<String, Object>();
	                    record.put("min_lat",srcLat);
	                    record.put("min_long", srcLong);
	                    record.put("min_time", mintime);
	                    record.put("max_time", maxtime);
	                    record.put("max_lat", destLat);
	                    record.put("max_long", destLong);
	                    record.put("halttime", hlt_time);
	                    courseList.add(record);
	                    isNewMin = true;
	                   
	                }
	                else
	                {
	                    prevRecord.put("max_time", datetime);
	                   	prevRecord.put("max_lat",lattitude);
	                   	prevRecord.put("max_long",longitude);
	                   
	                    isNewMin = true;
	                    isStarted = true;
	                }
	                              
	                 
	            }
	            else
	            {
	                maxtime = datetime;
	                destLat = lattitude;
	                destLong = longitude;
	                isStarted = false;
	                Map<String,Object> record = new HashMap<String, Object>();
	                record.put("min_lat",srcLat);
	                record.put("min_long", srcLong);
	                record.put("min_time", mintime);
	                record.put("max_time", maxtime);
	                record.put("max_lat", destLat);
	                record.put("max_long", destLong);
	                courseList.add(record);
	                isNewMin = true;
	               
	            }
        
    	
        if(lattitude.substring(0, 5).equals("12.72") && longitude.substring(0, 5).equals("80.20"))
		 {
			 
			 
			 return_courseList.addAll(courseList);
			 System.out.println("ONE WAY MAP " + return_courseList);
			 courseList.clear();
			 System.out.println("HALT TIME MAP " + courseList);
			 
			 
			 
		 }
    	}
		
    } 
       
               
}

%>
<br/>
<div><img src="../../images/oneway_icon.png" /></div>
<br/>
<table id="myTable" cellspacing="0" cellpadding="2" class="table_content" style="width: 100%; background-color: #f1fafc; border: 1px solid #2898b4; border-bottom: 0px;">
		
	        <tr>
				<th class="report_heading">Start Point</th>
				<th class="report_heading">Stopped at</th>
				<th class="report_heading">End Point</th>
				<th class="report_heading">Stopped till</th>
				<th class="report_heading">Distance</th>
				<th class="report_heading">Halt Time</th>		
					
			</tr> 

<%
System.out.println("Result : "+courseList.size());
for(Map<String,Object> r : return_courseList)
{
	minimum_time = df.format(r.get("min_time"));
	maximum_time = df.format(r.get("max_time"));
	hlt_time_result = (String)r.get("halttime"); 
	
	
	
	%>
		<tbody>
				<tr>		 
				
	<%
	
	
	 if((hlt_time_result == null) && (cnt == 1))
	{ 
	%>
		
				
				 <td  align="left" class="report_border" id="message<%=one_way_end_count %>" style="width: 24%; height: 50px;"><input type="hidden" class="latlan" id="place" name="place" value="<%=r.get("min_lat") %> , <%= r.get("min_long") %>"/></td> 
				<td align="left" class="report_border" style="width: 15%; height: 50px;"> <%= minimum_time %></td>
				<td  align="left" class="report_border" id="msg<%=one_way_count %>" style="width: 24%;"><input type="hidden" class="latlon" id="place" name="place" value="<%=r.get("max_lat") %> , <%= r.get("max_long") %>"/></td>
				<td align="left" class="report_border" style="width: 15%;"><%= maximum_time %></td>
				<td align="left" class="report_border" style="width: 7%;" id="demo<%= one_way_count %>"><input type="hidden" class="latlong" value="<%= r.get("min_lat") %> , <%= r.get("min_long") %> , <%=r.get("max_lat") %> , <%= r.get("max_long") %>" /></td>
	 			<td align="left" class="report_border" style="padding-left: 10px; width:15%;">Strats from Source</td> 
	<%
		cnt++;
	System.out.println("Count " + cnt);
	 }
	else if(hlt_time_result != null)
	{	 
	%>
	
	 <td  align="left" class="report_border" id="message<%=one_way_end_count %>" style="width: 24%; height: 50px;"><input type="hidden" class="latlan" id="place" name="place" value="<%=r.get("min_lat") %> , <%= r.get("min_long") %>"/></td> 
	 <td align="left" class="report_border" style="width: 15%; height: 50px;"> <%= minimum_time %></td>
	 <td  align="left" class="report_border" id="msg<%=one_way_count %>" style="width: 24%;"><input type="hidden" class="latlon" id="place" name="place" value="<%=r.get("max_lat") %> , <%= r.get("max_long") %>"/></td>
	 <td align="left" class="report_border" style="width: 15%;"><%= maximum_time %></td>
	 <td align="left" class="report_border" style="width: 7%;" id="demo<%= one_way_count %>"><input type="hidden" class="latlong" id="distance" value="<%= r.get("min_lat") %> , <%= r.get("min_long") %> , <%=r.get("max_lat") %> , <%= r.get("max_long") %>" /></td>
	 <td align="left" class="report_border" style="padding-left: 10px; width:15%;"><%= hlt_time_result %></td>
	</tr>
	

	
	<%
	
		System.out.println("Halt Time " + hlt_time_result);
	 }
	
	one_way_count++;
	one_way_end_count++; 
	
	
//    System.out.println(r.get("min_lat")+" | "+r.get("min_long")+" | "+r.get("min_time")+" | "+r.get("max_lat")+" | "+r.get("max_long")+" | "+r.get("max_time")+" | "+r.get("halttime"));
    System.out.println(r.get("min_time")+" | "+r.get("max_time")+" | "+r.get("halttime"));
}





%>
<tr>
	<td style="border-top: 1px solid #2898b4; background-color: #fff;"></td>
	<td style="border-top: 1px solid #2898b4; background-color: #fff;"></td>
	<td style="border-top: 1px solid #2898b4; background-color: #fff;"></td>
	<td align="left" class="report_border"  style="padding-left: 10px; width:7%; border-top: 1px solid #2898b4;border-bottom: 1px solid #2898b4;">Total Distance</td>
	<td align="left" class="report_border"  id="total_dis" style="padding-left: 10px; width:7%; border-top: 1px solid #2898b4;border-bottom: 1px solid #2898b4;"></td>
	<td style="border-top: 1px solid #2898b4; border-left: 1px solid #2898b4; background-color: #fff;"></td>
</tr>
</tbody> 
</table>
<br/>
<div><img src="../../images/return_icon.png" /></div>
<br/>
<table id="myTable_return" cellspacing="0" cellpadding="2" class="table_content" style="width: 100%; background-color: #f1fafc; border: 1px solid #2898b4; border-bottom: 0px;">
		
	        <tr>
				<th class="report_heading">Start Point</th>
				<th class="report_heading">Stopped at</th>
				<th class="report_heading">End Point</th>
				<th class="report_heading">Stopped till</th>
				<th class="report_heading">Distance</th>
				<th class="report_heading">Halt Time</th>		
					
			</tr> 

<%

System.out.println("Return Result : "+courseList.size());
for(Map<String,Object> rc : courseList)
{
	minimum_time = df.format(rc.get("min_time"));
	maximum_time = df.format(rc.get("max_time"));
	hlt_time_result = (String)rc.get("halttime"); 
	
	%>
				<tbody>
				<tr>
			 
				
	<%
	
	
	 if(hlt_time_result == null )
	{ 
	%>
		<%-- <td align="left" class="report_border" > <%=lat_value %> , <%= long_value %></td> --%>
				<!--  <td  align="left" 		="report_border" style="width: 25%;">Source</td> -->
	 <td  align="left" class="report_border" id="message_return<%=end_count %>" style="width: 24%; height: 50px;"><input type="hidden" class="latlangg" id="place" name="place" value="<%=rc.get("min_lat") %> , <%= rc.get("min_long") %>"/></td> 
	 <td align="left" class="report_border" style="width: 15%; height: 50px;"> <%= minimum_time %></td>
	 <td  align="left" class="report_border" id="msg_return<%=count %>" style="width: 24%;"><input type="hidden" class="latlongg" id="place" name="place" value="<%=rc.get("max_lat") %> , <%= rc.get("max_long") %>"/></td>
	 <td align="left" class="report_border" style="width: 15%;"><%= maximum_time %></td>
	 <td align="left" class="report_border" style="width: 7%;" id="demo_return<%= count %>"><input type="hidden" class="latlonggg" value="<%= rc.get("min_lat") %> , <%= rc.get("min_long") %> , <%=rc.get("max_lat") %> , <%= rc.get("max_long") %>" /></td>
	 <td align="left" class="report_border" style="padding-left: 10px; width:15%;">Strats from Source</td> 
	<%
	 }
	else
	{	 
	%>
	 <td  align="left" class="report_border" id="message_return<%=end_count %>" style="width: 24%; height: 50px;"><input type="hidden" class="latlangg" id="place" name="place" value="<%=rc.get("min_lat") %> , <%= rc.get("min_long") %>"/></td> 
	 <td align="left" class="report_border" style="width: 15%; height: 50px;"> <%= minimum_time %></td>
	 <td  align="left" class="report_border" id="msg_return<%=count %>" style="width: 24%;"><input type="hidden" class="latlongg" id="place" name="place" value="<%=rc.get("max_lat") %> , <%= rc.get("max_long") %>"/></td>
	 <td align="left" class="report_border" style="width: 15%;"><%= maximum_time %></td>
	 <td align="left" class="report_border" style="width: 7%;" id="demo_return<%= count %>"><input type="hidden" class="latlonggg" value="<%= rc.get("min_lat") %> , <%= rc.get("min_long") %> , <%=rc.get("max_lat") %> , <%= rc.get("max_long") %>" /></td>
	 <td align="left" class="report_border" style="padding-left: 10px; width:15%;"><%= hlt_time_result %></td>
	</tr>
	
	
	
	<%
	 }
	
	end_count++;
	count++; 
	
	
//    System.out.println(r.get("min_lat")+" | "+r.get("min_long")+" | "+r.get("min_time")+" | "+r.get("max_lat")+" | "+r.get("max_long")+" | "+r.get("max_time")+" | "+r.get("halttime"));
    System.out.println(rc.get("min_time")+" | "+rc.get("max_time")+" | "+rc.get("halttime"));
}
%>


<tr>
	<td style="border-top: 1px solid #2898b4; background-color: #fff;"></td>
	<td style="border-top: 1px solid #2898b4; background-color: #fff;"></td>
	<td style="border-top: 1px solid #2898b4; background-color: #fff;"></td>
	<td align="left" class="report_border"  style="padding-left: 10px; width:7%; border-top: 1px solid #2898b4;border-bottom: 1px solid #2898b4;">Total Distance</td>
	<td align="left" class="report_border"  id="total_d" style="padding-left: 10px; width:7%; border-top: 1px solid #2898b4;border-bottom: 1px solid #2898b4;"></td>
	<td style="border-top: 1px solid #2898b4; border-left: 1px solid #2898b4; background-color: #fff;"></td>
</tr>


<%
System.out.println("Source Min Time "+ source_min_time);
System.out.println("Time at Thiruporur " + destin_max_time);
System.out.println("Time at Adanur Dam " + desti_max_time);
connection.close();
rs.close();
st.close();
}catch(SQLException e){ System.out.println(e.getMessage()); } %>
<tr>
	
	<td colspan="6" height="20px;" style="background-color: #fff;"></td>
	
</tr>
</tbody> 
</table>
</form>
</body>
</html>