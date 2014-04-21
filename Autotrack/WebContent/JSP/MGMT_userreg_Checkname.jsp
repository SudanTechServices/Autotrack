<%@ page language="java" import="java.sql.*" %>
<%@ page errorPage="errorpage.jsp" %> 
<%@ page import="com.ts.dbtransactionmgr.DBTransaction;" %>
<% response.setContentType("text/html");%>
<%
try {
String str=request.getParameter("user");
DBTransaction dbtranobj=new DBTransaction();
Connection con=dbtranobj.connect();
		
//String connectionURL = "jdbc:postgresql://182.72.167.34:5432/master_database";
//Connection con;
//Class.forName("org.postgresql.Driver");
// Get a Connection to the database
//con = DriverManager.getConnection(connectionURL, "postgres", "postgres");
//Add the data into the database
String sql = "SELECT user_name FROM login_information WHERE user_name='"+str+"'";
Statement stm = con.createStatement();
stm.executeQuery(sql);
ResultSet rs= stm.getResultSet();
int count = 0;
while (rs.next ()){
count++;
}
if(count==0)
{
out.println("User Name is Available");
}
else
	{
	out.println("User Name already exists !!! ");
	}
stm.close();
con.close();
rs.close();


}catch(Exception e){
out.println("Exception is ;"+e);
}
%>