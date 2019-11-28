<%
	// Remove the user from the session to log them out
	session.setAttribute("authenticatedUser",null);
	session.setAttribute("fullname",null);
	session.setAttribute("admin",null);
	session.setAttribute("uid",null);
	
	response.sendRedirect("index.jsp");		// Re-direct to main page
%>
