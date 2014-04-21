package com.ts.service;

import java.io.IOException;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import com.ts.dao.TripSheetInfoDAO;
import com.ts.domain.TripSheetInfo;



@SuppressWarnings("serial")
public class TripSheetInfoService extends CommonService{
int counter;
	@Override
	public void run() throws ServletException, IOException {
	
		TripSheetInfo tripsheetinfoobj =new TripSheetInfo();
				TripSheetInfoDAO tripsheetinfodao=new TripSheetInfoDAO();
				
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
			
			   	tripsheetinfoobj.setSno(Integer.parseInt(request.getParameter("sno")));
			   	tripsheetinfoobj.setVehicle_number(request.getParameter("vehicle_number"));
				tripsheetinfoobj.setRoute_number(request.getParameter("route_number"));
				tripsheetinfoobj.setDate(todaysdate);
				tripsheetinfoobj.setDays(day);
				tripsheetinfoobj.setStart_km(request.getParameter("start_km"));
				tripsheetinfoobj.setClose_km((request.getParameter("close_km")));
				int start_km = Integer.parseInt(request.getParameter("start_km"));
				int close_km = Integer.parseInt(request.getParameter("close_km"));
				int run_km = close_km - start_km;
				String total_km = ""+run_km;
				System.out.println(total_km);
				tripsheetinfoobj.setRun_km(total_km);
				tripsheetinfoobj.setPresent_children(request.getParameter("present_children"));
				tripsheetinfoobj.setVehicle_outtime(request.getParameter("vehicle_outtime"));
				tripsheetinfoobj.setVehicle_intime(request.getParameter("vehicle_intime"));
				tripsheetinfoobj.setDriver_name(request.getParameter("driver_name"));
				tripsheetinfoobj.setTcss_name(request.getParameter("tcss_name"));
				
							
				int row=tripsheetinfodao.tripsheetInfoSave(tripsheetinfoobj);
				if (row>0)
				{
					RequestDispatcher rd=request.getRequestDispatcher("/JSP/tripsheet.jsp");
					rd.forward(request, response);
				}
			
			}

}

