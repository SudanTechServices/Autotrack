package com.ts.controller;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

import com.ts.service.CommonService;

import java.io.*;


public class ExcelControllerServlet extends HttpServlet 
{
	
	public void doGet(HttpServletRequest request,HttpServletResponse response)
	throws ServletException,IOException
	{
		doPost(request,response);
	}

	public void doPost(HttpServletRequest request,HttpServletResponse response)
	throws ServletException,IOException
	{
		PrintWriter out=response.getWriter();
		HttpSession session=request.getSession();
		out.println(session);
		Map actionMap=(Map)session.getAttribute("actionMap");

		if(actionMap==null){
		
			actionMap=new HashMap();
			session.setAttribute("actionMap",actionMap);
		}

		ServletContext context=getServletContext();//to get real path to map a URI

		try{
			String pathInfo=request.getPathInfo();
//			System.out.println(pathInfo);
			if(pathInfo==null)
				throw new ServletException("Invalid internal state-No path Found");

			CommonService cs=(CommonService)actionMap.get(pathInfo); 
			
			if(cs==null) 
			{
				StringTokenizer st=new StringTokenizer(pathInfo,"/");

				if(st.countTokens()!=1)
				 	throw new ServletException("Invalid Internal State -Invalid Path");
				String name=st.nextToken();//it identify the class whose calling me /Login/ControllerServlet/LoginService
				//name it store LoginService
			
				String className="com.ts.excelservlet."+name;//it call to the LoginService class which is available in com.ts.service
				
				try
				{
					Class actionClass=Class.forName(className);
					cs=(CommonService)actionClass.newInstance();//it create an instance of 
				}
				catch(ClassNotFoundException e)
				{
					throw new ServletException("Could not load class"+className+":"+e.getMessage());

				}
				catch(InstantiationException e)
				{
					throw new ServletException("Could Not Create Instance of a class "+className+":"+e.getMessage());

				}
				catch(IllegalAccessException e)
				{
					throw new ServletException(className+":"+e.getMessage());
				}

				actionMap.put(pathInfo,cs);
			}//end if
				cs.setRequest(request);
				cs.setResponse(response);
				cs.setApplication(context);
				cs.run();
		}//end try
		catch(ServletException se)
		{
			out.println(se);
				//RequestDispatcher rd=context.getRequestDispatcher("/JSP/ErrorPage.jsp");
				//rd.forward(request,response);
		}// end catch
	}// end post
}// end class

