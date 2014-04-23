package com.ts.service;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import java.sql.*;

import com.ts.dbtransactionmgr.DBTransaction;

public class reset_password_service extends CommonService{
	public void run() throws ServletException, IOException{
		
		String username=request.getParameter("username");
		System.out.println(username);
		String oldpassword=request.getParameter("password");
		String newpassword=request.getParameter("newpassword");
		
		String confirmpassword = request.getParameter("cpassword");
		String password="";
		//String mailid = "";
		/* String question2 = "";
		String answer2 = ""; */


		try{
			  DBTransaction dbtransobj=new DBTransaction();
			  Connection connection=dbtransobj.connect();
			  ResultSet rs = null;
			  Statement st=null;
			  st=connection.createStatement();
			  
			  rs = st.executeQuery("SELECT password from login_information WHERE user_name='"+username+"'");
			  
			  while(rs.next()){ 
				  
				  
				  password = rs.getString("password");
				  System.out.println(password);
				 /*  question2 = rs.getString("questions2");
				  answer2 = rs.getString("answers2"); */
			  }
			 
			 		  
			  if(oldpassword.equals(password))
			  {
				  
				  
				  if(newpassword.equals(confirmpassword))
						  {
				
				  st.executeUpdate("UPDATE  login_information SET password='"+confirmpassword+"' WHERE password='"+oldpassword+"' and user_name='"+username+"'");
				  RequestDispatcher rd=request.getRequestDispatcher("../jsp/index.jsp?message=passwordupdated");
					 rd.forward(request, response);
				  System.out.println("Password Updated Successfully");
						  }
				  else
				  {

					  RequestDispatcher rd=request.getRequestDispatcher("../jsp/resetpassword.jsp?mode1=Mismatch");
				 		 rd.forward(request, response);
				  }
			  }
			  else
			  {
				  RequestDispatcher rd=request.getRequestDispatcher("../jsp/resetpassword.jsp?mode=invalid");
			 		 rd.forward(request, response);
			  }
		}
		catch(Exception e){ System.err.println(e.getMessage()); } 
	}

}
