<%@page import="java.sql.*"%>
<%@page import="java.util.Calendar" %>
<%@page import="java.text.DateFormat" %> 
<%@page import="java.text.DecimalFormat" %>
<%@page import="java.util.Date"%> 
 <%@ page errorPage="errorpage.jsp"%> 
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

<html>
<head>
 <link rel="stylesheet" type="text/css" href="../../CSS/style.css" />
 
 	 <style type="text/css">
		tr:nth-child(even) {background: #f9f7f5}
		tr:nth-child(odd) {background: #FFF}
	</style>
	
 <%!
 
 public Map<String,Object> checkLocExists(Map<String,String> mp,String lati,String langi)
 {
	   boolean r = false;
     Map<String,Object> res = new HashMap<String,Object>();
     double dlat = Double.parseDouble(lati);
     double dlon = Double.parseDouble(langi);
    //System.out.println("Dlat-------------:"+dlat+" dlong-------------:"+dlon);
     DecimalFormat dft = new DecimalFormat("#0.00");
     String rkey = "";
     rkey = dft.format(dlat)+"$"+dft.format(dlon);
      if(mp.containsKey(rkey))
     {
         r = true;
         res.put("eloc", rkey);
         System.out.println("res.put ans------------------------- :"+res.get("eloc"));
     } 
     
    res.put("isexist", r);
     return res;
 } 
 
 %>
<%
	String imeinumber = request.getParameter("vehicle_number");
    //System.out.println("IMEI"+imeinumber);
    String startdate,enddate;
    startdate=request.getParameter("start_date");
    enddate=request.getParameter("end_date");
	System.out.println("Start DATE "+startdate); 
	System.out.println("End Date "+enddate);  
	int input_halt_time=Integer.parseInt(request.getParameter("halt_timing"));
		
	
%>
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" type="text/javascript"></script> 
 

<script language="javascript">
var total =0;
var destination ;
var start_address;
var des_address;
var orgn_lat;
var orgn_lng;
var des_lat ;
var des_lng ;
var a;
var b;
var stpt ;
var despt;
function goLite(FRM,BTN)
{
   window.document.forms[FRM].elements[BTN].style.color = "#FFFF99";
   window.document.forms[FRM].elements[BTN].style.backgroundColor = "#11AAEE";
}

function goDim(FRM,BTN)
{
   window.document.forms[FRM].elements[BTN].style.color = "#EEFFFF";
   window.document.forms[FRM].elements[BTN].style.backgroundColor = "#0088DD";
}

function tabletest()
{
	var color="FF0000";
	var cells = new Array();
	var totaldistance =[];

      var de;
			$('#myTable tbody tr ').each(function(idex){
				destination = $(this).find(".latlan").val();
				 
				var starting = $(this).find(".latlng").val();
				if(destination)
				{	
					if(idex >=6 && idex<=75){
						alert("Printing "+idex+"th row Click OK After one Second");
					}
					
					if(destination !="undefiend"){
						a=destination.split(",");
						for(var i=0; i < a.length;i++){
							des_lat=a[0];
							//alert("des"+des_lat);
							des_lng=a[1];
						}
						
					}
					
					if(starting !="undefiend"){
						b=starting.split(",");
						for(var k=0; k < b.length ; k++){
							orgn_lat=b[0];
							orgn_lng=b[1];
						}
					}			
				 var geo = new GClientGeocoder();
				// ====== Perform the Geocoding ======        
				geo.getLocations(destination, function (result)
				  { 					
					if (result.Status.code == G_GEO_SUCCESS) {
						 
					 	 for (var i=0; i<result.Placemark.length; i++) {
						 	 des_address=result.Placemark[i].address;		
						 	// alert("destinantion address :"+des_address);
							 document.getElementById("msg1"+idex).innerHTML =des_address;									
						
					  		 }
				
					}
					// ====== Decode the error status ======
					else {
					 		 var reasons="Code "+result.Status.code;
							 if (reasons = "Code 620"){
							 document.getElementById("msg1" + idex).innerHTML = "<font color=#"+color+">"+"Unable to find the location"+"</font>";
						}
					if (reasons[result.Status.code]) {
							reasons = reasons[result.Status.code];
					  } 
					  		document.getElementById("msg1" + idex).innerHTML = "<font color=#"+color+">"+"Unable to find the location"+"</font>";
					}
				  }
				
				
				);
				
                
				}	
				
					
				if(starting){
					if(idex >=6 && idex<=75){
						alert("Printing "+idex+"th row Click OK After one Second");
					}
				 var geo = new GClientGeocoder();			
				geo.getLocations(starting, function (result)
						  { 												
							if (result.Status.code == G_GEO_SUCCESS) {							 
							 	 for (var i=0; i<result.Placemark.length; i++) {
								  	 start_address=result.Placemark[i].address;
								  	//alert("Source address :"+start_address);
									 document.getElementById("msg"+idex).innerHTML =start_address;														
								   	
							        }
						
							}
							// ====== Decode the error status ======
							else {
							 	 var reasons="Code "+result.Status.code;
							 	 if (reasons = "Code 620"){
								 		document.getElementById("msg" + idex).innerHTML = "<font color=#"+color+">"+"Unable to find the location"+"</font>";
									}
							 	 if (reasons[result.Status.code]) {
										reasons = reasons[result.Status.code];
							  		} 
							  		document.getElementById("msg" + idex).innerHTML = "<font color=#"+color+">"+"Unable to find the location"+"</font>";
								}
						  });
				
			}
				if(idex !=0){
						stpt = new GLatLng(orgn_lat,orgn_lng);
						despt = new GLatLng(des_lat,des_lng);
						var miledistance = stpt.distanceFrom(despt, 3959).toFixed(1);		          
		             	var kmdistance = (miledistance * 1.85).toFixed(1);		                      
		             	document.getElementById("dis" +idex ).innerHTML = kmdistance;
		             	totaldistance.push(kmdistance);
						}
            });
			
			 //------------------------ Calcualting total distance Travelled---------------------//

          //  var total =0;
            for(var i =0;i<totaldistance.length;i++){            
            	total=total +Number(totaldistance[i]);                	
            }  
            total=total.toFixed(1);
            document.getElementById("totalDis").innerHTML=total;            
            console.log(cells); 
            
            
           
}

  </script>
 </head>
  <script type="text/javascript">
 
	function redirect_to_pdf(startdate,enddate,imeinumber)
	{
		//alert("total  :"+total);
	    var xmlStr = "<root>";
	    $('#mytable tbody tr').each(function() {	      
	        if (!this.rowIndex) return; // skip first row	       
	        xmlStr += "<record>"+
	                  "<place>"+this.cells[0].innerHTML+"</place>"+
	                  "<startTime>"+this.cells[1].innerHTML+"</startTime>"+
	                  "<haltPosition>"+this.cells[2].innerHTML+"</haltPosition>"+
	                  "<stopedAt>"+this.cells[3].innerHTML+"</stopedAt>"+	                  
	                  "<HaltedTime>"+this.cells[4].innerHTML+"</HaltedTime>"+
	                  "<distance>"+this.cells[5].innerHTML+"</distance>"+
	                  "</record>";
	    });
	    //alert("2");
		xmlStr +="</root>"
		 //	alert("3");
		 document.redirect.action="tripReport_xml.jsp?xmlstr="+xmlStr+"&startdate="+startdate+"&enddate="+enddate+"&imeinumber="+imeinumber+"&totalDistance="+total;
		 document.redirect.submit();
		// alert("4");
	}
	
	function redirect_to_excel(startdate,enddate,imeinumber)
	{
		
		//alert("total  :"+total);
		 var xmlStr = "<root>";
		    $('#mytable tbody tr').each(function() {
		       
		        if (!this.rowIndex) return; // skip first row
		        xmlStr += "<record>"+
		                  "<place>"+this.cells[0].innerHTML+"</place>"+
		                  "<startTime>"+this.cells[1].innerHTML+"</startTime>"+
		                  "<haltPodition>"+this.cells[2].innerHTML+"</haltPodition>"+
		                  "<StopedAt>"+this.cells[3].innerHTML+"</StopedAt>"+
		                  "<halttime>"+this.cells[4].innerHTML+"</halttime>"+
		                  "<distance>"+this.cells[5].innerHTML+"</distance>"+
		                  "</record>";
		    });
			xmlStr +="</root>"
		   
			
			document.redirect.action="Trip_Report_xml_Excel.jsp?xmlstr="+xmlStr+"&startdate="+startdate+"&enddate="+enddate+"&imeinumber="+imeinumber+"&totalDistance="+total;
			document.redirect.submit();
	} 
	
	</script> 
	

<!-- Export Buttons Here -->


 <%-- <form name="pdf" method="post" accept-charset="utf-8">
 
 <input class="groovybutton" type="button" value="Export To Pdf" tabindex="3" onclick="redirect_to_pdf('<%=startdate%>','<%=enddate%>','<%=imeinumber%>');"></input>
  <input class="groovybutton" type="button" value="Export To Excel" tabindex="3" onclick="redirect_to_excel('<%=startdate%>','<%=enddate%>','<%=imeinumber%>');"></input> 
</form> --%>
 
<body onload="tabletest()">
<!-- <label id="msg"></label> -->
<div class="content_bg"><span class="content_headning">Trip Report</span></div><br/>

<div style="float: right;">	
	<form name="pdf" method="post" accept-charset="utf-8">	
		<input class="submit" type="submit" name="action" id="export_pdf" value="Export To Pdf" tabindex="3" onclick="redirect_to_pdf('<%=startdate%>','<%=enddate%>','<%=imeinumber%>');"></input>
 		<input class="submit" type="submit" name="action" id="export_excel" value="Export To Excel" tabindex="3" onclick="redirect_to_excel('<%=startdate%>','<%=enddate%>','<%=imeinumber%>');"></input>  
 	</form>
	</div>
	  <br/><br/>
	  
<form name="tripReport"  method="post" accept-charset="utf-8">


 <div id="table">
 

	
	<table cellspacing="0" cellpadding="2" class="table_content"  id="myTable"
		style="width: 100%; background-color: #fff; border: 1px solid #dfdbdb;">
		<tr>
			<th class="report_heading">Start Position</th>
			<th class="report_heading">Start time</th>
			<th class="report_heading">Halt Position</th>
			<th class="report_heading">Stoped At</th>
			<th class="report_heading">Halted Time</th>
			<th class="report_heading">Distance Travelled(KM)</th>
									
		</tr>

<%		
		int halt_min = 0;	
		String lastTime="";
		String Starttime1="";
		String spendTime=null;
		String totalHalt = null;
		String totalTravelled=null;
		int totalSpentTime_min=0;
		Date f_time=null;
		Date l_time =null;
		int halt_hr =0;
		int totalTravel_min=0;
		boolean value =true;
		boolean contineousValue =true;
		
		int haltCounter=0;
		int offcounter=0,oncounter=0;
		String latitude = null;
		String longitude = null;
		String start_lat=null;
		String start_lng = null;
		String am_pm;int counter = 0;
		String ses_hour;String date;
		String fin_hr;String time;
		Date min_time = null;Date max_time = null;
		String diff = "";
		String min_diff= "";
		String minimum_time = "";
		String starttime ="";
		String maximum_time = "";
		int minute_diff = 0;
		int count = 0;
		
		String latitude_value = "";
		String longitude_value = "";
		String lat = "";
		String lon = "";
		Date prev_time = null;
		Date current_time = null;
		String mapKey = "";
		String halt_time = "";
		String previous_time = "";
		String crnt_time = "";
		Date start_time=null;
		boolean isstopped = false;
		List halt_time_list = new LinkedList(); 
		Map haltTimeMap = new LinkedHashMap();
		HashMap<String,List<Date>> map = new HashMap<String,List<Date>>();
		
		try{
			DBTransaction dbtranobj=new DBTransaction();
			Connection connection=dbtranobj.connect();
			ResultSet rs = null;
			Statement st=null;
			st=connection.createStatement();
			String query="SELECT latitude_value,longitude_value,tracking.engine_status,tracking.date_time FROM tracking WHERE tracking.imei_no ='"+imeinumber+"' and date_time>='"+startdate+"' and date_time<='"+enddate+"' order by date_time";
			System.out.println("Query is :"+query);
			rs = st.executeQuery(query);
			System.out.println("rs = "+rs);
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			int datacnt = 1;
			if(rs.next()){ //Beginig value
					starttime=rs.getString ("date_time");
					Starttime1 =starttime;
					start_lat=rs.getString("latitude_value");
					start_lng = rs.getString("longitude_value");
					start_time=df.parse(starttime);	
					
				}
			
			else{
				value=false;
				%>
					<script type="text/javascript">
					document.getElementById("myTable").style.display='none';						
					</script>
					
				<%
			
			}
			
			while(rs.next()){             //first iterate		
					String date_time = rs.getString("date_time");
					String lat_value=rs.getString("latitude_value");
					String long_value=rs.getString("longitude_value");
					String engine_status = rs.getString("engine_status");
					String date_in_db=date_time.substring(0,10);
					String day=date_in_db.substring(8,10);
					String month=date_in_db.substring(6, 7);
					String year=date_in_db.substring(0,4);
					String hr=date_time.substring(11,13);
					String min=date_time.substring(14,16);
					int hour = Integer.parseInt(hr);
					Date datetime=df.parse(date_time);
					
					if( hour > 12){
						am_pm = "PM";
						hour = hour - 12;
						if(hour < 10){
							fin_hr = "0"+hour;
						}else{ fin_hr = ""+hour; }
						time = fin_hr + ":"+min+" "+am_pm;
					}
					else{ 
						am_pm = "AM";
						if(hour < 10){
							fin_hr = "0"+hour;
						}else{ fin_hr = ""+hour; }
						
						time = fin_hr + " : "+min+" "+am_pm;
					}
					date=day+"-"+month+"-"+year;
					int lat_length = lat_value.indexOf(".");
					int lat_len = lat_value.length() - lat_length - 1;
					int long_length = long_value.indexOf(".");
					int long_len = long_value.length() - long_length - 1;
					if(lat_len <= 2 )
					{
						lat_value += "00";
					}
					if(long_len <= 2)
					{
						long_value += "00";
					}
					 latitude_value = lat_value.substring(0,5);
					longitude_value = long_value.substring(0,5);
		if(engine_status.equals("0"))
					{
						if(offcounter==0)
						 {
								min_time=datetime;  //off time											
								isstopped=true;	
						 } 
						 
						offcounter++;
						oncounter=0; 
					} //engine off
		else if(isstopped && engine_status.equals("1"))
		 {
			 if(oncounter==0)
				{  
					max_time = datetime;   //off to on (stoped at value)	
					System.out.println("Starttttttttttt time::"+start_time);
					System.out.println("Maxxxxxxxxxxxx Timee::"+min_time);
					lat = lat_value;
					lon = long_value;
					mapKey = lat +"$"+lon;
					Map<String,Object> cr = checkLocExists(haltTimeMap, lat, lon);
					 boolean rt = (Boolean)cr.get("isexist");
					if(rt)
					{
						
						String ky = (String)cr.get("eloc");
						List<Map<String,Object>> tmpList = (List)haltTimeMap.get(ky);
						Iterator<Map<String,Object>> titr = tmpList.iterator();
						while(titr.hasNext())
						{
							Map<String,Object> m = titr.next();
							Date maxi_time = (Date)m.get("max_time");	//Start time											
							long timeDiff = (Math.abs(min_time.getTime() - maxi_time.getTime())/1000)/60;		
							
							// converting hours to min 
																	
							
							System.out.println("Time differenceeeeeeee111 :"+timeDiff);
							if( timeDiff > input_halt_time )
							//if( timeDiff >1)
							{								
								Date tmin_time = (Date)m.get("min_time");
							}
							
						}//second iterate
						
					}//if boolean value is false
					
					else
					{ // off to on difference: 
						
						System.out.println("Latlang on displaying first lat values:"+lat_value );						
						long timeDiff = (Math.abs(min_time.getTime() - max_time.getTime())/1000)/60;							
						if(timeDiff > input_halt_time)			
						{
							
							Map<String,Object> m=new HashMap<String,Object>();							
									haltCounter++;								
									halt_time = String.format("%d hour(s) %d min(s)",
										 TimeUnit.MILLISECONDS.toHours(Math.abs(max_time.getTime() - min_time.getTime())),
							             TimeUnit.MILLISECONDS.toMinutes(Math.abs(max_time.getTime() - min_time.getTime())) - TimeUnit.HOURS.toMinutes(TimeUnit.MILLISECONDS.toHours(Math.abs(max_time.getTime() - min_time.getTime()))));
									halt_min = Integer.parseInt(String.format("%d",TimeUnit.MILLISECONDS.toMinutes(Math.abs(max_time.getTime() - min_time.getTime()))));
									System.out.println("Halt Time "+halt_time);									
									m.put("start_time",start_time);
									m.put("min_time",min_time);									
									m.put("max_time",max_time);							
									m.put("lat_value",lat_value);
									m.put("long_value",long_value);
									m.put("start_lat",start_lat);
									m.put("start_lng",start_lng);
									m.put("halt_time",halt_time); //purpose of display the halt time
									m.put("halt_min", halt_min); //purpose of find the total halt time
																		
									start_lat = lat_value;
									start_lng = long_value;
									start_time = max_time;
									
									System.out.println("Latlang on displaying :"+start_lat);
									System.out.println("Total values there in map :"+lat_value);
									
									//halt_time_list.add(m);
									List<Map<String,Object>> tmpList = new ArrayList<Map<String,Object>>();
									tmpList.add(m);
									haltTimeMap.put(mapKey,tmpList);
									System.out.println("halt counter is :"+haltCounter);
								
								
							
						}
						
																		
					}//off counter
					
					isstopped=false;
				}//on Conter
				
				oncounter++;
				offcounter=0; 
		 }  //Engine on
		for(Object m:halt_time_list)
		{
		
			Map y=(Map)m;						
		}
		
		
		if(counter == 0)
		{
			
		}
		
		 /* if(!(diff.equals("")) && (minute_diff > 5))
		{
		}  */
		} //first while  
			if(haltTimeMap.isEmpty()){						
			 	contineousValue =false;
			    %>
			 		<Script type="text/javascript">
						 document.getElementById("myTable").style.display='none';
			 		</script>
			 
			 		<h2><font color="red"><center>No Data Found </center></font></h2> 
				<%			 
			}
			
			
			
			Set keys = haltTimeMap.keySet();		
		Iterator it = keys.iterator();
		while(it.hasNext())
		{	
			String t=(String)it.next();
			List lt = (List)haltTimeMap.get(t); 	
			Iterator litr = lt.iterator();
			
			while(litr.hasNext())
			{	Map hm = (Map)litr.next();	
			
			count++;	
			if(haltCounter==count ){  
					halt_time="Stoped";
					hm.put("halt_time",halt_time);
					hm.put("halt_min",0);					
					}
			System.out.println("counter is :"+count);
				starttime =df.format(hm.get("start_time"));
				minimum_time = df.format(hm.get("min_time"));
				System.out.println("Min time :"+minimum_time);
				maximum_time = df.format(hm.get("max_time"));
				System.out.println("Halt time values in hash table :"+hm.get("halt_time"));
				
				halt_min= (Integer)hm.get("halt_min");
				halt_hr = halt_hr +halt_min ;
				
				System.out.println("Halt minutes is  ::::: "+halt_min);
				
				lastTime=minimum_time;
				l_time=df.parse(lastTime);
				f_time= df.parse(Starttime1);
				
			    spendTime=String.format("%d day(s) %d hour(s) %d min(s) ",
						TimeUnit.MILLISECONDS.toDays(Math.abs(f_time.getTime() - l_time.getTime())), //Days
						TimeUnit.MILLISECONDS.toHours(Math.abs(f_time.getTime() - l_time.getTime()))-TimeUnit.DAYS.toHours(TimeUnit.MILLISECONDS.toDays(Math.abs(f_time.getTime() - l_time.getTime()))) ,  // hours
						TimeUnit.MILLISECONDS.toMinutes(Math.abs(f_time.getTime() - l_time.getTime())) - TimeUnit.HOURS.toMinutes(TimeUnit.MILLISECONDS.toHours(Math.abs(f_time.getTime() - l_time.getTime()))));  // Minutes													
																	
			    totalSpentTime_min = Integer.parseInt(String.format("%d",TimeUnit.MILLISECONDS.toMinutes(Math.abs(f_time.getTime() - l_time.getTime()))));													
				//System.out.println("toatal hours into minutes .....mi.."+totalSpentTime_min);
				
				
				System.out.println("minimum time  :"+minimum_time);
				System.out.println("maximum time  :"+maximum_time);
				if(halt_min>150){ // 2 hrs and 30 mins
				 %>
					<tbody >
					<tr>
					<%-- <td align="left" class="report_border" > <%=lat_value %> , <%= long_value %></td> --%>
					<td  align="left" class="report_border" id="msg<%=count %>" style="width: 30%; background: #f9f7f5;"><input type="hidden" class="latlng" id="startPlace" name="startPlace" value="<%=hm.get("start_lat") %> , <%= hm.get("start_lng") %>"/></td>			  
					<td align="left" class="report_border" style="width: 16%;"> <%= starttime %></td>
					<td  align="left" class="report_border" id="msg1<%=count %>" style="width: 30%; background: #f9f7f5;"><input type="hidden" class="latlan" id="place" name="place" value="<%=hm.get("lat_value") %> , <%= hm.get("long_value") %>"/></td>
					<td align="left" class="report_border" style="width: 16%;"> <%= minimum_time %></td>			
					<td align="left" class="return_way_round" style=" width:38%; background: #f9f7f5;"><%= hm.get("halt_time") %></td>
					<td align="left" class="report_border" id="dis<%=count %>" style="padding-left: 10px; width:18%" ></td>			
					</tr>
					</tbody>
					<%
				}
				else{
					 %>
						<tbody >
						<tr>
						<%-- <td align="left" class="report_border" > <%=lat_value %> , <%= long_value %></td> --%>
						<td  align="left" class="report_border" id="msg<%=count %>" style="width: 30%; background: #f9f7f5;"><input type="hidden" class="latlng" id="startPlace" name="startPlace" value="<%=hm.get("start_lat") %> , <%= hm.get("start_lng") %>"/></td>			  
						<td align="left" class="report_border" style="width: 16%;"> <%= starttime %></td>
						<td  align="left" class="report_border" id="msg1<%=count %>" style="width: 30%; background: #f9f7f5;"><input type="hidden" class="latlan" id="place" name="place" value="<%=hm.get("lat_value") %> , <%= hm.get("long_value") %>"/></td>
						<td align="left" class="report_border" style="width: 16%;"> <%= minimum_time %></td>			
						<td align="left" class="report_border" style=" width:38%; background: #f9f7f5;"><%= hm.get("halt_time") %></td>
						<td align="left" class="report_border" id="dis<%=count %>" style="padding-left: 10px; width:18%" ></td>			
						</tr>
						</tbody>
						<%
				}
					System.out.println("May beeeeee :");;
		   }
		}
		
		
		//-----------------Finding Total Travelled and halt Time--------------//
		totalTravel_min =totalSpentTime_min - halt_hr;																				
		totalTravelled=totalTravel_min/24/60 + " day(s) " + totalTravel_min/60%24 + " hours(s) " + totalTravel_min%60+" min(s)";																								
		totalHalt=halt_hr/24/60 + " day(s) " + halt_hr/60%24 + " hour(s) " + halt_hr%60+" min(s)";
		
		session.setAttribute("totalSpendTime", spendTime);
		session.setAttribute("totalTravelled", totalTravelled);
		session.setAttribute("totalHalt", totalHalt);
		
		
		System.out.println("Same place Halt time "+haltTimeMap);
		connection.close();
		rs.close();
		st.close();
		}

		catch(SQLException e){ 
			e.printStackTrace();
			System.out.println(e.getMessage());
			return;
		} %>
			
		
		</table> 
		<br/>
										 
						 <table cellpadding="4" cellspacing="0"  id = "distance" width="500px" class="table_content" style="background-color: #fff; border: 1px solid #b1b1b1;" >	
						 	 <%
						 if(value == false || contineousValue == false){%>
						 <script type="text/javascript">
							 document.getElementById("distance").style.display='none';
							 </script>
							
				<%		 }
						 %>	 
						 		 		
								<tr>	
								<td  id="total_distance"> Total Distance Travelled </td><td> :</td>
 								 <td id ="totalDis" style="width:500px;" class="bold" ></td> 	
								</tr>	
								
								<tr>	
								<td style="width:500px;" id="total_distance"  class="group1" >  Total Spend Time</td><td> :</td>
 								 <td id ="totalSpendTime" style="width:500px;" class="bold" ><%=spendTime %></td> 	
								</tr>	
								
								<tr>	
								<td style="width:500px;" id="total_distance"  class="group1" > Total Halt Time</td><td> :</td>
 								 <td  style="width:500px;" class="bold" ><%=totalHalt %></td> 	
								</tr>	
								
								<tr>	
								<td style="width:500px;" id="total_distance"  class="group1"  > Total Travelled Time </td><td> :</td>
 								 <td style="width:500px;" class="bold" ><%=totalTravelled %></td> 	
								</tr>																			
				 </table> 				
		
		</div>
		
		</form>
		<!-- <button onclick="tabletest()">Click</button>  -->
		</body>
		
				<form name="redirect" method="post" >
				<table id="redirect" ><tr><td>
				<%
						 if(value == false || contineousValue == false){%>
						 <script type="text/javascript">
							 document.getElementById("redirect").style.display='none';
							 </script>
				<%		 }
						 %>	 	
				
 					
				</td></tr> </table>
				 
			</form>
		</html>
