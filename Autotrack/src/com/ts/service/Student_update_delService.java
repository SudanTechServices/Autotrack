package com.ts.service;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import com.ts.dao.Student_update_del_DAO;
import com.ts.domain.StudentInfo;


@SuppressWarnings("serial")

public class Student_update_delService extends CommonService{
	@Override
	public void run() throws ServletException, IOException {
		//Map map=new HashMap();
		ses=request.getSession();
				//PrintWriter out=response.getWriter();
		//System.out.println("verified");
			/*String customer_name=(String)ses.getAttribute("customer_name"); */
			String belongs=(String)request.getParameter("customer_id");
			
				StudentInfo studentinfoobj =new StudentInfo();
				Student_update_del_DAO studentinfodao=new Student_update_del_DAO();
				studentinfoobj.setEnrollment_number(request.getParameter("enrolment_number"));
				studentinfoobj.setName(request.getParameter("name"));
				studentinfoobj.setGender(request.getParameter("gender"));
				studentinfoobj.setStandard(request.getParameter("standard"));
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
				studentinfoobj.setMother_occupation(request.getParameter("mother_occupation"));
				studentinfoobj.setMother_designation(request.getParameter("mother_designation"));
				studentinfoobj.setMother_office_address(request.getParameter("mother_office_address"));
				studentinfoobj.setMother_contact_number(request.getParameter("mother_contact_number"));
				studentinfoobj.setMother_email(request.getParameter("mother_email"));
				studentinfoobj.setResidential_number(request.getParameter("residential_number"));
				
				//studentinfoobj.setBelongs(belongs);
				
				studentinfodao.StudentInfoUpdateValidate(studentinfoobj);
				//int no_of_licence=(Integer)ses.getAttribute("no_of_licence");
				
				//no_of_licence--;
				//System.out.println("now of no of licence="+no_of_licence);
				//ses.setAttribute("no_of_licence",no_of_licence);
				//if(no_of_licence>0)
				//{
				studentinfoobj.setAction(request.getParameter("action"));
			    String i=request.getParameter("action");
			
				System.out.println("Button Clicked is :::"+i);
				int row=studentinfodao.StudentInfoUpdateValidate(studentinfoobj);
				System.out.println("row"+row);
				if(row>0)
						{
					
					      if(i.equalsIgnoreCase("Update")) 
					      {
							RequestDispatcher rd=request.getRequestDispatcher("/JSP/CRM_studentregistration.jsp?message=updated");
							rd.forward(request, response);
							
						}
					      else if(i.equalsIgnoreCase("Delete"))
					      {
					    	  RequestDispatcher rd=request.getRequestDispatcher("/JSP/CRM_studentregistration.jsp?message=deleted");
								rd.forward(request, response);
					      }
						}
															
			}

}