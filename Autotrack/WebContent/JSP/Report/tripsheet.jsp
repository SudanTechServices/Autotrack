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
<script type="text/javascript" src="http://jqtouch.googlecode.com/svn-history/r134/trunk/jqtouch/jquery-1.4.2.min.js"></script>
	<link href="../CSS/SyntaxHighlighter.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../JS/shCore.js" language="javascript"></script>
    <script type="text/javascript" src="../JS/shBrushJScript.js" language="javascript"></script>
    <script type="text/javascript" src="../JS/ModalPopups.js" language="javascript"></script>
    <script type="text/javascript" src="../JS/shInit.js" language="javascript"></script>	
<script type="text/javascript">

function delete_record(sno){
	
	$(document).ready(function(){
		this.timer = setTimeout(function () {
		$.ajax({
		url: 'tripsheet_deleterecord.jsp',
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
		url: 'tripsheet_updaterecord.jsp',
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

function save_tripsheet(sno)
{  
	//alert('sd');
	document.TripSheet.action="/Autotrack/ControllerServlet/TripSheetInfoService?sno="+sno+"";
	document.TripSheet.submit();
}

function update_tripsheet(serialnumber)
{  
	alert(serialnumber);
	document.update_record.action="/Autotrack/ControllerServlet/TripSheetInfoUpdateDeleteService?serialnumber="+serialnumber+"";
	document.update_record.submit();
}

function delete_popup(sno){
	
	ModalPopups.Confirm("jsAlert1","<center><div style='padding-left:45px;'>Confirmation </div></center>",
        	"<br> Do you want to delete this item ? <br><br><br>",
             
            {
                    titleBackColor: "#0088DD",
                    titleFontColor: "white",
                    popupBackColor: "#BDE6FC",
                    popupFontColor: "black",
                    footerBackColor: "#0088DD",
                    footerFontColor: "white",
                    fontFamily: "Courier New",                 
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
            	"<table><tr><td>Vehicle Number </td><td><input type='text' name='vehicle_number' value='"+vehicle+"' /></td></tr>"+
            	"<tr><td>Route </td><td><input type='text' name='route_number' value='"+route+"' /></td></tr>"+
            	"<tr><td>Start KM </td><td><input type='text' name='start_km' value='"+start_km+"' /></td></tr>"+
            	"<tr><td>Close KM </td><td><input type='text' name='close_km' value='"+close_km+"' /></td></tr>"+
            	"<tr><td>Run KM </td><td><input type='text' name='run_km' value='"+run_km+"' /></td></tr>"+
            	"<tr><td>Present Children </td><td><input type='text' name='present_children' value='"+present_children+"' /></td></tr>"+
            	"<tr><td>Vehicle Out Time </td><td><input type='text' name='vehicle_outtime' value='"+vehicle_outtime+"' /></td></tr>"+
            	"<tr><td>Vehicle In Time </td><td><input type='text' name='vehicle_intime' value='"+vehicle_intime+"' /></td></tr>"+
            	"<tr><td>Driver Name </td><td><input type='text' name='driver_name' value='"+driver_name+"' /></td></tr>"+
            	"<tr><td>TCSS Name </td><td><input type='text' name='tcss_name' value='"+tcss_name+"' /></td></tr>"+
            	"<tr><td>TCSS Name </td><td><input type='text' name='inserted_by' value='"+tcss_name+"' /></td></tr>"+
            	"</form>",
                 
                {
                        titleBackColor: "#0088DD",
                        titleFontColor: "white",
                        popupBackColor: "#BDE6FC",
                        popupFontColor: "black",
                        footerBackColor: "#0088DD",
                        footerFontColor: "white",
                        fontFamily: "Courier New",                 
                        yesButtonText: "Save",
                        noButtonText: "Cancel",
                        onYes: "ModalPopupsConfirmYes("+serialnumber+")",
                        onNo: "ModalPopupsConfirmNo()"
                }
            );
        }    
        
        function ModalPopupsConfirmYes(serial) {
        	
        	alert(serial);
        	
        	update_tripsheet(serial);
            
        }
        
        function ModalPopupsConfirmNo() {
           ModalPopups.Close("jsAlert1");
        }
           
       function show_runkm(clkm,e){
    	      	  
    	   var stkm = document.getElementById("start_km").value;
    	   
    	   var run = parseFloat(clkm) - parseFloat(stkm);
    	   
    	   
    	   if (typeof e == 'undefined' && window.event) 
    	   { 
    	   e = window.event; 
    	   }
           if (e.keyCode == 9 || e.keyCode == 13)

           {
        	   
        	   document.getElementById("run_km").value = run;
           }

    	  
    	  
    	       	   
        } 
        
    </script>


</head>

<body onload="refresh();">

<form name="TripSheet" method="POST">
<div style="padding: 10px; color: red;">
<%
java.text.DateFormat df = new java.text.SimpleDateFormat("dd/MM/yyyy");
String todaysdate = df.format(new java.util.Date());
%>
Trip Sheet For : <input id="date" type="text" name="date" style="color: blue;" value="<%=todaysdate  %>" disabled="disabled"/>   | 

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
Day : <input id="days" type="text" name="days" style="color: blue;" value="<%=day %>" disabled="disabled" /> 
</div>



<table border="1" style="background-color:#BDE6FC; borderColor="black"; width="100%"">

<tr>
	<td style="color:#ffffff; background-color:#0088DD; padding: 2px;" colspan="2"><center><b></b></center></td>
	<td style="color:#ffffff; background-color:#0088DD; padding: 2px;"><center><b>S.No</b></center></td>
	<td style="color:#ffffff; background-color:#0088DD; padding: 2px;"><center><b>Vehicle</b></center></td>
   	<td style="color:#ffffff; background-color:#0088DD; padding: 2px;"><center><b>Route</b></center></td>
	<td style="color:#ffffff; background-color:#0088DD; padding: 2px"><center><b>Start KM</b></center></td>
 	<td style="color:#ffffff; background-color:#0088DD; padding: 2px"><center><b>Close KM</b></center></td>
 	<td style="color:#ffffff; background-color:#0088DD; padding: 2px"><center><b>Run KM</b></center></td>
 	<td style="color:#ffffff; background-color:#0088DD; padding: 2px"><center><b>Present Children</b></center></td>
 	<td style="color:#ffffff; background-color:#0088DD; padding: 2px"><center><b>Out Time</b></center></td>
 	<td style="color:#ffffff; background-color:#0088DD; padding: 2px"><center><b>In Time</b></center></td>
 	<td style="color:#ffffff; background-color:#0088DD; padding: 2px"><center><b>Driver Name</b></center></td>
 	<td style="color:#ffffff; background-color:#0088DD; padding: 2px"><center><b>TCSS</b></center></td>
</tr>

<%
try{
DBTransaction dbtranobj=new DBTransaction();
Connection connection=dbtranobj.connect();
ResultSet rs = null;
Statement mystatement = connection.createStatement();
rs = mystatement.executeQuery("select * from trip_sheet where date='"+todaysdate+"'");
%>
<tr>
<%
while(rs.next()){
%>
<td style="padding:2px;"><img alt="" src="http://www.paseosoft.com/img/components/delete_files.jpg" onclick="delete_popup('<%=s_no%>')"></td>
<td style="padding:2px;"><img alt="" src="http://www.erikmoynihan.com/tif.drop/Adobe%20Acrobat%209%20Pro/Acrobat%20Distiller.app/Contents/MacOS/SelfHealFiles/Help/APP_Adobe/Help/fr_FR/Acrobat%20Pro/9.0/images/A_EditInDesigner_Lg_N.png" onclick="update_record('<%=s_no%>')"></td>
<td style="padding:2px;"><%=s_no%></td>	  
<td style="padding:2px;"><%=rs.getString("vehicle_number")%></td>
<td style="padding:2px;"><%=rs.getString("route_number")%></td>
<td style="padding:2px;"><%=rs.getString("start_km")%></td>
<td style="padding:2px;"><%=rs.getString("close_km")%></td>
<td style="padding:2px;"><%=rs.getString("run_km")%></td>
<td style="padding:2px;"><%=rs.getString("present_children")%></td>
<td style="padding:2px;"><%=rs.getString("vehicle_outtime")%></td>
<td style="padding:2px;"><%=rs.getString("vehicle_intime")%></td>
<td style="padding:2px;"><%=rs.getString("driver_name")%></td>
<td style="padding:2px;"><%=rs.getString("tcss_name")%></td>

</tr>
	
<%
s_no ++;
}

connection.close();
mystatement.close();
rs.close();
}
catch(Exception e){
	System.out.println(e.getMessage());
}
%>
<tr>
<td style="padding:2px;" colspan="2"><img alt="" src="http://www.projecthosts.com/tours/images/32_Save.png" onclick="save_tripsheet('<%=s_no%>');"></td>
<td style="padding:2px;"><%=s_no%></td>	
<td>

<%	
String belongs=(String)session.getAttribute("belongs");
dropdown up=new dropdown();     
TreeMap hashmap = up.getName(belongs);  
Set set=hashmap.entrySet();
  
Iterator iterator = set.iterator();   
  
out.println("<select name='vehicle_number' class='dropdown'>");   

while(iterator.hasNext()){   
     //String temp = iterator.next().toString();
     Map.Entry me = (Map.Entry)iterator.next();
     out.println("<option class='blue' value=\"" + me.getKey() + "\">" + me.getKey() + "</option>");   
}   
  
out.println("</select>");   

%>
</td>

<td><input style="width: 100px;" type="text" name="route_number" /></td>
<td><input id="start_km" style="width: 120px;" type="text" name="start_km" /></td>
<td><input style="width: 120px;" type="text" name="close_km" onkeydown="show_runkm(this.value,event);"/></td>
<td><input id="run_km" style="width: 120px;" type="text" name="run_km"  /></td>
<td><input style="width: 120px;" type="text" name="present_children" /></td>
<td><input style="width: 100px;" type="text" name="vehicle_outtime" /></td>
<td><input style="width: 100px;" type="text" name="vehicle_intime" /></td>
<td><input style="width: 100px;" type="text" name="driver_name" /></td>
<td><input style="width: 100px;" type="text" name="tcss_name" /></td>

</tr>
</table>
<div>
</div>
</form>
</body>
</html>