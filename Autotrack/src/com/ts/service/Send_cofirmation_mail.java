package com.ts.service;

import java.io.IOException;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.activation.*;

public class Send_cofirmation_mail extends CommonService
{
	
	public void run() throws ServletException, IOException {
   {
	  
	   String from="info@sudantechservices.com";
	     //String password = request.getParameter("password");
	      String password="Computer";
      // Recipient's email ID needs to be mentioned.
      String to = request.getParameter("email_id");
	   String pswd=request.getParameter("password");
       String username=request.getParameter("user_name");
      // Sender's email ID needs to be mentioned
      /*String userID =request.getParameter("from");*/
     String text ="Hi  "+username+",\n\n"+"Your User Name : "+username+",\n \n"+ "Your Password  : "+pswd+",\n \n"+"Click on this Link to login"+",\n \n"+"http://www.autotrack.co.in/Autotrack/ControllerServlet/LoginService?usrname="+username+"&password="+pswd ;
      //String text="http://localhost:8080/VehicleTracking/JSP/Reset_password.jsp?emailid="+to;
 /*    text=text+"\n"+"Plese send me ID & password on "+userID;*/
    /* System.out.println(username);
     System.out.println(password);
     System.out.println(text);*/

      // Assuming you are sending email from localhost
      String host = "smtp.gmail.com";


      // Get system properties
      Properties props = System.getProperties();
     
      props.put("mail.smtp.starttls.enable", "true"); // added this line
      props.put("mail.smtp.host", host);
      props.put("mail.smtp.user", from);
      props.put("mail.smtp.password", password);
      props.put("mail.smtp.port", "25");
      props.put("mail.smtp.auth", "true");


      // Setup mail server
      props.setProperty("mail.smtp.host", host);
      
      
      // Get the object.
        
      Session session = Session.getInstance(props, new GMailAuthenticator(from,password));

      try{
         // Create a default MimeMessage object.
         MimeMessage message = new MimeMessage(session);

         // Set From: header field of the header.
         message.setFrom(new InternetAddress(from));
         message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));

         
         /*InternetAddress[] toAddress = new InternetAddress[to.length];

         // To get the array of addresses
         for( int i=0; i < to.length; i++ ) { // changed from a while loop
             toAddress[i] = new InternetAddress(to[i]);
         }
         System.out.println(Message.RecipientType.TO);

         for( int i=0; i < toAddress.length; i++) { // changed from a while loop
             message.addRecipient(Message.RecipientType.TO, toAddress[i]);
         }*/
         // Set To: header field of the header.
         //message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));

         // Set Subject: header field
         message.setSubject("Registration Sucesss");

         // Now set the actual message
         message.setContent(text, "text/plain");

         // Send message
         Transport.send(message);
         /*Transport transport = session.getTransport("smtp");
         transport.connect(host, username, password);

         transport.sendMessage(message, message.getAllRecipients());*/
         //Transport.close();
         System.out.println("Sent message successfully....");
         /*System.out.println(to);
         System.out.println(text);*/
         RequestDispatcher rd=request.getRequestDispatcher("/JSP/MGMT_userregistration.jsp?mode=success");
		 rd.forward(request, response);
         

      }catch (MessagingException mex) {
    	  
    	  mex.printStackTrace();
         
    	 /* RequestDispatcher rd=request.getRequestDispatcher("/JSP/emailid.jsp?mode=invalid");
 		 rd.forward(request, response);*/
      }
   }
	}
}
