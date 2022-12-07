goradox
#3426

aod — Today at 9:20 PM
So we’ve done all of them except ship.jsp
mantrobuski — Today at 9:20 PM
that explains why no one was talking lmaoooooo
aod — Today at 9:21 PM
So if you wanna finish it off then be our guest lol
mantrobuski — Today at 9:21 PM
yes for sure
of course
can you send me the .zip of what you guys have
goradox — Today at 9:21 PM
I’ll send all the codes to you
mantrobuski — Today at 9:21 PM
perfect
goradox — Today at 9:21 PM
Yeah, one sec
aod — Today at 9:21 PM
Ok @goradox can you send the code
To @mantrobuski
Actually
One of us can just submit on canvas and you can download from there
Should be easier?
mantrobuski — Today at 9:22 PM
I think it's the same either way
goradox — Today at 9:23 PM
this "should" be the codes
Attachment file type: archive
codes.zip
1.39 MB
Im kinda messy in arranging my files
so might be wrong
mantrobuski — Today at 9:24 PM
lmaoo that's what you like to hear
hahahaha
goradox — Today at 9:26 PM
and I believe Alexis has started working on some of the ship, I havent changed the one on mine
mantrobuski — Today at 9:33 PM
what are the log in details
actually
that doesn't matter
goradox — Today at 9:35 PM
Username is It’s “arnold” and password is “test
mantrobuski — Today at 9:35 PM
for what I have to do
goradox — Today at 9:35 PM
Fyi then
mantrobuski — Today at 9:36 PM
hey I think this is a bit wrong
because the search is not working
might be the wrong version of that file
it's also showing me the SQL query on the screen
goradox — Today at 9:36 PM
It’s kinda hard to tell from words, you mind sharing your screen on DC so I can have a look?
mantrobuski — Today at 9:37 PM
sure come in stuydy room 1
goradox — Today at 9:43 PM
Forgot to ask
Which file did you change to fix that?
mantrobuski — Today at 9:44 PM
might be one or two files
addcart and show orders maybe?
listprod
I mean
OOH
no
it's viewcart
showcart*
goradox — Today at 9:44 PM
Ok
mantrobuski — Today at 9:44 PM
and it might be also addcart I'm not sure what all I changed
but for sure it's showcart
goradox — Today at 9:46 PM
Yup, I replaced showcart, and it is functioning
mantrobuski — Today at 9:46 PM
ok
I think we need to make a video demo for this lab
I can do that , although I think you will be better at it cause you have written more of the code
goradox — Today at 9:46 PM
I asked him if he really needs it in class
and he said forget about it lol
mantrobuski — Today at 9:46 PM
ah ok
is there a link to the database schema that you know of quickly
goradox — Today at 9:49 PM
？
mantrobuski — Today at 9:49 PM
like the tables and all their columns
goradox — Today at 9:51 PM
I just click between them manually
mantrobuski — Today at 9:51 PM
ok
mantrobuski — Today at 10:07 PM
update, I'm doing super well, should be done failry soon
goradox — Today at 10:10 PM
nice
mantrobuski — Today at 10:36 PM
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
Expand
ship.jsp
5 KB
this should be rock solid
anything left to do?
goradox — Today at 10:45 PM
should be good to go
﻿
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