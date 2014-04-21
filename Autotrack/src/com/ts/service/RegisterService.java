package com.ts.service;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import com.ts.dao.UserRegisterDAO;
import com.ts.domain.UserRegister;

public class RegisterService extends CommonService{
	public void run()throws ServletException,IOException
	{
	
		String user_name=request.getParameter("usrname");
		String password=request.getParameter("password");
		String email_id=request.getParameter("email");
		UserRegister usrrgsobj=new UserRegister();
		UserRegisterDAO usrrgsdao=new UserRegisterDAO();
		ses=request.getSession();
		String privilagefromsession=(String)ses.getAttribute("privilage");
		String privilage=request.getParameter("privilage");
		//String usrname=(String)ses.getAttribute("usrname");
		
		if(privilage.equals("Owner"))//if I am giving owner permission
		{
			usrrgsobj.setBelongs("owner");
		}
		else if((privilage.equals("Admin")) && (privilagefromsession.equals("Admin")))//if I am login by admin and giving admin permission
		{
			usrrgsobj.setBelongs((String)ses.getAttribute("user"));
		}
		else if((privilage.equals("Admin")) && (privilagefromsession.equals("Owner")))//if I am login by owner and giving admin permission
		{
			usrrgsobj.setBelongs(request.getParameter("usrname"));
		}
		else if((privilage.equals("Guest")) && (privilagefromsession.equals("Owner")))//if I am login by owner and giving guest permission
		{
			usrrgsobj.setBelongs("owner");
		}
		else//if I am login by admin and giving guest permission
		{
			usrrgsobj.setBelongs((String)ses.getAttribute("user"));
		}
		
				usrrgsobj.setUsername(request.getParameter("usrname"));
				usrrgsobj.setPassword(request.getParameter("password"));
				usrrgsobj.setNumber(request.getParameter("number"));
				usrrgsobj.setCompany(request.getParameter("company"));
				usrrgsobj.setEmail(request.getParameter("email"));
				usrrgsobj.setPrivilage(request.getParameter("privilage"));
				/*RequestDispatcher rd_mail=request.getRequestDispatcher("Send_cofirmation_mail.java?user_name="+user_name+"&password="+password+"&email_id="+email_id);
				rd_mail.forward(request, response);*/
				Boolean log=usrrgsdao.register(usrrgsobj);
				if(log)
				{
				RequestDispatcher rd=request.getRequestDispatcher("Send_cofirmation_mail?user_name="+user_name+"&password="+password+"&email_id="+email_id);
				rd.forward(request, response);
				}
				else
				{
					RequestDispatcher rd=request.getRequestDispatcher("/JSP/MGMT_userregistration.jsp?mode=already");
					rd.forward(request, response);
				
				}
					
	}
}



