<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ page errorPage="errorpage.jsp" %>
    <%@ page import="com.ts.service.dropdown" %> 
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	function showmap()
	{
			document.DropDown.action="livetracking.jsp";//it go to controllerservlet and after that it go to LoginService
			document.DropDown.submit();
		
	}
	
	
</script>
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../CSS/style.css" />
 </head>
<body>

<form name="DropDown" target="livetrack">
<div >
	<!--  <label for="vehicle no">Choose Your Vehicle </label> -->
	
	

<%	
String belongs=(String)session.getAttribute("belongs");
dropdown dd=new dropdown();     
TreeMap hm = dd.getName(belongs);
Set sets = hm.entrySet(); 
Iterator iterator = sets.iterator();   
  
out.println("<table cellspacing='0' class='table_content' cellpadding='4' style='width: 100%; background-color: #fff; border: 1px solid #dfdbdb;'><tr><th colspan='3' align='left' style='background-color:#e78c39; color:#fff; '>Live Tracking</th></tr><tr><td>Vehicle Number</td><td>:</td><td><select name='vehicle_no'>");   
out.println("<option class='blue'>Select Your Vehicle</option>");   
while(iterator.hasNext()){   
     //String temp = iterator.next().toString();
     Map.Entry me = (Map.Entry)iterator.next();
     out.println("<option class='blue' value=\"" + me.getValue() + "\">" + me.getKey() + "</option> ");   
}   
  
out.println("</select></td></tr><tr><td></td><td></td><td align='left'><input type='button' name='go' onclick='showmap();' value='Track it Now' /></td></tr><tr><td colspan='3'></td></tr></table>");   

%>

 
 </div>
</form>
</body>

</html>