<%@page import="java.util.LinkedHashSet"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Calendar" %>
<%@page import="java.text.DateFormat" %>
<%@page import="java.text.DecimalFormat" %>
<%@page import="java.util.Date"%> 
<%-- <%@ page errorPage="errorpage.jsp"%>  --%>
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
 <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

 <html><head>
 <title>Round Trip Report</title>
 <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	 <%!
	 
	 public Map<String,Object> checkLocExists(Map<String,String> mp,String lati,String langi,Date max_time)
	 {
		 boolean r = false;
	     Map<String,Object> res = new HashMap<String,Object>();	     
	     double dlat = Double.parseDouble(lati);
	     double dlon = Double.parseDouble(langi);	   
	     DecimalFormat dft = new DecimalFormat("#0.00"); 
	     String rkey = "";
	     rkey = dft.format(dlat)+"$"+dft.format(dlon);
	    
	     /* It is used to remove duplicate values when  Previous lattitude of off and on and Current lattitude of off and on same lattidue and logitude   */
	      if(mp.containsKey(rkey))
	     {
	         r = true;
	         res.put("eloc", rkey);	   
	         System.out.println("inside truee :: "+rkey +" in the time of  :"+max_time);
	     }  
	     	//res.put("eloc", rkey);	
	         res.put("isexist", r);
	     return res;
	 } 
	 
	 %>
	<%
	String Starttime1="";
	String startdate = request.getParameter("round_trip_date");
	String imeinumber = request.getParameter("vehicle_number");
	String src_address = request.getParameter("source_address");	
	int input_halt =Integer.parseInt(request.getParameter("halt_time"));
	
	session.setAttribute("inputHaltTime", input_halt);	
	%>
	
	
	
	 
<link rel="stylesheet" type="text/css" href="../../CSS/style.css" />	 
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" type="text/javascript"></script> 
 

<script language="javascript">
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

