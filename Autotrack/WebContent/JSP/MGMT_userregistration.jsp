<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page errorPage="errorpage.jsp" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
 <head>

<title>Autotrack</title> 

<script type="text/javascript" src="../JS/jquery-1.4.3.min.js"></script>
<link rel="stylesheet" type="text/css" href="../CSS/style.css" />
<script type="text/javascript" src="../JS/validate.js"></script>

<script type="text/javascript">
function register()
{
	if(registerFormValidator())
	{    
		var password = document.registerpage.password.value;
		var cpassword = document.registerpage.cpassword.value;
	   
		if(password == cpassword){
			
		document.registerpage.action="/Autotrack/ControllerServlet/RegisterService";//it go to controllerservlet and after that it go to LoginService
		document.registerpage.submit();
		alert('Successfully registered!!');
		}else{
			alert("Password did not match with Confirm Password");
		}
			
	}
	
}
function check(confrimpassword){
	
	var password = document.getElementById("password").value;
	document.getElementById("pass_strength").innerHTML = "";
	
	if(password == confrimpassword){
		document.getElementById("msg").innerHTML = "<div><label style='color:#008000;'> Password Matched !!</label></div>";
	}else{
		document.getElementById("msg").innerHTML = "<div><label style='color:red;'> Password did not match </label></div>";
	}
	
}

function check_password_strength(password){
	
	document.getElementById("autoSuggestionsList").innerHTML = "";
	
	if(password.length <= 4){
		document.getElementById("pass_strength").innerHTML = "<div><label style='color:#EF0067;'>Password too short(atlest 4 char)</label></div>";
	}else if(password.length > 4){
		document.getElementById("pass_strength").innerHTML = "<div><label style='color:#1C20C0;'>Password is OK</label></div>";
	}
}

$(document).ready(function(){
//called when key is pressed in textbox
$("#inputString").keypress(function (e)
{
$("#error").hide();
$("#autoSuggestionsList").hide();
//if the letter is not digit then display error and don't type anything
if( e.which!=8 && e.which!=0 && (e.which<48 || e.which>57)&& (e.which<65 || e.which>90)&& (e.which<97 || e.which>122))
{
//display error message
$("#error").html("No Special Characters").show();
return false;
}
});}); 
function lookup(inputString) {
if(inputString.length <1) {
$('#suggestions').show();
$('#autoSuggestionsList').hide();
} else {
$('#suggestions').hide();
$.post("MGMT_userreg_Checkname.jsp",{user: ""+inputString+""},function(data){
$('#autoSuggestionsList').html(data).show();
});
}
}

function refresh(){
	$("#autoSuggestionsList").hide();
	document.getElementById("msg").innerHTML = "";
	document.getElementById("pass_strength").innerHTML = "";
}

</script>
</head> 

<body onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="refresh();">


	<div class="content_bg"><span class="content_headning">User Registration</span></div>
	

<form name="registerpage" method="post">

<%
String privilage=(String)session.getAttribute("privilage");

System.out.println("privilage : "+privilage);

String mode=request.getParameter("mode"); 
if(mode==null)
mode="";
else if(mode.equalsIgnoreCase("success"))
{
mode="Sucessfully Registered !!, Check your mail to login  !!";
}
%>
<div style="color: red; font-family:Comic Sans MS,sans-serif; font-size: 14px;"><%=mode %></div> 
<table cellpadding="4" cellspacing="0" class="table_content" style="width: 100%; background-color: #fff; border: 1px solid #dfdddb;">
<tr>
<td>
<table cellpadding="4" cellspacing="0" class="table_content" style="width: 55%; background-color: #fff;">
<tr>
<td style="width: 20%">
User name
</td>
<td style="width: 5%">:</td>
<td style="width: 40%"> 
<input type ="text" name ="usrname" size="30" class="tb" id="inputString" onblur="lookup(this.value);" onclick="refresh();"/>
</td>
<td style="width: 35%">
<div style="display: none; color: red;" id="autoSuggestionsList"></div>
<!-- <div style="display: none;" id="error"></div> -->
</td>
</tr>

<tr>
<td>
Password 
</td>
<td>:</td>
<td>
<input type ="password" name ="password" size="30" class="tb" id="password" onkeyup="check_password_strength(this.value)"  /></td>
<td id="pass_strength"></td>
</tr>


<tr>
<td>
 Confirm Password 
</td>
<td>:</td>
<td>
<input class="tb" type ="password" name ="cpassword" size="30" class="tb" onkeyup="check(this.value)" onblur="refresh();"/></td>
<td id="msg"></td>
</tr>



<tr>
<td>
Contact Number
</td>
<td>:</td>
<td>
<input type ="text" name ="number" size="30"  class="tb" onclick="refresh();"/>
</td>
<td></td>
</tr>

<tr>
<td>
Company Name
</td>
<td>:</td>
<td>
<input type ="text" name ="company" size="30" class="tb"/>
</td>
<td></td>
</tr>

<tr>
<td>
Email
</td>
<td>:</td>
<td>
<input type ="text" name ="email" size="30"  class="tb"/>
</td>
<td></td>
</tr>

<tr>
<td>
Privilege
</td>
<td>:</td>
<%if(privilage.equalsIgnoreCase("Owner"))
{%>
	<td>
		<select name="privilage" class="tb">
		<option>--Select One--</option>
		<option>Owner</option>
		<option>Admin</option>
		<option>Guest</option>
		</select>
	</td>
<%}

else if (privilage.equalsIgnoreCase("Admin"))
{	%>
<td>
<select name="privilage" class="tb">
<option>Admin</option>
<option>Guest</option>
</select>
</td>
<%}
else{
%>
<td>
<select name="privilage" class="tb">
<option>Guest</option>
</select>
</td>
<%} %>
<td></td>
</tr>

<tr>
<td></td>
<td></td>
<td>
<input type="button" value="Register" onclick="register();">
</td>
<td></td>
</tr>
</table>
</td>
</tr>
</table>

</form>

</body>
</html>