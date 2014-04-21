package com.ts.service;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import java.sql.*;

import com.ts.dbtransactionmgr.DBTransaction;

public class ForgetPassword extends CommonService{
	public void run() throws ServletException, IOException{
		
		String emailid = request.getParameter("emailid");
		String username=request.getParameter("username");
		System.out.println(emailid);
		System.out.println(username);
		String usernam="";
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
			  rs = st.executeQuery("SELECT password from login_information WHERE e_mail = '"+emailid+"'and user_name ='"+username+"'");
			  
			  if(rs.next()){ 
				  
				  password = rs.getString("password");
				  
				 /*  question2 = rs.getString("questions2");
				  answer2 = rs.getString("answers2"); */
				  RequestDispatcher rd=request.getRequestDispatcher("SendPwdToEmail?username="+username+"&mailid="+emailid+"&password="+password+"");
			 		 rd.forward(request, response);
			  }
			    //if(mailid.equals(emailid))
			  else
			  {
				  RequestDispatcher rd=request.getRequestDispatcher("/JSP/forgetpassword.jsp?message=invalid");
			 		 rd.forward(request, response);
			  }
			  
				  
			  
		}
		catch(Exception e){ System.err.println(e.getMessage()); } 
	}

}
