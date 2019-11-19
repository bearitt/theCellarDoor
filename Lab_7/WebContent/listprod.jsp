<%@ page import="java.sql.*,java.net.URLEncoder"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>The Cellar Door - Products</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<style>
.container-fluid, container {
	padding: 80px 120px;
}

body {
	color: #F2E8DF;
}

.table {
	color: #F2E8DF;
}

a:link, a:visited, a:hover, a:active {
	color: #F2E8DF;
}

.table-hover tbody tr:hover td {
  background-color:#A6A29F;
	color:#262524;
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
	<div class="container" style="background-color: #403F3D;">
		<div class="row">
			<div class="col-sm-9">
				<form method="get" action="listprod.jsp" class="form-inline">
					<div class="form-group">
						<div class="col-xs-12 col-md-4">
							<label class="sr-only" for="helpProduct">Search for the
								products you want to buy</label> <input type="text" class="form-control"
								id="helpProduct" placeholder="Enter product name"
								name="productName">
						</div>
					</div>
					<div class="col-xs-12 col-md-8">
						<div class="btn-group">
							<button type="submit" class="btn btn-secondary">Submit</button>
							<button type="reset" class="btn btn-dark">Reset</button>
						</div>
					</div>
				</form>
			</div>
			<br>
			<%
				// Get product name to search for
				String name = request.getParameter("productName");
				if (name == null)
					name = "";

				//Note: Forces loading of SQL Server driver
				try { // Load driver class
					Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
				} catch (java.lang.ClassNotFoundException e) {
					out.println("ClassNotFoundException: " + e);
				}
				String uid = "bjackson";
				String pw = "66122573";
				String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_bjackson;";
				PreparedStatement pstmt = null;
				ResultSet rst = null;
				NumberFormat currFormat = NumberFormat.getCurrencyInstance();
				try (Connection con = DriverManager.getConnection(url, uid, pw);) {
					//String[] rowColours = { "", "\"table-primary\"", "\"table-success\"", "\"table-danger\"",
					//	"\"table-info\"", "\"table-warning\"", "\"table-light\"" };
					String[] rowColours = { "#736E6C", "#403F3D", "#262524" };
					String sql = "SELECT productName,categoryName,productPrice,productId "
							+ "FROM product P JOIN category C ON C.categoryId=P.categoryId "
							+ "WHERE productName LIKE ? ORDER BY categoryName ASC";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%" + name + "%");
					rst = pstmt.executeQuery();
					//table header
					out.println("<table class=\"table table-hover table-responsive-md table-borderless\"><thead><tr>"
							+ "<th> </th><th>Product Name</th><th>Category</th><th>Price</th></tr></thead>");
					//table data
					int i = 0;
					int counter;
					String last = null;
					while (rst.next()) {
						String category = rst.getString(2);
						if (last == null || !last.equals(category)) {
							i++;
							last = category;
						}

						counter = i % 3;
						/*out.println("<tr class=" + rowColours[counter] + "><td><a href=\"addcart.jsp?id=" + rst.getString(4)
								+ "&name=" + rst.getString(1) + "&price=" + rst.getString(3) + "\">Add to Cart</a></td>"
								+ "<td>" + rst.getString(1) + "</td><td>" + category + "</td><td>"
								+ currFormat.format(rst.getDouble(3)) + "</td></tr>");*/
						out.println("<tr style=\"background-color:" + rowColours[counter] + "\"><td><a href=\"addcart.jsp?id=" + rst.getString(4)
								+ "&name=" + rst.getString(1) + "&price=" + rst.getString(3) + "\">Add to Cart</a></td>"
								+ "<td>" + rst.getString(1) + "</td><td>" + category + "</td><td>"
								+ currFormat.format(rst.getDouble(3)) + "</td></tr>");
					}
				} catch (SQLException e) {
					out.println("Something went wrong");
				}
				// Variable name now contains the search string the user entered
				// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

				// Make the connection

				// Print out the ResultSet

				// For each product create a link of the form
				// addcart.jsp?id=productId&name=productName&price=productPrice
				// Close connection

				// Useful code for formatting currency values:
				// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
				// out.println(currFormat.format(5.0);	// Prints $5.00
			%>
		</div>
	</div>
	</div>
	<script src="js/jquery-3.4.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
