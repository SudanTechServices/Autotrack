package com.ts.service;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import com.ts.dao.TcssInfoDAO;
import com.ts.domain.TcssInfo;




@SuppressWarnings("serial")
public class TcssInfoService extends CommonService{
int counter;
	@Override
	public void run() throws ServletException, IOException {
	
				TcssInfo TcssInfoobj =new TcssInfo();
				TcssInfoDAO TcssInfodao=new TcssInfoDAO();
				TcssInfoobj.setTcss_id_number(request.getParameter("tcss_id_number"));
				TcssInfoobj.setName(request.getParameter("tcss_name"));
				TcssInfoobj.setGender(request.getParameter("gender"));
				TcssInfoobj.setContact_number(request.getParameter("contact_no"));
				TcssInfoobj.setAddress(request.getParameter("address"));
				TcssInfoobj.setDate_of_birth(request.getParameter("dob"));
				TcssInfoobj.setDate_of_joining(request.getParameter("doj"));
				TcssInfoobj.setYears_of_exp(request.getParameter("experience"));
				TcssInfoobj.setVehicle_number(request.getParameter("vehicle_number"));
				TcssInfoobj.setRoute_number(request.getParameter("Route_number"));
				
				
				
		
				TcssInfodao.TcssInfoValidate(TcssInfoobj);
				
						RequestDispatcher rd=request.getRequestDispatcher("/JSP/tcss.jsp?message=success");
						rd.forward(request, response);
					
									
			}

}

