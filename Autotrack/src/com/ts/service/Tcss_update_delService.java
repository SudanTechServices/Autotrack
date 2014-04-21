package com.ts.service;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import com.ts.dao.TcssInfoDAO;
import com.ts.dao.Tcss_update_delDAO;
import com.ts.domain.TcssInfo;




@SuppressWarnings("serial")
public class Tcss_update_delService extends CommonService{
int counter;
	@Override
	public void run() throws ServletException, IOException {
	
				TcssInfo TcssInfoobj =new TcssInfo();
				Tcss_update_delDAO TcssInfodao=new Tcss_update_delDAO();
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
				TcssInfoobj.setAction(request.getParameter("action"));
				String i=request.getParameter("action");
				 System.out.println("Button Clicked is :::"+i);
				
		
				 int row=TcssInfodao.TcssInfoValidate(TcssInfoobj);
				 System.out.println(row);
					
					if(row>0)
					{
						
						 if(i.equalsIgnoreCase("Update")) 
					      {
							RequestDispatcher rd=request.getRequestDispatcher("/JSP/tcss.jsp?message=updated");
							rd.forward(request, response);
							
					      }
					      else if(i.equalsIgnoreCase("Delete"))
					      {
					    	  RequestDispatcher rd=request.getRequestDispatcher("/JSP/tcss.jsp?message=deleted");
								rd.forward(request, response);
					      }
						
						
					}
					
						
										
						
					
									
			}

}

