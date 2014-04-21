package com.ts.service;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import java.sql.*;

import com.ts.dbtransactionmgr.DBTransaction;

public class emailpassword extends CommonService{
	public void run() throws ServletException, IOException{
		
		String emailid = request.getParameter("emailid");
		String user=request.getParameter("username");
		String username="";
		String password = "";
		String mailid = "";
		/* String question2 = "";
		String answer2 = ""; */


		try{
			  DBTransaction dbtransobj=new DBTransaction();
			  Connection connection=dbtransobj.connect();
			  ResultSet rs = null;
			  Statement st=null;
			  st=connection.createStatement();
			  rs = st.executeQuery("SELECT * from login_information WHERE e_mail = '"+emailid+"' and user_name='"+user+"'");
			  
			  while(rs.next()){ 
				  username = rs.getString("user_name");
				  mailid = rs.getString("e_mail"); 
				  password = rs.getString("password");
				 /*  question2 = rs.getString("questions2");
				  answer2 = rs.getString("answers2"); */
				  System.out.println(username);
			  }
			  if(mailid.equals(emailid))
			  {
				  RequestDispatcher rd=request.getRequestDispatcher("sendpwdemail?username="+username+"&mailid="+mailid+"&password="+password+"");
			 		 rd.forward(request, response);
			  }
			  else
			  {
				  RequestDispatcher rd=request.getRequestDispatcher("/JSP/emailid.jsp?mode=invalid");
			 		 rd.forward(request, response);
			  }
		}
		catch(Exception e){ System.err.println(e.getMessage()); } 
	}

}
