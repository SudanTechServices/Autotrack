package com.ts.service;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import com.ts.dao.ShiftInfoDeleteDAO;
import com.ts.dao.ShiftInfoUpdateDAO;
import com.ts.domain.ShiftInfo;




@SuppressWarnings("serial")
public class ShiftInfoDeleteService extends CommonService{
int counter;
	@Override
	public void run() throws ServletException, IOException {
	
				ShiftInfo shiftInfoobj =new ShiftInfo();
				ShiftInfoDeleteDAO ShiftInfodao=new ShiftInfoDeleteDAO();
				ses=request.getSession();
				shiftInfoobj.setShift_id(request.getParameter("shift_id"));
				shiftInfoobj.setStart_time(request.getParameter("start_time"));
				shiftInfoobj.setEnd_time(request.getParameter("end_time"));
				
		
				int row=ShiftInfodao.ShiftInfoValidate(shiftInfoobj);
				
				if(row>0)
				{
					
					RequestDispatcher rd=request.getRequestDispatcher("/JSP/drivershiftinfo.jsp?message=updated");
					rd.forward(request, response);
					
				}
				
					
									
			}

}
