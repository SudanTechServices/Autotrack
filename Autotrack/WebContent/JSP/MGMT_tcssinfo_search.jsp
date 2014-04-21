<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="errorpage.jsp" %>
<%@page import="java.sql.*"%>
 <%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
 
<!DOCTYPE html>
<script type="text/javascript">

window.history.forward();
function noBack() { window.history.forward(); }

var tcssid_arr = new Array();
<%
int counter=0;
String tcssid= null;
DBTransaction dbtranobj=new DBTransaction();
Connection connection=dbtranobj.connect();
ResultSet set = null;
Statement mystatement = connection.createStatement();

set = mystatement.executeQuery("select DISTINCT id_number from tcss_information where id_number <> ''");
while(set.next())
{
	tcssid = set.getString("id_number");
		%>
		tcssid_arr[<%=counter%>]='<%=tcssid%>';
		<%
	counter++;
}
%>

	function print_tcssid(id){
		// given the id of the <select> tag as function argument, it inserts <option> tags
		var option_str = document.getElementById(id);
		var x, i=0;
		for(x in tcssid_arr){
			
			option_str.options[i++] = new Option(tcssid_arr[x],tcssid_arr[x]);
		}
	}

	
	function search()
	{
		var tcss_id_number = document.TcssInfo.tcss_id_number.value;
		
		document.TcssInfo.action="../JSP/MGMT_tcssinfo_update.jsp?tcss_id_number="+tcss_id_number;
		document.TcssInfo.submit();
		
	}
		
</script>

<html xmlns="http://www.w3.org/1999/xhtml"> 
 
<head> 
	<meta http-equiv="Content-type" content="text/html; charset=utf-8" /> 
	<title>Welcome to Autotrack</title> 
<link rel="stylesheet" type="text/css" href="../CSS/style.css" />
	
</head> 
 
<body>

<div class="content_bg"><span class="content_headning">Search</span></div>
		
<form name="TcssInfo">
<table  cellpadding="0" cellspacing="0" class="table_content" style="width: 100%; background-color: #fff; border: 1px solid #dfdddb;">
<tr>
<td>
<table cellpadding="4" cellspacing="0" class="table_content" style="width: 35%; background-color: #fff;">
<tr>
<td width="5%"></td>
<td colspan="3" style="color: red">* Enter TCSS ID Number</td></tr>
<tr height=15px>
<td></td>
	<td width="80%">ID Number</td>
	<td>:</td>
	<td><select id="tcss_id_number" name ="tcss_id_number" style="width:150px;" class="tb" >
			 		<option>--Select Route --</option>
			 	</select>
			 	<script type="text/javascript">print_tcssid("tcss_id_number");</script></td>
				<td colspan="3"><input type="button" value="Search TCSS Info" onclick="search();"></td>
</tr>
</table>
</td>
</tr>
</table>
</form>		


</body> 
 
</html>