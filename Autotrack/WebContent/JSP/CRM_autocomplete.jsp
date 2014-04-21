<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@ page import="com.ts.dbtransactionmgr.DBTransaction;" %>
<%
ArrayList<String> b1=new ArrayList<String>();   
try    
{              
	
String name = (String)request.getParameter("q");
 System.out.println(name);
 DBTransaction dbtranobj=new DBTransaction();
	Connection connection=dbtranobj.connect();
	ResultSet rs = null;
	Statement st=null;
	st=connection.createStatement();
	String dbquery="select name ,enrolment_number,location from student where name like '%"+name+"%' or enrolment_number like '%"+name+"%' or location like '%"+name+"%'";
	rs=st.executeQuery(dbquery);
	
	//System.out.println("1"+request.getParameterNames().nextElement());
	response.setHeader("Content-Type", "text/html");
	 if(!rs.next()){
	out.println("No Records Found");
	}
	else{ 
	
						int cnt=1;
						for(int i=0;rs.next();i++)
						{     
							//String s=rs.getString("name");   
							
							 String names=rs.getString("name");
							 String number=rs.getString("enrolment_number");
							 String loc=rs.getString("location");
							if(names.toUpperCase().startsWith(name.toUpperCase()))
							{
								
								
								out.print(names+"  ,  ");
								out.print(number+"   ,  ");
								out.print(loc+"\n");
								if(cnt>=10)
									break;
								cnt++;
							}
							else if(number.toUpperCase().startsWith(number.toUpperCase()))
							{
								out.print(names+"  ,  ");
								out.print(number+"   ,  ");
								out.print(loc+"\n");
								if(cnt>=10)
									break;
								cnt++;
							}
							else if(loc.toUpperCase().startsWith(loc.toUpperCase()))
							{
								out.print(names+"  ,  ");
								out.print(number+"   ,  ");
								out.print(loc+"\n");
								if(cnt>=10)
									break;
								cnt++;
							}
						}
	 } 
	 connection.close();
	 st.close();
	 rs.close();
}
catch(Exception ex)    
{   
ex.printStackTrace();   
System.err.println("Exception: " + ex.getMessage());   
}   
 
%>