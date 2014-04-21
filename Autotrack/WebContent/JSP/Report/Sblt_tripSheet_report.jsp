			<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
			    pageEncoding="ISO-8859-1"%>
			    <%@page import="java.util.Date"  %>
			    <%@page import="java.text.SimpleDateFormat" %>
			    <%@page import="java.text.DateFormat" %>
			    <%@page import="java.text.ParseException"%>
			    <%@page import="java.util.Calendar" %>
			    <%@page import = "java.sql.Connection" %>
			    <%@page import = "java.sql.Statement" %>
			    <%@page import = "java.sql.ResultSet" %>
			    <%@page errorPage="errorpage.jsp" %>
			    <%@page import = "com.ts.dbtransactionmgr.DBTransaction" %>
			    <%@page errorPage="errorpage.jsp" %>

			<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
			
			<%!
			int count=0;
			String counter="";
			int rowcount=0;
			%>
			
			<html>
			<head>
			<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
			 <link rel="stylesheet" type="text/css" href="../../CSS/style.css" />
			  <script type="text/javascript" src="../../JS/validate.js"></script>
			  <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=AIzaSyCy1B2Bb7sCN7elKT_nUkcwfLkmUoT442M" type="text/javascript"></script>
			<title>SBLT Trip Sheet </title>
			
			</head>
			<script type="text/javascript">

			
			function redirect_to_pdf()
			{
								
				/* document.getElementById("vehicle_type").disabled=false;
				document.getElementById("vehicle_number").disabled=false;
				document.getElementById("date_time").disabled=false;
				
				document.getElementById("client").disabled=false;
				document.getElementById("order").disabled=false;		
				document.getElementById("boarding").disabled=false;		
				document.getElementById("driverName").disabled=false;		
				document.getElementById("opening").disabled=false;		
				document.getElementById("openingKm").disabled=false;		
				document.getElementById("close").disabled=false;		
				document.getElementById("ClosingKm").disabled=false;
				
		        
				document.getElementById("hire").disabled=false;	
				document.getElementById("hireP").disabled=false;		
				document.getElementById("e_hour").disabled=false;		
				document.getElementById("e_hourP").disabled=false;		
				document.getElementById("running_km").disabled=false;		
				document.getElementById("running_kmP").disabled=false;		
				document.getElementById("excess_km").disabled=false;		
				document.getElementById("excess_kmP").disabled=false;		
				
				document.getElementById("betta").disabled=false;		
				document.getElementById("bettaP").disabled=false;		
				document.getElementById("permit").disabled=false;		
				document.getElementById("permitP").disabled=false;
				
				document.getElementById("night_halt").disabled=false;
				document.getElementById("night_haltP").disabled=false;
				document.getElementById("hillsCharge").disabled=false;
				document.getElementById("hillsChargeP").disabled=false;
				document.getElementById("parking").disabled=false;
				document.getElementById("parkingP").disabled=false; */
				document.trans_trip_Sheet_report.action="Sblt_Cons_TripSheet_PDF.jsp";
				document.trans_trip_Sheet_report.submit();   
				
				}
			
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
			
			function previous(count){
				var counter = parseInt(count);
		//		alert(counter);
			//	alert("previous button");
				//var counter='<%=count-1%>';
				
				 var date_time=document.getElementById("date_time").value;
		         var vehicle_number=document.getElementById("vehicle_number").value;
				counter=counter-1;
				
				 document.trans_trip_Sheet_report.action="../Report/Sblt_tripSheet_report.jsp?offset="+counter+"&vehicle_number="+vehicle_number+"&sblt_trip_date="+date_time+"";//it go to controllerservlet and after that it go to LoginService
					document.trans_trip_Sheet_report.submit();
					
			}
			function next(count){
				var counter = parseInt(count);			
		     	counter=counter+1;
		    var date_time=document.getElementById("date_time").value;
		    var vehicle_number=document.getElementById("vehicle_number").value;
		    
				//alert( "Next counter +1 = "+counter);						
				 document.trans_trip_Sheet_report.action="../Report/Sblt_tripSheet_report.jsp?offset="+counter+"&vehicle_number="+vehicle_number+"&sblt_trip_date="+date_time+" ";// it go to controllerservlet and after that it go to LoginService
				document.trans_trip_Sheet_report.submit();
				
				
			}		
						
			</script>
			<body>
			<%
			   boolean value= true;
			   counter=request.getParameter("offset");
			   System.out.println("Counter is Starting condition : "+counter);
			   
			   if(counter==null)
				{
					count=0;
					System.out.println("counter= "+count+"");
				}
				else
				{
					count=Integer.parseInt(counter);
					System.out.println("else counter= "+count+"");
					if(count<0)
						count=0;
					
				}	 
					
					
					String dateTime = request.getParameter("sblt_trip_date"); 
					
					String vehicle_no= request.getParameter("vehicle_number");
					System.out.println("date time : "+dateTime +"  vehicle number :" +vehicle_no);		
					String vehicle_type="";
					String ac="";
					String db_datetime="";
					String client="";
					String orderBy="";
					String boardingPoint="";
					String driverName="";
					String openingtime="";
					String openingkm="";
					String closingtime="";
					String closingkm="";
					String coverage="";
					String hire ="";
					String hireP ="";
					String e_hour ="";
					String e_hourP ="";
					String running_km ="";
					String running_kmP ="";
					String excess_km ="";
					String excess_kmP ="";
					String betta ="";
					String bettaP ="";
					String permit ="";
					String permitP ="";
					String night_halt ="";
					String night_haltP ="";
					String hillsCharge ="";
					String hillsChargeP="";
					String parking="";
					String parkingP="";
					
					String open_km="";
					String close_km="";
					String travelled_km="";
					String payment="";
					
				    String str_hire="";String str_e_hour="";String str_running_km="";String str_excess_km="";String str_betta="";String str_permit="";String str_nightHalt="";String str_hillscharge="";String str_parking="";String str_totalCost ="";
					String str_hireP="";String str_e_hourP="";String str_running_kmP="";String str_excess_kmP="";String str_bettaP=""; String str_permitP="";String str_nightHaltP="";String str_hillschargeP="";String str_parkingP="";String str_totalP="";
					ResultSet rs=null;
					Statement st=null;
					Connection con=null;
					
					try{
						DBTransaction dbtrans = new DBTransaction();
						con = dbtrans.connect();
						st= con.createStatement();
						String selectQuery = "select * from trans_trip_sheet where date_time >='"+dateTime+"' and vehicle_number='"+vehicle_no+"' order by date_time limit 1 offset "+count+"";
						System.out.println("select Query :"+selectQuery);
						rs = st.executeQuery(selectQuery);
						if(rs.next()){
							System.out.println("if condtion");
						}
						else{
							int a=10;
							a=a/0;
						}
						
						rs = st.executeQuery(selectQuery);
						while(rs.next()){							
							vehicle_type = rs.getString("vehicle_type");
							//sheet_pdf.setVehicle_type(vehicle_type);
							db_datetime = rs.getString("date_time");
							ac = rs.getString("ac_nonac");
							//sheet_pdf.setAc(ac);
							client = rs.getString("client");
							////sheet_pdf.setClient(client);
							orderBy = rs.getString("orderby");
							//sheet_pdf.setOrderBy(orderBy);
							boardingPoint = rs.getString("boarding_point");
							//sheet_pdf.setBoardingPoint(boardingPoint);
							openingtime = rs.getString("starting_date_time");
							//sheet_pdf.setOpeningtime(openingtime);
							open_km = rs.getString("starting_km");
							//sheet_pdf.setOpen_km(open_km);												
							closingtime = rs.getString("end_date_time");
							//sheet_pdf.setClosingtime(closingtime);
							close_km = rs.getString("end_km");
							//sheet_pdf.setClose_km(close_km);
													
							str_hire = rs.getString("hire_charge");		
							//sheet_pdf.setStr_hire(str_hire);
							str_e_hour = rs.getString("excess_hours");
							//sheet_pdf.setStr_e_hour(str_e_hour);
							str_running_km = rs.getString("running_km_charge");
							//sheet_pdf.setStr_running_km(str_running_km);
							str_excess_km = rs.getString("excess_km_charge");
							//sheet_pdf.setStr_excess_km(str_excess_km);
							str_betta = rs.getString("driver_betta");
							//sheet_pdf.setStr_betta(str_betta);
							str_permit = rs.getString("permit_cost");
							//sheet_pdf.setStr_permit(str_permit);
							str_nightHalt = rs.getString("night_halt");
							//sheet_pdf.setStr_nightHalt(str_nightHalt);
							str_hillscharge = rs.getString("hills_charge");
							//sheet_pdf.setStr_hillscharge(str_hillscharge);
							str_parking = rs.getString("parking_others");
							travelled_km = rs.getString("total_km");
							//sheet_pdf.setTravelled_km(travelled_km);
													
							session.setAttribute("coverage",travelled_km);
							
							str_hireP = rs.getString("hire_charge_pi");
							//sheet_pdf.setStr_hireP(str_hireP);
							str_e_hourP = rs.getString("excess_hours_pi");
							//sheet_pdf.setStr_e_hourP(str_e_hourP);
							str_running_kmP = rs.getString("running_km_charge_pi");
							//sheet_pdf.setStr_running_kmP(str_running_kmP);
							str_bettaP = rs.getString("driver_betta_pi");
							//sheet_pdf.setStr_bettaP(str_bettaP);
							str_permitP = rs.getString("permit_cost_pi");
							//sheet_pdf.setStr_permitP(str_permitP);
							str_nightHaltP = rs.getString("night_halt_pi");
							//sheet_pdf.setStr_nightHaltP(str_nightHaltP);
							str_hillschargeP = rs.getString("hills_charge_pi");
							//sheet_pdf.setStr_hillschargeP(str_hillschargeP);
							str_parkingP = rs.getString("parking_others_pi");
							//sheet_pdf.setStr_parkingP(str_parkingP);
							driverName = rs.getString("driver_name");
							//sheet_pdf.setDriverName(driverName);
							str_excess_kmP = rs.getString("excess_km_pi");
							//sheet_pdf.setStr_excess_kmP(str_excess_kmP);
							payment = rs.getString("total_cost");
							//sheet_pdf.setPayment(payment);		
							
							session.setAttribute("payment",payment);
							
						}
						
						
					}
				catch(SQLException e){
					e.printStackTrace();
				}
			%>
			
			<form name="trans_trip_Sheet_report" method="post" accept-charset="utf-8">
			
				
				<!--  String selectQuery = "select * from trans_trip_sheet where vehicle_number='"+vehicle_no+"' and date_time='"+datetime1+"'";
				System.out.println("selectQuery :"+selectQuery);
				ResultSet rs=st.executeQuery(selectQuery);  -->
				<div class="content_bg"><span class="content_headning">SBLT Trip Sheet</span></div>
		
		
		<div class="sbltcenter">
		<div class="sbltlogoleft"><img src="../../images/sblt.png"></div>
		<div class="sbltlogoright">
		<div class="sbltheading">Sri Bhagiyalakshmi Tours & Travels</div>
		No.124, P.H. Road, Kellys, Chennai - 10.<br/>Tourist Buses, Staff Buses, Maxi Cabs, Tempo Traveller, Innova, Qualis Travera, Indica A/c & Non A/c<br/> Phone No : 26425412 / 42661232 / 42175768
		</div>
		</div>	
				
				
		<div class="sbltcenter_new">
		<table cellpadding="0" cellspacing="0" border="0" style="width:100%;" id="trip_sheet_vehicle">
		
		
		
		<tr>
		<td>Type of Vehicle</td>
			<td class='blue' ><input type="text" id="vehicle_type" name="vehicle_type" value="<%=vehicle_type %>" readonly="readonly"/> </td>
				
				<%-- <td id="ac"><%=ac %></td> --%>
				
				<%if(ac.equals("Ac")){ %>
		            <td><input name="ac" type="radio"  id="ac" value="Ac" checked="checked"/>A/C
					<input name="ac" type="radio"  id="Nonac" value="Non Ac"/>Non A/C </td>
			<%} %> 			
				<%if(ac.equals("Non Ac")){ %>
				 <td><input name="ac" type="radio"  id="ac" value="Ac" />A/C
					<input name="ac" type="radio"  id="Nonac" value="Non Ac" checked="checked"/>Non A/C </td>
			<%} %> 
			
				
				<td>Vehicle No:<input type="text" id="vehicle_number" name="vehicle_number" value="<%=vehicle_no %>" readonly="readonly"/></td>
				<td>Date: <input type="text" id="date_time" name="date_time" value="<%=db_datetime %>" readonly="readonly"/></td> 
					</tr>
		</table>
		</div>
			
			<div class="twomaindiv">
		<div class="twomaindivleft">
		
		<div class="twomaindivleftinner">
		<div class="splitleft">Client</div>
		<div class="splitright"><textarea name="client" cols="" rows="" style="width:200px; border:1px solid #6fbaf3;" id="client" readonly="readonly"><%=client%></textarea></div>
		</div>
		
		<div class="twomaindivleftinner">
		<div class="splitleft">Boarding Point</div>
		<div class="splitright"><input name="boarding" id="boarding" type="text" style="width:200px; height:22px; border:1px solid #6fbaf3;" value="<%=boardingPoint %>" readonly="readonly" /></div>
		</div>
		
		<div class="twomaindivleftinner">
		<div class="splitleft">Ordered by</div>
		<div class="splitright"><input name="order" type="text" style="width:200px; height:22px; border:1px solid #6fbaf3;"  id="order" value="<%=orderBy%>" readonly="readonly"/></div>
		</div>
		
		<div class="twomaindivleftinner">
		<div class="splitleft">Driver Name</div>
		<div class="splitright"><input name="driverName" id="driverName" type="text" style="width:200px; height:22px; border:1px solid #6fbaf3;"   value="<%=driverName%>"readonly="readonly" /></div>
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
		<input  type="Text" id="opening"  size="17" name="opening" value="<%=openingtime%>" readonly="readonly" ></td>
		
		<!-- <td><input name="" type="text" style="width:100px; height:15px;" /></td> -->
		<td><input type="text" style="width:100px; height:15px; text-align: center;"  id="openingKm" name="openingKm" onchange="distanceCalculation()" value="<%=open_km%>" readonly="readonly"/></td>
		</tr>
		
		<tr>
		<td>Closing</td>
		<td>
		<input  type="Text" id="close"  size="17" name="close" style="text-align:left;"  value="<%=closingtime%>" readonly="readonly"></td>
		
		<!-- <td><input name="" type="text" style="width:100px; height:15px;" /></td> -->
		<td><input  type="text" style="width:100px; height:15px; text-align: center;" id="ClosingKm" name="ClosingKm"  onchange="distanceCalculation()"  value="<%=close_km%>" readonly="readonly"/></td>
		</tr>
		
		<tr>
		<td>Coverage</td>
		<td colspan="2"  id="coverage" style="text-align:left; padding:0px 0px 0px 247px;" ><%=travelled_km %></td>
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
		<td style="width:100px;"><input name="hire" id="hire" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=str_hire%>" readonly="readonly" /></td>
		<td><input name="hireP" id="hireP"  type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=str_hireP%>" readonly="readonly"/></td>
		</tr>
		
		<tr>
		<td>Excess Hours</td>
		<td><input name="e_hour" id="e_hour" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=str_e_hour %>" readonly="readonly"/></td>
		<td><input name="e_hourP" id="e_hourP" type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()"  value="<%=str_e_hourP %>" readonly="readonly"/></td>
		</tr>
		
		<tr>
		<td>Running KM Charge</td>
		<td><input name="running_km" id="running_km" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=str_running_km %>" readonly="readonly"/></td>
		<td><input name="running_kmP" id="running_kmP" type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=str_running_kmP %>" readonly="readonly"/></td>
		</tr>
		
		<tr>
		<td>Excess KM Charge</td>
		<td><input name="excess_km" id="excess_km" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=str_excess_km %>" readonly="readonly"/></td>
		<td><input name="excess_kmP" id="excess_kmP" type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=str_excess_kmP %>" readonly="readonly"/></td>
		</tr>
		
		<tr>
		<td>Driver Batta</td>
		<td><input name="betta" id="betta" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=str_betta%>" readonly="readonly"/></td>
		<td><input name="bettaP" id="bettaP" type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=str_bettaP %>" readonly="readonly"/></td>
		</tr>
		
		<tr>
		<td>Permit Cost</td>
		<td><input name="permit" id="permit" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=str_permit %>" readonly="readonly"/></td>
		<td><input name="permitP" id="permitP" type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=str_permitP %>" readonly="readonly"/></td>
		</tr>
		
		<tr>
		<td>Night Halt</td>
		<td><input name="night_halt" id="night_halt" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=str_nightHalt %>" readonly="readonly"/></td>
		<td><input name="night_haltP" id="night_haltP" type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=str_nightHaltP %>" readonly="readonly"/></td>
		</tr>
		
		<tr>
		<td>Hills Charge</td>
		<td><input name="hillsCharge" id="hillsCharge" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=str_hillscharge %>" readonly="readonly"/></td>
		<td><input name="hillsChargeP" id="hillsChargeP" type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=str_hillschargeP %>" readonly="readonly"/></td>
		</tr>
		
		<tr>
		<td>Parking / Others</td>
		<td><input name="parking" id="parking" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=str_parking %>" readonly="readonly"/></td>
		<td><input name="parkingP" id="parkingP" type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=str_parkingP %>" readonly="readonly"/></td>
		</tr>
		
		<tr>
		<td><span>Total</span></td>
		<td  colspan="2" style="width:200px; height:15px; text-align:center; color:#000000;" id="totalCost" ><%=payment%></td>
				<%--  <%
				rowcount++;
				%>  --%>
		</tr>
		
		</table>
		
		
		
		<div class="sealtext">For Sri Bhagiyalakshmi Tours & Travels</div>
		
		<div class="sealtextnew">Manager</div>
		
		</div>
			
			
			<table  style="margin:0px 0px 0px 15px;" width="98%">
					 <tr>
					
						 <%
					 		if(count!=0){
					 			
						 %>
						<td style="width:97%"><input type ="image" src="../../images/previous.png" value="Previous" name="Previous" style="float:right; " onclick="previous('<%=count%>')"></td>
						<%
							}
					 		else
					 		{
					 	%>
					 	<td style="width:97%"><img src="../../images/previousdull.PNG" style="float:right; "></td>
					 	<%
					 		}
						 if(rowcount!=1){
							
						%>
						
						<td><input type ="image" src="../../images/next.png" value="Next" name="Next" style="float:right;" onclick="next('<%=count%>')"></td>
						<%
							}
						 else
						 {
							%>
						<td><img src="../../images/nextdull.png"  style="float:right;"></td>
						<%
							}
					 	%>
					</tr>
				</table>
			<center>
		<!-- <a href="javaScript:redirect_to_Back()"><img src="../../images/back.png"></a>  -->
<!-- 		<a href="javaScript:edit()"><img src="../../images/edit_btn.png"></a> 
		<a href="javaScript:update()"><img src="../../images/update.png"></a> -->
		<a href="javaScript:redirect_to_pdf()"><img src="../../images/export_pdf.png"></a>
    	</center> 
			</form>
			</body>
			</html>