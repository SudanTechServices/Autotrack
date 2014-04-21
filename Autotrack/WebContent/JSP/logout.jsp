<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page errorPage="errorpage.jsp" %>
    <%@ page import="com.ts.dbtransactionmgr.DBTransaction"%>
    <%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script type="text/javascript">
window.history.forward();
function noBack() { window.history.forward(); }
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Logged out</title>
</head>
<body onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">

<%  
try{
	DBTransaction dbtranobj=new DBTransaction();
	Connection connection=dbtranobj.connect();
String user=(String)session.getAttribute("user");
//System.out.println(user);
PreparedStatement pstmt=connection.prepareStatement("insert into session(user_id) values(?)");
pstmt.setString(1, user);
pstmt.executeUpdate();
	
session.invalidate();
connection.close();
pstmt.close();

response.sendRedirect("login.jsp?mode=out");
connection.close();
pstmt.close();
//set.close();
}catch(Exception e){
	e.printStackTrace();
	
}
finally{

}
%>
</body>
</html>