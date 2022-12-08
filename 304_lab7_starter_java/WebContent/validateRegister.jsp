
<%@ page language="java" import="java.io.*,java.sql.*,java.security.MessageDigest, java.security.NoSuchAlgorithmException"%>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);

	try
	{
		authenticatedUser = validateLogin(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }

	if(authenticatedUser != null)
		response.sendRedirect("shop.html");		// Successful login
	else
		response.sendRedirect("register.jsp");
				// Failed register - redirect back to register page with a message 
%>


<%!
	String validateLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String firstName = request.getParameter("first");
		String lastName = request.getParameter("last");
		String retStr = null;

		if(username == null || password == null || firstName == null || lastName == null)
		{
			session.setAttribute("error", "missing data");
				return null;
		}
		if((username.length() == 0) || (password.length() == 0) || (firstName.length() == 0) || (lastName.length() == 0))
		{
			session.setAttribute("error", "missing data");
				return null;
		}

		String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
		String uid = "sa";
		String pw = "304#sa#pw";

		try (Connection con = DriverManager.getConnection(url, uid, pw);
		Statement stmt = con.createStatement(); )
		{
			
			// TODO: Check if userId and password match some customer account.If so, set retStr to be the username.

			//using hashing for secure authentication
			String hash = "";
			try
			{
				MessageDigest digest = MessageDigest.getInstance("SHA-256");
				
				byte[] message = password.getBytes();
				digest.update(message);

			    byte[] md = digest.digest();
			    StringBuffer sb = new StringBuffer();
			    for (int i = 0; i < md.length; i++) {
			    	//https://stackoverflow.com/questions/48577861/java-sha-not-woking-hash-value-dosent-equal-string-is-there-an-issue-with-my
			        sb.append(Integer.toString((md[i] & 0xff) + 0x100, 16).substring(1));
			    }

			    hash = sb.toString();

				//session.setAttribute("loginMessage", new String(hash));
			}catch(NoSuchAlgorithmException e)
			{
				out.println(e);
				session.setAttribute("error", "no alg");
				return null;
			}
			

			//making sure account doesn't already exist with username
			String sql = "SELECT userid FROM customer WHERE userid = ?";
				PreparedStatement pstmt = con.prepareStatement (sql);
				pstmt.setString(1, username);
				ResultSet rst = pstmt.executeQuery(); 
				//there is a result
				if(rst.isBeforeFirst())
				{
					session.setAttribute("registerMessage", "Username Taken");
					session.setAttribute("error", "username taken");
					retStr = null;
				}
				else{
					pstmt = con.prepareStatement("INSERT INTO customer(firstName, lastName, userid, password) VALUES (?, ?, ?, ?)");
					pstmt.setString(1, firstName);
					pstmt.setString(2, lastName);
					pstmt.setString(3, username);
					pstmt.setString(4, hash);

					pstmt.execute();

					retStr = username;
				}
			con.close();		
		} 
		catch (SQLException ex) {
			session.setAttribute("error", "SQL: " + ex);
			out.println(ex);
		}
		
		if(retStr != null)
		{	
			session.setAttribute("registerMessage", "Successfully registered, login now");
			//session.removeAttribute("registerMessage");
			//session.setAttribute("authenticatedUser",username);
		}
		else session.setAttribute("registerMessage","Could not register to the system using that data.");

		return retStr;
	}
%>

