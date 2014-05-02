package com.ts.service;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import com.ts.dao.UserRegisterDAO;
import com.ts.domain.UserRegister;

public class RegisterService extends CommonService{
	public void run()throws ServletException,IOException
	{
	    UserRegister usrrgsobj=new UserRegister();
	    UserRegisterDAO usrrgsdao=new UserRegisterDAO();
	    
	    try{
	    	usrrgsobj.setCompany(request.getParameter("company"));
	    	usrrgsobj.setNumber(request.getParameter("number"));
	    	usrrgsobj.setEmail(request.getParameter("email"));
	    	usrrgsobj.setUsername(request.getParameter("usrname"));
	    	usrrgsobj.setPassword(request.getParameter("password"));
	    	usrrgsobj.setPrivilage(request.getParameter("privilage"));
			
			
			
			Boolean log=usrrgsdao.register(usrrgsobj);
			
			if(log)
			 {
			
			RequestDispatcher rd=request.getRequestDispatcher("../jsp/user_account.jsp?message=success");
		
			rd.forward(request, response);
			}
		else
		{
			RequestDispatcher rd=request.getRequestDispatcher("../jsp/user_account.jsp?message=already");
			
			rd.forward(request, response);
		
		}
}
catch(Exception e){
	e.printStackTrace();
}
	}
}
		


