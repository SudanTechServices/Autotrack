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
String sql = "SELECT enrolment_number FROM student WHERE enrolment_number='"+str+"'";
Statement stm = con.createStatement();
stm.executeQuery(sql);
ResultSet rs= stm.getResultSet();
int count = 0;
while (rs.next ()){
count++;
}
if(count==0)
{
out.println("ID number is Available");
}
else
	{
	out.println("ID number already exists !!! ");
	}
con.close();
stm.close();
rs.close();
}catch(Exception e){
out.println("Exception is ;"+e);
}
%>