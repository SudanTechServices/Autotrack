package com.ts.service;

import java.io.IOException;
import java.lang.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;


import com.ts.dao.DriverInfoUpdateDAO;
import com.ts.domain.DriverInfo;


@SuppressWarnings("serial")
public class DriverInfoUpdateService extends CommonService{
int counter;
	@Override
	public void run() throws ServletException, IOException {
	
				DriverInfo DriverInfoobj =new DriverInfo();
				DriverInfoUpdateDAO DriverInfodao=new DriverInfoUpdateDAO();
				ses=request.getSession();
				DriverInfoobj.setDriver_name(request.getParameter("driver_name"));
				DriverInfoobj.setSex(request.getParameter("gender"));
				DriverInfoobj.setContact_no(request.getParameter("contact_no"));
				DriverInfoobj.setAddress(request.getParameter("address"));
				DriverInfoobj.setDate_of_birth(request.getParameter("date_of_birth"));
				DriverInfoobj.setDate_of_joining(request.getParameter("date_of_joining"));
				DriverInfoobj.setLicense_number(request.getParameter("license_number"));
				System.out.println("License Number in Service"+request.getParameter("license_number"));
				DriverInfoobj.setDate_of_issue(request.getParameter("date_of_issue"));
				DriverInfoobj.setDate_of_expiry(request.getParameter("date_of_expiry"));
				DriverInfoobj.setVehicle_number(request.getParameter("vehicle_number"));
				DriverInfoobj.setShift_number(request.getParameter("shift_number"));
				DriverInfoobj.setRoute_number(request.getParameter("Route_number"));
				DriverInfoobj.setAction(request.getParameter("action1"));
				 String i=request.getParameter("action1");
				 System.out.println("Button Clicked is :::"+i);
				int row=DriverInfodao.DriverInfoValidate(DriverInfoobj);
				System.out.println(row);
				
				if(row>0)
				{
					
					 if(i.equalsIgnoreCase("Update")) 
				      {
						RequestDispatcher rd=request.getRequestDispatcher("/JSP/MGMT_driverinformation.jsp?message=updated");
						rd.forward(request, response);
						
					}
				      else if(i.equalsIgnoreCase("Delete"))
				      {
				    	  RequestDispatcher rd=request.getRequestDispatcher("/JSP/MGMT_driverinformation.jsp?message=deleted");
							rd.forward(request, response);
				      }
					
					
				}
				
					
									
			}

}
