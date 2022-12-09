<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Your Shopping Cart</title>
</head>
<body>

<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

String deleteWhat = request.getParameter("delete");
String addWhat = request.getParameter("addOne");
String reduceWhat = request.getParameter("removeOne");

//if delete is set, delete from map
if(deleteWhat != null && !deleteWhat.equals(""))
{
	productList.remove(deleteWhat);
}

//add one
if(addWhat != null && !addWhat.equals(""))
{
	//this is so gross
	ArrayList<Object> product = productList.get(addWhat);
	product.set(3, (int)product.get(3) + 1);
}

//remove one, if total goes to zero then delete
if(reduceWhat != null && !reduceWhat.equals(""))
{
	ArrayList<Object> product = productList.get(reduceWhat);
	product.set(3, (int)product.get(3) - 1);
	if((int)product.get(3) < 1) productList.remove(reduceWhat);
}

if (productList == null || productList.size() == 0)
{	out.println("<H1>Your shopping cart is empty!</H1>");
	productList = new HashMap<String, ArrayList<Object>>();
}
else
{
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

	out.println("<h1>Your Shopping Cart</h1>");
	out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
	out.println("<th>Price</th><th>Subtotal</th><th>Delete?</th></tr>");

	double total =0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) 
	{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		if (product.size() < 4)
		{
			out.println("Expected product with four entries. Got: "+product);
			continue;
		}
		
		out.print("<tr><td>"+product.get(0)+"</td>");

		out.print("<td>" + product.get(1) + "</td>");

		out.print("<td align=\"center\">"+product.get(3)+"</td>");
		Object price = product.get(2);
		Object itemqty = product.get(3);
		double pr = 0;
		int qty = 0;
		
		try
		{
			pr = Double.parseDouble(price.toString().substring(1)); //clears dollar sign
		}
		catch (Exception e)
		{
			out.println("Invalid price for product: "+product.get(0)+" price: "+price);
		}
		try
		{
			qty = Integer.parseInt(itemqty.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
		}		

		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");
		out.print("<td align=\"right\"><a href=\"showcart.jsp?delete=" + entry.getKey() + "\">Delete</a></td>");
		out.print("<td align=\"right\"><a href=\"showcart.jsp?addOne=" + entry.getKey() + "\">Add One</a></td>");
		out.print("<td align=\"right\"><a href=\"showcart.jsp?removeOne=" + entry.getKey() + "\">Remove One</a></td>");
		out.println("</tr>");
		total = total +pr*qty;
	}
	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
	out.println("</table>");

	out.println("<h2><a href=\"checkout.jsp\">Check Out</a></h2>");
}
%>
<h2><a href="listprod.jsp">Continue Shopping</a></h2>
</body>
</html> 

