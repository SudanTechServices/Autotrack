<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="errorpage.jsp" %>
 <%@page import="java.sql.*"%>
 <%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script language="javascript" type="text/javascript" src="../../JS/datetimepicker.js"></script>

<script type="text/javascript">
function show_UserDefinedReport(){
	
	 	document.userdefinedreport.action="AJAX_UserDefinedReport_student.jsp";
	   	document.userdefinedreport.target="ReportWindow";
		document.userdefinedreport.submit();
	
}

var route_arr = new Array();
var s_a = new Array();
s_a[0]="";
<%
int counter=0;
try{
DBTransaction dbtranobj=new DBTransaction();
Connection connection=dbtranobj.connect();
ResultSet set = null;
Statement mystatement = connection.createStatement();
set = mystatement.executeQuery("select DISTINCT routenumber from student");
String pickpoint=null,busroute=null,fee=null;
while(set.next())
{
	
	//pickpoint=""+set.getString("stopping_point_1")+"|"+set.getString("stopping_point_2")+"|"+set.getString("stopping_point_3")+"|"+set.getString("stopping_point_4")+"|"+set.getString("stopping_point_5")+"";
	
	busroute=set.getString("routenumber");
	
	%>
	
	route_arr[<%=counter%>]='<%=busroute%>';
	<%-- s_a[<%=counter%>+1]='<%=pickpoint%>'; --%>
	<%
	
	counter++;
}
connection.close();
mystatement.close();
set.close();
}//try
catch(Exception e){
	
}
%>
function print_routes(route_id){
	// given the id of the <select> tag as function argument, it inserts <option> tags
	var option_str = document.getElementById(route_id);
	var x, i=0;
	for(x in route_arr){
		
		option_str.options[i++] = new Option(route_arr[x],route_arr[x]);
	}
}

/* function print_points(state_id, state_index){
	var option_str = document.getElementById(state_id);
	var x, i=0; state_index++;
	var pick_arr = s_a[state_index].split("|");
	for(x in pick_arr){
            option_str.options[i++] = new Option(pick_arr[x],pick_arr[x]);
	}
}
*/

function refresh(){
	
	print_routes("route");
}

function checkAll(field)
{
for (i = 0; i < field.length; i++)
	field[i].checked = true ;
}

function uncheckAll(field)
{
for (i = 0; i < field.length; i++)
	field[i].checked = false ;
}
</script>


 <link rel="stylesheet" type="text/css" href="../CSS/style.css" />
 
 <style type="text/css">

input.groovybutton
{
   font-size:14px;
   font-family:Trebuchet MS,sans-serif;
   font-weight:bold;
   color:#000;
   width:150px;
   height:30px;
   background-image:url("../images/content_pagetitle_bg.jpg");
   background-repeat: repeat-x;
   border-radius:25px;
}
.dropdown{
font-family:Trebuchet MS,sans-serif;
background-color:#B8E2FA; 
border-radius:10px; 
color:#000;
width:200px;
height: 30px;
padding: 2px;
}
option.blue 
{
background-color:#3B5C9A; 
font-weight: bold; 
font-size: 12px; 
color: white;
padding:3px;
}
input.field{
background-color:#B8E2FA;
font-family:Trebuchet MS,sans-serif;
width:150px;
color:#000;
}
</style>

</head>
<body onload="refresh();">

<form name="userdefinedreport">
<table>
	<%-- <tr><td>Vehicle:<br/>
	
<%@ page import="com.ts.service.dropdown" %> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*" %>
<%	
String belongs=(String)session.getAttribute("belongs");
dropdown up=new dropdown();     
HashMap hashmap = up.getName(belongs);  
Set set1=hashmap.entrySet();
  
Iterator iterator = set1.iterator();   
  
out.println("<select name='vehicle_number' class='dropdown'>");   

while(iterator.hasNext()){   
     //String temp = iterator.next().toString();
     Map.Entry me = (Map.Entry)iterator.next();
     out.println("<option class='blue' value=\"" + me.getValue() + "\">" + me.getKey() + "</option>");   
}   
  
out.println("</select>");   

%>
 --%>
 	</td>
 	<td>Select Route
 	<br/> 	
 	<select class="dropdown" onchange="print_points('route_name',this.selectedIndex);" id="route" name ="route">
 		<option>--Select Route --</option>
 	</select>
 	</td>
 </tr>

 <tr>
 	<td>
		 <input type="checkbox" name="id" value="name"> Name <BR></td></tr>
		<!-- <tr> <td><input type="checkbox" name="id" value="age"> Age <BR></td></tr>
	
	<tr> <td>
		 <input type="checkbox" name="id" value="date_of_birth"> Date of Birth <BR></td></tr> -->
	<tr> <td>	 <input type="checkbox" name="id" value="standard"> Class <BR></td></tr>
	
	<tr> <td>
		 <input type="checkbox" name="id" value="section"> Section <BR></td></tr>
		<!-- <tr> <td> <input type="checkbox" name="id" value="parent_name"> Parent Name <BR></td></tr>
 -->	
	<tr> <td>
		 <input type="checkbox" name="id" value="idnumber"> ID Number <BR></td></tr>
		 <tr> <td>
		 <input type="checkbox" name="id" value="vehicle_number">Vehicle Number <BR></td></tr> 
		<tr> <td> <input type="checkbox" name="id" value="pick_point"> Pick Point <BR></td></tr>
		<tr> <td> <input type="checkbox" name="id" value="pick_up_timing"> Pick Point Timing <BR></td></tr>
	
	 
	<tr> <td>	 <input type="checkbox" name="id" value="rate"> Bus Fare <BR></td></tr>
	
	<tr> <td colspan="2"><a href="#" onClick="checkAll(document.userdefinedreport.id)">Check All</a>&nbsp; &nbsp;<a href="#" onClick="uncheckAll(document.userdefinedreport.id)">UnCheck All</a></td></tr>
	
	<tr> <td>
 		<input class="groovybutton" type="button" name="search" value="Get Report" onclick="show_UserDefinedReport();">
 		</td></tr>
	

</table>
</form>
</body>
</html>