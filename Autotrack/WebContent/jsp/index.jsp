<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>Welcome to Autotrack</title>
<link rel="shortcut icon" href="../images/fav_icon.ico" />

<link rel="stylesheet" href="../css/style.default.css" type="text/css" />
<script type="text/javascript" src="../js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="../js/jquery-migrate-1.1.1.min.js"></script>

<script type="text/javascript">
 window.history.forward();
function noBack() { window.history.forward(); } 
</script>

<script type="text/javascript">

function login()
{
	    document.loginpage.action="/Autotrack_new/ControllerServlet/LoginService";//it go to controllerservlet and after that it go to LoginService
		document.loginpage.submit();
	   
	
}
function keySubmit()
{	
	if(window.event.keyCode==13)
	{
		if(checkNotBlankTB('loginpage','usrname','Username ') && checkNotBlankTB('loginpage','password','Password '))
		{
			document.loginpage.action="/Autotrack_new/ControllerServlet/LoginService";
			document.loginpage.submit();
		}
	}
}

</script>

</head>
<body class="loginbody">

<div class="loginwrapper">
	<div class="loginwrap zindex100 animate2 bounceInDown">
	<h1 class="logintitle"><img src="../images/login_logo.png"/></h1>
        <div class="loginwrapperinner">
            <form name="loginpage" method="post">
                <p class="animate4 bounceIn"><input type="text" id="txtUname" name="usrname" placeholder="Username" /></p>
                <p class="animate5 bounceIn"><input type="password" id="txtPwd"  name="password" placeholder="Password" /></p>
                <p class="animate6 bounceIn"><button class="btn btn-warning btn-block" onclick="login();">Submit</button></p>
                <p class="animate7 fadeIn"><a href=""><span class="icon-question-sign icon-white"></span> Forgot Password?</a></p>
            </form>
        </div><!--login wrapper inner-->
    </div>
    <div class="loginshadow animate3 fadeInUp"></div>
</div><!--login wrapper-->




</body>
</html>