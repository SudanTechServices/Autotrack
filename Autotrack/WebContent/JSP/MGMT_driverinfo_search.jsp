<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="errorpage.jsp"%>
<%@page import="java.sql.*"%>
 <%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>

<!DOCTYPE html>
<SCRIPT type="text/javascript">
	window.history.forward();
	function noBack() {
		window.history.forward();
	}
	
	var licence_arr = new Array();
	<%
	int counter=0;
	String licence= null, vehiclenumber=null,busroute=null,standard=null, locations = null;
	try{
	DBTransaction dbtranobj=new DBTransaction();
	Connection connection=dbtranobj.connect();
	ResultSet set = null;
	Statement mystatement = connection.createStatement();

	set = mystatement.executeQuery("select DISTINCT license_number from driver_info where license_number <> ''");
	while(set.next())
	{
		licence = set.getString("license_number");
			%>
			licence_arr[<%=counter%>]='<%=licence%>';
			<%
		counter++;
	}

	 connection.close();
	 mystatement.close();
		set.close();
	}catch(Exception e){}
	%>

		function print_licence(id){
			// given the id of the <select> tag as function argument, it inserts <option> tags
			var option_str = document.getElementById(id);
			var x, i=0;
			for(x in licence_arr){
				
				option_str.options[i++] = new Option(licence_arr[x],licence_arr[x]);
			}
		}

	function search() {
		var licence_number = document.DriverInfo.licence_number.value;
		if (licence_number == "") {
			alert("Enter The License Number");
		} else {
			document.DriverInfo.action = "../JSP/MGMT_driverinfo_update.jsp";
			document.DriverInfo.submit();
		}
	}

	
</SCRIPT>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<title>Autotrack</title>
<link rel="stylesheet" type="text/css" href="../CSS/style.css" />
</head>




<body>

	<div class="content_bg">
		<span class="content_headning">Search</span>
	</div>

	<form name="DriverInfo">
		<table cellpadding="2px;" cellspacing="4px;" class="table_content"
			style="width: 100%; background-color: #f1fafc; border: 1px solid #2898b4;">
			<tr>
				<td>
					<table cellpadding="2px;" cellspacing="4px;" class="table_content"
						style="width: 48%; background-color: #f1fafc;">
						<tr>
							<td colspan="3" style="color: red">* Enter the License	Number</td>
						</tr>
						<tr>
							<td>License Number</td>
							<td>:</td>
							<td><select id="licence_number" name ="licence_number" style="width: 200px;" class="tb" >
			 		<option>--Select Route --</option>
			 	</select>
			 	<script type="text/javascript">print_licence("licence_number");</script></td>
						
							<td >
							    <input type="button" value="Search Record" onclick="search();"> 
								
						    </td>
							
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>


</body>

</html>