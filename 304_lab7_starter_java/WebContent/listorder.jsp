<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Gower's Grocery Order List</title>
</head>
<body>

<h1>Order List</h1>

<%
//Note: Forces loading of SQL Server driver

try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection

String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
try (Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement(); 
	Statement stmt2 = con.createStatement();) 
{
	ResultSet rst = stmt.executeQuery("SELECT orderId, customer.customerId, firstname, lastname, totalAmount FROM ordersummary LEFT JOIN customer ON (orderSummary.customerId = customer.customerId) ");
	out.println("<table border=1><tbody><tr><th>orderId</th><th>customerId</th><th>Customer Name</th><th>Total Amount</th></tr>");
		
	while (rst.next())
	{
		int orderId = rst.getInt(1);
		int customerId = rst.getInt(2);
		String cName = rst.getString(3) + rst.getString(4);
		String tAmount = currFormat.format(rst.getDouble(5));

		out.println("<tr><td>"+orderId+"</td><td>"+customerId+"</td><td>"+cName+"</td><td>"+tAmount+"</td></tr>");
		String test = "SELECT productId, quantity, price FROM orderproduct WHERE orderproduct.orderId = ?";
		PreparedStatement pstmt = con.prepareStatement (test);
		pstmt.setInt(1,orderId);
		//ResultSet rst2 = stmt2.executeQuery("SELECT productId, quantity, price, orderproduct.orderId FROM orderproduct LEFT JOIN ordersummary ON (orderproduct.orderId = ordersummary.orderId)");
		out.println("<table border = 1><tr><th>productId</th><th>quantity</th><th>price</th></tr>");
		ResultSet rst2 = pstmt.executeQuery();
		while(rst2.next()){
			int productId = rst2.getInt(1);
			int quantity = rst2.getInt(2);
			String price = currFormat.format(rst2.getInt(3));
			out.println("<tr><td>"+productId+"</td>"+"<td>"+quantity+"</td>"+"<td>"+price+"</td></tr>");	
			}
			out.println("</table>");

	}

	con.close();
}
catch (SQLException ex) 
{ 	
	out.println(ex); 
}

//Write query to retrieve all order summary records

// For each order in the ResultSet

	// Print out the order summary information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 

// Close connection
%>

</body>
</html>

