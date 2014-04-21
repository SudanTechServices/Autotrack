function validate_user()
{
	var uname = document.getElementById("txtUname");
	var pwd = document.getElementById("txtPwd");
	if(uname.value !="User Name" && pwd.value !="Password")
	{
		if(uname.value=="admin")
			window.location = "admin.html";
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
	self.parent.location="login.html";	
}
