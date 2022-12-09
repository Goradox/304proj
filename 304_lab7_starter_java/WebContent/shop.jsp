<!DOCTYPE html>

<html>


<head>
        <title>Myhtical Creatures Store Main Page</title>
        <style>
                body {
                        background-image: url('https://mythicalrealm.com/wp-content/uploads/2018/09/the_gryphons_call_web_by_nambroth-d9penj5-780x350.jpg?x22639');
                        background-repeat: no-repeat;
                        background-attachment: fixed;
                        background-size: 100% 100%;
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
        <body>
                <div class="topnav">
                        <a class="active" href="shop.jsp">Home</a>
                        <a href="listprod.jsp">Products</a>
                        <%
                        String userName = (String) session.getAttribute("authenticatedUser");
                        if (userName != null)
                                out.println("<a href = 'customer.jsp'>"+userName+"</a>");
                         %>
                        <a href="checkout.jsp">Check Out</a>
                        <a href="about.html">About</a>
                        <a href="showcart.jsp">Cart</a>
                        
                </div>
                <h1 align="center">Welcome to Inhuman trafficking</h1>

                <h2 align="center"><a href="login.jsp">Login</a></h2>

                <h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

                <h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

                <h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

                <h2 align="center"><a href="admin.jsp">Administrators</a></h2>

                <h2 align="center"><a href="logout.jsp">Log out</a></h2>

                <%
                        //String userName = (String) session.getAttribute("authenticatedUser");
                        if (userName != null)
                                out.println("<h3 align=\"center\">Signed in as: "+userName+"</h3>");
                %>
        </body>
</head>


