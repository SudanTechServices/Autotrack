package com.ts.service;


import java.io.IOException;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.activation.*;

public class NewUser extends CommonService
{
	
	public void run() throws ServletException, IOException {
   {
	  
	   String username="sudantechservices@gmail.com";
	     //String password = request.getParameter("password");
	      String password="Computer";
      // Recipient's email ID needs to be mentioned.
      String to = "info@sudantechservices.com";
	   

      // Sender's email ID needs to be mentioned
      String userID =request.getParameter("to");
      String contact_number=request.getParameter("cnum");
      String text = request.getParameter("text"); 
     text=text+"\n"+"Please send me ID & password to  "+userID+" "+"and you contact me on"+" "+contact_number;
    /* System.out.println(username);
     System.out.println(password);
     System.out.println(text);*/

      // Assuming you are sending email from localhost
      String host = "smtp.gmail.com";


      // Get system properties
      Properties props = System.getProperties();
     
      props.put("mail.smtp.starttls.enable", "true"); // added this line
      props.put("mail.smtp.host", host);
      props.put("mail.smtp.user", username);
      props.put("mail.smtp.password", password);
      props.put("mail.smtp.port", "25");
      props.put("mail.smtp.auth", "true");


      // Setup mail server
      props.setProperty("mail.smtp.host", host);
      
      

      
      

      // Get the object.
        
      Session session = Session.getInstance(props, new GMailAuthenticator(username,password));

      try{
         // Create a default MimeMessage object.
         MimeMessage message = new MimeMessage(session);

         // Set From: header field of the header.
         message.setFrom(new InternetAddress(username));
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
         message.setSubject("New user name & password");

         // Now set the actual message
         message.setContent(text, "text/plain");

         // Send message
         Transport.send(message);
         /*Transport transport = session.getTransport("smtp");
         transport.connect(host, username, password);

         transport.sendMessage(message, message.getAllRecipients());*/
         //Transport.close();
         System.out.println("Sent message successfully....");
         
         RequestDispatcher rd=request.getRequestDispatcher("/JSP/login.jsp?newuser=yes");
		 rd.forward(request, response);
         

      }catch (MessagingException mex) {
         
    	  RequestDispatcher rd=request.getRequestDispatcher("/JSP/sendmail.jsp?mode=invalid");
 		 rd.forward(request, response);
      }
   }
	}
}
