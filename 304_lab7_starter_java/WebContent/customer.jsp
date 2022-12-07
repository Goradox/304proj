<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>



<%


	// TODO: Print Customer information
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
	String uid = "sa";
	String pw = "304#sa#pw";

	String userId = (String) session.getAttribute("authenticatedUser");

	try 
	(Connection con = DriverManager.getConnection(url,uid,pw);
	Statement stmt = con.createStatement(); )
	{
		String sql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid"
			+" FROM customer WHERE userid = ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, userId);
		ResultSet rst = pstmt.executeQuery();
		// Print out the ResultSet
		while (rst.next()) {
			//out.println("<form method='post' action='createUser.jsp?id="+rst.getInt(1)+"'>");
			out.println("<table border=2><tr><th>Customer Profile</th><th></th></thead>");
			//ID
			out.println("<tr><td>Id</td><td>" + rst.getInt(1)+ "</td></tr>");
			//names
			out.println("<tr><td>First Name</td><td>" + rst.getString(2)+ "</td></tr>");
			out.println("<tr><td>Last Name</td><td>" + rst.getString(3)+ "</td></tr>");
			//email
			out.println("<tr><td>Email</td><td>" + rst.getString(4)+ "</td></tr>");
			//phone
			out.println("<tr><td>Phone </td><td>" + rst.getString(5)+ "</td></tr>");
			//address
			out.println("<tr><td>Address </td><td>" + rst.getString(6)+ "</td></tr>");
			out.println("<tr><td>City </td><td>" + rst.getString(7)+ "</td></tr>");
			out.println("<tr><td>State </td><td>" + rst.getString(8)+ "</td></tr>");
			out.println("<tr><td>Postal Code </td><td>" + rst.getString(9)+ "</td></tr>");
			out.println("<tr><td>Country </td><td>" + rst.getString(10)+ "</td></tr>");
			//user id
			out.println("<tr><td>User id </td><td>" + rst.getString(11)+ "</td></tr>");
		}
			
		out.println("</table>");
		con.close();
	}
	catch (SQLException ex) 
	{
		out.println(ex);
	}

   

%>

</body>
</html>

