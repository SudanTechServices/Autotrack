<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page errorPage="errorpage.jsp"%>

<!DOCTYPE html>
<SCRIPT type="text/javascript">
	window.history.forward();
	function noBack() {
		window.history.forward();
	}

	function search() {
		var enumber = document.StudentRegInfo.enumber.value;
		if (enumber == "") {
			alert("Enter Your Enrollment Number");
		} else {
			document.StudentRegInfo.action = "../JSP/studentregupdate.jsp?enumber="+ enumber;
			document.StudentRegInfo.submit();
		}
	}

	function delete1() {
		var enumber = document.StudentRegInfo.enumber.value;
		if (enumber == "") {
			alert("Enter Your Enrollment Number");
		} else {
			document.StudentRegInfo.action = "../JSP/studentregupdate.jsp?enumber="+ enumber;
			document.StudentRegInfo.submit();
		}
	}
</SCRIPT>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<title>Autotrack</title>
<link rel="stylesheet" type="text/css" href="../CSS/style.css" />

</head>

<body>

	<div class="content_bg">
		<span class="content_headning">Search</span>
	</div>

	<form name="StudentRegInfo">
		<table cellspacing="2" cellpadding="1"
			style="width: 100%; background-color: #f1fafc; border: 1px solid #2898b4;">
			<tr>
				<td>
					<table cellspacing="2" class="table_content" cellpadding="1"
						style="width: 40%; background-color: #f1fafc;">
						<tr>
							<td colspan="3" style="color: red">* Enter the ID Card	Number</td>
						</tr>
						<tr>
							<td>Enrollment Number</td>
							<td>:</td>
							<td><input class="tb" type="text" name="enumber" size="30" />
							</td>						

							<td colspan="3"><input type="button" value="Search Student"
								onclick="search();">
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>


</body>

</html>