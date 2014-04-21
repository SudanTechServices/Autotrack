	<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	    pageEncoding="ISO-8859-1"%>
	    
	    <%@page import="java.util.Date"  %>
	    <%@page import="java.text.SimpleDateFormat" %>
	    <%@page import="java.text.DateFormat" %>
	    <%@page import="java.util.Calendar" %>
	    <%@page import = "java.sql.Connection" %>
	    <%@page import = "java.sql.Statement" %>
	    <%@page import = "java.sql.ResultSet" %>
	    <%@page errorPage="errorpage.jsp" %>
	    <%@page import = "com.ts.dbtransactionmgr.DBTransaction" %>
	    
	    
	    
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<link rel="stylesheet" type="text/css" href="../CSS/style.css" /> 
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
	
	function totalCost(){                        
		                           
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

	</script>
		
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Update Record</title>
	</head>
	<body>
	<%
	
	
	
	String vehicle_no="";
	String datetime1="";
	String vehicle_type="";
	String ac="";
	//String datetime="";
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

	double open_km=0;
	double close_km=0;
	double travelled_km=0;
	double payment=0;
	
	   int int_hire,int_e_hour,int_running_km,int_excess_km,int_betta,int_permit,int_nightHalt,int_hillscharge,int_parking,int_totalCost;
	 float fl_hireP,fl_e_hourP,fl_running_kmP,fl_excess_kmP,fl_bettaP,fl_permitP,fl_nightHaltP,fl_hillschargeP,fl_parkingP,fl_totalP;
	 
	try{
	 vehicle_type = request.getParameter("vehicle_type");
	 System.out.println("driverName "+vehicle_type);
	 vehicle_no = request.getParameter("vehicle_number");
	 System.out.println("driverName "+vehicle_no);
	 
	 ac = request.getParameter("ac");
	 datetime1 = request.getParameter("date_time");
	 client = request.getParameter("client");
	 orderBy = request.getParameter("order");
	 boardingPoint = request.getParameter("boarding");
	 driverName = request.getParameter("driverName");
	 System.out.println("driverName "+driverName);
	 
	 openingtime = request.getParameter("opening"); 
	 System.out.println("opening time "+openingtime);
	 
	 openingkm = request.getParameter("openingKm");
	 System.out.println("opening time  "+openingkm);
	 
	 open_km=Double.parseDouble(openingkm);
	 System.out.println("opening time second  "+open_km);
	 
	 closingtime = request.getParameter("close");
	 System.out.println("closingtime is "+closingtime);
	 
	 closingkm = request.getParameter("ClosingKm");
	 close_km=Double.parseDouble(closingkm);
	
	 //-----------Calculate travel distance -----------------//
	 
	 travelled_km = close_km - open_km;
	 
	 //------------------------------------------------------//
	 System.out.println("Coverage km  is (Travelled km)::"+travelled_km );
	 
	 hire =request.getParameter("hire");
	 int_hire=Integer.parseInt(hire);
	 
	 hireP =request.getParameter("hireP");
	 fl_hireP=Float.parseFloat(hireP);
	 
	 e_hour =request.getParameter("e_hour");
	 int_e_hour=Integer.parseInt(e_hour);
	 
	 e_hourP =request.getParameter("e_hourP");
	 fl_e_hourP=Float.parseFloat(e_hourP);
	 
	 running_km =request.getParameter("running_km");
	 int_running_km=Integer.parseInt(running_km);
	 
	 running_kmP =request.getParameter("running_kmP");
	 fl_running_kmP=Float.parseFloat(running_kmP);
	 
	 
	 excess_km =request.getParameter("excess_km");
	 int_excess_km=Integer.parseInt(excess_km);
	 
	 excess_kmP =request.getParameter("excess_kmP");
	 fl_excess_kmP=Float.parseFloat(excess_kmP);
	 
	 
	 betta =request.getParameter("betta");
	 int_betta=Integer.parseInt(betta);
	 
	 bettaP =request.getParameter("bettaP");
	 fl_bettaP=Float.parseFloat(bettaP);
	 
	 
	 permit =request.getParameter("permit");
	 int_permit=Integer.parseInt(permit);
	 
	 permitP =request.getParameter("permitP");
	 fl_permitP=Float.parseFloat(permitP);
	 
	 
	 night_halt =request.getParameter("night_halt");
	 int_nightHalt=Integer.parseInt(night_halt);
	 
	 night_haltP =request.getParameter("night_haltP");
	 fl_nightHaltP=Float.parseFloat(night_haltP);
	 
	 
	 hillsCharge =request.getParameter("hillsCharge");
	 int_hillscharge=Integer.parseInt(hillsCharge);
	 
	 hillsChargeP =request.getParameter("hillsChargeP");
	 fl_hillschargeP=Float.parseFloat(hillsChargeP);
	 
	 parking =request.getParameter("parking");
	 int_parking=Integer.parseInt(parking);
	 
	 parkingP =request.getParameter("parkingP");
	 fl_parkingP=Float.parseFloat(parkingP);
	
	 
	
	 //---------------Calcuate total cost-------------------------//
	 
	 int_totalCost = +int_hire+ + +int_e_hour+ + +int_running_km+ + +int_excess_km+ + +int_betta+ + +int_permit+ + +int_nightHalt+ + +int_hillscharge+ + +int_parking ;
	 fl_totalP = +fl_hireP+ + +fl_e_hourP+ + +fl_running_kmP+ + +fl_excess_kmP+ + +fl_bettaP+ + +fl_permitP+ + +fl_nightHaltP+ + +fl_hillschargeP+ + +fl_parkingP ;
	 	 
	 payment = +int_totalCost+  +  +fl_totalP;
	 
	 //------------------------------------------------------------//
	 
	 System.out.println("total cost is :"+int_totalCost+"    paise is "+fl_totalP);
	 System.out.println("vehicle_type"+vehicle_type+" vehicle_no "+vehicle_no+"  ac"+ac+" datetime"+datetime1+" client  "+client+"orderBy "+orderBy+" boardingPoint "+boardingPoint+" driverName "+driverName+" openingtime "+openingtime+" openingkm "+openingkm +" closingtime "+closingtime+" closingkm " +closingkm+" coverage "+coverage+" hire "+hire+" e_hour "+e_hour+" running_km "+running_km+" excess_km "+excess_km+" betta "+betta+" permit "+permit+" night_halt "+night_halt+" hillsCharge "+hillsCharge+" parking "+parking+" hireP "+hireP+"hireP"+" e_hourP "+e_hourP+" running_kmP "+running_kmP+" excess_kmP "+excess_kmP+" bettaP "+bettaP+" permitP "+permitP+" night_haltP "+night_haltP+" hillsChargeP "+hillsChargeP+"parkingP"+parkingP);
	
	 //-----------------DB Inserting-----------------------//
	  
	 DBTransaction dbtrans =new DBTransaction();
	 Connection con = dbtrans.connect();
	 Statement st =con.createStatement();
	 //String Query ="insert into trans_trip_sheet values('"+vehicle_no+"','"+vehicle_type+"','"+ac+"','"+client+"','"+orderBy+"','"+datetime1+"','"+boardingPoint+"','"+openingtime+"',"+open_km+",'"+closingtime+"',"+close_km+","+int_hire+",                                                                                                                  "+int_e_hour+","+int_running_km+",                                    "+int_excess_km+","+int_betta+","+int_permit+",                         "+int_nightHalt+","+int_hillscharge+",                                             "+int_parking+","+travelled_km+","+fl_hireP+","+fl_e_hourP+",                                "+fl_running_kmP+",                                             "+fl_bettaP+","+fl_permitP+","+fl_nightHaltP+","+fl_hillschargeP+",                                                    "+fl_parkingP+",'"+driverName+"',"+fl_excess_kmP+","+payment+")";
	 String updateQuery= "update trans_trip_sheet set vehicle_type='"+vehicle_type+"',ac_nonac='"+ac+"',client='"+client+"',orderby ='"+orderBy+"',boarding_point='"+boardingPoint+"',starting_date_time='"+openingtime+"',starting_km="+open_km+",end_date_time='"+closingtime+"',end_km="+close_km+",hire_charge="+int_hire+",excess_hours="+int_e_hour+",running_km_charge="+int_running_km+",excess_km_charge="+int_excess_km+",driver_betta="+int_betta+",permit_cost="+int_permit+",night_halt="+int_nightHalt+",hills_charge="+int_hillscharge+",parking_others="+int_parking+",total_km="+travelled_km+",hire_charge_pi="+fl_hireP+",excess_hours_pi="+fl_e_hourP+",running_km_charge_pi="+fl_running_kmP+",driver_betta_pi="+fl_bettaP+",permit_cost_pi="+fl_permitP+",night_halt_pi="+fl_nightHaltP+",hills_charge_pi="+fl_hillschargeP+",parking_others_pi="+fl_parkingP+",driver_name='"+driverName+"',excess_km_pi="+fl_excess_kmP+",total_cost="+payment+" where vehicle_number='"+vehicle_no+"' and date_time='"+datetime1+"' ";
	 System.out.println("update query is :"+updateQuery);
	 
	 st.executeUpdate(updateQuery);
	 
	}
	catch(ClassCastException e){
		e.printStackTrace();
	}
	
	%>
	<center><h1 style="color: Green">Successfully Updated</h1></center>
	
		<form name="trans_trip_Sheet">
	
		
		<!--  String selectQuery = "select * from trans_trip_sheet where vehicle_number='"+vehicle_no+"' and date_time='"+datetime1+"'";
		System.out.println("selectQuery :"+selectQuery);
		ResultSet rs=st.executeQuery(selectQuery);  -->
		<div class="content_bg"><span class="content_headning">SBLT Trip Sheet</span></div>


<div class="sbltcenter">
<div class="sbltlogoleft"><img src="../images/sblt.png"></div>
<div class="sbltlogoright">
<div class="sbltheading">Sri Bhagiyalakshmi Tours & Travels</div>
No.124, P.H. Road, Kellys, Chennai - 10.<br/>Tourist Buses, Staff Buses, Maxi Cabs, Tempo Traveller, Innova, Qualis Travera, Indica A/c & Non A/c<br/> Phone No : 26425412 / 42661232 / 42175768
</div>
</div>	
		
		
<div class="sbltcenter_new">
<table cellpadding="0" cellspacing="0" border="0" style="width:100%;" id="trip_sheet_vehicle">



<tr>
<td>Type of Vehicle</td>
	<td class='blue' ><input type="text" id="vehicle_type" name="vehicle_type" value="<%=vehicle_type %>" disabled="disabled"/> </td>
		
		<%-- <td id="ac"><%=ac %></td> --%>
		
		<%if(ac.equals("Ac")){ %>
            <td><input name="ac" type="radio"  id="ac" value="Ac" checked="checked"/>A/C
			<input name="ac" type="radio"  id="Nonac" value="Non Ac"/>Non A/C </td>
	<%} %> 
	
		<%if(ac.equals("Non Ac")){ %>
		 <td><input name="ac" type="radio"  id="ac" value="Ac" />A/C
			<input name="ac" type="radio"  id="Nonac" value="Non Ac" checked="checked"/>Non A/C </td>
	<%} %> 
	
		
		<td>Vehicle No:<input type="text" id="vehicle_number" name="vehicle_number" value="<%=vehicle_no %>" disabled="disabled"/></td>
		<td>Date & Time: <input type="text" id="date_time" name="date_time" value="<%=datetime1 %>" disabled="disabled"/></td> 
			</tr>
</table>
</div>
	
	<div class="twomaindiv">
<div class="twomaindivleft">

<div class="twomaindivleftinner">
<div class="splitleft">Client</div>
<div class="splitright"><textarea name="client" cols="" rows="" style="width:200px; border:1px solid #6fbaf3;" id="client" disabled="disabled"><%=client%></textarea></div>
</div>

<div class="twomaindivleftinner">
<div class="splitleft">Boarding Point</div>
<div class="splitright"><input name="boarding" id="boarding" type="text" style="width:200px; height:22px; border:1px solid #6fbaf3;" value="<%=boardingPoint %>" disabled="disabled" /></div>
</div>

<div class="twomaindivleftinner">
<div class="splitleft">Ordered by</div>
<div class="splitright"><input name="order" type="text" style="width:200px; height:22px; border:1px solid #6fbaf3;"  id="order" value="<%=orderBy%>" disabled="disabled"/></div>
</div>

<div class="twomaindivleftinner">
<div class="splitleft">Driver Name</div>
<div class="splitright"><input name="driverName" id="driverName" type="text" style="width:200px; height:22px; border:1px solid #6fbaf3;"   value="<%=driverName%>"disabled="disabled" /></div>
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
						border="0" alt="Pick a date"></a>&nbsp;<input  type="Text" id="opening"  size="17" name="opening" value="<%=openingtime%>" disabled="disabled" ></td>

<!-- <td><input name="" type="text" style="width:100px; height:15px;" /></td> -->
<td><input type="text" style="width:100px; height:15px; text-align: center;"  id="openingKm" name="openingKm" onchange="distanceCalculation()" value="<%=openingkm%>" disabled="disabled"/></td>
</tr>

<tr>
<td>Closing</td>
<td>
<a	href="javascript:NewCssCal('close','yyyyMMdd','dropdown',true,'24')"><img
						src="../images/calendar_icon.gif" width="16" height="16"
						border="0" alt="Pick a date"></a>&nbsp;<input  type="Text" id="close"  size="17" name="close"  value="<%=closingtime%>" disabled="disabled"></td>

<!-- <td><input name="" type="text" style="width:100px; height:15px;" /></td> -->
<td><input  type="text" style="width:100px; height:15px; text-align: center;" id="ClosingKm" name="ClosingKm"  onchange="distanceCalculation()"  value="<%=closingkm%>" disabled="disabled"/></td>
</tr>

<tr>
<td>Coverage</td>
<td colspan="2"  id="coverage" style="text-align:left; padding:0px 0px 0px 205px;" ><%=travelled_km %></td>
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
<td style="width:100px;"><input name="hire" id="hire" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=hire %>" disabled="disabled" /></td>
<td><input name="hireP" id="hireP"  type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=hireP %>" disabled="disabled"/></td>
</tr>

<tr>
<td>Excess Hours</td>
<td><input name="e_hour" id="e_hour" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=e_hour %>" disabled="disabled"/></td>
<td><input name="e_hourP" id="e_hourP" type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()"  value="<%=e_hourP %>" disabled="disabled"/></td>
</tr>

<tr>
<td>Running KM Charge</td>
<td><input name="running_km" id="running_km" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=running_km %>" disabled="disabled"/></td>
<td><input name="running_kmP" id="running_kmP" type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=running_kmP %>" disabled="disabled"/></td>
</tr>

<tr>
<td>Excess KM Charge</td>
<td><input name="excess_km" id="excess_km" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=excess_km %>" disabled="disabled"/></td>
<td><input name="excess_kmP" id="excess_kmP" type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=excess_kmP %>" disabled="disabled"/></td>
</tr>

<tr>
<td>Driver Batta</td>
<td><input name="betta" id="betta" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=betta%>" disabled="disabled"/></td>
<td><input name="bettaP" id="bettaP" type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=bettaP %>" disabled="disabled"/></td>
</tr>

<tr>
<td>Permit Cost</td>
<td><input name="permit" id="permit" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=permit %>" disabled="disabled"/></td>
<td><input name="permitP" id="permitP" type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=permitP %>" disabled="disabled"/></td>
</tr>

<tr>
<td>Night Halt</td>
<td><input name="night_halt" id="night_halt" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=night_halt %>" disabled="disabled"/></td>
<td><input name="night_haltP" id="night_haltP" type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=night_haltP %>" disabled="disabled"/></td>
</tr>

<tr>
<td>Hills Charge</td>
<td><input name="hillsCharge" id="hillsCharge" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=hillsCharge %>" disabled="disabled"/></td>
<td><input name="hillsChargeP" id="hillsChargeP" type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=hillsChargeP %>" disabled="disabled"/></td>
</tr>

<tr>
<td>Parking / Others</td>
<td><input name="parking" id="parking" type="text" style="width:100px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=parking %>" disabled="disabled"/></td>
<td><input name="parkingP" id="parkingP" type="text" style="width:80px; height:15px; text-align:center;" onchange ="totalCost()" value="<%=parkingP %>" disabled="disabled"/></td>
</tr>

<tr>
<td><span>Total</span></td>
<td  colspan="2" style="width:200px; height:15px; text-align:center; color:#000000;" id="totalCost" ><%=payment %></td>

</tr>

</table>



<div class="sealtext">For Sri Bhagiyalakshmi Tours & Travels</div>

<div class="sealtextnew">Manager</div>

</div>
	
	</form>
	
	
	<center><a href="MGMT_Consolidated_Trip_Sheet.jsp"><img src="../images/back.png"></a></center>
	
	 <center>
		<!-- <a href="javaScript:redirect_to_Back()"><img src="../images/back.png"></a>  -->
	</body>
	</html>