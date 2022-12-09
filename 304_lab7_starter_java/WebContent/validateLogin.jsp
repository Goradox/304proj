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

	if(authenticatedUser != null) response.sendRedirect("shop.jsp");		// Successful login
	else response.sendRedirect("login.jsp");		// Failed login - redirect back to login page with a message 
%>


<%!
	String validateLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String retStr = null;

		if(username == null || password == null)
				return null;
		if((username.length() == 0) || (password.length() == 0))
				return null;

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
			    //https://stackoverflow.com/questions/48577861/java-sha-not-woking-hash-value-dosent-equal-string-is-there-an-issue-with-my
			    for (int i = 0; i < md.length; i++) {
			        sb.append(Integer.toString((md[i] & 0xff) + 0x100, 16).substring(1));
			    }

			    hash = sb.toString();

				//session.setAttribute("loginMessage", new String(hash));
			}catch(NoSuchAlgorithmException e)
			{
				out.println(e);
				return null;
			}
			


			String sql = "SELECT password FROM customer WHERE userid = ?";
				PreparedStatement pstmt = con.prepareStatement (sql);
				pstmt.setString(1, username);
				ResultSet rst = pstmt.executeQuery(); 
				//value found
				if(rst.isBeforeFirst()) 
				{
					rst.next();
					String compare = rst.getString(1);
					if(compare.equals(new String(hash)))
					{
						//success
						retStr = username;
					}
					else
					{
						retStr = null;
					session.setAttribute("error", "wrong password: " + compare.length() + " vs " + (new String(hash)).length());
					}
				}
				else{
					retStr = null;
					//session.setAttribute("error", "wrong password or no username");
				}
			con.close();		
		} 
		catch (SQLException ex) {
			out.println(ex);
		}
		
		if(retStr != null)
		{	session.removeAttribute("loginMessage");
			session.setAttribute("authenticatedUser",username);
		}
		else session.setAttribute("loginMessage","Could not connect to the system using that username/password.");

		return retStr;
	}
%>

