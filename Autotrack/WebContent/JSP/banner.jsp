<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html>
<head>
<script type="text/javascript">
window.history.forward();
function noBack() { window.history.forward(); }
</script>

<title>AutoTrack - Banner</title>
<link rel="stylesheet" type="text/css" href="../CSS/style.css" />
<script type=text/javascript>
function validate_user()
{
	var uname = document.getElementById("txtUname");
	var pwd = document.getElementById("txtPwd");
	if(uname.value !="User Name" && pwd.value !="Password")
	{
		if(uname.value=="admin")
			window.location = "../HTML/frame_home.htm";
		else if(uname.value=="user")
			window.location="#";
		else 
			alert("Invalid User Name or Password");
	}
	else
		alert("Please Enter User Name or Password");
}
function Logout()
{	
	self.parent.location="logout.jsp";	
}

</script>
</head>
<%
String am_pm;
String ses_hour;
String fin_hr;

String last_log = (String)session.getAttribute("sessionuser");

System.out.println(last_log);

if(last_log.equals("I logged in first time")){
	ses_hour = "logged in first time";
}else{
String date = last_log.substring(0,11);
String hr = last_log.substring(11, 13);
String min = last_log.substring(14,16);


int hour = Integer.parseInt(hr);
if( hour > 12){
	am_pm = "PM";
	hour = hour - 12;
	if(hour < 10){
		fin_hr = "0"+hour;
	}else{ fin_hr = ""+hour; }
	ses_hour = date+" "+ fin_hr + ":"+min+" "+am_pm;
}
else{ 
	am_pm = "AM";
	if(hour < 10){
		fin_hr = "0"+hour;
	}else{ fin_hr = ""+hour; }
	
	ses_hour = date+" "+ fin_hr + " : "+min+" "+am_pm;
}

System.out.println("Last Login : "+ ses_hour);
}
%>
<body onload="noBack();" onpageshow="if (event.persisted) noBack() ;" onunload="">
	<div class="top_menu">

<div class="logo"><a href="homepage.jsp" target="Content"><img src="../images/banner_logo.png"></img></a></div>
<div class="logorightside"><div class="welcome_content">Welcome <%=session.getAttribute("user")%>
								| <span>Last login: <%=ses_hour %> </span>
</div>
<div class="logoinnerleft">
<div class="homebtn"><div class="homefont"><a href="homepage.jsp" target="Content">Home</a></div></div>
</div>
<div class="logoinnerright"><a href="resetpassword.jsp" target="Content">Reset password</a>
<div class="logoinnerright"><a href="#" onclick="Logout();">Logout</a></div>
</div>
</div>
	</div>

</body>
</html>
