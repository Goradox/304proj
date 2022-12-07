<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ include file = "jdbbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Lexi's Grocery Order Processing</title>
</head>
<body>

<% 
// Get customer id
String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Determine if valid customer id was entered
if (custId == null || custId.equals("")) {
    out.println("<h1>Invalid customer id. Try again</h1>");
} // Determine if there are products in the shopping cart
else if (productList) == null) {
    out.println("<h1>Your shopping cart is empty</h1>");

} // If either are not true, display an error message
else {
    // check if customer id is a number
    int num = -1
    try
    {
        num = Integer.parseInt(custId)
    } catch(Exception e) {
        out.println("<h1>Invalid customer id</h1>");
        return
    }
}

try
{   // Load driver class
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
    out.println("ClassNotFoundException: " + e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection


String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
String uid = "sa";
String pw = "304#sa#pw";
try (Connection con = DriverManager.getConnection(url, uid, pw);
    Statement stmt = con.createStatement();) 

// Save order information to database


    
/*
    // Use retrieval of auto-generated keys.
    int orderId = -1;
    String sql = "SELECT orderId FROM ordersummary WHERE customerId = ? ORDER BY orderId DESC";
    PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
    pstmt.setInt(1, id);
    ResultSet keys = pstmt.executeQuery();
    while (keys.next()) {
        orderId = keys.getInt(1);
    }

/*
    
    





// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

double totalPrice = 0;
Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
while (iterator.hasNext())
{ 
    Map.Entry<String, ArrayList<Object>> entry = iterator.next();
    ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
    String productId = (String) product.get(0);
    String price = (String) product.get(2);
    double pr = Double.parseDouble(price);
    int qty = ( (Integer)product.get(3)).intValue();
    
    // Insert into orderproduct table
    String sql = "INSERT INTO orderproduct VALUES (?, ?, ?, ?)";
    pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
    pstmt.setInt(1, productId; pstmt.setString(2, productName); pstmt.setInt(3, qty); pstmt.setDouble(4, pr);
    pstmt.executeUpdate();

    
    totalPrice += qty*pr;
}


// Update total amount for order record
String sql = "UPDATE ordersummary SET totalAmount=? WHERE orderId = ?";
pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); 
pstmt.setDouble(1, totalPrice);
pstmt.setInt(2,orderId);
pstmt.executeUpdate();

// Print out order summary
out.println("<h1 class=mb-3>Your Order Summary</h1>");
