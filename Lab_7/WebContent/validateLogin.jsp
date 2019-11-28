<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ include file="jdbc.jsp"%>
<%
	String authenticatedUser = null;
	session = request.getSession(true);
	
	try {
		authenticatedUser = validateLogin(out, request, session);
	} catch (IOException e) {
		System.err.println(e);
	}

	if (authenticatedUser != null)
		response.sendRedirect("index.jsp"); // Successful login
	else
		response.sendRedirect("login.jsp"); // Failed login - redirect back to login page with a message
%>


<%!String validateLogin(JspWriter out, HttpServletRequest request, HttpSession session) throws IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String retStr = null;
		
		if (username == null || password == null)
			return null;
		if ((username.length() == 0) || (password.length() == 0))
			return null;

		try {
			getConnection();
			//query db for user
			String sqlAuth = "SELECT * FROM customer WHERE userid = ?";
			PreparedStatement psAuth = con.prepareStatement(sqlAuth);
			psAuth.setString(1, username);
			ResultSet rsAuth = psAuth.executeQuery();
			String customerID = null;
			//check if customer is in db
			if (rsAuth.next()) {
				//check if password matches entry in db
				if (password.equals(rsAuth.getString(12))) {
					retStr = username;
					customerID = rsAuth.getString(1);
					//create first and last name string for displaying throughout the site
					String firstAndLastName = rsAuth.getString(2) + " " + rsAuth.getString(3);
					session.setAttribute("fullname", firstAndLastName);
					//set session variable for customerId
					session.setAttribute("uid",customerID);
					//check for admin privileges
					if(rsAuth.getInt(13)==1)
						session.setAttribute("admin","true");
				}
			}
			//starter code to store/retrieve cart from db
			String sqlCart = "SELECT I.orderId, productId, quantity, price FROM incart "+
			"I JOIN orderSummary O ON I.orderId=O.orderId WHERE customerId = ?";
			PreparedStatement psCart = con.prepareStatement(sqlCart);
			psCart.setString(1, customerID);
			ResultSet rsCart = psCart.executeQuery();
			if(rsCart.next()) {
				
			}

		} catch (SQLException ex) {
			out.println(ex);
		} finally {
			closeConnection();
		}
		//if valid login
		if (retStr != null) {
			session.removeAttribute("loginMessage");
			session.setAttribute("authenticatedUser", username);
		} else
			session.setAttribute("loginMessage", "Could not connect to the system using that username/password.");

		return retStr;
	}%>
