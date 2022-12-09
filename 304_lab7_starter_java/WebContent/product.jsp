<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Gower's Pet - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<style>
	table, th, td {
	  border: 1px solid red;
	  color:red;
	}
    table.fixed {table-layout:fixed; width:600px;}/*Setting the table width is important!*/
</style>
</head>
<body style="background-color:black;">

<%@ include file="header.jsp" %>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product
    String productId = request.getParameter("id");

    if(productId == null)
        return;
    int number=-1;
    try{
        number = Integer.parseInt(productId);
    }
    catch(Exception e)
    {
        out.println("Invalid id");
        return;
    }
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";
    NumberFormat currFormat = NumberFormat.getCurrencyInstance();

    try (Connection con = DriverManager.getConnection(url, uid, pw);
		Statement stmt = con.createStatement(); )
	{

        String sql = "SELECT productId, productPrice, productName, productImageURL, productImage, productDesc FROM product WHERE productId = ?";
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setInt(1,number);
        ResultSet rst = pstmt.executeQuery(); 
        while(rst.next()){
            int productid = rst.getInt(1);
            String productPrice = currFormat.format(rst.getDouble(2));
            String productName = rst.getString(3);
            out.println("<h1 style ='color:red;'>"+productName+"</h1>");
            String imgurl = rst.getString(4);
            String desc = rst.getString(6);
            if (imgurl != null)
                out.println("<img src = \""+imgurl+"\">");
            String img = rst.getString(5);
            out.println("<table class = 'fixed'>");
            out.println("<tr><td>"+"id"+"</td><td>"+productid+"</td></tr>");
            out.println("<tr><td>"+"price"+"</td><td>"+productPrice+"</td></tr>");
            out.println("<tr><td>"+"Product Description"+"</td><td>"+desc+"</td></tr>");
            out.println("</table>");
            out.println("<table>");
            String addcart = "<a href='addcart.jsp?id="+productId+"&name="+productName+"&price="+productPrice+"'>Add To Cart</a>";
            out.println("<tr><td>"+addcart+"</td></tr>");
            String cont = "<a href='listprod.jsp'>Continue Shopping</a>";
            out.println("<tr><td>"+cont+"</td></tr>");
            out.println("</table>");
        }
        con.close();
    }
    catch (SQLException ex) 
    {
        out.println(ex);
    }

// TODO: If there is a productImageURL, display using IMG tag
		
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
		
// TODO: Add links to Add to Cart and Continue Shopping

%>

</body>
</html>

