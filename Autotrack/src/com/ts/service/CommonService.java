package com.ts.service;
import com.ts.domain.*;
import com.ts.dao.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
public abstract class CommonService implements Serializable
{
	protected transient HttpServletRequest request;
	protected transient HttpServletResponse response;
	protected transient ServletContext application;
	protected transient HttpSession ses;
	public abstract void run()throws ServletException,IOException;

	
	public HttpSession getSes() {
		return ses;
	}

	public void setSes(HttpSession ses) {
		this.ses = ses;
	}

	public void setRequest(HttpServletRequest request)
	{
		this.request=request;
	}
	public void setResponse(HttpServletResponse response)
	{
		this.response=response;
	}
	public void setApplication(ServletContext application)
	{
		this.application=application;
	}
}



