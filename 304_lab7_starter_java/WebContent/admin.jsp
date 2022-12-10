<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
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

    <form id="newProduct">
        <h2>New product</h2>

        Product name: <input type="text" name="name">
        Image url: <input type="text" name="imgUrl">
        Category (1 - humanlike, 2 - unhuman): <input type="number" name="category" min="1" max="2">
        Price: <input type="number" name="price" min="0" step="0.01">
        <textarea rows="5">Description</textarea>

        <input type="submit" value="Create product?">

    </form>

    <button style="font-size: 4vw; margin-top: 100px;"><a style="text-decoration: none; color: #eb4334" href="loaddata.jsp">NUCLEAR OPTION (reset DB)</a></button>

    <script>

        //AJAX stuff
        $('#newProduct').submit(function(e)
        {
            e.preventDefault();
            $.post("addProduct.jsp", {'name': $('input[name="name"').val(), 'imgUrl': $('input[name="imgUrl"').val(), 'category': $('input[name="category"').val(), 'desc': $('textarea').val(), 'price': $('input[name="price"').val()}, function(data)
            {
                if(data.length <= 231)
                {
                    alert('PRODUCT ADDED');
                }
                else
                {
                    alert('PRODUCT NOT ADDED, BAD INPUT');
                }
            });
        });



        
    </script>

</body>
</html>

