package com.ts.service;

import java.io.IOException;
import java.lang.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;


import com.ts.dao.DriverInfoUpdateDAO;
import com.ts.domain.DriverInfo;



public class DriverInfoUpdateService extends CommonService{

	public void run() throws ServletException, IOException {
	
				DriverInfo DriverInfoobj =new DriverInfo();
				DriverInfoUpdateDAO DriverInfodao=new DriverInfoUpdateDAO();
				//ses=request.getSession();
				DriverInfoobj.setDriver_name(request.getParameter("fullname"));
				DriverInfoobj.setSex(request.getParameter("gender"));
				DriverInfoobj.setContact_no(request.getParameter("contact number"));
				DriverInfoobj.setAddress(request.getParameter("address"));
				DriverInfoobj.setDate_of_birth(request.getParameter("date"));
				DriverInfoobj.setDate_of_joining(request.getParameter("dateofjoin"));
				DriverInfoobj.setLicense_number(request.getParameter("license_number"));
				System.out.println("License Number in Service"+request.getParameter("license_number"));
				DriverInfoobj.setDate_of_issue(request.getParameter("dateofissue"));
				DriverInfoobj.setDate_of_expiry(request.getParameter("dateofexp"));
				DriverInfoobj.setVehicle_number(request.getParameter("vehicleno"));
				DriverInfoobj.setShift_number(request.getParameter("shift"));
				DriverInfoobj.setRoute_number(request.getParameter("routenumber"));
				DriverInfoobj.setAction(request.getParameter("actions"));
				 String i=request.getParameter("actions");
				 System.out.println("Button Clicked is :::"+i);
					
				int row=DriverInfodao.DriverInfoValidate(DriverInfoobj);
				System.out.println(row);
				
				if(row>0)
				
				 {
						RequestDispatcher rd=request.getRequestDispatcher("../jsp/driver_information.jsp?message=updated");
						rd.forward(request, response);
				  }
				else
					
				  {
				    	  RequestDispatcher rd=request.getRequestDispatcher("../jsp/driver_information.jsp?message=deleted");
							rd.forward(request, response);
				  }
					
		}

}
