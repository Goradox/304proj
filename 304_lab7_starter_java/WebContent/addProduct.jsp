

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%

	//this page is meant to be accessed with AJAX only

	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
    String uid = "sa";
    String pw = "304#sa#pw";

  	String name = request.getParameter("name");
  	double price = 0;
  	String imgUrl = request.getParameter("imgUrl");
  	String desc = request.getParameter("desc");
  	int category = 0;
  	try
  	{
	  	price = Double.parseDouble(request.getParameter("price"));
	  	category = Integer.parseInt(request.getParameter("category"));

  	}catch(Exception e)
  	{
  		//bad request
  		out.println(e);
  		out.println("{\"status\":400}");
  	}

  	if(name == null || imgUrl == null || desc == null)
  	{
  		out.println("{\"status\":400}");
  	}
  	
  	else
  	{
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
	            pstmt = con.prepareStatement("INSERT INTO product(productName, productPrice, productImageURL, productDesc, categoryId) VALUES (?, ?, ?, ?, ?)");
	            pstmt.setString(1, name);
	            pstmt.setDouble(2, price);
	            pstmt.setString(3, imgUrl);
	            pstmt.setString(4, desc);
	            pstmt.setInt(5, category);

	            pstmt.execute();

	            out.println("{\"status\":200}");

	        }

	    }
	    catch (SQLException ex) 
	    {
	        out.println(ex);
	    }
  	}

   


%>
