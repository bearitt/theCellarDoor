<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>The Cellar Door - Thank you for your order!</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/custom.css">
</head>
<body>
	<%@ include file="auth.jsp"%>
	<%@ include file="header.jsp"%>
	<div class="container" style="background-color: #403F3D">
		<div class="col-sm-12 p-5">
			<%
				@SuppressWarnings({ "unchecked" })
				HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
						.getAttribute("productList");

				//initialize custId, parameters for connection
				String username = request.getParameter("username");
				String url = "jdbc:sqlserver://sql04.ok.ubc.ca;databaseName=db_bjackson;";
				String uid = "bjackson";
				String pw = "66122573";

				//-----------------2 marks for updating total amount for the order in OrderSummary table--------------------
				try {
					// Determine if valid customer id was entered
					String temp = username;
					Connection conn = DriverManager.getConnection(url, uid, pw);
					String userId = "SELECT * FROM customer WHERE userid = ?";
					PreparedStatement prep = conn.prepareStatement(userId);
					prep.setString(1, username);
					ResultSet rs = prep.executeQuery();
					if (!rs.next()) {
			%>
			<div class="container-fluid">
				<h1>Login to complete the transaction:</h1>
				<form method=post action="order.jsp">
					<div class="form-group">
						<label class="">Username</label> <input class="form-control"
							name="username" id="username" type="text">
					</div>
					<div class="form-group">
						<label class="">Password</label> <input class="form-control"
							name="password" id="password" type="password"> <br
							class="">
					</div>
					<button type="submit" id="btnLogin"
						class="btn btn-secondary btn-sm">Login</button>
				</form>
			</div>
			<%
				conn.close();
					} else {
						String userNum = rs.getString(1);
						String fullName = rs.getString(2) + " " + rs.getString(3);
						conn.close();
						try {
							getConnection();
							//determine if shopping cart is empty
							if (productList == null || productList.isEmpty()) {
								out.print("There are no products in the shopping cart");
							} else {

								//insert values into OrderSummary
								String SQLsum = "INSERT INTO OrderSummary (orderDate, totalAmount,"
										+ " shiptoAddress, shiptoCity, shiptoState, shiptoPostalCode, shiptoCountry,"
										+ " customerId) VALUES (?,?,?,?,?,?,?,?)";
								PreparedStatement psOrderSum = con.prepareStatement(SQLsum,
										Statement.RETURN_GENERATED_KEYS);
								//obtain info about customer to add to order
								String sqlUserInfo = "SELECT address, city, state, postalCode, country, customerId "
										+ "FROM customer WHERE userid = ?";
								PreparedStatement pUserInfo = con.prepareStatement(sqlUserInfo);
								pUserInfo.setString(1, username);
								ResultSet rstCust = pUserInfo.executeQuery();
								rstCust.next();
								//obtain current date and time
								Timestamp timestamp = new Timestamp(System.currentTimeMillis());
								//begin adding fields to ordersummary
								psOrderSum.setTimestamp(1, timestamp);
								psOrderSum.setInt(2, 0); //totalAmount will be calculated from orderProduct
								psOrderSum.setString(3, rstCust.getString(1));
								psOrderSum.setString(4, rstCust.getString(2));
								psOrderSum.setString(5, rstCust.getString(3));
								psOrderSum.setString(6, rstCust.getString(4));
								psOrderSum.setString(7, rstCust.getString(5));
								psOrderSum.setString(8, rstCust.getString(6));
								psOrderSum.executeUpdate();
								//obtain auto generated orderId
								ResultSet keys = psOrderSum.getGeneratedKeys();
								keys.next();
								int orderId = keys.getInt(1);

								Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
								while (iterator.hasNext()) {
									//traverses through the hashmap with array values = 0-id, 1-name, 2-quantity, 3-price
									Map.Entry<String, ArrayList<Object>> entry = iterator.next();
									ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
									String productId = (String) product.get(0);
									String price = (String) product.get(2);
									double pr = Double.parseDouble(price);
									int qty = (Integer.parseInt(product.get(3).toString()));
									//int qty = (((Integer)product.get(3)).intValue());
									//insert into orderproduct
									String SQL6 = ("INSERT INTO OrderProduct (orderId, productId, quantity,"
											+ " price) VALUES (?,?,?,?)");
									PreparedStatement pstmt6 = con.prepareStatement(SQL6);
									pstmt6.setInt(1, orderId);
									pstmt6.setString(2, productId);
									pstmt6.setInt(3, qty);
									pstmt6.setDouble(4, pr);
									pstmt6.executeUpdate();
								}
								//calculate total amount from OrderProduct
								String sqlTotal = "SELECT SUM(quantity*price) FROM OrderProduct " + "WHERE orderId = ?";
								PreparedStatement pstTotal = con.prepareStatement(sqlTotal);
								pstTotal.setInt(1, orderId);
								ResultSet rsTotal = pstTotal.executeQuery();
								rsTotal.next();
								double totalAmount = rsTotal.getDouble(1);
								//update OrderSummary with calculated total
								String upTotal = "UPDATE OrderSummary SET totalAmount = ? WHERE orderId = ?";
								PreparedStatement pUpTotal = con.prepareStatement(upTotal);
								pUpTotal.setDouble(1, totalAmount);
								pUpTotal.setInt(2, orderId);
								pUpTotal.executeUpdate();
								//print the table
								NumberFormat currFormat = NumberFormat.getCurrencyInstance();
								out.println("<h1>Your order:</h1>");
								out.print("<table class=\"table table-hover table-responsive-md table-borderless\">"
										+ "<thead><tr><th>Product Id</th>" + "<th>Product Name</th><th>Quantity</th>");
								out.println("<th>Price</th><th>Subtotal</th></tr></thead>");

								double total = 0;
								Iterator<Map.Entry<String, ArrayList<Object>>> iteratorOrder = productList.entrySet()
										.iterator();
								while (iteratorOrder.hasNext()) {
									Map.Entry<String, ArrayList<Object>> entry = iteratorOrder.next();
									ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
									if (product.size() < 4) {
										out.println("Expected product with four entries. Got: " + product);
										continue;
									}

									out.print("<tr><td>" + product.get(0) + "</td>");
									out.print("<td>" + product.get(1) + "</td>");

									out.print("<td align=\"center\">" + product.get(3) + "</td>");
									Object price = product.get(2);
									Object itemqty = product.get(3);
									double pr = 0;
									int qty = 0;

									try {
										pr = Double.parseDouble(price.toString());
									} catch (Exception e) {
										out.println("Invalid price for product: " + product.get(0) + " price: " + price);
									}
									try {
										qty = Integer.parseInt(itemqty.toString());
									} catch (Exception e) {
										out.println(
												"Invalid quantity for product: " + product.get(0) + " quantity: " + qty);
									}

									out.print("<td align=\"right\">" + currFormat.format(pr) + "</td>");
									out.print("<td align=\"right\">" + currFormat.format(pr * qty) + "</td></tr>");
									out.println("</tr>");
									total = total + pr * qty;
								}
								out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
										+ "<td align=\"right\">" + currFormat.format(total) + "</td></tr>");
								out.println("</table>");

								//clear the shopping cart by setting productList attribute to null
								session.setAttribute("productList", null);
								out.println("<h1>Order completed, will be shipped soon!</h1>");
								out.print("<h2>Your order reference number is: " + orderId + "</h2>");
								out.print("<h2>Shipping to customer: " + userNum + "</h2><h2>Name: " + fullName + "</h2>");
							}
						} catch (SQLException e) {
							System.err.println(e);
							out.println("<p>Something went wrong</p>");
						} finally {
							closeConnection();
						}
					}

				} catch (NumberFormatException e) {
					out.println("<h1>Invalid User Id</h1>");
					out.println("<form method=\"get\" action=\"order.jsp\" class=\"form-inline\">"
							+ "<div class=\"form-group\"><div class=\"col-xs-12 col-md-4\">"
							+ "<input type=\"text\" class=\"form-control\" id=\"helpProduct\""
							+ "placeholder=\"Enter customer id\" name=\"customerId\"></div></div>"
							+ "<div class=\"col-xs-12 col-md-8\"><div class=\"btn-group\">"
							+ "<button type=\"submit\" class=\"btn btn-secondary\">Submit</button>"
							+ "<button type=\"reset\" class=\"btn btn-dark\">Reset</button>" + "</div></div></form>");
				}
				//TODO:

				// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price
			%>
			<br> <a href="index.jsp" class="btn btn-dark" role="button">Return
				to homepage</a>
		</div>
	</div>
	<script src="js/jquery-3.4.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</BODY>
</HTML>
