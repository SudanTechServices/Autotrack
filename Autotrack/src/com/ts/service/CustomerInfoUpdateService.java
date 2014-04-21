package com.ts.service;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import com.ts.dao.CustomerInfoUpdateDAO;
import com.ts.domain.CustomerInfo;








@SuppressWarnings("serial")
public class CustomerInfoUpdateService extends CommonService{
int counter;
	@Override
	public void run() throws ServletException, IOException {
	
		        CustomerInfo customerinfoobj =new CustomerInfo();
				CustomerInfoUpdateDAO Customerinfoupdatedao=new CustomerInfoUpdateDAO();
				
				ses=request.getSession();
				customerinfoobj.setCustomer_id(request.getParameter("customer_id"));
				//System.out.println(request.getParameter("transnum"));
				//System.out.println(request.getParameter("route_numbers"));
				customerinfoobj.setCustomername(request.getParameter("customer_name"));
				customerinfoobj.setCustomer_address(request.getParameter("customer_address"));
				customerinfoobj.setCustomer_number(request.getParameter("contact_number"));
				customerinfoobj.setContact_person(request.getParameter("contact_person"));
				customerinfoobj.setContract_start_date(request.getParameter("contract_Start_date"));
				customerinfoobj.setContract_end_date(request.getParameter("contract_End_date"));
				customerinfoobj.setNumber_of_licence(Integer.parseInt(request.getParameter("number_of_licence")));
				customerinfoobj.setAction(request.getParameter("action1"));
				
			  String i=request.getParameter("action1");
			
				System.out.println("Button Clicked is :::"+i);
				int row=Customerinfoupdatedao.CustomerInfoUpdateValidate(customerinfoobj);
				
				if(row>0)
						{
					
					      if(i.equalsIgnoreCase("Update")) 
					      {
							RequestDispatcher rd=request.getRequestDispatcher("/JSP/MGMT_customerinfo.jsp?message=updated");
							rd.forward(request, response);
							
						}
					      else if(i.equalsIgnoreCase("Delete"))
					      {
					    	  RequestDispatcher rd=request.getRequestDispatcher("/JSP/MGMT_customerinfo.jsp?message=deleted");
								rd.forward(request, response);
					      }
						}
															
			}

}