function tabletest()
{
	
	var cells = new Array();
	var totaldistance =[];
			$('#roundTripTable tbody tr ').each(function(idex){
			var	destination = $(this).find(".latlan").val();				 
				var starting = $(this).find(".latlng").val();

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
					
					var geo = new GClientGeocoder();					
					geo.getLocations(starting, function (result)
						
						  { 					
							
							if (result.Status.code == G_GEO_SUCCESS) {							 
							 	 for (var i=0; i<result.Placemark.length; i++) {
								  	 start_address=result.Placemark[i].address;
									 document.getElementById("startingPlace"+idex).innerHTML =start_address;														
								   	
							        }
						
							}
							// ====== Decode the error status ======
							else {
							 	 var reasons="Code "+result.Status.code;
							 	 if (reasons = "Code 620"){
								 		document.getElementById("startingPlace" + idex).innerHTML = "<font color=#"+color+">"+"Unable to find the location"+"</font>";
									}
							 	 if (reasons[result.Status.code]) {
										reasons = reasons[result.Status.code];
							  		} 
							  		document.getElementById("startingPlace" + idex).innerHTML = "<font color=#"+color+">"+"Unable to find the location"+"</font>";
								}
						  });
				
			}//starting 
			
				
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
																				
				 var geo = new GClientGeocoder();
				// ====== Perform the Geocoding ======        
				geo.getLocations(destination, function (result)
				  { 					
					if (result.Status.code == G_GEO_SUCCESS) {
						 
					 	 for (var i=0; i<result.Placemark.length; i++) {
						 	 des_address=result.Placemark[i].address;		
							 document.getElementById("nextPlace"+idex).innerHTML =des_address;									
							// cells.push(result.Placemark[i].address);						
							// $(this).text(result.Placemark[i].address);
					  		 }				
					}
					// ====== Decode the error status ======
					else {
					 		 var reasons="Code "+result.Status.code;
							 if (reasons = "Code 620"){
							 document.getElementById("nextPlace" + idex).innerHTML = "<font color=#"+color+">"+"Unable to find the location"+"</font>";
						}
					if (reasons[result.Status.code]) {
							reasons = reasons[result.Status.code];
					  } 
					  		document.getElementById("nextPlace" + idex).innerHTML = "<font color=#"+color+">"+"Unable to find the location"+"</font>";
					}
				  }
				
				
				);
				
                
				}	//destination
				

			
				//---------------------Calculating Distance travelled Per row---------------------------------//
				  	
				
				if(idex !=0){
						stpt = new GLatLng(orgn_lat,orgn_lng);
						despt = new GLatLng(des_lat,des_lng);
						var miledistance = stpt.distanceFrom(despt, 3959).toFixed(1);		          
		             	var kmdistance = (miledistance * 1.85).toFixed(1);
		             	document.getElementById("totalDistance" +idex ).innerHTML = kmdistance;  			           
		             	totaldistance.push(kmdistance);		             			             	
						}

			
            });//main function
       
            //------------------------ Calcualting total distance Travelled---------------------//

            var total =0;
            for(var i =0;i<totaldistance.length;i++){            
            	total=total +Number(totaldistance[i]);                	
            }  
            total=total.toFixed(1);
            document.getElementById("totalDis").innerHTML=total;            
            console.log(cells); 
            
            
            

}//table test

  </script>
 </head>
 
			<!--  Redirect to excel  -->
			
		<script type="text/javascript">
	 		function redirect_to_excel(Starttime1,imeinumber,input,src_lat)
				{			
	 			
	 			/* document.pdf.action="/Autotrack/ExcelControllerServlet/Excel_Round_Trip_report?startdate="+Starttime1+"&imeinumber="+imeinumber+"&inputHaltTime="+input+" &src_lat="+src_lat+""; */ 
				 document.pdf.action="round_trip_report_excel.jsp?startdate="+Starttime1+"&imeinumber="+imeinumber+"&inputHaltTime="+input+" &src_lat="+src_lat+""; 
				document.pdf.submit();
			}
	 		
	 		function redirect_to_pdf(Starttime1,imeinumber,input,src_lat)
			{		
	 		    var xmlStr = "<root>";
	 		    $('#roundTripTable tbody tr').each(function() {
	 		       
	 		        if (!this.rowIndex) return; // skip first row	 		     
	 		        xmlStr += "<record>"+
	 		                  "<start_position>"+this.cells[0].innerHTML+"</start_position>"+
	 		                  "<start_time>"+this.cells[1].innerHTML+"</start_time>"+
	 		                  "<halt_Position>"+this.cells[2].innerHTML+"</halt_Position>"+
	 		                  "<stopedAt>"+this.cells[3].innerHTML+"</stopedAt>"+
	 		                  "<halted_time>"+this.cells[4].innerHTML+"</halted_time>"+
	 		                 "<distance>"+this.cells[5].innerHTML+"</distance>"+
	 		                  "</record>";
	 		    });
	 		    
	 			xmlStr +="</root>"
	 			
	 		var values = document.getElementById("totalDis").innerHTML;

			document.pdf.action="round_trip_xml.jsp?startdate="+Starttime1+"&imeinumber="+imeinumber+"&xmls="+xmlStr+"&values="+values+"";			
			document.pdf.submit();
		}
 		
	 		
		</script>
	
	
	<body onload="tabletest()">
 

