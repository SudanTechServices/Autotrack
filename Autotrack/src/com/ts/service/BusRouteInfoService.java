package com.ts.service;

import java.io.IOException;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import com.ts.dao.BusRouteInfoDAO;

import com.ts.domain.BusRouteInfo;



@SuppressWarnings("serial")
public class BusRouteInfoService extends CommonService{
int counter;
	@Override
	public void run() throws ServletException, IOException {
	
		BusRouteInfo busrouteinfoobj =new BusRouteInfo();
				BusRouteInfoDAO busrouteinfodao=new BusRouteInfoDAO();
				
				ses=request.getSession();
				busrouteinfoobj.setBus_route_number(request.getParameter("route_number"));
				busrouteinfoobj.setSource(request.getParameter("source"));
				busrouteinfoobj.setDestination(request.getParameter("destination"));
				busrouteinfoobj.setStopping_point_1(request.getParameter("limit1"));
				busrouteinfoobj.setRate_1(request.getParameter("rate1"));
				busrouteinfoobj.setStopping_point_2(request.getParameter("limit2"));
				busrouteinfoobj.setRate_2(request.getParameter("rate2"));
				busrouteinfoobj.setStopping_point_3(request.getParameter("limit3"));
				busrouteinfoobj.setRate_3(request.getParameter("rate3"));
				busrouteinfoobj.setStopping_point_4(request.getParameter("limit4"));
				busrouteinfoobj.setRate_4(request.getParameter("rate4"));
				busrouteinfoobj.setStopping_point_5(request.getParameter("limit5"));
				busrouteinfoobj.setRate_5(request.getParameter("rate5"));
				busrouteinfoobj.setVehiclenumber(request.getParameter("vehicle_no"));
				
			   busrouteinfodao.busrouteInfoValidate(busrouteinfoobj);
				
						
						
							RequestDispatcher rd=request.getRequestDispatcher("/JSP/routeregistration.jsp?message=sucesss");
							rd.forward(request, response);
							
						}
						
					
									
}

