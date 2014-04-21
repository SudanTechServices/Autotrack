package com.ts.service;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import com.ts.dao.StudentInfoDAO;
import com.ts.domain.StudentInfo;



@SuppressWarnings("serial")
public class StudentInfoService extends CommonService{
int counter;
	@Override
	public void run() throws ServletException, IOException {
	
				StudentInfo studentinfoobj =new StudentInfo();
				StudentInfoDAO studentinfodao=new StudentInfoDAO();
				 
				ses=request.getSession();
				studentinfoobj.setEnrollment_number(request.getParameter("enrolment_number"));
				studentinfoobj.setName(request.getParameter("name"));
				studentinfoobj.setGender((request.getParameter("gender")));
				studentinfoobj.setStandard((request.getParameter("standard")));
				studentinfoobj.setSection(request.getParameter("section"));
				studentinfoobj.setDob(request.getParameter("dob"));
				studentinfoobj.setResidence_address(request.getParameter("address"));
				studentinfoobj.setRoutenumber(request.getParameter("routenumber"));
				studentinfoobj.setLocations(request.getParameter("location"));
				studentinfoobj.setPick_point(request.getParameter("pick_point"));
				studentinfoobj.setPick_up_timing(request.getParameter("pickuptiming"));
				studentinfoobj.setCategory(request.getParameter("category"));
				studentinfoobj.setParent_name(request.getParameter("parentname"));
				studentinfoobj.setOccupation(request.getParameter("occupation"));
				studentinfoobj.setDesignation(request.getParameter("designation"));
				studentinfoobj.setOffice_address(request.getParameter("office_address"));
				studentinfoobj.setContact_number(request.getParameter("contact_number"));
				studentinfoobj.setEmail(request.getParameter("email"));
				studentinfoobj.setMother_name(request.getParameter("mother_name"));
				studentinfoobj.setMother_designation(request.getParameter("mother_designation"));
				studentinfoobj.setMother_occupation(request.getParameter("mother_occupation"));
				studentinfoobj.setMother_office_address(request.getParameter("mother_office_address"));
				studentinfoobj.setMother_contact_number(request.getParameter("mother_contact_number"));
				studentinfoobj.setMother_email(request.getParameter("mother_email"));
				studentinfoobj.setResidential_number(request.getParameter("residential_number"));
				
				int row=studentinfodao.studentInfoSave(studentinfoobj);
				if (row>0)
				{
					RequestDispatcher rd=request.getRequestDispatcher("/JSP/CRM_studentregistration.jsp?message=saved");
					rd.forward(request, response);
				}
			
			}

}
