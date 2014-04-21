	<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Autotrack - Forgot Password</title>
	<link rel="stylesheet" href="../CSS/style.css" type="text/css" />
	<script type="text/javascript" src="../JS/validate.js"></script>
	<script type="text/javascript">
	
		function forgetpassword()
		{
		
			/* var emailid=document.eid.username.value; */
			if(forgotpasswordvalidation()){
			
			document.forgotpassword.action="/Autotrack/ControllerServlet/ForgetPassword";
			document.forgotpassword.submit();
			}
		}
		function login()
		{
			//alert("sdf");
			document.forgotpassword.action="../JSP/login.jsp";
			document.forgotpassword.submit();
		}
	
	</script>
	</head>
	
	
	<body style="background:url(../images/login_bg.jpg); background-repeat:repeat-x; width:100%;">
	<%
	
	String message = request.getParameter("message");
	if (message == null) {
		message = "";
	}
	else if (message.equalsIgnoreCase("invalid")) {
		message = "Entered data did not matched with Record!!";
	}
	else if (message.equalsIgnoreCase("emailsent")) {
		message = "Email sent successfully to your mail ID!!";
	}
	%>
	<center>
	<div class="wrapper">
	  <div style="height:60px;"></div>
	  <div class="top">&nbsp;</div><br />
	  <div style="padding-left:50px;">
	  <form name="forgotpassword" method="post" accept-charset="utf-8" ">
	    <table cellpadding="0" cellspacing="0" class="forgot_bg">
	      
	      <tr>
	        <td><table width="100%" cellpadding="4" cellspacing="2" class="login_cont">
	            <tr>
	              <td align="center" height="5px" colspan="4"></td>
	            </tr>
	            <tr>
	            	<td colspan="4" class="error_msg" style="padding-left: 10px;"><%=message%></td>
				</tr>
	            <tr>
	              <td  colspan="4" align="left" class="forgot_pswd" style="padding-left:45px;">Enter Your valid E-Mail id</td>
	            </tr>
	            <tr>
	              <td align="center" height="10px" colspan="4"></td>
	            </tr>
	            <tr>
	            	<td width="7%"></td>
	            	<td>User Name</td>
	            	<td>:</td>
	            	<td>            	
	            		<input type="text" name="username" placeholder="User Name" style="height: 25px; width: 220px;"/>
	               	</td>  
            	</tr>
            	 <tr>
	            	<td width="7%"></td>
	            	<td>Email Id</td>
	            	<td>:</td>
	            	<td>            	
	            		<input type="text" name="emailid" placeholder="Email Id" style="height: 25px; width: 220px;"/>
	               	</td>  
            	</tr>
	             
	            <tr>
	              <td align="center" height="10px" colspan="4"></td>
	            </tr>
	            <tr>  
		            <td align="center" colspan="4">           
		            	 <input type="button" value="" name="" onclick="forgetpassword();" style="border-style: none; background: url('../images/login_submit.png') no-repeat; width: 137px; height: 45px;" />
		            	 <input type="button" value="" name="" onclick="login();" style="border-style: none; background: url('../images/login_buttom.png') no-repeat; width: 137px; height: 45px;" />
		             </td>
	            </tr>            
	          </table></td>
	      </tr>
	      
	    </table>
	    </form>
	  </div>
	</div>
	<map name="Map" id="Map">
	  <area shape="rect" coords="4,2,138,43" onclick="validate_user();" target="_self" />
	</map>
	</center>
	</body>
	</html>