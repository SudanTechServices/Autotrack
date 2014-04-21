<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page errorPage="errorpage.jsp" %>
 <%@ page import="java.util.*" %>
 <%@page import="java.sql.*"%>
 <%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
 <%@ page import="com.ts.service.dropdown" %> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*" %>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Trip Sheet</title>

<!--  Style for ComboBox -->

<style type="text/css" media="screen">
	
	div.combobox	{position: relative;}
	div.combobox	div.dropdownlist	{display: none;width: 100px;border: solid 1px #dad9d7;
		height: auto; overflow: auto;position: absolute;background-color: #fff;top: 18px;left: 0px;}
	div.combobox	.dropdownlist	a	{display: block;text-decoration: none;color: #000;padding: 1px}
	div.combobox	.dropdownlist	a.light	{color: #fff;background-color: #30B8EA;}
	div.combobox	.dropdownlist, input {font-family: Tahoma;font-size: 12px;}
	div.combobox	input {float: left;width: 100px;border: solid 1px #ccc;height: 15px}
	/* div.combobox	span	{border: solid 1px #ccc;background: #eee;width: 16px;height: 17px;
		float: left;text-align: center;border-left: none} */
		
	div.routeno	{position: relative;}
	div.routeno	div.dropdownlist	{display: none;width: 50px;border: solid 1px #2898b4;
		height: auto; overflow: auto;position: absolute;background-color: #f1fafc;top: 18px;left: 0px;}
	div.routeno	.dropdownlist	a	{display: block;text-decoration: none;color: #000;padding: 1px}
	div.routeno	.dropdownlist	a.light	{color: #fff;background-color: #30B8EA;}
	div.routeno	.dropdownlist, input {font-family: Tahoma;font-size: 12px;}
	div.routeno	input {float: left;width: 50px;border: solid 1px #ccc;height: auto;}
	/* div.combobox	span	{border: solid 1px #ccc;background: #eee;width: 16px;height: 17px;
		float: left;text-align: center;border-left: none} */
</style>



<script type="text/javascript" src="../JS/jquery-1.4.2.min.js"></script>
	<link href="../CSS/SyntaxHighlighter.css" rel="stylesheet" type="text/css" />
	<link href="../CSS/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../JS/shCore.js" language="javascript"></script>
    <script type="text/javascript" src="../JS/shBrushJScript.js" language="javascript"></script>
    <script type="text/javascript" src="../JS/ModalPopups.js" language="javascript"></script>
    <script type="text/javascript" src="../JS/shInit.js" language="javascript"></script>	
     <script type="text/javascript" src="../JS/validate.js" language="javascript"></script>
<script type="text/javascript">

function insert_record(sno){
	
	var vehicle_number = document.getElementById("vehicle_number").value;
	var route_number = document.getElementById("route_number").value;
	var start_km = document.getElementById("start_km").value;
	var close_km = document.getElementById("close_km").value;
	var present_children = document.getElementById("present_children").value;
	var vehicle_outtime = document.getElementById("vehicle_outtime").value;
	var vehicle_intime = document.getElementById("vehicle_intime").value;
	var driver_name = document.getElementById("driver_name").value;
	var tcss_name = document.getElementById("tcss_name").value;
	
	$(document).ready(function(){
		this.timer = setTimeout(function () {
		$.ajax({
			
		url: 'MGMT_tripsheet_insertrecord.jsp?sno='+sno+'&vehicle_number='+vehicle_number+'&route_number='+route_number+'&start_km='+start_km+'&close_km='+close_km+'&present_children='+present_children+
		     '&vehicle_outtime='+vehicle_outtime+'&vehicle_intime='+vehicle_intime+'&driver_name='+driver_name+'&tcss_name='+tcss_name,
		data: '',
		type: 'POST',
		success: function(msg){ 
			
					alert(msg.trim());
					
					window.location.reload();
					
					
		} }); }, 100);

		return true;
		});
}


function delete_record(sno){
	
		$(document).ready(function(){
		this.timer = setTimeout(function () {
		$.ajax({
		url: 'MGMT_tripsheet_deleterecord.jsp',
		data: 'sno='+sno,
		type: 'POST',
		success: function(msg){ 
		
			window.location.reload();
			
		} }); }, 600);

		return true;
		});
}

function update_record(sno){
	
	
	
	$(document).ready(function(){
		this.timer = setTimeout(function () {
		$.ajax({
		url: 'MGMT_tripsheet_selectrecord.jsp',
		data: 'sno='+sno,
		type: 'POST',
		success: function(msg){ 
			
			var result = msg.trim();
			
			var split = result.split(',');
			var serialnumber = split[0];
			var vehicle_number = split[1];
			var route_number = split[2];
			var start_km = split[5];
			var close_km = split[6];
			var run_km = split[7];
			var present_children = split[8];
			var vehicle_outtime = split[9];
			var vehicle_intime = split[10];
			var driver_name = split[11];
			var tcss_name = split[12];
						
			ModalPopupsAlert1(serialnumber,vehicle_number,route_number,start_km,close_km,run_km,present_children,vehicle_outtime,vehicle_intime,driver_name,tcss_name);
			
		} }); }, 600);

				
		
		return true;
		
		});
	
	
}

/* function save_tripsheet(sno)
{  
	if(tripsheetFormValidator()){
	document.TripSheet.action="/Autotrack/ControllerServlet/TripSheetInfoService?sno="+sno+"";
	document.TripSheet.submit();
	}
} */

function update_tripsheet(sno)
{  
	
	var vehicle_number = document.update_record.vehicle_number.value;
	var route_number = document.update_record.route_number.value;
	var start_km = document.update_record.start_km.value;
	var close_km = document.update_record.close_km.value;
	var present_children = document.update_record.present_children.value;
	var vehicle_outtime = document.update_record.vehicle_outtime.value;
	var vehicle_intime = document.update_record.vehicle_intime.value;
	var driver_name = document.update_record.driver_name.value;
	var tcss_name = document.update_record.tcss_name.value;
	
		
	document.update_record.action='MGMT_tripsheet_updaterecord.jsp?sno='+sno+'&vehicle_number='+vehicle_number+'&route_number='+route_number+'&start_km='+start_km+'&close_km='+close_km+'&present_children='+present_children+
	     							'&vehicle_outtime='+vehicle_outtime+'&vehicle_intime='+vehicle_intime+'&driver_name='+driver_name+'&tcss_name='+tcss_name;
	document.update_record.submit();
}

function delete_popup(sno){
	
	
	ModalPopups.Confirm("jsAlert1","<center><div style='padding-left:45px;'>Confirmation </div></center>",
        	"<br> Do you want to delete this item ? <br><br><br>",
             
            {
                    titleBackColor: "#30b8ea",
                    titleFontColor: "#fff",
                    popupBackColor: "#f1fafd",
                    popupFontColor: "black",
                    footerBackColor: "#30b8ea",
                    footerFontColor: "white",
                    fontFamily: "Arial", 
                    fontSize: "12px",               
                    yesButtonText: "Delete",
                    noButtonText: "Cancel",
                    onYes: "DeletePopupConfirmYes("+sno+")",
                    onNo: "DeletePopupConfirmNo()"
            }
        );
	
}

function DeletePopupConfirmYes(sno) {
	
	delete_record(sno);
	  
}

function DeletePopupConfirmNo() {
	
   ModalPopups.Close("jsAlert1");
   
}

        function ModalPopupsAlert1(serialnumber,vehicle,route,start_km,close_km,run_km,present_children,vehicle_outtime,vehicle_intime,driver_name,tcss_name) {
            ModalPopups.Confirm("jsAlert1","<center><div style='padding-left:45px;'>Edit Trip Sheet</div></center>",
            	"<form name='update_record' method='post'>"+
            	"<table>"+
            	"<tr><td>Vehicle Number </td><td><input type='text' name='vehicle_number' value='"+vehicle+"' /></td></tr>"+
            	"<tr><td>Route </td><td><input type='text' name='route_number' value='"+route+"' /></td></tr>"+
            	"<tr><td>Start KM </td><td><input type='text' id='start_km1' name='start_km' value='"+start_km+"' /></td></tr>"+
            	"<tr><td>Close KM </td><td><input type='text' id='close_km1' name='close_km' value='"+close_km+"' onkeyup='show_runkm1(this.value,event);'/></td></tr>"+
            	"<tr><td>Run KM </td><td><input type='text' id='run_km1' name='run_km' value='"+run_km+"' disabled='disabled'/></td></tr>"+
            	"<tr><td>Present Children </td><td><input type='text' name='present_children' value='"+present_children+"' /></td></tr>"+
            	"<tr><td>Vehicle Out Time </td><td><input type='text' name='vehicle_outtime' value='"+vehicle_outtime+"' /></td></tr>"+
            	"<tr><td>Vehicle In Time </td><td><input type='text' name='vehicle_intime' value='"+vehicle_intime+"' /></td></tr>"+
            	"<tr><td>Driver Name </td><td><input type='text' name='driver_name' value='"+driver_name+"' /></td></tr>"+
            	"<tr><td>TCSS Name </td><td><input type='text' name='tcss_name' value='"+tcss_name+"' /></td></tr>"+
            	"</form>",
                 
                {
                        titleBackColor: "#30b8ea",
                        titleFontColor: "#ffffff",
                        popupBackColor: "#f1fafd",
                        popupFontColor: "black",
                        footerBackColor: "#30b8ea",
                        footerFontColor: "white",
                        fontFamily: "Arial",
                        fontSize: "12px",
                        yesButtonText: "Save",
                        noButtonText: "Cancel",
                        onYes: "ModalPopupsConfirmYes("+serialnumber+")",
                        onNo: "ModalPopupsConfirmNo()"
                }
            );
        }    
        
        function ModalPopupsConfirmYes(sno) {
        	
        	update_tripsheet(sno);
            
        }
        
        function ModalPopupsConfirmNo() {
           ModalPopups.Close("jsAlert1");
        }
           
       function show_runkm(clkm,e){
    	      	  
    	   var stkm = document.getElementById("start_km").value;
    	   
    	   var run = parseFloat(clkm) - parseFloat(stkm);
    	   
    	   	   document.getElementById("run_km").value = run;
    	   	   
    	   	  // document.getElementById("present_children").focus();
             	       	   
        } 
       function show_runkm1(clkm,e){
	      	  
    	   var stkm = document.getElementById("start_km1").value;
    	   
    	   var run = parseFloat(clkm) - parseFloat(stkm);
    	   
    	   	   document.getElementById("run_km1").value = run;
    	   	   
    	   	  // document.getElementById("present_children").focus();
             	       	   
        } 
        
      
    </script>


</head>

<body onload="refresh();">
<%
Calendar calendar = new GregorianCalendar();
String am_pm;
String hour = "";
String minute = "";

int hr = calendar.get(Calendar.HOUR);
int min = calendar.get(Calendar.MINUTE);

if(calendar.get(Calendar.AM_PM) == 0)
am_pm = "AM";
else
am_pm = "PM";


if(hr < 10){
	hour = "0"+hr;
}else{
	hour = ""+hr;
}
if(min < 10){
	minute = "0"+hr;
}else{
	minute = ""+min;
}

String Current_Time = hour+":"+minute+" "+am_pm;

%>

<div class="content_bg"><span class="content_headning">Trip Sheet</span></div>

<form name="TripSheet" method="POST" action="tripsheet_insertrecord.jsp">
<table border="0" style="background-color:#f8f8f8; border: 1px solid #dfdddb;" width="100%" cellpadding="2" cellspacing="0">

<tr>
<td>
<div  class="trip">
<%
java.text.DateFormat df = new java.text.SimpleDateFormat("dd/MM/yyyy");
String todaysdate = df.format(new java.util.Date());
%>
Trip Sheet For : <input id="date" type="text" size="10" name="date" class="days" value="<%=todaysdate  %>" disabled="disabled"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 

<% 
	int s_no = 1;
 	String day = null;
	Date date = new Date(); 
   int dayno = date.getDay();
   if(dayno == 0){ day = "Sunday";}
   else if(dayno == 1){ day = "Monday";}
   else if(dayno == 2){ day = "Tuesday";}
   else if(dayno == 3){ day = "Wednesday";}
   else if(dayno == 4){ day = "Thursday";}
   else if(dayno == 5){ day = "Friday";}
   else if(dayno == 6){ day = "Saturday";}
%>
Day : <input id="days" type="text" name="days" size="10" class="days"  value="<%=day %>" disabled="disabled" />

</div>
</td>
<tr>
<td>
<table border="0" style="background-color:#f8f8f8; border: 1px solid #dfdddb;" width="100%" cellpadding="2" cellspacing="0">

<tr>
	<th class="report_heading">S.No</th>	
   	<th class="report_heading">Route</th>
	<th class="report_heading">Start KM</th>
 	<th class="report_heading">Close KM</th>
 	<th class="report_heading">Run KM</th>
 	<th class="report_heading">Present <br/> Children</th>
 	<th class="report_heading">Out Time</th>
 	<th class="report_heading">In Time</th>
 	<th class="report_heading">Driver Name</th>
 	<th class="report_heading">TCSS</th>
 	<th class="report_heading">Inserted By</th>
 	<th class="report_heading" colspan="2"></th>	
</tr>

<%
try{
DBTransaction dbtranobj=new DBTransaction();
Connection connection=dbtranobj.connect();
ResultSet rs = null;
Statement mystatement = connection.createStatement();
rs = mystatement.executeQuery("select * from trip_sheet where date='"+todaysdate+"' order by sno");
%>
<tr>
<%
while(rs.next()){
%>
<td class="table_inner_content"><%=rs.getString("sno")%></td>	  
<td class="table_inner_content"><%=rs.getString("vehicle_number")%></td>
<td class="table_inner_content"><%=rs.getString("route_number")%></td>
<td class="table_inner_content"><%=rs.getString("start_km")%></td>
<td class="table_inner_content"><%=rs.getString("close_km")%></td>
<td class="table_inner_content"><%=rs.getString("run_km")%></td>
<td class="table_inner_content"><%=rs.getString("present_children")%></td>
<td class="table_inner_content"><%=rs.getString("vehicle_outtime")%></td>
<td class="table_inner_content"><%=rs.getString("vehicle_intime")%></td>
<td class="table_inner_content"><%=rs.getString("driver_name")%></td>
<td class="table_inner_content"><%=rs.getString("tcss_name")%></td>
<td class="table_inner_content"><%=rs.getString("inserted_by")%></td>
<td class="table_inner_content" align="center"><img alt="" src="../images/delete1.png" onclick="delete_popup('<%=rs.getString("sno")%>')"></td>
<td class="table_inner_content" align="center"><img alt="" src="../images/edit.png" onclick="update_record('<%=rs.getString("sno")%>')"></td>
</tr>
	
<%
s_no ++;
}
%>
<tr>
<td class="table_inner_content" id="sno"><%=s_no%></td>	
<td class="table_inner_content"><div class="combobox">
	<input type="text" name="vehicle_number" id="vehicle_number" style="height: 25px;">
	<span></span>
	<div class="dropdownlist">
		<%
		
			String belongs=(String)session.getAttribute("belongs");
			dropdown up=new dropdown();     
			TreeMap TreeMap = up.getName(belongs);  
			Set set=TreeMap.entrySet();
  
			Iterator iterator = set.iterator();   
  
			while(iterator.hasNext()){   
     				//String temp = iterator.next().toString();
    				 Map.Entry me = (Map.Entry)iterator.next();
     				out.println("<a>" + me.getKey() + "</a>");   
			}   
  

%>
	</div>
</div>

<!-- JS code -->
<script type="text/javascript" charset="utf-8" src="../JS/combobox.js"></script>
<script type="text/javascript" charset="utf-8">
var no = new ComboBox('vehicle_number');
</script></td>

<td class="table_inner_content">
<div class="routeno">
	<input type="text" name="route_number" id="route_number" style="height: 25px;">
	<span></span>
	<div class="dropdownlist">
		<%
		
			rs = mystatement.executeQuery("select DISTINCT route_number from student where route_number <> ''");
			while(rs.next()){   
     				
     				out.println("<a>" + rs.getString("route_number") + "</a>");   
			}   
  

%>
	</div>
</div>

<!-- JS code -->
<script type="text/javascript" charset="utf-8" src="../JS/combobox.js"></script>
<script type="text/javascript" charset="utf-8">
var no = new ComboBox('route_number');
</script>

</td>
<td class="table_inner_content"><input id="start_km" size="10" style="height: 25px;" type="text" name="start_km" /></td>
<td class="table_inner_content"><input id="close_km" size="10" style="height: 25px;" type="text" name="close_km" onkeyup="show_runkm(this.value,event);"/></td>
<td class="table_inner_content"><input id="run_km" size="10" style="height: 25px;" type="text" name="run_km" disabled="disabled"/></td>
<td class="table_inner_content"><input id="present_children" style="height: 25px;" type="text" name="present_children" /></td>
<td class="table_inner_content"><input id="vehicle_outtime" style="height: 25px;" type="text" name="vehicle_outtime" /></td>
<td class="table_inner_content"><input id="vehicle_intime" style="height: 25px;" type="text" name="vehicle_intime" /></td>
<td class="table_inner_content">
<div class="combobox">
	<input type="text" name="driver_name" id="driver_name"  style="height: 25px;" >
	<span></span>
	<div class="dropdownlist">
		<%
		
			rs = mystatement.executeQuery("select DISTINCT driver_name from driver_info where driver_name <> ''");
			while(rs.next()){   
     				
     				out.println("<a>" + rs.getString("driver_name") + "</a>");   
			}   

  

%>
	</div>
</div>

<!-- JS code -->
<script type="text/javascript" charset="utf-8" src="../JS/combobox.js"></script>
<script type="text/javascript" charset="utf-8">
var no = new ComboBox('driver_name');
</script>

</td>
<td class="table_inner_content">
<div class="combobox">
	<input type="text" name="tcss_name" id="tcss_name" size="15"  style="height: 25px;">
	<span></span>
	<div class="dropdownlist">
		<%
		
			rs = mystatement.executeQuery("select DISTINCT name from tcss_information where name <> ''");
			while(rs.next()){   
     				
     				out.println("<a>" + rs.getString("name") + "</a>");   
			}   
			mystatement.close();
			connection.close();
			rs.close();

}catch(Exception e){}

%>
	</div>
</div>

<!-- JS code -->
<script type="text/javascript" charset="utf-8" src="../JS/combobolx.js"></script>
<script type="text/javascript" charset="utf-8">
var no = new ComboBox('tcss_name');
</script>

</td>
<td class="table_inner_content"><input id="inserted_by" size="15"  style="height: 25px;" type="text" name="inserted_by" disabled="disabled" value="<%=session.getAttribute("user")%> | <%=Current_Time%>"/></td>
<td colspan="2" align="center" class="table_inner_content"><img alt="" src="../images/save.png" onclick="insert_record('<%=s_no%>');"></td>

</tr>
</table>
<br/>
<div>
</div>
</td>
</tr>
</table>
</form>
</body>
</html>