<!-- <label id="msg"></label> -->
	<div class="content_bg"><span class="content_headning">Round Trip Report</span></div>
			
			<form name="RoundTrip" method="post">

 			<div id="table">
				<table id="roundTripTable" class="table_content"style="width: 100%; background-color: #f1fafc; border: 1px solid #2898b4;">
		
					<tr>
						<th class="report_heading">Start Position</th>
						<th class="report_heading">Start time</th>
						<th class="report_heading">Halt Position</th>
						<th class="report_heading">Stopped At</th>
						<th class="report_heading">Halted Time</th>
						<th class="report_heading">Distance Travelled(KM)</th>
												
	<%
	
 	String src_lat=null;
 	double double_src_lat=0.0;
 	double double_des_lat=0.0;
 	String starttime="";
 	String lastTime="";
 	String start_lat="";
 	String lat_subString="";
 	String  start_lng=""; 
 	Date start_time=null;
 	String am_pm;		 	
 	String date;
	String fin_hr;String time;
	Date min_time = null;Date max_time = null;			
	String minimum_time = "";			
	String maximum_time = "";
	Date f_time=null;
	Date l_time =null;
	
	String lat = "";
	String lon = "";	
	String endTime="";
	boolean  value=true;
	boolean contineousValue=true;
	
	int counter =1;
	int count = 1;
	int sub_String_cnt=0;
	int offcounter=0,oncounter=0;
	int whilecounter=0;	
	int haltCounter =0;
	int haltCounter1=0;
	int southCount=0;
	int northCount=0;
	int splitCount=0;
	
	
	boolean isstopped = false;		
	String mapKey = "";
	String halt_time = "";
	String date_time ="";
	double startLat =0.00;
	double currentLat =0.00;
	double startLng=0.00;
	double currentLng=0.00;
	
	String spendTime=null;
	String totalHalt = null;
	String totalTravelled=null;
	
	int halt_hr =0;
	int halt_min = 0;	
	int totalSpentTime_min=0;
	int totalTravel_min=0;
	
	List<Double> largest = new ArrayList<Double>();
	List<Double> smallest = new ArrayList<Double>();
	
	String direction ="";
	String actualDirection ="";
	String oneWaylat="";
	String  southlat="";
	String northlat="";
	
	LinkedHashMap haltTimeMap = new LinkedHashMap();
	HashMap<String,List<Date>> map = new HashMap<String,List<Date>>();
	List<String> equal_lat_Count=new ArrayList<String>();	
	List<String> lat_array = new ArrayList<String>();
	
	//equal_halt_Count
	List<Integer> equal_halt_Count=new ArrayList<Integer>();
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	ResultSet rs = null;
	ResultSet rs1 = null;
	Connection con =null;
	Statement st =null;
	Statement st1 =null;
	try{
		DBTransaction dbtrans = new DBTransaction();
		con = dbtrans.connect();
		st = con.createStatement();
		
		String finding_lat ="Select Latitude,Longitude from address where address='"+src_address+"'";
		rs = st.executeQuery(finding_lat);
		if(rs.next()){
			 src_lat=rs.getString("Latitude");		 
		 	 double_src_lat=Double.parseDouble(src_lat);			
			}
		String src_sub_lat=src_lat.substring(0,5);
		//-------------Main login Query--------------------//
		
	    st1 =con.createStatement();
		
		String mainLogic = "select latitude_value,longitude_value,tracking.engine_status,tracking.date_time,mile from tracking where tracking.imei_no ='"+imeinumber+"' and date_time >(select date_time from tracking where imei_no='"+imeinumber+"' and date_time >'"+startdate+"' and latitude_value like '"+src_lat+"%' order by date_time limit 1) order by date_time";
		System.out.println("main logic  query is  :"+mainLogic);
		rs1 = st1.executeQuery(mainLogic);
		
		if(rs1.next()){ //Starting value
			starttime=rs1.getString ("date_time");
			Starttime1=starttime;
			System.out.println("first time is :"+starttime);
		    start_lat=rs1.getString("latitude_value");
			start_lng = rs1.getString("longitude_value");
			start_time=df.parse(starttime);				
			}
			
			else{			
				value=false;
			%> 
				 <script type="text/javascript">				
				document.getElementById("roundTripTable").style.display='none';
				document.getElementById("distance").style.display='none';				
				document.getElementById("export_excel").style.display='none';
				document.getElementById("export_PDF").style.display='none';
				
				
				</script> 
					
			<%
		
		}		
			while(rs1.next()){
   				
   			    date_time = rs1.getString("date_time");
   				String lat_value=rs1.getString("latitude_value");	    				   				   				
   				
   				String long_value=rs1.getString("longitude_value");
				String engine_status = rs1.getString("engine_status");
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
							mapKey = lat_value +"$"+long_value;									
							Map<String,Object> cr = checkLocExists(haltTimeMap, lat, lon,max_time);
							 boolean rt = (Boolean)cr.get("isexist");							
							 System.out.println("");
							 System.out.println("");
							
							 
							 if(rt)
							{							
								//String ky = (String)cr.get("eloc");	 
								//System.out.println("String value iss keyyyyyy :"+ky);
								//List<Map<String,Object>> tmpList = (List)haltTimeMap.get(ky);
								//Iterator<Map<String,Object>> titr = tmpList.iterator();
								///while(titr.hasNext())
								//{
									//Map<String,Object> m = titr.next();
									//Date maxi_time = (Date)m.get("max_time");	//Start time								
									//long timeDiff = (Math.abs(min_time.getTime() - maxi_time.getTime())/1000)/60;																										
								//}//second iterate
								
							}//if boolean value is false
							 
						else 
						{ // off to on difference:	
								
						     System.out.println("engine on time ~~~~~~~~~~~~~~ :"+max_time +"latlng is :~~~~~~~~~~~~ "+start_lat);
							 System.out.println("engine off time ~~~~~~~~~~~~~~ :"+min_time);
							 long timeDiff = (Math.abs(min_time.getTime() - max_time.getTime())/1000)/60;							
								if(timeDiff > input_halt)			
								{													
									LinkedHashMap<String,Object> m=new LinkedHashMap<String,Object>();																		
									
											halt_time = String.format("%d hour(s) %d min(s)",
												 TimeUnit.MILLISECONDS.toHours(Math.abs(max_time.getTime() - min_time.getTime())),
									             TimeUnit.MILLISECONDS.toMinutes(Math.abs(max_time.getTime() - min_time.getTime())) - TimeUnit.HOURS.toMinutes(TimeUnit.MILLISECONDS.toHours(Math.abs(max_time.getTime() - min_time.getTime()))));												
											lat_subString=lat_value.substring(0,5);																																	
							
											// converting hours to min 
											halt_min = Integer.parseInt(String.format("%d",TimeUnit.MILLISECONDS.toMinutes(Math.abs(max_time.getTime() - min_time.getTime()))));											
											
												
												
									//----------------Putting all the values in map--------------//		
										
													m.put("start_time",start_time);
													m.put("min_time",min_time);	//last time								
													m.put("max_time",max_time);							
													m.put("lat_value",lat_value);
													m.put("long_value",long_value);
													m.put("start_lat",start_lat);
													m.put("start_lng",start_lng);
													m.put("halt_time",halt_time); //for the purpose of display the halt time
													m.put("halt_min", halt_min); // for the purpose of find the total halt time
													
													System.out.println(" values are inserted");
													startLat = Double.parseDouble(start_lat);
													currentLat = Double.parseDouble(lat_value);
													startLng = Double.parseDouble(start_lng);
													currentLng = Double.parseDouble(long_value);
													
													if(startLat > currentLat){ //Direction is north to south vehicle moving towards south														
														direction ="south";
														southCount++;
														northCount=100;
														 southlat=lat_value;	
														 System.out.println("South counter "+southCount);																												 											
													}
													
													else if(startLat < currentLat + 0.03){ //Direction is south to north vehicle moving towards north																									
														direction ="north";
														northCount++;	
														southCount=100;
														System.out.println("North count "+northCount);													  													 								
												   }	
												   		
												  if(southCount < 100 && southCount !=0 ){
													   
													   splitCount=southCount;
													   System.out.println("south count condition checking Split counte  :"+splitCount);													  
												   }
												   else if(northCount < 100 && northCount!=0 ){
													   splitCount=northCount;
													   System.out.println("north count condition checking Split counte  :"+splitCount);
												   }												  
												   if(actualDirection.equals("south")){													   
													   oneWaylat = southlat;													   
												   }												   
												   else if(actualDirection.equals("north")){
													   oneWaylat = northlat;
												   }
												   												   													   												 
												   session.setAttribute("splitCount", splitCount);												   												  												   												   												  
												   												  
										//-------------- Assigning previous lattiutude and longitude into current lattitude  and longitude---------//
										
 												    start_lat = lat_value;
													start_lng = long_value;
													start_time = max_time;
													haltCounter++;	
													lat_array.add(lat_value);
													String second_value=lat_array.get(0).substring(0,6);	// Because address tabel has only 3 digit after the decimal point						
													
													//-------------------- Condition to find out the last latlng ---------------------//																					
													if(src_sub_lat.equals(lat_subString) && counter!=1){  															
														equal_lat_Count.add(date_time);
														endTime = equal_lat_Count.get(0);  //once condition gets true ,pick out the time and consider as a endtime.																								
														equal_halt_Count.add(haltCounter);																								       
														haltCounter1 =equal_halt_Count.get(0);   //once condition gets true, pick out the count to compare the iteration														
														System.out.println("Stop condition counterrrrrrrr   :"+counter +"and time is :"+endTime);																									
													}
													counter++;													
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
				
				if(haltTimeMap.isEmpty()){						
					 	contineousValue =false;
					    %>
					 		<Script type="text/javascript">
								 document.getElementById("roundTripTable").style.display='none';
					 		</script>
					 
					 		<h2><font color="red"><center>No Data Found </center></font></h2> 
						<%			 
					}

						Set keys = haltTimeMap.keySet();		
						Iterator it = keys.iterator();
						 int breakcondition = 0;						
						while(it.hasNext())
						{								
							String t=(String)it.next();
							
								if(breakcondition  == 1){         //------Stop Condition--------//									
									break;
								}	
								
								 List lt = (List)haltTimeMap.get(t); 	
								Iterator litr = lt.iterator();								
										while(litr.hasNext())
										{
											
											LinkedHashMap hm = (LinkedHashMap)litr.next();		
											System.out.println("inside printing Start time is  : "+hm.get("start_time"));
											whilecounter++;
											System.out.println("Stop condition counter :"+whilecounter);
											System.out.println("Stop condition halt counter1 :"+haltCounter1);
											if(whilecounter == haltCounter1 ){  																								
												halt_time="Round Trip Completed";
												hm.put("halt_time",halt_time);
												hm.put("halt_min",0);
											}		
											
											starttime =df.format(hm.get("start_time"));
											minimum_time = df.format(hm.get("min_time"));											
											maximum_time = df.format(hm.get("max_time"));
																									
											maximum_time = maximum_time.substring(0,19);  											
										
											
											endTime = endTime.substring(0,19); 												
											halt_min= (Integer)hm.get("halt_min");
											halt_hr = halt_hr +halt_min ;
											
											//-------------------------------Printing All the values into one way table-----------------------//
											 %>											 											  																									
													
												<%  System.out.println("Split count is :"+splitCount +"  while count : "+count);	
												if(halt_min>150){
														if(count == splitCount){
														 System.out.println("split count is ::::::::::::::------------------ "+splitCount);%>
												<tbody>
												<tr>
													<td align="left" class="report_border" id="startingPlace<%=count %>" style="width: 30%;"><input type="hidden" class="latlng" id="startPlace" name="startPlace" value="<%=hm.get("start_lat") %> , <%= hm.get("start_lng") %>"/></td>			  
													<td align="left" class="report_border" style="width: 16%;"> <%= starttime %></td>
													<td align="left" class="return_way_round" id="nextPlace<%=count %>" style="width: 30%;"><input type="hidden" class="latlan" id="place" name="place" value="<%=hm.get("lat_value") %> , <%= hm.get("long_value") %>"/></td>
													<td align="left" class="report_border" style="width: 16%;"> <%= minimum_time %></td>										 
													<td align="left" class="return_way_round" style=" width:38%;"><%= hm.get("halt_time") %></td>
													<td align="left" class="report_border" id="totalDistance<%=count %>" style="padding-left: 10px; width:18%" ></td>
												</tr>
												</tbody>													
													<%}
														else if(halt_min>150){ // 2 hrs and 30 mins
															if(count != splitCount){%>
																<tbody>
												<tr>
													<td align="left" class="report_border" id="startingPlace<%=count %>" style="width: 30%;"><input type="hidden" class="latlng" id="startPlace" name="startPlace" value="<%=hm.get("start_lat") %> , <%= hm.get("start_lng") %>"/></td>			  
													<td align="left" class="report_border" style="width: 16%;"> <%= starttime %></td>
													<td align="left" class="report_border" id="nextPlace<%=count %>" style="width: 30%;"><input type="hidden" class="latlan" id="place" name="place" value="<%=hm.get("lat_value") %> , <%= hm.get("long_value") %>"/></td>
													<td align="left" class="report_border" style="width: 16%;"> <%= minimum_time %></td>										 
													<td align="left" class="return_way_round" style=" width:38%;"><%= hm.get("halt_time") %></td>
													<td align="left" class="report_border" id="totalDistance<%=count %>" style="padding-left: 10px; width:18%" ></td>
												</tr>
												</tbody>	
														<%	}
														}
															
													}
												else if(count == splitCount){%>
												<tbody>
												<tr>
													<td align="left" class="report_border" id="startingPlace<%=count %>" style="width: 30%;"><input type="hidden" class="latlng" id="startPlace" name="startPlace" value="<%=hm.get("start_lat") %> , <%= hm.get("start_lng") %>"/></td>			  
													<td align="left" class="report_border" style="width: 16%;"> <%= starttime %></td>
													<td align="left" class="return_way_round" id="nextPlace<%=count %>" style="width: 30%;"><input type="hidden" class="latlan" id="place" name="place" value="<%=hm.get("lat_value") %> , <%= hm.get("long_value") %>"/></td>
													<td align="left" class="report_border" style="width: 16%;"> <%= minimum_time %></td>										 
													<td align="left" class="report_border" style=" width:38%;"><%= hm.get("halt_time") %></td>
													<td align="left" class="report_border" id="totalDistance<%=count %>" style="padding-left: 10px; width:18%" ></td>
												</tr>
												</tbody>	
													
												<% }
													
													 
													else  {%>	
											<tbody>
											<tr>						 
												<td align="left" class="report_border" id="startingPlace<%=count %>" style="width: 30%;"><input type="hidden" class="latlng" id="startPlace" name="startPlace" value="<%=hm.get("start_lat") %> , <%= hm.get("start_lng") %>"/></td>			  
												<td align="left" class="report_border" style="width: 16%;"> <%= starttime %></td>
												<td align="left" class="report_border" id="nextPlace<%=count %>" style="width: 30%;"><input type="hidden" class="latlan" id="place" name="place" value="<%=hm.get("lat_value") %> , <%= hm.get("long_value") %>"/></td>
												<td align="left" class="report_border" style="width: 16%;"> <%= minimum_time %></td>										 
												<td align="left" class="report_border" style=" width:38%;"><%= hm.get("halt_time") %></td>
												<td align="left" class="report_border" id="totalDistance<%=count %>" style="padding-left: 10px; width:18%" ></td>	
											</tr>
											</tbody>			
											
												
												
												<%}
													
													
													
												// -----------------Finding Total time spend-----------------//
													lastTime=minimum_time;
													l_time=df.parse(lastTime);
													f_time= df.parse(Starttime1);
													
												    spendTime=String.format("%d day(s) %d hour(s) %d min(s) ",
															TimeUnit.MILLISECONDS.toDays(Math.abs(f_time.getTime() - l_time.getTime())), //Days
															TimeUnit.MILLISECONDS.toHours(Math.abs(f_time.getTime() - l_time.getTime()))-TimeUnit.DAYS.toHours(TimeUnit.MILLISECONDS.toDays(Math.abs(f_time.getTime() - l_time.getTime()))) ,  // hours
															TimeUnit.MILLISECONDS.toMinutes(Math.abs(f_time.getTime() - l_time.getTime())) - TimeUnit.HOURS.toMinutes(TimeUnit.MILLISECONDS.toHours(Math.abs(f_time.getTime() - l_time.getTime()))));  // Minutes													
																										
												    totalSpentTime_min = Integer.parseInt(String.format("%d",TimeUnit.MILLISECONDS.toMinutes(Math.abs(f_time.getTime() - l_time.getTime()))));													
													//System.out.println("toatal hours into minutes .....mi.."+totalSpentTime_min);
													
													
													
												if( endTime.equals(maximum_time) ){		//if condition gets match break the operation
													System.out.println("make loop as break");
													
													breakcondition =1;
												}  
												
												
											count++;	
											
						                 }//last while		
										
										
										
						       } //map iterate while	
						    
						    	   
								//-----------------Finding Total Travelled and halt Time--------------//
								totalTravel_min =totalSpentTime_min - halt_hr;																				
								totalTravelled=totalTravel_min/24/60 + " day(s) " + totalTravel_min/60%24 + " hours(s) " + totalTravel_min%60+" min(s)";																								
								totalHalt=halt_hr/24/60 + " day(s) " + halt_hr/60%24 + " hour(s) " + halt_hr%60+" min(s)";
								
								session.setAttribute("totalSpendTime", spendTime);
								session.setAttribute("totalTravelled", totalTravelled);
								session.setAttribute("totalHalt", totalHalt);
								
														    						    	
						
						
						}//try	ends here										
						catch(SQLException e){
							
							e.printStackTrace();
							System.out.println(e.getMessage());
							return;
						} 	
						catch(NumberFormatException e){
							e.printStackTrace();
						}
						finally{
							if(con!=null){
								con.close();
								rs.close();
								rs1.close();
								st.close();
								st1.close();
							}
						}
		    
						%>
						
						
						</table>	
														 
						 <table  id = "distance" width="500px" class="tableclsnew" >	
						 	 <%
						 if(value == false || contineousValue == false){%>
						 <script type="text/javascript">
							 document.getElementById("distance").style.display='none';
							 </script>
							
				<%		 }
						 %>	 
						 		 		
								<tr>	
								<td  id="total_distance"  > Total Distance Travelled </td><td> :</td>
 								 <td id ="totalDis" style="width:500px;" class="bold" ></td> 	
								</tr>	
								
								<tr>	
								<td style="width:500px;" id="total_distance"  class="group1" >  Total Spend Time</td><td> :</td>
 								 <td id ="totalSpendTime" style="width:500px;" class="bold" ><%=spendTime %></td> 	
								</tr>	
								
								<tr>	
								<td style="width:500px;" id="total_distance"  class="group1" > Total haltTime</td><td> :</td>
 								 <td  style="width:500px;" class="bold" ><%=totalHalt %></td> 	
								</tr>	
								
								<tr>	
								<td style="width:500px;" id="total_distance"  class="group1"  > Total Travelled Time </td><td> :</td>
 								 <td style="width:500px;" class="bold" ><%=totalTravelled %></td> 	
								</tr>																			
				 </table> 						
		</div>
		</form>
						
	</body>							
			
			<form name="pdf" method="post" accept-charset="utf-8">
				<table id="redirect" ><tr><td>
				<%
						 if(value == false || contineousValue == false){%>
						 <script type="text/javascript">
							 document.getElementById("redirect").style.display='none';
							 </script>
				<%		 }
						 %>	 	
				 <input type="button"  value="Export To Excel" tabindex="3" id="export_excel" onclick="redirect_to_excel('<%=Starttime1%>','<%=imeinumber%>','<%=input_halt%>','<%=src_lat%>');"></input>
				 <input type="button"  value="Export To PDF" tabindex="3" id="export_PDF" onclick="redirect_to_pdf('<%=Starttime1%>','<%=imeinumber %>','<%=input_halt %>','<%=src_lat%>');"></input> 
				</td></tr> </table>
				 
			</form>  																																																													
				 	
						
						</html>
						