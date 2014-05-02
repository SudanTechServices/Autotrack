package com.ts.service;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import com.ts.dao.DriverInfoDAO;
import com.ts.domain.DriverInfo;

public class DriverInfoService extends CommonService{
//int counter;
public void run() throws ServletException, IOException {
	System.out.println("in service");
				DriverInfo DriverInfoobj =new DriverInfo();
				DriverInfoDAO DriverInfodao=new DriverInfoDAO();
				//Date Of Birth
				/*String drivername = request.getParameter("fullname");
				String dob = request.getParameter("date");
				String doj = request.getParameter("dateofjoin");
				String doi = request.getParameter("dateofissue");
				String dox = request.getParameter("dateofexp");*/
				
				DriverInfoobj.setDriver_name(request.getParameter("fullname"));
				DriverInfoobj.setSex(request.getParameter("gender"));
				DriverInfoobj.setContact_no(request.getParameter("contact"));
				DriverInfoobj.setAddress(request.getParameter("address"));
				DriverInfoobj.setDate_of_birth(request.getParameter("date"));
				DriverInfoobj.setDate_of_joining(request.getParameter("dateofjoin"));
				DriverInfoobj.setLicense_number(request.getParameter("licensenumber"));
				DriverInfoobj.setDate_of_issue(request.getParameter("dateofissue"));
				DriverInfoobj.setDate_of_expiry(request.getParameter("dateofexp"));
				DriverInfoobj.setVehicle_number(request.getParameter("vehicleno"));
				DriverInfoobj.setShift_number(request.getParameter("shift"));
				DriverInfoobj.setRoute_number(request.getParameter("routenumber"));
				
				
		
						DriverInfodao.DriverInfoValidate(DriverInfoobj);
				
						RequestDispatcher rd=request.getRequestDispatcher("/jsp/driver_information.jsp?message=success");
						rd.forward(request, response);
					
									
			}

}
