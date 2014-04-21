package com.ts.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.Date;

import com.lowagie.text.Document;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfWriter;


import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;


public class create_pdf extends CommonService {


	public void run() throws ServletException, IOException
	{
		String filename = "StorePdf.pdf";
response.setContentType("text/html;charset=UTF-8");
PrintWriter out = response.getWriter();
response.setContentType("application/pdf");
response.setHeader("Content-Disposition", "inline;filename="+filename);

try {
//OutputStream file = new FileOutputStream(new File("/home/aatman4/Desktop/gp.pdf"));

Document document = new Document();
PdfWriter.getInstance(document,new FileOutputStream(filename));
document.open();
String name=request.getParameter("username");
String age=request.getParameter("age");
String lname=request.getParameter("userlname");
document.add(new Paragraph("Disney World "));
document.add(new Paragraph(new Date().toString()));
document.add(new Paragraph(name));

document.add(new Paragraph(lname));
document.add(new Paragraph(age));
document.add(new Paragraph(name));

document.close();
//file.close();
out.println("<table>");
out.println("<tr>");
out.println("<th><h1>" + name + "</h1></th>");
out.println("</tr>");
out.println("<th><h1>" + age + "</h1></th>");
out.println("<tr>");
out.println("<th><h1>" + lname + "</h1></th>");
out.println("</tr>");
out.println("<div align='center'><h1> succefully created pdf</h1></div>");

	
} catch (Exception e) {
System.err.println(e);
//e.printStackTrace();
} finally {
out.close();
}
}


}

