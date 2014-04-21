package com.ts.service;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import com.ts.dao.VehicleInfoDAO;
import com.ts.domain.VehicleInfo;

@SuppressWarnings("serial")

public class VehicleInfoService extends CommonService{
	@Override
	public void run() throws ServletException, IOException {
		//Map map=new HashMap();
		ses=request.getSession();
				//PrintWriter out=response.getWriter();
		//System.out.println("verified");
			/*String customer_name=(String)ses.getAttribute("customer_name"); */
			String belongs=(String)request.getParameter("customer_id");
			
				VehicleInfo vehicleinfoobj =new VehicleInfo();
				VehicleInfoDAO vehicleinfodao=new VehicleInfoDAO();
				vehicleinfoobj.setCustomer_id(request.getParameter("customer_id"));
				vehicleinfoobj.setCustomer_name(request.getParameter("customer_name"));
				vehicleinfoobj.setSim_no(request.getParameter("Sim_no"));
				vehicleinfoobj.setImei_no(request.getParameter("IMEI_no"));
				vehicleinfoobj.setCamera_id(request.getParameter("camera_id"));
				vehicleinfoobj.setVehicle_no(request.getParameter("vehicle_number"));
				vehicleinfoobj.setVehicle_type(request.getParameter("vehicle_type"));
				vehicleinfoobj.setVehicle_mfg(request.getParameter("vechile_mfg"));
				vehicleinfoobj.setFuel_tank(Double.parseDouble(request.getParameter("fuel_capacity")));
				vehicleinfoobj.setMax_speed(Integer.parseInt(request.getParameter("max_speed")));
			    vehicleinfoobj.setFuel_sender(request.getParameter("fuel_sender"));
				vehicleinfoobj.setMin_fuel_volt(Double.parseDouble(request.getParameter("min_fuel_volt")));
				vehicleinfoobj.setMax_fuel_volt(Double.parseDouble(request.getParameter("max_fuel_volt")));
				vehicleinfoobj.setBelongs(belongs);
				
				vehicleinfodao.vehicleInfoValidate(vehicleinfoobj);
				//int no_of_licence=(Integer)ses.getAttribute("no_of_licence");
				
				//no_of_licence--;
				//System.out.println("now of no of licence="+no_of_licence);
				//ses.setAttribute("no_of_licence",no_of_licence);
				//if(no_of_licence>0)
				//{
					RequestDispatcher rd=request.getRequestDispatcher("/JSP/MGMT_vehiclereg.jsp?message=success");
					rd.forward(request, response);
					
				//}
				//else
				//{
					//RequestDispatcher rd=request.getRequestDispatcher("/JSP/MGMT_customerinfo.jsp?message=success");
					//rd.forward(request, response);
					//ses.removeAttribute("no_of_licence");
					//ses.removeAttribute("customer_name");
					//ses.removeAttribute("customer_id");
				//}
				
			}
}
