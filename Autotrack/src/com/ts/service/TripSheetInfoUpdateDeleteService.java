package com.ts.service;

import java.io.IOException;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import com.ts.dao.CustomerInfoUpdateDAO;
import com.ts.dao.TripSheetInfoUpdateDAO;
import com.ts.domain.CustomerInfo;
import com.ts.domain.TripSheetInfo;

@SuppressWarnings("serial")
public class TripSheetInfoUpdateDeleteService extends CommonService{
int counter;
	@Override
	public void run() throws ServletException, IOException {
	
		TripSheetInfo tripsheetinfoobj =new TripSheetInfo();
		TripSheetInfoUpdateDAO tripsheetinfoupdatedao=new TripSheetInfoUpdateDAO();
				
				ses=request.getSession();
				java.text.DateFormat df = new java.text.SimpleDateFormat("dd/MM/yyyy");
				String todaysdate = df.format(new java.util.Date());
				String day = null;
				Date date = new Date(); 
			   int dayno = date.getDay();
			   if(dayno == 0){ day = "Sunday";}
			   else if(dayno == 1){ day = "Monday";}
			   else if(dayno == 2){ day = "Tuesday";}
			   else if(dayno == 3){ day = "Wednesday";}
			   else if(dayno == 4){ day = "Thursday";}
			   else if(dayno == 5){ day = "Friday";}
			   else if(dayno == 6){ day = "Saturday";}
				
			    tripsheetinfoobj.setSno(Integer.parseInt(request.getParameter("serialnumber")));
				tripsheetinfoobj.setVehicle_number(request.getParameter("vehicle_number"));
				tripsheetinfoobj.setRoute_number(request.getParameter("route_number"));
				tripsheetinfoobj.setDate(todaysdate);
				tripsheetinfoobj.setDays(day);
				tripsheetinfoobj.setStart_km(request.getParameter("start_km"));
				tripsheetinfoobj.setClose_km((request.getParameter("close_km")));
				tripsheetinfoobj.setRun_km(request.getParameter("run_km"));
				tripsheetinfoobj.setPresent_children(request.getParameter("present_children"));
				tripsheetinfoobj.setVehicle_outtime(request.getParameter("vehicle_outtime"));
				tripsheetinfoobj.setVehicle_intime(request.getParameter("vehicle_intime"));
				tripsheetinfoobj.setDriver_name(request.getParameter("driver_name"));
				tripsheetinfoobj.setTcss_name(request.getParameter("tcss_name"));
				
				int row=tripsheetinfoupdatedao.TripSheetInfoUpdateValidate(tripsheetinfoobj);
			
				
							RequestDispatcher rd=request.getRequestDispatcher("/JSP/tripsheet.jsp?message=updated");
							rd.forward(request, response);
							
						
						}
															
			}
