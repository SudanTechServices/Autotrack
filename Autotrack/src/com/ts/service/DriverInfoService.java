package com.ts.service;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import com.ts.dao.DriverInfoDAO;
import com.ts.domain.DriverInfo;


@SuppressWarnings("serial")
public class DriverInfoService extends CommonService{
int counter;
	@Override
	public void run() throws ServletException, IOException {
	
				DriverInfo DriverInfoobj =new DriverInfo();
				DriverInfoDAO DriverInfodao=new DriverInfoDAO();
				//Date Of Birth
				String dob_month = request.getParameter("dob_dropdown_month");
				String dob_day = request.getParameter("dob_dropdown_day");
				String dob_year = request.getParameter("dob_dropdown_year");
				if(dob_month.equalsIgnoreCase("Jan")){ dob_month = "01"; }
				else if(dob_month.equalsIgnoreCase("Feb")){ dob_month = "02"; }
				else if(dob_month.equalsIgnoreCase("Mar")){ dob_month = "03"; }
				else if(dob_month.equalsIgnoreCase("Apr")){ dob_month = "04"; }
				else if(dob_month.equalsIgnoreCase("May")){ dob_month = "05"; }
				else if(dob_month.equalsIgnoreCase("Jun")){ dob_month = "06"; }
				else if(dob_month.equalsIgnoreCase("Jul")){ dob_month = "07"; }
				else if(dob_month.equalsIgnoreCase("Aug")){ dob_month = "08"; }
				else if(dob_month.equalsIgnoreCase("Sep")){ dob_month = "09"; }
				else if(dob_month.equalsIgnoreCase("Oct")){ dob_month = "10"; }
				else if(dob_month.equalsIgnoreCase("Nov")){ dob_month = "11"; }
				else if(dob_month.equalsIgnoreCase("Dec")){ dob_month = "12"; }
				
				if(dob_day.length() <2){ dob_day = "0"+dob_day; }
				
				String Date_of_birth = dob_day+"/"+dob_month+"/"+dob_year;
				
				//Date Of Joining
				String doj_month = request.getParameter("doj_dropdown_month");
				String doj_day = request.getParameter("doj_dropdown_day");
				String doj_year = request.getParameter("doj_dropdown_year");
				if(doj_month.equalsIgnoreCase("Jan")){ doj_month = "01"; }
				else if(doj_month.equalsIgnoreCase("Feb")){ doj_month = "02"; }
				else if(doj_month.equalsIgnoreCase("Mar")){ doj_month = "03"; }
				else if(doj_month.equalsIgnoreCase("Apr")){ doj_month = "04"; }
				else if(doj_month.equalsIgnoreCase("May")){ doj_month = "05"; }
				else if(doj_month.equalsIgnoreCase("Jun")){ doj_month = "06"; }
				else if(doj_month.equalsIgnoreCase("Jul")){ doj_month = "07"; }
				else if(doj_month.equalsIgnoreCase("Aug")){ doj_month = "08"; }
				else if(doj_month.equalsIgnoreCase("Sep")){ doj_month = "09"; }
				else if(doj_month.equalsIgnoreCase("Oct")){ doj_month = "10"; }
				else if(doj_month.equalsIgnoreCase("Nov")){ doj_month = "11"; }
				else if(doj_month.equalsIgnoreCase("Dec")){ doj_month = "12"; }
				
				if(doj_day.length() <2){ doj_day = "0"+doj_day; }
				
				String Date_of_joining = doj_day+"/"+doj_month+"/"+doj_year;
				
				//Date Of Issue
				String doi_month = request.getParameter("doi_dropdown_month");
				String doi_day = request.getParameter("doi_dropdown_day");
				String doi_year = request.getParameter("doi_dropdown_year");
				if(doi_month.equalsIgnoreCase("Jan")){ doi_month = "01"; }
				else if(doi_month.equalsIgnoreCase("Feb")){ doi_month = "02"; }
				else if(doi_month.equalsIgnoreCase("Mar")){ doi_month = "03"; }
				else if(doi_month.equalsIgnoreCase("Apr")){ doi_month = "04"; }
				else if(doi_month.equalsIgnoreCase("May")){ doi_month = "05"; }
				else if(doi_month.equalsIgnoreCase("Jun")){ doi_month = "06"; }
				else if(doi_month.equalsIgnoreCase("Jul")){ doi_month = "07"; }
				else if(doi_month.equalsIgnoreCase("Aug")){ doi_month = "08"; }
				else if(doi_month.equalsIgnoreCase("Sep")){ doi_month = "09"; }
				else if(doi_month.equalsIgnoreCase("Oct")){ doi_month = "10"; }
				else if(doi_month.equalsIgnoreCase("Nov")){ doi_month = "11"; }
				else if(doi_month.equalsIgnoreCase("Dec")){ doi_month = "12"; }
				
				if(doi_day.length() <2){ doi_day = "0"+doi_day; }
				
				String Date_of_issue = doi_day+"/"+doi_month+"/"+doi_year;
				
				
				//Date Of Expiry
				String doe_month = request.getParameter("doe_dropdown_month");
				String doe_day = request.getParameter("doe_dropdown_day");
				String doe_year = request.getParameter("doe_dropdown_year");
				if(doe_month.equalsIgnoreCase("Jan")){ doe_month = "01"; }
				else if(doe_month.equalsIgnoreCase("Feb")){ doe_month = "02"; }
				else if(doe_month.equalsIgnoreCase("Mar")){ doe_month = "03"; }
				else if(doe_month.equalsIgnoreCase("Apr")){ doe_month = "04"; }
				else if(doe_month.equalsIgnoreCase("May")){ doe_month = "05"; }
				else if(doe_month.equalsIgnoreCase("Jun")){ doe_month = "06"; }
				else if(doe_month.equalsIgnoreCase("Jul")){ doe_month = "07"; }
				else if(doe_month.equalsIgnoreCase("Aug")){ doe_month = "08"; }
				else if(doe_month.equalsIgnoreCase("Sep")){ doe_month = "09"; }
				else if(doe_month.equalsIgnoreCase("Oct")){ doe_month = "10"; }
				else if(doe_month.equalsIgnoreCase("Nov")){ doe_month = "11"; }
				else if(doe_month.equalsIgnoreCase("Dec")){ doe_month = "12"; }
				
				if(doe_day.length() <2){ doe_day = "0"+doe_day; }
				
				String Date_of_expiry = doe_day+"/"+doe_month+"/"+doe_year;
				
				DriverInfoobj.setDriver_name(request.getParameter("driver_name"));
				DriverInfoobj.setSex(request.getParameter("gender"));
				DriverInfoobj.setContact_no(request.getParameter("contact_no"));
				DriverInfoobj.setAddress(request.getParameter("address"));
				DriverInfoobj.setDate_of_birth(Date_of_birth);
				DriverInfoobj.setDate_of_joining(Date_of_joining);
				DriverInfoobj.setLicense_number(request.getParameter("license_number"));
				DriverInfoobj.setDate_of_issue(Date_of_issue);
				DriverInfoobj.setDate_of_expiry(Date_of_expiry);
				DriverInfoobj.setVehicle_number(request.getParameter("vehicle_number"));
				DriverInfoobj.setShift_number(request.getParameter("shift_number"));
				DriverInfoobj.setRoute_number(request.getParameter("Route_number"));
				
				
		
						DriverInfodao.DriverInfoValidate(DriverInfoobj);
				
						RequestDispatcher rd=request.getRequestDispatcher("/JSP/MGMT_driverinformation.jsp?message=success");
						rd.forward(request, response);
					
									
			}

}
