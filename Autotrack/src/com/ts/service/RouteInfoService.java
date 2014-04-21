package com.ts.service;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import com.ts.dao.RouteInfoDAO;
import com.ts.domain.RouteInfo;


@SuppressWarnings("serial")
public class RouteInfoService extends CommonService{
int counter;
	@Override
	public void run() throws ServletException, IOException {
	
				RouteInfo RouteInfoobj =new RouteInfo();
				RouteInfoDAO RouteInfodao=new RouteInfoDAO();
				
				RouteInfoobj.setRoute_no(request.getParameter("route_no"));
				RouteInfoobj.setSource(request.getParameter("source"));
				RouteInfoobj.setDestination(request.getParameter("destination"));
				RouteInfoobj.setVehicle_no(request.getParameter("vehicle_no"));
				
		
						RouteInfodao.RouteInfoValidate(RouteInfoobj);
				
						RequestDispatcher rd=request.getRequestDispatcher("/JSP/Route_info.jsp");
						rd.forward(request, response);
					
									
			}

}
