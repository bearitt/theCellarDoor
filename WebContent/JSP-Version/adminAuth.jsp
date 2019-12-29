<%@ page language="java" import="java.io.*,java.sql.*"%>
<%
	boolean authorized = session.getAttribute("authenticatedUser") == null ? false : true;
	if (authorized) {
		String adminPriv = (String) session.getAttribute("admin");
		if (adminPriv == null || !adminPriv.equals("true")) {
			session.setAttribute("loginMessage",
					"This account does not have admin privileges, try logging in with an admin account.");
			response.sendRedirect("login.jsp"); // Failed login - redirect back to login page with a message
		}
	}
%>