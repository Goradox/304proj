<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>YOUR NAME Grocery Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
	// TODO: Get order id
	int orderId = 0;
	try
	{
		orderId = Integer.parseInt(request.getParameter("orderId"));
	} catch(Exception e)
	{
		out.println(e);
		out.println("<h1>Invalid order ID</h1>");
	}
	
          
	// TODO: Check if valid order id
	String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
	String uid = "sa";
	String pw = "304#sa#pw";

	try (Connection con = DriverManager.getConnection(url, uid, pw);
		Statement stmt = con.createStatement();) 
	{
	
		String SQL =  "SELECT orderId FROM ordersummary WHERE orderId = ?";

		
		PreparedStatement pstmt = con.prepareStatement(SQL);
		pstmt.setInt(1,orderId);

		ResultSet rst = pstmt.executeQuery();
		if(!rst.isBeforeFirst())
		{
			//NO RESULTS
			out.println("<h1>Invalid order ID</h1>");
		}
		else
		{
			// TODO: Start a transaction (turn-off auto-commit)
			con.setAutoCommit(false);
			// TODO: Retrieve all items in order with given id
			PreparedStatement listall = con.prepareStatement("SELECT productId, quantity FROM orderproduct WHERE orderId = ?");
			listall.setInt(1, orderId);
			rst = listall.executeQuery();
			HashMap<Integer, Integer> items = new HashMap<Integer, Integer>();
			while (rst.next())
			{
				//stick results in hash map
				items.put(rst.getInt(1), rst.getInt(2));
			}

			
			// TODO: Create a new shipment record.
			int warehouseId = 1; //this is hard coded for this lab
			PreparedStatement rec = con.prepareStatement("INSERT INTO shipment(shipmentDate, shipmentDesc, warehouseId) VALUES (?, ?, ?)");
			rec.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
			rec.setString(2, "Shipment of: " + items.size() + " different types of item");
			rec.setInt(3, warehouseId);
			rec.execute();

			// TODO: For each item verify sufficient quantity available in warehouse 1.
			boolean rollback = false;
			PreparedStatement check = con.prepareStatement("SELECT quantity FROM productinventory WHERE productId = ? AND warehouseId = ?");
			check.setInt(2, warehouseId);
			for (Map.Entry<Integer, Integer> entry : items.entrySet()) 
			{
			    int productId = entry.getKey();
			    int quantity = entry.getValue();
			    
			    check.setInt(1, productId);
			    rst = check.executeQuery();
			    while(rst.next())
			    {
			    	if(quantity > rst.getInt(1))
			    	{
			    		rollback = true;
			    	}
			    }

			    //stop checking if one item has not enough quantity
			    if(rollback) break;
			}

			// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
			if(rollback) 
			{
				con.rollback();
				out.println("<h1>Not enough inventory</h1>");
			}
			else
			{
				PreparedStatement inv = con.prepareStatement("UPDATE productinventory SET quantity = quantity - ? WHERE productID = ? AND warehouseId = ?");
				inv.setInt(3, warehouseId);
				for (Map.Entry<Integer, Integer> entry : items.entrySet()) 
				{
				    int productId = entry.getKey();
				    int quantity = entry.getValue();

				    inv.setInt(1, quantity);
				    inv.setInt(2, productId);

				    inv.execute();
				}

				out.println("<h1>SHIPMENT RECORD RECORDED</h1>");
			}
		
			//commit transaction
			//this is fine to do no matter what because if there is a rollback, this commit will do nothing
			con.commit();

			// TODO: Auto-commit should be turned back on
			con.setAutoCommit(true);
		}
		con.close();
	}catch(SQLException ex){
		out.println(ex);
	}
	
	
%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>