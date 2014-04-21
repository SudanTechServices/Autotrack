package com.ts.service;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import com.ts.dao.CustomerInfoUpdateDAO;
import com.ts.dao.VehicleInfoUpdateDAO;
import com.ts.domain.CustomerInfo;
import com.ts.domain.VehicleInfo;

@SuppressWarnings("serial")
public class VehicleInfoUpdateDeleteService extends CommonService{
int counter;
	@Override
	public void run() throws ServletException, IOException {
	
		VehicleInfo vehicleinfoobj =new VehicleInfo();
		VehicleInfoUpdateDAO vehicleinfoupdatedao=new VehicleInfoUpdateDAO();
				
				ses=request.getSession();
				vehicleinfoobj.setCustomer_id(request.getParameter("customer_id"));
				vehicleinfoobj.setCustomer_name(request.getParameter("customer_name"));
				vehicleinfoobj.setVehicle_no(request.getParameter("vehicle_number"));
				vehicleinfoobj.setVehicle_type(request.getParameter("vehicle_type"));
				vehicleinfoobj.setFuel_tank(Double.parseDouble(request.getParameter("fuel_capacity")));
				vehicleinfoobj.setSim_no(request.getParameter("Sim_no"));
				vehicleinfoobj.setImei_no(request.getParameter("IMEI_no"));
				vehicleinfoobj.setCamera_id(request.getParameter("camera_id"));
				vehicleinfoobj.setVehicle_mfg(request.getParameter("vechile_mfg"));
				vehicleinfoobj.setMax_speed(Integer.parseInt(request.getParameter("max_speed")));
				vehicleinfoobj.setFuel_sender(request.getParameter("fuel_sender"));
				vehicleinfoobj.setMin_fuel_volt(Double.parseDouble(request.getParameter("min_fuel_volt")));
				vehicleinfoobj.setMax_fuel_volt(Double.parseDouble(request.getParameter("max_fuel_volt")));
				vehicleinfoobj.setAction1(request.getParameter("action1"));
			    String i=request.getParameter("action1");
			
				System.out.println("Button Clicked is :::"+i);
				int row=vehicleinfoupdatedao.VehicleInfoUpdateValidate(vehicleinfoobj);
				
				if(row>0)
						{
					
					      if(i.equalsIgnoreCase("Update")) 
					      {
							RequestDispatcher rd=request.getRequestDispatcher("/JSP/MGMT_vehiclereg.jsp?message=updated");
							rd.forward(request, response);
							
						}
					      else if(i.equalsIgnoreCase("Delete"))
					      {
					    	  RequestDispatcher rd=request.getRequestDispatcher("/JSP/MGMT_vehiclereg.jsp?message=deleted");
								rd.forward(request, response);
					      }
						}
															
			}

}

