<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%@ include file="jdbc.jsp"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.Map"%>
<%
	//update inCart relation to save cart for user
	//Obtain product list
	@SuppressWarnings({ "unchecked" })
	HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
			.getAttribute("productList");
	int uid = Integer.parseInt((String) session.getAttribute("uid"));
	try {
		getConnection();

		if (productList != null) {
			//first delete all the user's previous entries in inCart
			/*String clearCart = "DELETE FROM inCart WHERE userId=?";
			PreparedStatement psclear = con.prepareStatement(clearCart);
			psclear.setInt(1, uid);
			psclear.executeUpdate();*/
			//create new arraylist for product, iterator for hashmap
			ArrayList<Object> product = new ArrayList<Object>();
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
			//iterate through each product and add it to the db
			while (iterator.hasNext()) {
				Map.Entry<String, ArrayList<Object>> entry = iterator.next();
				product = (ArrayList<Object>) entry.getValue();
				//check for invalid product entries
				if (product.size() < 4) {
					continue;
				}
				String sqlcart = "INSERT INTO inCart VALUES (?,?,?,?)";
				//0 - id ; 1 - name ; 2 - price ; 3 - quantity
				PreparedStatement upcart = con.prepareStatement(sqlcart);
				upcart.setInt(1, uid);
				upcart.setInt(2, Integer.parseInt((String) product.get(0)));
				upcart.setInt(3, (Integer)product.get(3));
				upcart.setDouble(4, Double.parseDouble((String) product.get(2)));
				
				upcart.executeUpdate();
			}
		}
	} catch (SQLException e) {

	} finally {
		closeConnection();
	}
	// Remove the user from the session to log them out
	session.setAttribute("authenticatedUser", null);
	session.setAttribute("fullname", null);
	session.setAttribute("admin", null);
	session.setAttribute("uid", null);
	session.setAttribute("productList", null);

	response.sendRedirect("index.jsp"); // Re-direct to main page
%>
