
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
	<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	
	<html>
	
	<head>
	<title>Consolidated Trip Report</title>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<%!
	 int haltCounter=0;
	String dest_halt_time ; 		
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
	     
	         res.put("isexist", r);
	     return res;
	 } 
	 
	 %>
		<link rel="stylesheet" type="text/css" href="../../CSS/style.css" />
		<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
		<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" type="text/javascript"></script> 
		 

		<script language="javascript">
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
		
		function returnWay()
		{		
		var cells = new Array();
		var totaldistance =[];
			$('#returnTable tbody tr ').each(function(idex){				
		    var starting= $(this).find(".latlng_return").val();				 
		    var destination = $(this).find(".latlog_return").val();		
		    
			if(starting){
				if(idex >=6 && idex<=75){
					alert("Printing "+idex+"th row Click OK After one Second");
				}
					if(starting !="undefiend"){
					b=starting.split(",");
						for(var k=0; k < b.length ; k++){
								orgn_lat=b[0];
								orgn_lng=b[1];
							}
					}							
					var geo_location = new GClientGeocoder();
					geo_location.getLocations(starting, function (result)
						{ 								
							if (result.Status.code == G_GEO_SUCCESS) {								
									 for (var i=0; i<result.Placemark.length; i++) {
										   start_address=result.Placemark[i].address;											  
										    document.getElementById("st_point"+idex).innerHTML =start_address;																						   	
									   }
								
							}
									// ====== Decode the error status ======
							else {
									 var reasons="Code "+result.Status.code;
										 if (reasons = "Code 620"){
											 document.getElementById("st_point" + idex).innerHTML = "<font color=#"+color+">"+"Unable to find the location"+"</font>";
									     }
									 	 if (reasons[result.Status.code]) {
												reasons = reasons[result.Status.code];
									  		} 
									  		document.getElementById("st_point" + idex).innerHTML = "<font color=#"+color+">"+"Unable to find the location"+"</font>";
								}
						});//getlocation
						
			  }	 //Starting			
						
						
						
			  if(destination)
				{	
				  if(idex >=6 && idex<=75){
						alert("Printing "+idex+"th row Click OK After one Second");
					}
				if(destination !="undefiend"){
					
					a=destination.split(",");
						for(var i=0; i < a.length;i++){
							des_lat=a[0];							
							des_lng=a[1];
						}
								
					}
				// ====== Perform the Geocoding ======  
					 var geo_location = new GClientGeocoder();						 								
					 geo_location.getLocations(destination, function (result)
						  { 				
							if (result.Status.code == G_GEO_SUCCESS) {				
							 	 for (var i=0; i<result.Placemark.length; i++) {
								 	 des_address=result.Placemark[i].address;								
									 document.getElementById("end_point"+idex).innerHTML =des_address;																
							  	 }
							}
							// ====== Decode the error status ======
							else {
							 		 var reasons="Code "+result.Status.code;
									 if (reasons = "Code 620"){
									 document.getElementById("end_point" + idex).innerHTML = "<font color=#"+color+">"+"Unable to find the location"+"</font>";
								}
							if (reasons[result.Status.code]) {
									reasons = reasons[result.Status.code];
							  } 
							  		document.getElementById("end_point" + idex).innerHTML = "<font color=#"+color+">"+"Unable to find the location"+"</font>";
							}
						}
						
						
					);}	//Location end
						
						
					
	
					
					
					//--------------------Calculating the Distance -------------------//
				if(idex !=0){
					stpt = new GLatLng(orgn_lat,orgn_lng);
					despt = new GLatLng(des_lat,des_lng);
					var miledistance = stpt.distanceFrom(despt, 3959).toFixed(1);		          
				    var kmdistance = (miledistance * 1.85).toFixed(1);		                      
				    document.getElementById("return_dis" +idex ).innerHTML = kmdistance;  
				    totaldistance.push(kmdistance);	
					}
		      });//main function
				//------------------------ Calcualting total distance Travelled
				
           // alert(totaldistance.length);
            var total =0;
            for(var i =0;i<totaldistance.length;i++){            
            	total=total +Number(totaldistance[i]); 
            	//total=document.write(total.toFixed(2));
            	
            }    
            total=total.toFixed(1);
            document.getElementById("totalDistance").innerHTML=total;
					
		            console.log(cells);		            					    		        
		}
			
		  </script>
   	 <style type="text/css">
		tr:nth-child(even) {background: #f9f7f5}
		tr:nth-child(odd) {background: #FFF}
	</style>
		 </head>			 			 			 
		 <body onload="returnWay()">
		 
		
		 		
		<form name="consolidated_return way">		
		 <div id="table">
		 
		
		   <table>
								<tr><td><input type="Button" id="get_address" value = "Get Return Way Address" onclick="returnWay()"/></td>
										
								</table>
		
				<table cellspacing="0" cellpadding="4" class="table_content"   id="returnTable"
		style="width: 100%; background-color: #fff; border: 1px solid #dfdbdb;">	
		<tr>
			<th class="report_heading">Start Position</th>
		<!-- 	<th class="report_heading">Start Fuel</th> -->
			<th class="report_heading">Start Time</th>
			<th class="report_heading">Halt Position</th>
			<th class="report_heading">Stoped At</th>
			<th class="report_heading">Halted Time</th>
			<th class="report_heading">Distance Travelled(KM)</th>
		<!-- 	<th class="report_heading">Fuel Status</th>
			<th class="report_heading">AVG Fuel</th> -->
						
								
		</tr>
	<%
	String imeinumber = request.getParameter("vehicle_number");
	String startdate =(String)session.getAttribute("one_way_last_time");
	String one_way_srclat=(String) session.getAttribute("one_way_srclat");
	String one_way_deslat= (String)session.getAttribute("one_way_deslat");
	
	System.out.println("lat lng inside con_return_report oneway return report :::: "+one_way_srclat+" ---"+one_way_deslat);
	int input_halt_time=Integer.parseInt(request.getParameter("inputHaltTime"));	
	if(!one_way_deslat .equals(null) && !one_way_srclat .equals(null) ){
	//------------- Assinging the values ------------------//
	String src_lat=one_way_deslat;
	String des_lat=one_way_srclat;	
	double double_src_lat=0.0;
 	double double_des_lat=0.0;
 	String starttime="";
 	String start_lat="";
 	String lat_subString="";
 	String  start_lng="";
 	String latitude_value="";
 	String longitude_value="";
 	Date start_time=null;
 	String am_pm;		 	
 	String date;
	String fin_hr;String time;
	Date min_time = null;Date max_time = null;			
	String minimum_time = "";			
	//String maximum_time = "";
	String lat = "";
	String lon = "";			
	int return_count = 1;
	int sub_Str_cnt=0;
	int sub_String_cnt=0;
	int offcounter=0,oncounter=0;
	int whilecounter=1;			
	boolean isstopped = false;		
	String mapKey = "";
	String halt_time = "";
	//String previous_time = "";
	//String crnt_time = "";			
	Map haltTimeMap = new LinkedHashMap();
	List<Integer> equalCount=new ArrayList<Integer>();
	HashMap<String,List<Date>> map = new HashMap<String,List<Date>>();

	DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	  try {
 			DBTransaction dbtrans = new DBTransaction();
 			Connection con = dbtrans.connect();
 			Statement stmt1=  con.createStatement();
 			double_src_lat=Double.parseDouble(src_lat);
 			double_des_lat=Double.parseDouble(des_lat);  // have to do comparison 
 			String des_sub_lat=des_lat.substring(0,4);
 			
 			 //      -------------Main Query---------------One way Report//  	
	           String Query3 ="";
	  		   if(double_src_lat < double_des_lat){		   			 	
	   				 Query3="select latitude_value,longitude_value, tracking.engine_status,tracking.date_time,mile from tracking where tracking.imei_no='"+imeinumber+"' and date_time > (select date_time from tracking where imei_no='"+imeinumber+"' and date_time >'"+startdate+"' order by date_time limit 1) and latitude_value >='"+src_lat+"%' and latitude_value <='"+des_lat+"%' order by date_time";
	  		   }
	  		   if(double_src_lat > double_des_lat){
	  				 Query3=" select latitude_value,longitude_value, tracking.engine_status,tracking.date_time,mile from tracking where tracking.imei_no='"+imeinumber+"' and date_time > (select date_time from tracking where imei_no='"+imeinumber+"' and date_time >'"+startdate+"'  order by date_time limit 1) and latitude_value >='"+des_lat+"%' and latitude_value <='"+src_lat+"%' order by date_time";
	  		   }
	  		   
	   			System.out.println("Query 3 return way: "+Query3);
	   			ResultSet rs3 =stmt1.executeQuery(Query3);
	   			if(rs3.next()){ //Starting value
					starttime=rs3.getString ("date_time");
					start_lat=rs3.getString("latitude_value");
					start_lng = rs3.getString("longitude_value");
					start_time=df.parse(starttime);	
					
					if(starttime !="" ){
			   			Date s_time =df.parse(startdate);
			   			Date e_time =df.parse(starttime);
			   		    dest_halt_time = String.format("%d hour(s) %d min(s)",
			   				                    TimeUnit.MILLISECONDS.toHours(Math.abs(e_time.getTime() - s_time.getTime())),
			 	                                TimeUnit.MILLISECONDS.toMinutes(Math.abs(e_time.getTime() - s_time.getTime())) - TimeUnit.HOURS.toMinutes(TimeUnit.MILLISECONDS.toHours(Math.abs(e_time.getTime() - s_time.getTime()))));
			 		    System.out.println("Destination Halt time ::::::::::::@@@@@@@@@@@@@@@"+dest_halt_time);
			   			}
	   			}
	   			else{
					%>
						<script type="text/javascript">
						document.getElementById("returnTable").style.display='none';		
						document.getElementById("get_address").innerHTML.style.display = 'none';						
						</script>
							<h1><font color="red"><center>Return way Trip is not Completed</center></font></h1>
					<%
				
				}
	   			
	   			
	   			//---------------------Destination halt time calculation------------------------//
	   			/* System.out.println("Start dateeeeeeeeeeeeee :"+startdate);
	   			System.out.println("Start Timeeeeeeeeeeeeee :"+starttime); */
	   			
	 		    
	 		    
	 		    
	   			while(rs3.next()){
	   				
	   				String date_time = rs3.getString("date_time");
	   				String lat_value=rs3.getString("latitude_value");		   				
	   				String long_value=rs3.getString("longitude_value");
					String engine_status = rs3.getString("engine_status");
					String date_in_db=date_time.substring(0,10);
					String day=date_in_db.substring(8,10);
					String month=date_in_db.substring(6, 7);
					String year=date_in_db.substring(0,4);
					String hr=date_time.substring(11,13);
					String min=date_time.substring(14,16);
					int hour = Integer.parseInt(hr);
					Date datetime=df.parse(date_time);
				
					//-----------Time Alignment---------------//
					
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
					}
					
					//---------------Flow Starts here----------------//
					
					else if(isstopped && engine_status.equals("1"))
					 {
						 if(oncounter==0)
							{  
								max_time = datetime;   //off to on (stoped at value)									
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
										//System.out.println("Time differenceeeeeeee111 :"+timeDiff);
										if( timeDiff > 15 )
										//if( timeDiff >1)
										{								
											Date tmin_time = (Date)m.get("min_time");
										}
										
									}//second iterate
									
								}//if boolean value is false
								
								else
								{ // off to on difference: 
									long timeDiff = (Math.abs(min_time.getTime() - max_time.getTime())/1000)/60;	
										
									if(timeDiff > input_halt_time)			
									{
										
										
										Map<String,Object> m=new HashMap<String,Object>();							
												haltCounter++;								
												halt_time = String.format("%d hour(s) %d min(s)",
													 TimeUnit.MILLISECONDS.toHours(Math.abs(max_time.getTime() - min_time.getTime())),
										             TimeUnit.MILLISECONDS.toMinutes(Math.abs(max_time.getTime() - min_time.getTime())) - TimeUnit.HOURS.toMinutes(TimeUnit.MILLISECONDS.toHours(Math.abs(max_time.getTime() - min_time.getTime()))));						
												System.out.println("Halt Time "+halt_time);	
												
												lat_subString=lat_value.substring(0,4);
																							
													sub_Str_cnt++;
													
													
													
										//----------------Putting all the values in map--------------//		
														System.out.println("latitude value is :"+lat_value+"Long vlaue : "+long_value);
														m.put("start_time",start_time);
														m.put("min_time",min_time);	//last time								
														m.put("max_time",max_time);							
														m.put("lat_value",lat_value);
														m.put("long_value",long_value);
														m.put("start_lat",start_lat);
														m.put("start_lng",start_lng);
														m.put("halt_time",halt_time);
														start_lat = lat_value;
														start_lng = long_value;
														start_time = max_time;
														
														
												if(des_sub_lat.equals(lat_subString)){   
											/** It gives exact location we don't skip exact location 
												so we took next count of this loop.(By this we can get exact location)
												
											*/													
													equalCount.add(sub_Str_cnt+1);
													System.out.println("inside condtion equal count ************ :"+equalCount);
													System.out.println("SubString count-------------------++++++++++++++ des_sub_lat"+des_sub_lat+"     latitude subStirng equal :"+lat_subString);
													sub_String_cnt =  equalCount.get(0); //getting first time count of inside equal condition
												}
												List<Map<String,Object>> tmpList = new ArrayList<Map<String,Object>>();
												tmpList.add(m);
												haltTimeMap.put(mapKey,tmpList);													
									       }
								}//off counter
								isstopped=false;
							}//on Conter
							
							oncounter++;
							offcounter=0; 
					 }  //Engine on
					
					} //first while
						
						
						
				//	----------------Retrive and print the values which is there in halttimeMap---------------//
					//sub_String_cnt =  equalCount.get(0);
					System.out.println("array values in the contere********************"+sub_String_cnt);
					Set keys = haltTimeMap.keySet();		
					Iterator it = keys.iterator();
					while(it.hasNext())
					{								
						String t=(String)it.next();
						lat_subString=t.substring(0,4);
						lat_subString= lat_subString.substring(0,4);           //9
						//Sub_String_cnt = next count of exact location 
						  if(sub_String_cnt  == whilecounter ){							
								break;
							}  
					 
						
						 else{	//------Stop Condition--------//
							List lt = (List)haltTimeMap.get(t); 	
							Iterator litr = lt.iterator();
							
									while(litr.hasNext())
									{	Map hm = (Map)litr.next();																					
									whilecounter++;
										if(whilecounter == sub_String_cnt ){  
											halt_time="Stoped";
											hm.put("halt_time",halt_time);
										}	
										
										System.out.println("inside iteration "+lat_subString);
										starttime =df.format(hm.get("start_time"));
										minimum_time = df.format(hm.get("min_time"));
										System.out.println("Min time :"+minimum_time);
									//	maximum_time = df.format(hm.get("max_time"));
										System.out.println("Halt time values in hash table :"+hm.get("halt_time"));		
										
										System.out.println("Starting  value:$$$$$$$$$$$$$$$$$$$$$$$$  111: "+hm.get( "start_lat"));
										System.out.println("Starting  value:$$$$$$$$$$$$$$$$$$$$$$$$: 111"+hm.get( "start_lng"));
										System.out.println("Starting  value:$$$$$$$$$$$$$$$$$$$$$$$$: 111"+hm.get( "lat_value"));
										System.out.println("Starting  value:$$$$$$$$$$$$$$$$$$$$$$$$: 111"+hm.get( "long_value"));
										
										//-------------------------------Printing All the values into return way table-----------------------//
										 %>
											<tbody >
											
											<tr>
											<td  align="left" class="report_border" id="st_point<%=return_count %>" style="width: 30%;  background: #f9f7f5;"><input type="hidden" class="latlng_return" id="start_Place" name="start_Place" value="<%=hm.get("start_lat") %> , <%= hm.get("start_lng") %>"/></td>
											<%-- <td  align="left" class="report_border" id="ms<%=return_count %>" style="width: 10%;"> --%>			  
											<td align="left" class="report_border" style="width: 12%;"> <%= starttime %></td>
											<td  align="left" class="report_border" id="end_point<%=return_count %>" style="width: 30%;  background: #f9f7f5;"><input type="hidden" class="latlog_return" id="end_Place" name="end_Place" value="<%=hm.get("lat_value") %> , <%= hm.get("long_value") %>"/></td>
											<td align="left" class="report_border" style="width: 12%;"> <%= minimum_time %></td>										 
											<td align="left" class="report_border" style=" width:38%;  background: #f9f7f5;"><%= hm.get("halt_time") %></td>
											<td align="left" class="report_border" id="return_dis<%=return_count %>" style="padding-left: 10px; width:12%;" ></td>	
											<%-- <td  align="left" class="report_border" id="msg12<%=return_count %>" style="width: 10%;">
											<td  align="left" class="report_border" id="msg23<%=return_count %>" style="width: 10%;"> --%>											
											</tr>
											</tbody>
											<%																																	
										return_count++;		
					                 }//last while
					            }// if not equal
						
					       } //map iterate while
					    	//String one_way_last_time = minimum_time;					       
					       // System.out.println("Min time  (Final time of report):"+one_way_last_time);
							System.out.println("Same place Halt time "+haltTimeMap);
					
					
					con.close();					
					stmt1.close();									
					rs3.close();				
					}//try
					
					
					catch(NumberFormatException e){ 
						e.printStackTrace();
						System.out.println(e.getMessage());
						return;
					} 
					}%>
						
					
					</table> 
					<table width="245px" class="tableclsnew">								
								<tr><td style="width:100px;"> Total Distance Travelled :</td>
							<td  id ="totalDistance" style="width:50px;" class="bold" ></td>	
								</tr>
								
						
						
						</table>
					
					<table>
					<tr><td><h3>Actual Halt Time at Client location :<%=dest_halt_time %></h3></tr>
					</table>
					
	</div>
	</form>
	
	
	
	</body>
	
	</html>