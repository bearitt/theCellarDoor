<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
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
			String sqlCart = "SELECT I.productId, productName, price, quantity FROM incart "+
					"I JOIN customer C ON I.customerId = C.customerId JOIN product P ON I.productId=P.productId"+
					" WHERE I.customerId = ?";
			PreparedStatement psCart = con.prepareStatement(sqlCart);
			customerID = (String)session.getAttribute("uid");
			psCart.setString(1, customerID);
			ResultSet rsCart = psCart.executeQuery();
			while(rsCart.next()) {
				//create new hashmap for product list
				@SuppressWarnings({ "unchecked" })
				HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
					.getAttribute("productList");
				if (productList == null) { // No products currently in list.  Create a list.
					productList = new HashMap<String, ArrayList<Object>>();
				}
				//Scrape db for variables
				String id = rsCart.getString(1);
				String name = rsCart.getString(2);
				String price = rsCart.getString(3);
				int quantity = rsCart.getInt(4);
				//create new array list for product
				ArrayList<Object> product = new ArrayList<Object>();
				product.add(id); //id
				product.add(name); //name
				product.add(price); //price
				product.add(quantity); //quantity
				
				//check hashmap for product; if product from db is already in the cart, add
				//their quantities together. If not, add to hash map
				if (productList.containsKey(id)) {
					product = (ArrayList<Object>) productList.get(id);
					int curAmount = ((Integer) product.get(3)).intValue();
					product.set(3, new Integer(curAmount + quantity));
				} else
					productList.put(id, product);
				
				//set productList as a session variable
				session.setAttribute("productList", productList);
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
