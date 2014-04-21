package com.ts.service;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import com.ts.dao.CustomerInfoDAO;
import com.ts.domain.CustomerInfo;


@SuppressWarnings("serial")
public class CustomerInfoService extends CommonService{
int counter;
	@Override
	public void run() throws ServletException, IOException {
	
				CustomerInfo customerinfoobj =new CustomerInfo();
				CustomerInfoDAO customerinfodao=new CustomerInfoDAO();
					ses=request.getSession();
				customerinfoobj.setCustomername(request.getParameter("customer_name"));
				customerinfoobj.setCustomer_address(request.getParameter("customer_address"));
				customerinfoobj.setCustomer_number(request.getParameter("contact_number"));
				customerinfoobj.setContact_person(request.getParameter("contact_person"));
				customerinfoobj.setContract_start_date(request.getParameter("contarct_start_date"));
				customerinfoobj.setContract_end_date(request.getParameter("contarct_end_date"));
				//customerinfoobj.setNumber_of_licence(Integer.parseInt(request.getParameter("No_Of_Licence")));
				customerinfoobj.setCustomer_id(request.getParameter("customer_id"));
				customerinfoobj.setNumber_of_licence(Integer.parseInt(request.getParameter("number_of_licence")));
				//int no_of_licence=Integer.parseInt(request.getParameter("No_Of_Licence"));
				//String customer_name=request.getParameter("customer_name");
				//String customer_id=request.getParameter("customer_id");
				
				//System.out.println("no of licence by customer"+no_of_licence);
				//ses.setAttribute("no_of_licence",no_of_licence);
				//ses.setAttribute("customer_name",customer_name);
				//ses.setAttribute("customer_id",customer_id);
				customerinfodao.customerInfoValidate(customerinfoobj);
				
						RequestDispatcher rd=request.getRequestDispatcher("/JSP/MGMT_customerinfo.jsp?message=success");
						rd.forward(request, response);
					
									
			}

}
