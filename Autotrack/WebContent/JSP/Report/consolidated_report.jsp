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

 <html><head>
 <title>Consolidated Trip Report</title>
 <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	 <%!
	 //int haltCounter=0;
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
	         //System.out.println("res.put ans------------------------- :"+res.get("eloc"));
	     } 
	     
	         res.put("isexist", r);
	     return res;
	 } 
	 
	 %>
	 
	 	<%		
			String imeinumber = request.getParameter("vehicle_number");		    		   		     		   
	 		String Starttime1="";
	 		int input_halt_time=Integer.parseInt(request.getParameter("inputHaltTime")); 
		    System.out.println("inpupt halt time is  :"+input_halt_time);
		    String startdate=request.getParameter("cons_date");
		    if(startdate !=null){
		    System.out.println("start date :::::::::::^^^^^^^^^^^^^^^"+startdate);
		    
		    		    
		    session.setAttribute("startDate", startdate);
		    session.setAttribute("imei", imeinumber);		    
		    String source_address = request.getParameter("source");  
		    String desti_address  = request.getParameter("destination");
		    
		    %>
	 
	 
	 <link rel="stylesheet" type="text/css" href="../../CSS/style.css" />
	 
<script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" type="text/javascript"></script> 
 

<script language="javascript">
//var destination ;
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
			$('#myTable tbody tr ').each(function(idex){
			var	destination = $(this).find(".latlan").val();				 
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
					
					
							
					
				 var geo = new GClientGeocoder();
				// ====== Perform the Geocoding ======        
				geo.getLocations(destination, function (result)
				  { 					
					if (result.Status.code == G_GEO_SUCCESS) {
						 
					 	 for (var i=0; i<result.Placemark.length; i++) {
						 	 des_address=result.Placemark[i].address;		
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
				
                
				}	//destination
				
				
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
				
			}//starting
			
			
				//---------------------Calculating Distance travelled---------------------------------//
				  	
				
				if(idex !=0){
						stpt = new GLatLng(orgn_lat,orgn_lng);
						despt = new GLatLng(des_lat,des_lng);
						var miledistance = stpt.distanceFrom(despt, 3959).toFixed(1);		          
		             	var kmdistance = (miledistance * 1.85).toFixed(1);
		             	document.getElementById("dis" +idex ).innerHTML = kmdistance;  			           
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
            document.getElementById("totalDis").innerHTML=total;
            
            console.log(cells);
            
           
}//table test
  </script>
  
   	 <style type="text/css">
		tr:nth-child(even) {background: #f9f7f5}
		tr:nth-child(odd) {background: #FFF}
	</style>
 </head>
 
			<!--  Redirect to excel  -->
			
			          
 		<script type="text/javascript">
	 		function redirect_to_excel(Starttime1,imeinumber,input)
				{	
				document.pdf.action="Cons_TripReport_Excel.jsp?startdate="+Starttime1+"&imeinumber="+imeinumber+"&inputHaltTime="+input+"";				
				document.pdf.submit();
			} 
	 		
	 		
	 		function redirect_to_pdf(Starttime1,imeinumber,input)
			{	
	 			/* var xmlStr;
	 			$('#returnTable').each(function(){
	 				if (!this.rowIndex) return; // skip first row
			        xmlStr += "<record>"+
			                  "<place>"+this.cells[0].innerHTML+"</place>"+
			                  "<mintime>"+this.cells[1].innerHTML+"</mintime>"+
			                  "<maxtime>"+this.cells[2].innerHTML+"</maxtime>"+
			                  "<halttime>"+this.cells[3].innerHTML+"</halttime>"+
			                  "</record>";
			    });
				xmlStr +="</root>"
	 				
				alert("xmlStr  ::"+xmlStr);
					 		 */
			/* document.pdf.action="/Autotrack/ExcelControllerServlet/Pdf_Consolidate_report?startdate="+Starttime1+"&imeinumber="+imeinumber+"&inputHaltTime="+input+""; */
			document.pdf.action="Cons_TripReport_PDF.jsp?startdate="+Starttime1+"&imeinumber="+imeinumber+"&inputHaltTime="+input+"";
			document.pdf.submit();
		} 
		</script>
	 
	 
	 
 <body onload="tabletest()">

<!-- <label id="msg"></label> -->
	<div class="content_bg"><span class="content_headning">Consolidated Trip Report</span></div>
	<br/>
	<div style="float: right;">
	<form name="pdf" method="post" accept-charset="utf-8">
				 <input type="button"  value="Export To Excel" tabindex="3" id="export_excel" onclick="redirect_to_excel('<%=Starttime1%>','<%=imeinumber%>','<%=input_halt_time%>');"></input>
				 <input type="button"  value="Export To PDF" tabindex="3" id="export_pdf" onclick="redirect_to_pdf('<%=Starttime1%>','<%=imeinumber%>','<%=input_halt_time%>');"></input>
	</form> 
	</div> 
	<br/>
		<input type="Button" value = "One Way Report" id="one_way" />
	<br/>
			<form name="consolidated">

 			<div id="table">
				
			<table cellspacing="0" cellpadding="4" class="table_content"   id="myTable"
		style="width: 100%; background-color: #fff; border: 1px solid #dfdbdb;">
					<tr>
						<th class="report_heading">Start Position</th>
					<!-- 	<th class="report_heading">Start Fuel</th> -->
						<th class="report_heading">Start time</th>
						<th class="report_heading">Halt Position</th>
						<th class="report_heading">Stoped At</th>
						<th class="report_heading">Halted Time</th>
						<th class="report_heading">Distance Travelled(KM)</th>
					<!-- <th class="report_heading">Fuel Status</th>
						<th class="report_heading">AVG Fuel</th>
						 -->

 
		    <%
		 	String src_lat=null;
		 	String src_lng=null;
		 	String des_lat=null;
		 	String des_lng=null;
		 	double double_src_lat=0.0;
		 	double double_des_lat=0.0;
		 	String starttime="";
		 	String start_lat="";
		 	String lat_subString="";
		 	String  start_lng="";		 	
		 	String longitude_value="";
		 	Date start_time=null;
		 	String am_pm;		 	
		 	String date;
			String fin_hr;
			String time;
			Date min_time = null;Date max_time = null;			
			String minimum_time = "";					
			String lat = "";
			String lon = "";	
			float start_fuel_per =0f;
			float end_fuel_per =0f;
			
			double start_fuel=0;
			double end_fuel=0;
			
			int count = 1;
			int sub_Str_cnt=0;
			int sub_String_cnt=0;
			int offcounter=0,oncounter=0;
			int whilecounter=1;			
			boolean isstopped = false;		
			String mapKey = "";
			String halt_time = "";						
			Map haltTimeMap = new LinkedHashMap();
			HashMap<String,List<Date>> map = new HashMap<String,List<Date>>();
			List<Integer> equalCount=new ArrayList<Integer>();
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		 	
		   try {
		   			DBTransaction dbtrans = new DBTransaction();
		   			Connection con = dbtrans.connect();
		   			Statement stmt1=  con.createStatement();
		   			
		   		//---------------------Getting Source latitude----------------//
		   		   	String Query1="Select Latitude,Longitude from address where address='"+source_address+"'";
		   			ResultSet rs1 = stmt1.executeQuery(Query1);
		   			while(rs1.next()){
		   				 src_lat =rs1.getString("latitude");
		   				 src_lng =rs1.getString("Longitude");
		   				 double_src_lat=Double.parseDouble(src_lat);
		   				 session.setAttribute("one_way_srclat", src_lat);		   				
		   				//
		   			}

		   		//---------------------Getting Destination latitude----------------//	
		   			String Query2="Select Latitude,Longitude from address where address='"+desti_address+"'";
		   			ResultSet rs2 = stmt1.executeQuery(Query2);
		   			while(rs2.next()){
		   				des_lat = rs2.getString("latitude");
		   				des_lng = rs2.getString("Longitude");
		   				double_des_lat=Double.parseDouble(des_lat);  // have to do comparison 
		   				session.setAttribute("one_way_deslat", des_lat);
		   			} 		   					   			
		   			String des_sub_lat=des_lat.substring(0,4);
		   			session.setAttribute("des_lat",des_sub_lat);
	
		  //      -------------Main Query---------------One way Report//  	
		           String Query3 ="";
		  		   if(double_src_lat < double_des_lat){		   			 	
		   				 Query3="select latitude_value,longitude_value, tracking.engine_status,tracking.date_time,mile,fuel from tracking where tracking.imei_no='"+imeinumber+"' and date_time >= (select date_time from tracking where imei_no='"+imeinumber+"' and date_time >'"+startdate+"' and latitude_value like '"+src_lat+"%' order by date_time limit 1) and latitude_value >='"+src_lat+"%' and latitude_value <='"+des_lat+"%' order by date_time";
		   				System.out.println("Query 3 one way src<  des (1): "+Query3);
		   				 
		  		   }
		  		   if(double_src_lat > double_des_lat){
		  				Query3=" select latitude_value,longitude_value, tracking.engine_status,tracking.date_time,mile,fuel from tracking where tracking.imei_no='"+imeinumber+"' and date_time >= (select date_time from tracking where imei_no='"+imeinumber+"' and date_time >'"+startdate+"' and latitude_value like '"+src_lat+"%' order by date_time limit 1) and latitude_value >='"+des_lat+"%' and latitude_value <='"+src_lat+"%' order by date_time";
		  				System.out.println("Query 3 one way src>  des (2): "+Query3);
		  		   }
		  		   
		  		   
		  		   Statement stmt2 =con.createStatement();
		   			
		   			ResultSet rs3 =stmt1.executeQuery(Query3);
		   			if(rs3.next()){ //Starting value
						starttime=rs3.getString ("date_time");
						Starttime1=starttime;
		   				System.out.println("first time is :"+starttime);
						start_lat=rs3.getString("latitude_value");
						start_lng = rs3.getString("longitude_value");
						start_time=df.parse(starttime);	
						String fuel_value  = rs3.getString("fuel");
						start_fuel_per=Float.parseFloat(fuel_value);
					
		   			}
		   			
		   			else{
						%>
							<script type="text/javascript">
							document.getElementById("myTable").style.display='none';												
							document.getElementsById("one_way").style.display='none';
							</script>
								
								<h1><font color="red"><center>No Data Found </center></font></h1>
						<%
					
					}
		   			
		   			//--------------- finding fuel capacity --------------//
		   			
		   			
		   			String fuel = "select fuel_tank_capacity from vehicle_information where imei_no='"+imeinumber+"' ";
		   			int fuelCapacity=0;
		   			ResultSet rs4 =  stmt2.executeQuery(fuel);
		   			
		   			while(rs4.next()){
		   				fuelCapacity =Integer.parseInt(rs4.getString("fuel_tank_capacity"));
		   			}

		   			System.out.println("Fuel capacity iss ::::::::::::::::::::::::::::::"+fuelCapacity);
		   		
		   			while(rs3.next()){		   				
		   				String date_time = rs3.getString("date_time");
		   				String lat_value=rs3.getString("latitude_value");		   				
		   				String long_value=rs3.getString("longitude_value");
						String engine_status = rs3.getString("engine_status");
						end_fuel_per =Float.parseFloat(rs3.getString("fuel")) ;
						
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
											System.out.println("Start lat deatailssss :::::::::::"+start_lat);
											Map<String,Object> m=new HashMap<String,Object>();							
													//haltCounter++;								
													halt_time = String.format("%d hour(s) %d min(s)",
														 TimeUnit.MILLISECONDS.toHours(Math.abs(max_time.getTime() - min_time.getTime())),
											             TimeUnit.MILLISECONDS.toMinutes(Math.abs(max_time.getTime() - min_time.getTime())) - TimeUnit.HOURS.toMinutes(TimeUnit.MILLISECONDS.toHours(Math.abs(max_time.getTime() - min_time.getTime()))));						
													System.out.println("Halt Time "+halt_time);	
													
													lat_subString=lat_value.substring(0,4);
																								
													sub_Str_cnt++;
														
											//-------------- fuel calculation ---------------------------//
											              System.out.println("before calculation s_fuel: "+start_fuel+"  end_fuel   "+end_fuel);
											           start_fuel =start_fuel_per * fuelCapacity;
													   end_fuel = end_fuel_per * fuelCapacity;
														
											//----------------Putting all the values in map--------------//		
															
															System.out.println("latitude value is :"+lat_value+"Long vlaue : "+long_value +" start lat is  :"+start_lat );
															System.out.println(" Start Fuel :::::::::::::::::"+start_fuel+" End fuel ::::::: "+end_fuel);															
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
															start_fuel = end_fuel;
															
															
													if(des_sub_lat.equals(lat_subString)){   
												/** It gives exact location we don't skip exact location 
													so we took next count of this loop.(By this we can get exact location)
													
												*/	
														
														System.out.println("destination sub lat .equals of lat substrig"+lat_subString+"  Count is  :"+sub_Str_cnt);														
														equalCount.add(sub_Str_cnt+1);
														sub_String_cnt =  equalCount.get(0);
														System.out.println("SubString count-------------------++++++++++++++"+sub_String_cnt);														
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
						
						//System.out.println("Sub String count inside while loooooooooooooop :"+sub_String_cnt);
						Set keys = haltTimeMap.keySet();		
						Iterator it = keys.iterator();
						while(it.hasNext())
						{								
							String t=(String)it.next();
							
							lat_subString=t.substring(0,4);
							lat_subString= lat_subString.substring(0,4);           													
							  if(sub_String_cnt  == whilecounter ){							
									break;
								}  
						 
							
							 else{			//------Stop Condition--------//
								
								 List lt = (List)haltTimeMap.get(t); 	
								Iterator litr = lt.iterator();
								
										while(litr.hasNext())
										{	Map hm = (Map)litr.next();																					
										whilecounter++;
										
											if(whilecounter == sub_String_cnt ){  
												halt_time="Stoped";
												hm.put("halt_time",halt_time);
											}		
										   // System.out.println("inside iteration "+lat_subString);
											starttime =df.format(hm.get("start_time"));
											minimum_time = df.format(hm.get("min_time"));
											//System.out.println("Min time :"+minimum_time);											
											//System.out.println("Halt time values in hash table :"+hm.get("halt_time"));											
											
											
											
											
											//-------------------------------Printing All the values into one way table-----------------------//
											 %>
												<tbody >
												<tr>
												<%-- <td align="left" class="report_border" > <%=lat_value %> , <%= long_value %></td> --%>
												<td  align="left" class="report_border" id="msg<%=count %>" style="width: 30%;  background: #f9f7f5;"><input type="hidden" class="latlng" id="startPlace" name="startPlace" value="<%=hm.get("start_lat") %> , <%= hm.get("start_lng") %>"/></td>			  
												<%-- <td  align="left" class="report_border" id="ms<%=count %>" style="width: 10%;"> --%>
												<td align="left" class="report_border" style="width: 12%;"> <%= starttime %></td>
												<td  align="left" class="report_border" id="msg1<%=count %>" style="width: 30%;  background: #f9f7f5;"><input type="hidden" class="latlan" id="place" name="place" value="<%=hm.get("lat_value") %> , <%= hm.get("long_value") %>"/></td>
												<td align="left" class="report_border" style="width: 12%;"> <%= minimum_time %></td>										 
												<td align="left" class="report_border" style=" width:38%;  background: #f9f7f5;"><%= hm.get("halt_time") %></td>
												<td align="left" class="report_border" id="dis<%=count %>" style="padding-left: 10px; width:12%" ></td>			
												<%-- <td  align="left" class="report_border" id="msg<%=count %>" style="width: 10%;">
												<td  align="left" class="report_border" id="msg<%=count %>" style="width: 10%;">
												 --%>
												</tr>
												</tbody>
												<%
											
											count++;		
						                 }//last while
						            }// if not equal
							
						       } //map iterate while
						    	String one_way_last_time = minimum_time;
						       	session.setAttribute("one_way_last_time", one_way_last_time);
						        System.out.println("Min time  (Final time of report):"+one_way_last_time);
								System.out.println("Same place Halt time "+haltTimeMap);
							
							
						
						
						con.close();
						rs1.close();
						stmt1.close();
						rs2.close();					
						rs3.close();				
						}//try												
						catch(NumberFormatException e){ 
							//e.printStackTrace();
							//System.out.println(e.getMessage());
							//return;
						} 	
		    }
						%>
						
						</table> 
						<table width="245px" class="tableclsnew">
				
								<tr>
								<td style="width:100px;"> Total Distance Travelled :</td>
								<td id ="totalDis" style="width:50px;" class="bold" ></td>	
								</tr>
								
						
						
				</table>
						
			</div>
		</form>
		
		
					
	</body>																													
						<!-- Return way Table include here -->
												
																								
				 	<jsp:include page="cons_Return_Report.jsp" /> 
						
			
					 	
						
						</html>
						