package com.ts.service;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import com.ts.dao.ShiftInfoDAO;
import com.ts.domain.ShiftInfo;


@SuppressWarnings("serial")
public class ShiftInfoService extends CommonService{
int counter;
	@Override
	public void run() throws ServletException, IOException {
	
				ShiftInfo ShiftInfoobj =new ShiftInfo();
				ShiftInfoDAO ShiftInfodao=new ShiftInfoDAO();
				
				ShiftInfoobj.setShift_id(request.getParameter("shift_id"));
				ShiftInfoobj.setStart_time(request.getParameter("start_time"));
				ShiftInfoobj.setEnd_time(request.getParameter("end_time"));
				
				
		
						ShiftInfodao.ShiftInfoValidate(ShiftInfoobj);
				
						RequestDispatcher rd=request.getRequestDispatcher("/JSP/drivershiftinfo.jsp?message=success");
						rd.forward(request, response);
					
									
			}

}
