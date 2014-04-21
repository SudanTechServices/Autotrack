package com.ts.service;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;




@SuppressWarnings("serial")
public class RoutenoInfoService extends CommonService{
int counter;
	@Override
	public void run() throws ServletException, IOException {
	
				
					ses=request.getSession();
				
				int total_route_number=Integer.parseInt(request.getParameter("total_route_number"));
                 ses.setAttribute("total_route_number",total_route_number);
				RequestDispatcher rd=request.getRequestDispatcher("/JSP/routeregistration.jsp");
						rd.forward(request, response);
					
									
			}

}

