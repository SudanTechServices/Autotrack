package com.ts.service;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import com.ts.dao.LoginDAO;
import com.ts.dbtransactionmgr.DBTransaction;
import com.ts.domain.UserLogin;

@SuppressWarnings("serial")
public class LoginService extends CommonService{
	ResultSet rs=null;
	String sessionuser=null;
	String privilage=null,belongs=null;
	PreparedStatement pstmt=null;
	public void run()throws ServletException,IOException
	{
		ses=request.getSession(false);
		//ses.setMaxInactiveInterval(10);
	//	System.out.println(ses.getId());
		
		UserLogin usrlgnobj=new UserLogin();
		LoginDAO usrlgndao=new LoginDAO();
			
				usrlgnobj.setUsername(request.getParameter("usrname"));
				System.out.println(request.getParameter("password"));
				usrlgnobj.setPassword(request.getParameter("password"));
				Boolean log=usrlgndao.validate(usrlgnobj);
				if(!response.isCommitted())
				if(log)
				{
					try{
									
					DBTransaction dbtranobj=new DBTransaction();
					Connection con=dbtranobj.connect();
					pstmt=con.prepareStatement("select date_time from session where user_id=? order by date_time desc limit 1");
					pstmt.setString(1, usrlgnobj.getUsername());
					rs=pstmt.executeQuery();
					if(rs.next())
					sessionuser=rs.getString(1);
					else
					sessionuser="I logged in first time";
					pstmt=con.prepareStatement("select privilage,belongs from login_information where user_name=?");
					pstmt.setString(1, usrlgnobj.getUsername());
					rs=pstmt.executeQuery();
					if(rs.next())
					{
						privilage=rs.getString(1);
						belongs=rs.getString(2);
					}
				//	System.out.println(privilage);
					}
					
					catch(Exception e){}
				ses.setAttribute("sessionuser",sessionuser);	
				ses.setAttribute("user",request.getParameter("usrname"));
				ses.setAttribute("privilage",privilage);
				ses.setAttribute("belongs",belongs);
				RequestDispatcher rd=request.getRequestDispatcher("/HTML/frame_home.htm");
				rd.forward(request, response);

					
				}
				else
				{
					RequestDispatcher rd=request.getRequestDispatcher("/JSP/login.jsp?mode=invalid");
					rd.forward(request, response);
					
				}
					
	}
}

