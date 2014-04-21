<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page errorPage="errorpage.jsp" %>
<%@page import="java.sql.*"%>
 <%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
<!DOCTYPE html>
<SCRIPT type="text/javascript">

window.history.forward();
function noBack() { window.history.forward(); }
   
var customerid_arr = new Array();
<%
int counter=0;
String customerid= null, vehiclenumber=null,busroute=null,standard=null, locations = null;
try{
DBTransaction dbtranobj=new DBTransaction();
Connection connection=dbtranobj.connect();
ResultSet set = null;
Statement mystatement = connection.createStatement();

set = mystatement.executeQuery("select DISTINCT customer_id from customer_information");
while(set.next())
{
	customerid = set.getString("customer_id");
		%>
		customerid_arr[<%=counter%>]='<%=customerid%>';
		<%
	counter++;
}
connection.close();
mystatement.close();
set.close();
}//try
catch(Exception e){}
%>

	function print_customerid(id){
		// given the id of the <select> tag as function argument, it inserts <option> tags
		var option_str = document.getElementById(id);
		var x, i=0;
		for(x in customerid_arr){
			
			option_str.options[i++] = new Option(customerid_arr[x],customerid_arr[x]);
		}
	}
   function search()
	{     
    		var cust_id = document.CustomerInfo.customer_id.value;
    		
    		if(cust_id == ""){
    			alert("Enter Your Customer Id")
    		}
    		else{
    	  		 document.CustomerInfo.action="../JSP/MGMT_customerinfo_update.jsp";
		  		 document.CustomerInfo.submit();
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

<div class="content_bg"><span class="content_headning">Customer Information</span></div>
		
<form name="CustomerInfo" >

<table cellpadding="0" cellspacing="0" class="table_content" style="width: 100%; background-color: #f8f8f8; border: 1px solid #dfdddb;">
<tr>
<td>
<table cellpadding="4" cellspacing="0" class="table_content" style="width: 50%; background-color: #f8f8f8;">
	<tr>
		<td colspan="3" style="color: red">* Enter the Customer ID </td>
	</tr>
	<tr height=15px>
		<td>Customer ID  </td>
	<td>:</td>
	<td width="10%">
	<select id="customer_id" name ="customer_id" style="width: 135px;" class="tb" onchange="javascript:check_nooflicence(this.value);">
				 		<option>--Select Route --</option>
				 	</select>
				 	<script type="text/javascript">print_customerid("customer_id");</script>
	</td>
	<td width="20%"><input type="button" value="Search" onclick="search();"></td>
	<td></td>
	</tr>

</table>
</td>
</tr>
</table>
</form>		
</body> 
 
</html>