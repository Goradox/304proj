
<!DOCTYPE html>
<html>
<head>
<title>Register Screen</title>
</head>
<body>

<div style="margin:0 auto;text-align:center;display:inline">

<h3>Please Register to System</h3>

<%
// Print prior error login message if present
if (session.getAttribute("registerMessage") != null)
	out.println("<p>"+session.getAttribute("registerMessage").toString()+"</p>");

if (session.getAttribute("error") != null)
	out.println("<p>"+session.getAttribute("error").toString()+"</p>");
%>

<br>
<form name="MyForm" method=post action="validateRegister.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Username:</font></div></td>
	<td><input type="text" name="username"  size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Password:</font></div></td>
	<td><input type="password" name="password" size=10 maxlength="10"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">First Name:</font></div></td>
	<td><input type="text" name="first" size=10 maxlength="10"></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Last Name:</font></div></td>
	<td><input type="text" name="last" size=10 maxlength="10"></td>
</tr>
</table>
<br/>
<input class="submit" type="submit" name="Submit2" value="Register">
</form>

</div>

</body>
</html>

