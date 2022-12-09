<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Gower's Grocery</title>
	<style>
		table, th, td {
		border: 1px solid red;
		color:red;
		}

		/* Add a black background color to the top navigation */
		.topnav {
		background-color: rgb(179, 142, 65);
		overflow: hidden;
		}

		/* Style the links inside the navigation bar */
		.topnav a {
		float: left;
		color: #f2f2f2;
		text-align: center;
		padding: 14px 16px;
		text-decoration: none;
		font-size: 17px;
		}

		/* Change the color of links on hover */
		.topnav a:hover {
		background-color: #ddd;
		color: black;
		}

		/* Add a color to the active/current link */
		.topnav a.active {
		background-color: #5a630a;
		color: white;
		}
	</style>
</head>
<body style="background-color:black;">

	<div class="topnav">
		<a class="active" href="shop.jsp">Home</a>
        <a href="listprod.jsp">Products</a>
        <a href="customer.jsp">customer info</a>
        <a href="checkout.jsp">Check Out</a>
        <a href="about.html">About</a>
        <a href="showcart.jsp">Cart</a>
        
	</div>	
<h1 style="color:red">Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp" style="color:red">
	<p align="left">
		<select size="1" name="categoryName">
		<option>All</option>
	  
	  <%
	  /*
	  // Could create category list dynamically - more adaptable, but a little more costly
	  try               
	  {
		  getConnection();
		   ResultSet rst = executeQuery("SELECT DISTINCT categoryName FROM Product");
			  while (rst.next()) 
			  out.println("<option>"+rst.getString(1)+"</option>");
	  }
	  catch (SQLException ex)
	  {       out.println(ex);
	  }
	  */
	  %>
	  
		<option>Human like</option>
		<option>Unhuman</option>      
		</select>
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection
String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";
String productNameReq = '%'+request.getParameter("productName")+'%';
NumberFormat currFormat = NumberFormat.getCurrencyInstance();
try (Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();) 
{
	out.println("<table><tr><th></th><th><font color=red>image</font></th><th>Product Name</th><th>Category</th><th>Product Price</th></tr>");
	
	String SQL =  "SELECT productId, productName, productPrice, productImageURL, categoryName FROM product JOIN category on product.categoryID = category.categoryID";

	boolean hasProd = productNameReq != null && !productNameReq.equals("");
	if(hasProd){
		//productNameReq = "%" + productNameReq + "%";
		SQL = SQL+" WHERE productName LIKE ?";
	}
	PreparedStatement pstmt = con.prepareStatement(SQL);
	pstmt.setString(1,productNameReq);
	ResultSet rst = pstmt.executeQuery();
	while (rst.next()){
		int productId = rst.getInt(1);
		String productName = rst.getString(2);
		String productPrice = currFormat.format(rst.getDouble(3));
		String IMGurl = rst.getString(4);
		String CatName = rst.getString(5);
		String Query = "<tr><td><a href='addcart.jsp?id="+productId+"&name="+productName+"&price="+productPrice+"'>Add To Cart</a></td><td><img src = \""+IMGurl+"\"></td><td><a href='product.jsp?id="+productId+"'>"+productName+"</a></td><td>"+CatName+"</td><td>"+productPrice+"</td></tr>";
		out.println(Query);
		
	}
	out.println("</table>");
	con.close();
}catch(SQLException ex){
	out.println(ex);
}
// Print out the ResultSet

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

</body>
</html>