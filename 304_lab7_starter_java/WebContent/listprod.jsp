<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.HashMap" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Gower's Grocery</title>
<style>
	table, th, td {
	  border: 1px solid red;
	  color:red;
	}
</style>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

</head>
<body style="background-color:black;">

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

<%
// Colors for different item categories
HashMap<String,String> colors = new HashMap<String,String>();		// This may be done dynamically as well, a little tricky...
colors.put("Human like", "#FF0000");
colors.put("Unhuman", "#FF0000");

%>

<%
// Get product name to search for
String name = request.getParameter("productName");
String category = request.getParameter("categoryName"); 

boolean hasNameParam = name != null && !name.equals("");
boolean hasCategoryParam = category != null && !category.equals("") && !category.equals("All");
String filter = "", sql = "";

if (hasNameParam && hasCategoryParam)
{
	filter = "<h3>Products containing '"+name+"' in category: '"+category+"'</h3>";
	name = '%'+name+'%';
	sql = "SELECT productId, productName, productPrice, productImageURL, categoryName FROM Product P JOIN Category C ON P.categoryId = C.categoryId WHERE productName LIKE ? AND categoryName = ?";
}
else if (hasNameParam)
{
	filter = "<h3>Products containing '"+name+"'</h3>";
	name = '%'+name+'%';
	sql = "SELECT productId, productName, productPrice, productImageURL, categoryName FROM Product P JOIN Category C ON P.categoryId = C.categoryId WHERE productName LIKE ?";
}
else if (hasCategoryParam)
{
	filter = "<h3>Products in category: '"+category+"'</h3>";
	sql = "SELECT productId, productName, productPrice, productImageURL, categoryName FROM Product P JOIN Category C ON P.categoryId = C.categoryId WHERE categoryName = ?";
}
else
{
	filter = "<h3>All Products</h3>";
	sql = "SELECT productId, productName, productPrice, productImageURL, categoryName FROM Product P JOIN Category C ON P.categoryId = C.categoryId";
}

out.println(filter);

NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try 
{
	getConnection();
	Statement stmt = con.createStatement(); 			
	stmt.execute("USE orders");
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	if (hasNameParam)
	{
		pstmt.setString(1, name);	
		if (hasCategoryParam)
		{
			pstmt.setString(2, category);
		}
	}
	else if (hasCategoryParam)
	{
		pstmt.setString(1, category);
	}
	
	ResultSet rst = pstmt.executeQuery();
	
	out.print("<font face=\"Century Gothic\" size=\"2\"><table class=\"table\" border=\"1\"><tr><th class=\"col-md-1\"></th><th>Product Name</th>");
	out.println("<th>Image</th><th>Category</th><th>Price</th></tr>");
	while (rst.next()) 
	{
		int id = rst.getInt(1);
		out.print("<td class=\"col-md-1\"><a href=\"addcart.jsp?id=" + id + "&name=" + rst.getString(2)
				+ "&price=" + rst.getDouble(3) + "\">Add to Cart</a></td>");

		String itemCategory = rst.getString(4);
		String color = (String) colors.get(itemCategory);
		if (color == null)
			color = "#FF0000";

		out.println("<td><a href=\"product.jsp?id="+id+"\"<font color=\"" + color + "\">" + rst.getString(2) + "</font></td>"
				+ "<td><img src = \"" + rst.getString(4) + "\"></td>"
				+ "<td><font color=\"" + color + "\">" + category + "</font></td>"
				+ "<td><font color=\"" + color + "\">" + currFormat.format(rst.getDouble(3))
				+ "</font></td></tr>");
	}
	out.println("</table></font>");
	closeConnection();
} catch (SQLException ex) {
	out.println(ex);
}
%>

<script>


</script>

</body>
</html>