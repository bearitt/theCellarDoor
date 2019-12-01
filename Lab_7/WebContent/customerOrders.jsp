<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>The Cellar - Order List</title>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/custom.css">
</head>
<body>
<%@ include file="auth.jsp"%>
<%@ include file="header.jsp"%>
	<div class="container" style="background-color: #403F3D; text-align:center;">
		<div class="col-sm-12 p-5">
		<h1>Order List</h1>
		<p>All of the orders that <%out.print(session.getAttribute("fullname"));%> has ever placed.</p>
		<br>
		<%
			try {
				getConnection();
				String sql = "SELECT O.orderId, orderDate, C.customerId, CONCAT(firstName, ' ', lastName) "
						+ "AS name, totalAmount, P.productId, quantity, price "
						+ "FROM ordersummary O JOIN customer C ON O.customerId = C.customerId "
						+ "JOIN orderproduct P ON O.orderId = P.orderId WHERE C.customerId = ?";

				//create the table and print the header row
				out.println(
						"<table class=\"table table-hover table-borderless table-responsive-md\"><thead><tr>");
				out.println("<th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th>"
						+ "<th>Total Amount</th></tr></thead>");
				PreparedStatement stmt = con.prepareStatement(sql);
				stmt.setString(1,(String)session.getAttribute("uid"));
				ResultSet rst = stmt.executeQuery();
				String last = null;
				NumberFormat currFormat = NumberFormat.getCurrencyInstance();
				int j = 0;
				while (rst.next()) {
					String current = rst.getString(1);
					if (last != null) {
						//ends the table tag after the last entry of the nested product table
						if (!last.equals(current))
							out.println("</table></div></td></tr>");
					}
					if (last == null || !last.equals(current)) {
						last = current;
						//starts a new row for the next order
						out.println("<tr>");
						//for loop prints order id, order date, customer id, customer name, totalAmount
						for (int i = 1; i < 6; ++i) {
							//format orderDate to only show centiseconds after seconds
						    if(i==2) {
						        out.println("<td>" + rst.getString(i).substring(0,21) + "</td>");
						    }
							//format totalAmount to print currency format
						    else if(i==5)
						        out.println("<td>" + currFormat.format(rst.getDouble(5)) + "</td>");
							//no formatting on other values
						    else
							    out.println("<td>" + rst.getString(i) + "</td>");
						}
						out.println("</tr>");
						//starts a new row for the nested product table
						out.println("<tr align=\"right\"><td colspan=\"5\">"
								+ "<button data-toggle=\"collapse\" data-target=\"#prodList" + j
								+ "\" type=\"button\" class=\"btn btn-secondary\">Click for list of products</button>"
								+ "<div id=\"prodList" + (j++) + "\" class=\"collapse\">" +
								"<table class=\"table-hover\">"
								+ "<thead><th>Product Id</th> <th>Quantity</th>" + "<th>Price</th></tr></thead>");
					}
					//prints product id, quantity and price
					out.println("<tr><td>" + rst.getString(6) + "</td><td>" + rst.getString(7) + "</td>" + "<td>"
							+ currFormat.format(rst.getDouble(8)) + "</td></tr>");
				}
				//ending tag for order list table
				out.println("</table>");

			} catch (SQLException e) {
				System.err.println(e);
			} finally {
				closeConnection();
			}

			// Useful code for formatting currency values:
			// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
			// out.println(currFormat.format(5.0);  // Prints $5.00

			// Make connection

			// Write query to retrieve all order summary records

			// For each order in the ResultSet

			// Print out the order summary information
			// Write a query to retrieve the products in the order
			//   - Use a PreparedStatement as will repeat this query many times
			// For each product in the order
			// Write out product information

			// Close connection
		%>
	</div></div>
</body>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</html>
