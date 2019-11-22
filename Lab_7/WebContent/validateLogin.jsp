<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*" %>
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
		response.sendRedirect("index.jsp");		// Successful login
	else
		response.sendRedirect("login.jsp");		// Failed login - redirect back to login page with a message
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

		try
		{
			getConnection();
			String sqlAuth = "SELECT * FROM customer WHERE userid = ?";
			PreparedStatement psAuth = con.prepareStatement(sqlAuth);
			psAuth.setString(1, username);
			ResultSet rsAuth = psAuth.executeQuery();
			
			if(rsAuth.next()) {
				retStr = username;
				String firstAndLastName = rsAuth.getString(2) + " " + rsAuth.getString(3);
				session.setAttribute("fullname",firstAndLastName);
			}
			// TODO: Check if userId and password match some customer account. If so, set retStr to be the username.
		}
		catch (SQLException ex) {
			out.println(ex);
		}
		finally
		{
			closeConnection();
		}

		if(retStr != null)
		{	session.removeAttribute("loginMessage");
			session.setAttribute("authenticatedUser",username);
		}
		else
			session.setAttribute("loginMessage","Could not connect to the system using that username/password.");

		return retStr;
	}
%>
