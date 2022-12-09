<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<h3>Administrator Sales Report by Day</h3>
<%

    // TODO: Write SQL query that prints out total order amount by day
    String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";
    NumberFormat currFormat = NumberFormat.getCurrencyInstance();

    try (Connection con = DriverManager.getConnection(url, uid, pw);
    Statement stmt = con.createStatement(); )
    {
        //validating that the user is actually an admin
        PreparedStatement pstmt = con.prepareStatement ("SELECT isAdmin FROM customer WHERE userid = ?");
        pstmt.setString(1, (String) session.getAttribute("authenticatedUser"));

        ResultSet rst = pstmt.executeQuery();

        boolean isAdmin = false;

        while(rst.next())
        {
            if(rst.getBoolean(1) == true) isAdmin = true;
        }

        if(!isAdmin)
        {
            out.println("<h1 style='font-size: 10vw;'>UNAUTHORIZED</h1>");
        }

        else
        {
            pstmt = con.prepareStatement("SELECT firstName, lastName, userid FROM customer");

            rst = pstmt.executeQuery();

            out.println("<p>Customers:</p>");
            out.println("<table border=2><tr><th>First name</th><th>Last Name</th><th>id</th></tr>");
            while(rst.next())
            {
                out.println("<tr><td>" + rst.getString(1) + "</td><td>" + rst.getString(2) + "</td><td>" + rst.getString(3) + "</td></tr>");
            }


            String sql = "SELECT max(orderDate), sum(totalAmount) FROM ordersummary GROUP BY YEAR(orderDate), MONTH(orderDate), DAY(orderDate)";
            rst = stmt.executeQuery (sql);
            out.println("<table border=2><tr><th>Order Date</th><th> Total Order Amount</th></tr>");
            while(rst.next()){
                Date date = rst.getDate(1);
                String totalA = currFormat.format(rst.getDouble(2));

                out.println("<tr><td>"+date+"</td><td>" + " " + totalA+ "</td></tr>");

            }
            out.println("</table>");
            con.close();
        }

    }
    catch (SQLException ex) 
    {
        out.println(ex);
    }
    



%>

</body>
</html>

