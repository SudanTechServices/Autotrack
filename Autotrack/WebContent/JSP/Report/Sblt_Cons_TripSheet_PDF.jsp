	<%@page import="javax.swing.GroupLayout.Alignment"%>
<%@page import="java.awt.Color"%>
<%@page import="java.util.concurrent.ExecutionException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	    pageEncoding="ISO-8859-1"%>
	    
	<%@page import="java.io.*"%>
	<%@page import="java.sql.Connection"%>
	<%@page import="java.sql.ResultSet"%>
	<%@page import="java.sql.Statement"%>
	<%@page import="com.lowagie.text.*"%>
	<%@page import=" com.lowagie.text.pdf.*"%>
	<%@page import="com.ts.dbtransactionmgr.DBTransaction" %>
	<%@page import="com.lowagie.text.pdf.PdfReader" %>
	<%@page import="java.text.DateFormat" %>
	<%@page import="java.text.ParseException" %>
	<%@page import="java.text.SimpleDateFormat" %>
	<%@page import="java.util.Date" %>
	<%@page import="com.ts.excelservlet.Excel_Consolidated_Trip_report" %>
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Consolidated PDF for Trip Sheet</title>
	</head>
	<body>
   <%
   
   	/* 	Sblt_TripSheet_DAO sblt=new Sblt_TripSheet_DAO();
   		System.out.println("only date time is :"+sblt.getDate_time());
   		System.out.println("session coverage  "+session.getAttribute("coverage"));
   		System.out.println("sblt.getPayment()  "+sblt.getPayment());
   		 */
   		
   		String vehicle_no = request.getParameter("vehicle_number");
   		String date_time =request.getParameter("date_time");
   		System.out.println("Vehicle No :"+vehicle_no +"   date time "+date_time);
   		
   		
   		response.setContentType("application/pdf");
   		String filename="TripSheet.pdf";
   		
   		response.setHeader("Content-Disposition", "attachment;filename=" + filename);
   		
   		try{
   		/* DBTransaction dbtrans =new DBTransaction();
   		Connection con =dbtrans.connect();
   		Statement st =con.createStatement();
   		String pdfQuery ="Select * from trans_trip_sheet where vehicle_number ='"+vehicle_no+"' and date_time='"+date_time+"' ";
   		System.out.println("pdf query is "+pdfQuery);
   		ResultSet rs = st.executeQuery(pdfQuery); */
   		
   		/* while(rs.next()){
   	 //String asdf=rs.getString("");
   	
   		} */
   		OutputStream out1  = response.getOutputStream();
   		Document document=new Document(PageSize.A4,20,10,64,44);
   	    PdfWriter writer=PdfWriter.getInstance(document,response.getOutputStream());	    
   		Font style=new Font();
   		style.setStyle("bold");		
   		style.setSize(7);
   		style.isBold();
   		
   		
    	document.open();	    
   	       Image image = Image.getInstance("/E:/workspace/Autotrack/WebContent/images/sblt.png");
   	       Image headerImage = Image.getInstance("/E:/workspace/Autotrack/WebContent/images/Sblt_header.jpg");
   		 	Font headerStyle=new Font();
   		 	headerStyle.setStyle("bold");
   		 	headerStyle.setColor(0, 143, 235);
   		 	headerStyle.setSize(16);
   		 	headerStyle.isBold();
   	PdfPCell cell;
   	
   	 Font smallSize=new Font();
   	 smallSize.setSize(9);

   	
   	
   	Color clr =new Color(111,186,243);
   		    float[] widths ={5,10};
   		    PdfPTable table=new PdfPTable(widths);
   		    table.setWidthPercentage(100);
   	        table.addCell(image);
   	        table.addCell(headerImage);
   	        
   	        cell = new PdfPCell(new Paragraph(""));
   	        cell.setFixedHeight(10);
   	        cell.setBorder(Rectangle.NO_BORDER);
   	        table.addCell(cell);
   	        
   	        cell = new PdfPCell(new Paragraph(""));
	        cell.setFixedHeight(10);
	        cell.setBorder(Rectangle.NO_BORDER);
	        table.addCell(cell);
   	 //  table.
   	 
   	 Font font = new Font(Font.NORMAL, 10, Font.BOLD);
	 font.setColor(new Color(74,201,255)); //sky blue color
			
	 
	  Font white_font = new Font(Font.NORMAL, 10, Font.BOLD);
	  white_font.setColor(new Color(255,255,255)); 
   	   
   	 float[] vehicleWidths={7,4,7,7};   
   	 PdfPTable veh_table=new PdfPTable(vehicleWidths);
   	 veh_table.setWidthPercentage(100);
   	 
	   	 cell = new PdfPCell(new Paragraph("Vehicle Type :"+request.getParameter("vehicle_type"),smallSize));
	   	 cell.setBorder(Rectangle.NO_BORDER);
	   	 cell.setBackgroundColor(clr);
	   	 veh_table.addCell(cell);
	   	 
	   	 cell = new PdfPCell(new Paragraph(request.getParameter("ac"),smallSize));
	   	 cell.setBorder(Rectangle.NO_BORDER);	
	   	 cell.setBackgroundColor(clr);
	   	 veh_table.addCell(cell);
	   	 
	   	 cell = new PdfPCell(new Paragraph("Vehicle Number :"+request.getParameter("vehicle_number"),smallSize));
	   	 cell.setBorder(Rectangle.NO_BORDER);			 
	   	 cell.setBackgroundColor(clr);
	   	 veh_table.addCell(cell);
	   	 
	   	 cell = new PdfPCell(new Paragraph("DateTime :"+request.getParameter("date_time"),smallSize));
	   	 cell.setBorder(Rectangle.NO_BORDER);		   
	   	 cell.setBackgroundColor(clr);
	   	 veh_table.addCell(cell);	
	   	 
	   	
  	 	
   	 
   	 
	   	 
	   	 
	   	 
	   	 
	   	 
   	 float[] clntWidths={6,7,7,2,7,4,4};   
   	
   	 
   	 PdfPTable clnt_table=new PdfPTable(clntWidths);
   	 clnt_table.setWidthPercentage(100);
   	 clnt_table.setHorizontalAlignment(Element.ALIGN_LEFT);
   
	   	cell = new PdfPCell(new Paragraph("   ")); 
	 	cell.setHorizontalAlignment(Element.ALIGN_CENTER);
	    cell.setBorder(Rectangle.NO_BORDER);
		 cell.setFixedHeight(15.0f);
		 cell.setColspan(7);
	    clnt_table.addCell(cell);
	    
	   /*  cell = new PdfPCell(new Paragraph("")); 
	 	cell.setHorizontalAlignment(Element.ALIGN_CENTER);
	    cell.setBorder(Rectangle.NO_BORDER);
		 cell.setFixedHeight(15.0f);
	    clnt_table.addCell(cell);
	    
	    cell = new PdfPCell(new Paragraph("")); 
	 	cell.setHorizontalAlignment(Element.ALIGN_CENTER);
	    cell.setBorder(Rectangle.NO_BORDER);
		 cell.setFixedHeight(15.0f);
	    clnt_table.addCell(cell);
	    
	    cell = new PdfPCell(new Paragraph("")); 
	 	cell.setHorizontalAlignment(Element.ALIGN_CENTER);
	    cell.setBorder(Rectangle.NO_BORDER);
		 cell.setFixedHeight(15.0f);
	    clnt_table.addCell(cell);
	    
	    cell = new PdfPCell(new Paragraph("")); 
	 	cell.setHorizontalAlignment(Element.ALIGN_CENTER);
	    cell.setBorder(Rectangle.NO_BORDER);
		 cell.setFixedHeight(15.0f);
	    clnt_table.addCell(cell);
	    
	    cell = new PdfPCell(new Paragraph("")); 
	 	cell.setHorizontalAlignment(Element.ALIGN_CENTER);
	    cell.setBorder(Rectangle.NO_BORDER);
		 cell.setFixedHeight(15.0f);
	    clnt_table.addCell(cell);
	    
	    cell = new PdfPCell(new Paragraph("")); 
	 	cell.setHorizontalAlignment(Element.ALIGN_CENTER);
	    cell.setBorder(Rectangle.NO_BORDER);	
		 cell.setFixedHeight(15.0f);
	    clnt_table.addCell(cell); */
	    
	    //upto this making gap between top table and client table(clnt_table)
	    
   		cell = new PdfPCell(new Paragraph("Client ",smallSize));  
   		cell.setHorizontalAlignment(Element.ALIGN_CENTER);
  	 	clnt_table.addCell(cell);
  	 	
  	 	cell = new PdfPCell(new Paragraph(request.getParameter("client"),smallSize));
  	 	cell.setHorizontalAlignment(Element.ALIGN_CENTER);
  	 	clnt_table.addCell(cell);
  	 	
  	 	cell = new PdfPCell(new Paragraph("    ")); 
	 	cell.setHorizontalAlignment(Element.ALIGN_CENTER);
	    cell.setBorder(Rectangle.NO_BORDER);
	   	cell.setColspan(2);
	    clnt_table.addCell(cell);
	    
	   /*  cell = new PdfPCell(new Paragraph("    ")); 
	 	cell.setHorizontalAlignment(Element.ALIGN_CENTER);
	    cell.setBorder(Rectangle.NO_BORDER);
	    clnt_table.addCell(cell); */
  	 	
	     cell = new PdfPCell(new Paragraph("Details",white_font));  		
		 cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		 cell.setBackgroundColor(clr);
		 clnt_table.addCell(cell);
		  
		  cell = new PdfPCell(new Paragraph("Rs",white_font));  		  
		  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		  cell.setBackgroundColor(clr);
		  clnt_table.addCell(cell);
		  
		  cell = new PdfPCell(new Paragraph("P",white_font));  		  
		  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		  cell.setBackgroundColor(clr);
		  clnt_table.addCell(cell);
		  
	    
	    
  	 	cell = new PdfPCell(new Paragraph("Boarding Point ",smallSize));
  	 	cell.setHorizontalAlignment(Element.ALIGN_CENTER);
  	 	clnt_table.addCell(cell);
  	 	
  	 	cell = new PdfPCell(new Paragraph(request.getParameter("boarding"),smallSize));
  	 	cell.setHorizontalAlignment(Element.ALIGN_CENTER);
  	 	clnt_table.addCell(cell);
  	 	
  	 	cell = new PdfPCell(new Paragraph("    ")); 
	 	cell.setHorizontalAlignment(Element.ALIGN_CENTER);
	    cell.setBorder(Rectangle.NO_BORDER);
	   	cell.setColspan(2);
	    clnt_table.addCell(cell);
	    
	    cell = new PdfPCell(new Paragraph("Hire Changes",smallSize));  		  
		  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		  clnt_table.addCell(cell);
		  
		  cell = new PdfPCell(new Paragraph(request.getParameter("hire"),smallSize));  		  
		  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		  clnt_table.addCell(cell);
		  
		  cell = new PdfPCell(new Paragraph(request.getParameter("hireP"),smallSize));  		  
		  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		  clnt_table.addCell(cell);
  	 	
  	 	
  	 	
  	 	cell = new PdfPCell(new Paragraph("Ordered By",smallSize)); 
  	 	cell.setHorizontalAlignment(Element.ALIGN_CENTER);
  	 	clnt_table.addCell(cell);
  	 	
  	 	cell = new PdfPCell(new Paragraph(request.getParameter("order"),smallSize));
  	 	cell.setHorizontalAlignment(Element.ALIGN_CENTER);
  	 	clnt_table.addCell(cell);
  	 	
  	 	cell = new PdfPCell(new Paragraph("    ")); 
	 	cell.setHorizontalAlignment(Element.ALIGN_CENTER);
	    cell.setBorder(Rectangle.NO_BORDER);
	   	cell.setColspan(2);
	    clnt_table.addCell(cell);
  	 	
	    cell = new PdfPCell(new Paragraph("Excess Hours",smallSize));  		  
		  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		  clnt_table.addCell(cell);

		  cell = new PdfPCell(new Paragraph(request.getParameter("e_hour"),smallSize));  		  
		  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		  clnt_table.addCell(cell);
		  
		  cell = new PdfPCell(new Paragraph(request.getParameter("e_hourP"),smallSize));  		  
		  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		  clnt_table.addCell(cell);	
  	 	
  	 	
  	 	
  	 	cell = new PdfPCell(new Paragraph("Driver Name",smallSize));  	
  	 	cell.setHorizontalAlignment(Element.ALIGN_CENTER);
  	 	clnt_table.addCell(cell);
  	 	
  	 	cell = new PdfPCell(new Paragraph(request.getParameter("driverName"),smallSize)); 
  	 	cell.setHorizontalAlignment(Element.ALIGN_CENTER);
  	 	clnt_table.addCell(cell);
  	 	
  	 	/* cell = new PdfPCell(new Paragraph("")); 
  	 	cell.setHorizontalAlignment(Element.ALIGN_CENTER);
  	    cell.setBorder(Rectangle.NO_BORDER);	
  	    cell.setFixedHeight(15.0f);
  	 	clnt_table.addCell(cell);
  	 	
  	 	

  	 	
  	 	cell = new PdfPCell(new Paragraph("")); 
  	 	cell.setFixedHeight(15.0f);
  	 	cell.setHorizontalAlignment(Element.ALIGN_CENTER);
  	    cell.setBorder(Rectangle.NO_BORDER);	
  	 	clnt_table.addCell(cell); */
  	 	
  	 	cell = new PdfPCell(new Paragraph("    ")); 
	 	cell.setHorizontalAlignment(Element.ALIGN_CENTER);
	    cell.setBorder(Rectangle.NO_BORDER);
	   	cell.setColspan(2);
	    clnt_table.addCell(cell);
	    
	    cell = new PdfPCell(new Paragraph("Running KM Charge",smallSize));  
		  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		  clnt_table.addCell(cell);
		  
		  cell = new PdfPCell(new Paragraph(request.getParameter("running_km"),smallSize));  		  
		  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		  clnt_table.addCell(cell);
		  
		  cell = new PdfPCell(new Paragraph(request.getParameter("running_kmP"),smallSize));  		  
		  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		  clnt_table.addCell(cell);
	    
		  cell = new PdfPCell(new Paragraph("    ")); 
		 	cell.setHorizontalAlignment(Element.ALIGN_CENTER);
		    cell.setBorder(Rectangle.NO_BORDER);
		   	cell.setColspan(4);
		    clnt_table.addCell(cell);
		    
		    cell = new PdfPCell(new Paragraph("Excess KM Charge",smallSize));  		  
			  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			  clnt_table.addCell(cell);
			  
			  cell = new PdfPCell(new Paragraph(request.getParameter("excess_km"),smallSize));  		  
			  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			  clnt_table.addCell(cell);
			  
			  cell = new PdfPCell(new Paragraph(request.getParameter("excess_kmP"),smallSize));  		  
			  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			  clnt_table.addCell(cell); 
		    
			  
			  cell = new PdfPCell(new Paragraph("Particulars ",white_font));  
			  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			  cell.setBackgroundColor(clr);
			  clnt_table.addCell(cell);
			  
			  cell = new PdfPCell(new Paragraph("Date and Time ",white_font));  
			  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			  cell.setBackgroundColor(clr);
			  clnt_table.addCell(cell);
			  
			  cell = new PdfPCell(new Paragraph("Kilometers",white_font));  
			  cell.setBackgroundColor(clr);
			  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			  clnt_table.addCell(cell);
			  
			  cell = new PdfPCell(new Paragraph("    ")); 
			  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			  cell.setBorder(Rectangle.NO_BORDER);
			  clnt_table.addCell(cell);
			  
			  cell = new PdfPCell(new Paragraph("Driver Betta",smallSize));  		  
			  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			  clnt_table.addCell(cell);
			  
			  cell = new PdfPCell(new Paragraph(request.getParameter("betta"),smallSize));  		  
			  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			  clnt_table.addCell(cell);
			  
			  
			  cell = new PdfPCell(new Paragraph(request.getParameter("bettaP"),smallSize));  		  
			  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			  clnt_table.addCell(cell);
			  
			  
			  
			    
			   cell = new PdfPCell(new Paragraph("Opening",smallSize));  
			   cell.setHorizontalAlignment(Element.ALIGN_CENTER);
			   clnt_table.addCell(cell);
				  
				cell = new PdfPCell(new Paragraph(request.getParameter("opening"),smallSize));  
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				clnt_table.addCell(cell);
				  
				cell = new PdfPCell(new Paragraph(request.getParameter("openingKm"),smallSize));  
				cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				clnt_table.addCell(cell);
				 
				  cell = new PdfPCell(new Paragraph("    ")); 
				  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				  cell.setBorder(Rectangle.NO_BORDER);
				  clnt_table.addCell(cell);
				  
				  cell = new PdfPCell(new Paragraph("Permit Cost",smallSize));  		  
				  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				  clnt_table.addCell(cell);
				  
				  cell = new PdfPCell(new Paragraph(request.getParameter("permit"),smallSize));  		  
				  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				  clnt_table.addCell(cell);
				  
				  cell = new PdfPCell(new Paragraph(request.getParameter("permitP"),smallSize));  		  
				  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				  clnt_table.addCell(cell);
				  
				  
				  cell = new PdfPCell(new Paragraph("Closing",smallSize));  
				  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				  clnt_table.addCell(cell);
				  
				  cell = new PdfPCell(new Paragraph(request.getParameter("close"),smallSize));  
				  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				  clnt_table.addCell(cell);
				  
				  cell = new PdfPCell(new Paragraph(request.getParameter("ClosingKm"),smallSize));  
				  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				  clnt_table.addCell(cell);
				 
				  cell = new PdfPCell(new Paragraph("    ")); 
				  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				  cell.setBorder(Rectangle.NO_BORDER);
				  clnt_table.addCell(cell);
				  
				  cell = new PdfPCell(new Paragraph("Night Halt",smallSize));  		  
				  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				  clnt_table.addCell(cell);
				  
				  cell = new PdfPCell(new Paragraph(request.getParameter("night_halt"),smallSize));  		  
				  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				  clnt_table.addCell(cell);
				  
				  cell = new PdfPCell(new Paragraph(request.getParameter("night_haltP"),smallSize));  		  
				  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				  clnt_table.addCell(cell);
				  
				  cell = new PdfPCell(new Paragraph("Coverage",smallSize));  
				  cell.setHorizontalAlignment(Element.ALIGN_CENTER);		  
				  clnt_table.addCell(cell);
				  
				  cell = new PdfPCell(new Paragraph((String)session.getAttribute("coverage"),smallSize));  
				  cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				  cell.setPaddingRight(42);
				  cell.setColspan(2);
				  clnt_table.addCell(cell);
				  
				  cell = new PdfPCell(new Paragraph("    ")); 
				  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				  cell.setBorder(Rectangle.NO_BORDER);
				  clnt_table.addCell(cell);
				  
				  
				  cell = new PdfPCell(new Paragraph("Hills Charge",smallSize));  		  
				  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				  clnt_table.addCell(cell);
				  
				  cell = new PdfPCell(new Paragraph(request.getParameter("hillsCharge"),smallSize));  		  
				  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				  clnt_table.addCell(cell);
				  
				  cell = new PdfPCell(new Paragraph(request.getParameter("hillsChargeP"),smallSize));  		  
				  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				  clnt_table.addCell(cell);
				  
				  cell = new PdfPCell(new Paragraph("    ")); 
				  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				  cell.setBorder(Rectangle.NO_BORDER);
				  cell.setColspan(4);
				  clnt_table.addCell(cell);
				  
				  cell = new PdfPCell(new Paragraph("Parking/others",smallSize));  		  
				  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				  clnt_table.addCell(cell);
				  
				  cell = new PdfPCell(new Paragraph(request.getParameter("parking"),smallSize));  		  
				  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				  clnt_table.addCell(cell);
				  
				  cell = new PdfPCell(new Paragraph(request.getParameter("parkingP"),smallSize));  		  
				  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				  clnt_table.addCell(cell);
				  
				  cell = new PdfPCell(new Paragraph("1.Kms and time will be calculated from shed to shed.\n2.Interstate entrance Tax, Parking Charges etc. Should be given by the Passengers.\n3.In outstation trips minimum 250km per day average will be charged.",smallSize));
				  cell.setColspan(4);
				  cell.setBorder(Rectangle.NO_BORDER);	
				  clnt_table.addCell(cell);
				  
	    
				  
				  cell = new PdfPCell(new Paragraph("Total",smallSize));  
				  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				  cell.setBorder(Rectangle.NO_BORDER);
				  clnt_table.addCell(cell);
				  
				  cell = new PdfPCell(new Paragraph((String)session.getAttribute("payment"),smallSize));  
				  cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
				  cell.setPaddingRight(80);
				  cell.setBorder(Rectangle.NO_BORDER);
				  cell.setColspan(2);
				  clnt_table.addCell(cell);
				  
				  cell = new PdfPCell(new Paragraph("For Sri Bhagiyalakshmi Tours & Travels",font));  
				  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				//  cell.
				  cell.setColspan(7);
				  cell.setBorder(Rectangle.NO_BORDER);
				  clnt_table.addCell(cell);
				  
				  cell = new PdfPCell(new Paragraph(""));  
				  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				  cell.setColspan(7);
				  cell.setFixedHeight(15);
				  cell.setBorder(Rectangle.NO_BORDER);
				  clnt_table.addCell(cell);
				  
				  cell = new PdfPCell(new Paragraph("Manager"));  
				  cell.setHorizontalAlignment(Element.ALIGN_CENTER);
				  cell.setColspan(7);
				  cell.setBorder(Rectangle.NO_BORDER);
				  clnt_table.addCell(cell);

		  
   		    document.add(table);
   	        document.add(veh_table);
   	        document.add(clnt_table);   	     	
   	   //  document.add(price_table);
   	      //  document.add(kmTables);
   	       
   	     
   		     document.close(); 
   		     out1.close();
   		//con.close();
   		//st.close();
   		//rs.close();
   		}
   		catch(Exception e){
   	e.printStackTrace();
   		}
   %>


	</body>
	</html>