
function register()
{
	if(registerFormValidator())
	{    
		var password = document.registerpage.password.value;
		var cpassword = document.registerpage.cpassword.value;
	    alert("hi");
		if(password == cpassword){
			
		document.registerpage.action="/Autotrack/ControllerServlet/RegisterService";//it go to controllerservlet and after that it go to LoginService
		document.registerpage.submit();
		alert('Successfully registered!!');
		}else{
			alert("Password did not match with Confirm Password");
		}
			
	}
	
}