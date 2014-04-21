	<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	    pageEncoding="ISO-8859-1"%>
	<!DOCTYPE html >
	<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
	</head>
	
	<title>Autotrack</title> 
	
	<link rel="stylesheet" type="text/css" href="../CSS/style.css" />
	<script type="text/javascript" src="../JS/validate.js"></script>
	
	<script language="javascript" type="text/javascript" src="../JS/datetimepicker_css.js"></script>
	 <link rel="stylesheet" type="text/css" href="../CSS/style.css" /> 
	<body>
	
	
	<script type="text/javascript">
	
		function distanceCalculation(){	
			var startkm=document.getElementById("openingKm").value;
			var endkm=document.getElementById("ClosingKm").value;
			var total= endkm - startkm ;
			if(total < 0){
				alert("Please Enter ClosingKM is greater than openingKM");
				return false;
			}
			document.getElementById("coverage").innerHTML=total;
		}
		
		function distanceCal(){	
			var startkm=document.getElementById("openingKm").value;
			var endkm=document.getElementById("ClosingKm").value;
			var total= endkm - startkm ;
			if(total < 0){
				document.getElementById("coverage").innerHTML=0;
				return false;
			}
			
		}
		
		
		function totalCost(){
			
			/*  */
		
			                          
			                           
			                           
			var hire = document.getElementById("hire").value;		
			var hireP= document.getElementById("hireP").value;		
			var e_hour = document.getElementById("e_hour").value;		
			var e_hourP = document.getElementById("e_hourP").value;		
			var running_km = document.getElementById("running_km").value;		
			var running_kmP = document.getElementById("running_kmP").value;		
			var excess_km = document.getElementById("excess_km").value;		
			var excess_kmP = document.getElementById("excess_kmP").value;		
			
			var betta = document.getElementById("betta").value;		
			var bettaP = document.getElementById("bettaP").value;		
			var permit = document.getElementById("permit").value;		
			var permitP = document.getElementById("permitP").value;
			
			var night_halt = document.getElementById("night_halt").value;
			var night_haltP = document.getElementById("night_haltP").value;
			var hillsCharge = document.getElementById("hillsCharge").value;
			var hillsChargeP = document.getElementById("hillsChargeP").value;
			var parking = document.getElementById("parking").value;
			var parkingP = document.getElementById("parkingP").value;
		
			var totalCost  = +hire+ + +e_hour+ + +running_km+ + +excess_km+ + +betta+ + +permit+ + +night_halt+ + +hillsCharge+ + +parking ; 
			//alert("total cost" +totalCost);
			var totalpaise =+hireP+ + +e_hourP+ + +running_kmP+ + +excess_kmP+ + +bettaP+ + +permitP+ + +night_haltP+ + +hillsChargeP+ + +parkingP;
			
				totalCost=totalCost+totalpaise;
			
			document.getElementById("totalCost").innerHTML =totalCost; 
			document.getElementById("totalpaise").innerHTML =totalpaise;
			
		}
		function save(){
			//---------------------------- Validation------------------------------//
			
			if(tripSheet()){
				
				if(document.getElementById("ac").checked == true){
				ac=document.getElementById("ac").value;
				}
				else if(document.getElementById("ac").checked == false){
					ac=document.getElementById("Nonac").value;
				}
					
			/* var vehicle_number = document.getElementById("vehicle_number").value;		
			var date_time = document.getElementById("date_time").value;		
			var client = document.getElementById("client").value;			
			var order = document.getElementById("order").value;		
			var boarding = document.getElementById("boarding").value;		
			var driverName = document.getElementById("driverName").value;		
			var opening = document.getElementById("opening").value;		
			var open_km = document.getElementById("openingKm").value;		
			var close = document.getElementById("close").value;		
			var close_km = document.getElementById("ClosingKm").value;		
			var coverage = document.getElementById("coverage").innerHTML; */
			
			document.transTripSheet.action="MGMT_Consolidated_insertRecord.jsp";		
			
			document.transTripSheet.submit();
			}
			//return false;
			}
		function reset(){
			document.getElementById("transTripSheet").reset();
		}
	
		
			
		
		
		
	
	</script>
	
	<form name="transTripSheet" id="transTripSheet">
	<div class="content_bg"><span class="content_headning">SBLT Trip Sheet</span></div>
	
	
	<div class="sbltcenter">
	<div class="sbltlogoleft"><img src="../images/sblt.png"></div>
	<div class="sbltlogoright">
	<div class="sbltheading">Sri Bhagiyalakshmi Tours & Travels</div>
	No.124, P.H. Road, Kellys, Chennai - 10.<br/>Tourist Buses, Staff Buses, Maxi Cabs, Tempo Traveller, Innova, Qualis Travera, Indica A/c & Non A/c<br/> Phone No : 26425412 / 42661232 / 42175768
	</div>
	</div>
	
	<div class="sbltcenter_new">
	<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
	
	
	
	<tr>
	<td>Type of Vehicle</td>
	<!-- <td><input name="" type="text" style="width:200px;" /></td> -->
	
	<td>
														<%@ page import="com.ts.service.dropdown"%>
														<%@ page import="java.util.ArrayList"%> 
														<%@ page import="java.util.*"%>
														<%
														String belongs = (String) session.getAttribute("belongs");
														dropdown up= new dropdown();
														TreeMap<String,String> tm= up.getVehicleType(belongs);												
														Set set1 = tm.entrySet();
														Iterator itr = set1.iterator();
														out.println("<select name='vehicle_type' class='tb' id='vehicle_type' style='width: 150px;'>");
														while(itr.hasNext()){
															Map.Entry me = (Map.Entry) itr.next();
													 		out.println("<option class='blue' value=\"" + me.getKey()+ "\">" + me.getKey() + "</option>");
														}
													 	out.println("</select>");
														 
														 %>
														
														
														
														</td>
	
	
	
	<td><input name="ac" type="radio"  id="ac" value="Ac" checked="checked"/>A/C
		<input name="ac" type="radio"  id="Nonac" value="Non Ac"/>Non A/C </td>
	
	
	<td>Vehicle No</td>
	<!-- <td><input name="" type="text" /></td> -->
	<td>
														<%@ page import="com.ts.service.dropdown"%>
														<%@ page import="java.util.ArrayList"%> 
														<%@ page import="java.util.*"%>
														<%
														String belongs1 = (String) session.getAttribute("belongs");
														dropdown up1= new dropdown();
														TreeMap<String,String> tm1= up1.getName(belongs1);												
														Set set11 = tm1.entrySet();
														Iterator itr1 = set11.iterator();
														out.println("<select name='vehicle_number' id='vehicle_number' >");
														while(itr1.hasNext()){
															Map.Entry me = (Map.Entry) itr1.next();
													 		out.println("<option class='blue' value=\"" + me.getKey()+ "\">" + me.getKey() + "</option>");
														}
														out.println("</select>");
														 
														 %>
																																							
														</td>
	
	
	
	
	<td>Date & Time</td>
	<!-- <td><input name="" type="text" style="width:100px;" /></td> -->
	<td>
					<a	href="javascript:NewCssCal('date_time','yyyyMMdd','dropdown',true,'24')"><img
							src="../images/calendar_icon.gif" width="16" height="16"
							border="0" alt="Pick a date"></a>&nbsp;<input  type="Text" id="date_time"  size="17" name="date_time" readonly="readonly"></td>
	
	
	</tr>
	</table>
	</div>
	
	<div class="twomaindiv">
	<div class="twomaindivleft">
	
	<div class="twomaindivleftinner">
	<div class="splitleft">Client</div>
	<div class="splitright"><textarea name="client" cols="" rows="" style="width:200px; border:1px solid #6fbaf3;" id="client"></textarea></div>
	</div>
	
	<div class="twomaindivleftinner">
	<div class="splitleft">Boarding Point</div>
	<div class="splitright"><input name="boarding" id="boarding" type="text" style="width:200px; height:22px; border:1px solid #6fbaf3;" /></div>
	</div>
	
	<div class="twomaindivleftinner">
	<div class="splitleft">Ordered by</div>
	<div class="splitright"><input name="order" type="text" style="width:200px; height:22px; border:1px solid #6fbaf3;"  id="order" value=""/></div>
	</div>
	
	<div class="twomaindivleftinner">
	<div class="splitleft">Driver Name</div>
	<div class="splitright"><input name="driverName" id="driverName" type="text" style="width:200px; height:22px; border:1px solid #6fbaf3;" /></div>
	</div>
	
	<div class="twomaindivleftinner">
	<table cellpadding="0" cellspacing="0" width="100%"  style="" class="sblttablecls">
	<tr>
	<th style="width:25%;">Particulars</th>
	<th style="width:25%;">Date & Time</th>
	<th style="width:25%;">Kilometers</th>
	</tr>
	
	<tr>
	<td>Opening</td>
	<td>
	<a	href="javascript:NewCssCal('opening','yyyyMMdd','dropdown',true,'24')"><img
							src="../images/calendar_icon.gif" width="16" height="16"
							border="0" alt="Pick a date"></a>&nbsp;<input  type="Text" id="opening"  size="17" name="opening" readonly="readonly"></td>
	
	<!-- <td><input name="" type="text" style="width:100px; height:15px;" /></td> -->
	<td><input type="text" style="width:100px; height:15px; text-align: center;"  id="openingKm" name="openingKm" onchange="distanceCal() "/></td>
	</tr>
	
	<tr>
	<td>Closing</td>
	<td>
	<a	href="javascript:NewCssCal('close','yyyyMMdd','dropdown',true,'24')"><img
							src="../images/calendar_icon.gif" width="16" height="16"
							border="0" alt="Pick a date"></a>&nbsp;<input  type="Text" id="close"  size="17" name="close" readonly="readonly"></td>
	
	<!-- <td><input name="" type="text" style="width:100px; height:15px;" /></td> -->
	<td><input  type="text" style="width:100px; height:15px; text-align: center;" id="ClosingKm" name="ClosingKm"  onchange="distanceCalculation()"/></td>
	</tr>
	
	<tr>
	<td>Coverage</td>
	<td colspan="2"  id="coverage" style="text-align:left; padding:0px 0px 0px 205px; "  ></td>
	</tr>
	
	<tr>
	<td colspan="2">Party 's Signature <br/><br/><br/></td>
	<td colspan="2">Driver's Signature <br/><br/><br/></td>
	</tr>
	
	</table><br/>
	
	<div>1. Kms and time will be calculated from shed to shed.</div>
	<div>2. Interstate entrance Tax, Parking Charges etc. Should be given by the Passengers.</div>
	<div>3. In outstation trips minimum 250km per day average will be charged.</div>
	</div>
	
	
	
	
	</div><br/>
	
	
	<div class="twomaindivright">
	
	<table cellpadding="0" cellspacing="0" width="100%"  style="" class="sblttablecls">
	
	<tr>
	<th>Details</th>
	<th>Rs.</th>
	<th>P.</th>
	</tr>
	
	<tr>
	<td style="width:300px;">Hire Changes</td>
	<td style="width:100px;"><input name="hire" id="hire" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="0" /></td>
	<td><input name="hireP" id="hireP"  type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()" value="0.0"/></td>
	</tr>
	
	<tr>
	<td>Excess Hours</td>
	<td><input name="e_hour" id="e_hour" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="0"/></td>
	<td><input name="e_hourP" id="e_hourP" type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()"  value="0.0"/></td>
	</tr>
	
	<tr>
	<td>Running KM Charge</td>
	<td><input name="running_km" id="running_km" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="0"/></td>
	<td><input name="running_kmP" id="running_kmP" type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()" value="0.0"/></td>
	</tr>
	
	<tr>
	<td>Excess KM Charge</td>
	<td><input name="excess_km" id="excess_km" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="0"/></td>
	<td><input name="excess_kmP" id="excess_kmP" type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()" value="0.0"/></td>
	</tr>
	
	<tr>
	<td>Driver Batta</td>
	<td><input name="betta" id="betta" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="0"/></td>
	<td><input name="bettaP" id="bettaP" type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()" value="0.0"/></td>
	</tr>
	
	<tr>
	<td>Permit Cost</td>
	<td><input name="permit" id="permit" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="0"/></td>
	<td><input name="permitP" id="permitP" type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()" value="0.0"/></td>
	</tr>
	
	<tr>
	<td>Night Halt</td>
	<td><input name="night_halt" id="night_halt" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="0"/></td>
	<td><input name="night_haltP" id="night_haltP" type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()" value="0.0"/></td>
	</tr>
	
	<tr>
	<td>Hills Charge</td>
	<td><input name="hillsCharge" id="hillsCharge" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="0"/></td>
	<td><input name="hillsChargeP" id="hillsChargeP" type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()" value="0.0"/></td>
	</tr>
	
	<tr>
	<td>Parking / Others</td>
	<td><input name="parking" id="parking" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="0"/></td>
	<td><input name="parkingP" id="parkingP" type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()" value="0.0"/></td>
	</tr>
	
	<tr>
	<td><span>Total</span></td>
	<td  colspan="2" style="width:200px; height:15px; text-align:center; color:#000000;" id="totalCost" ></td>
	
	</tr>
	
	</table>
	
	
	
	<div class="sealtext">For Sri Bhagiyalakshmi Tours & Travels</div>
	
	<div class="sealtextnew">Manager</div>
	
	</div>
	
	<div class="sidcobtnmain">
	<!-- <div class="sidcobtnleft"><input name="" type="image" src="../images/savebtn.png"  onclick="save()" /></div> -->
	<input type="button" onclick="save()" value="Save"> 
	
	<input type="button" onclick="reset()" value="Clear">
	<!-- <div class="sidcobtnright"><input name="" type="image" src="../images/clear_btn.png" onclick="reset()" /></div> -->
	
	</div>
	
	
	
	</div>
	
	
	
	</form>
	</body>
	</html>
