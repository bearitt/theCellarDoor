<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.Map"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>The Cellar Door - Your Shopping Cart</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<style>
a:link, a:visited, a:hover, a:active, h1, h2, p {
	color: #F2E8DF;
}

body {
	color: #F2E8DF
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="shop.html">The Cellar Door</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link"
					href="shop.html">Home <span class="sr-only">(current)</span></a></li>
				<li class="nav-item"><a class="nav-link" href="listorder.jsp">Orders
						List</a></li>
				<li class="nav-item"><a class="nav-link" href="listprod.jsp">Product
						List</a></li>
				<li class="nav-item"><a class="nav-link" href="showcart.jsp">Your
						Shopping Cart</a></li>
			</ul>
			<form class="form-inline my-2 my-lg-0" action="listprod.jsp"
				method="get">
				<input class="form-control mr-sm-2" type="search"
					placeholder="Search" aria-label="Search" name="productName">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search
					for Product</button>
			</form>
		</div>
	</nav>
	<div class="container" style="background-color: #403F3D; text-align:center;">
		<div class="col-sm-12 p-5">
			<%
				// Get the current list of products
				@SuppressWarnings({ "unchecked" })
				HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session
						.getAttribute("productList");

				if (productList == null) {
					out.println("<H1>Your shopping cart is empty!</H1>");
					productList = new HashMap<String, ArrayList<Object>>();
				} else {
					NumberFormat currFormat = NumberFormat.getCurrencyInstance();

					out.println("<h1>Your Shopping Cart</h1>");
					out.print("<table class=\"table table-borderless\" style=\"color:#F2E8DF\"><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
					out.println("<th>Price</th><th>Subtotal</th></tr>");

					double total = 0;
					Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
					while (iterator.hasNext()) {
						Map.Entry<String, ArrayList<Object>> entry = iterator.next();
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
							out.println("Invalid quantity for product: " + product.get(0) + " quantity: " + qty);
						}

						out.print("<td align=\"right\">" + currFormat.format(pr) + "</td>");
						out.print("<td align=\"right\">" + currFormat.format(pr * qty) + "</td></tr>");
						out.println("</tr>");
						total = total + pr * qty;
					}
					out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>" + "<td align=\"right\">"
							+ currFormat.format(total) + "</td></tr>");
					out.println("</table>");

					out.println("<h2><a href=\"checkout.jsp\">Check Out</a></h2>");
				}
			%>
			<h2>
				<a href="listprod.jsp">Continue Shopping</a>
			</h2>
		</div>
	</div>
	<script src="js/jquery-3.4.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
