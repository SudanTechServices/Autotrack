<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Autotrack - Reset Password</title>
<link rel="stylesheet" type="text/css" href="../CSS/style.css" />
<script type="text/javascript">
window.history.forward();
function noBack() { window.history.forward(); }
<%	String loggedinas = (String)session.getAttribute("user"); 
System.out.println(loggedinas);

%>

	function update()
	{
		var user=document.eid.username.value;
		var newpwd = document.eid.newpswd.value;
		var newcpwd = document.eid.newcpswd.value;
		if(newpwd == "" || newcpwd == ""){
			alert("Password Cannot Be Blank");
		}
		else{
		document.eid.action="/Autotrack/ControllerServlet/UpdatePassword?username="+user;
		document.eid.submit();
		}
	}

</script>
</head>
<body>
<%

 
 String mode=request.getParameter("mode");
 String mode1=request.getParameter("mode1");
 System.out.println(" Mode 0 = "+mode);
 System.out.println(" Mode 1 = "+mode1);
 
//System.out.println(session.getId());
if(mode==null)
mode=""; 

else if(mode.equals("invalid"))
mode="Invalid Password";

if(mode1==null)
mode1="";

else if(mode1.equalsIgnoreCase("Mismatch"))
mode1="new password and confirm password did not match";

else
{
mode="";
mode1 = "";
}
String mailid=request.getParameter("emailid");

%> 

	<div class="content_bg">
		<span class="content_headning">Reset Password </span>
	</div>
	<div>
	<form name="eid" method="post">
		<table cellpadding="4" cellspacing="0" class="table_content" style="width: 100%; background-color: #f8f8f8; border: 1px solid #dfdddb;">
			<tr>
				<td>
								
					<table cellpadding="4" cellspacing="0" class="table_content" style="width: 50%; background-color: #f8f8f8;">			
						<tr>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td>User name<span class="mandat">*</span></td>
							<td>:</td>
							<td><input class="tb" type="text" size="25" name="username" value="<%=loggedinas%>" disabled="disabled" /></td>
						</tr>
						<tr>
							<td></td>
							<td>Old Password<span class="mandat">*</span></td>
							<td>:</td>
							<td><input size="25" type="password" name="oldpass" /></td>
							<td>	<label style="color: red"><%=mode%></label>	</td>
						</tr>
						<tr>
							<td></td>
							<td>New Password<span class="mandat">*</span></td>
							<td>:</td>
							<td><input size="25" type="password" name="newpswd" /></td>
						</tr>
						<tr>
							<td></td>
							<td>Confirm Password<span class="mandat">*</span></td>
							<td>:</td>
							<td><input size="25" type="password" name="newcpswd" /></td>
							<td><label style="color: red"><%=mode1%></label> </td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr style="text-align: center;">
							<td colspan="4"><input type="button" name="resetpwd"  value="Reset"  onclick="update();"/></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		</form>
	</div>
</body>
</html>
