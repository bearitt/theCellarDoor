<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>The Cellar - Order List</title>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<style>
		.container-fluid,container {
			padding: 80px 120px;
		}
	</style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="shop.html">The Cellar Door</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mr-auto">
        <li class="nav-item active">
          <a class="nav-link" href="shop.html">Home <span class="sr-only">(current)</span></a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="listorder.jsp">Orders List</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="listprod.jsp">Product List</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="showcart.jsp">Your Shopping Cart</a>
        </li>
      </ul>
			<form class="form-inline my-2 my-lg-0" action="listprod.jsp" method="get">
        <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" name="productName">
        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search for Product</button>
      </form>
    </div>
  </nav>
<div class="container">
<div class="container-fluid" style="background-color:#A6A29F; text-align:center;">
	<h1>Order List</h1>
	<p>List of all past and present orders</p>
</div>
<br>
<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}
String uid = "bjackson";
String pw = "66122573";
String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_bjackson;";
try(Connection con = DriverManager.getConnection(url,uid,pw);
		Statement stmt = con.createStatement();) {
	String sql = "SELECT O.orderId, orderDate, C.customerId, CONCAT(firstName, ' ', lastName) " +
			"AS name, totalAmount, P.productId, quantity, price " +
			"FROM ordersummary O JOIN customer C ON O.customerId = C.customerId " +
			"JOIN orderproduct P ON O.orderId = P.orderId";

	//create the table and print the header row
	out.println("<table class=\"table-hover table-bordered\" style=\"margin:auto; width:50% !important;\"><thead><tr>");
	out.println("<th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th>" +
	"<th>Total Amount</th></tr></thead>");
	ResultSet rst = stmt.executeQuery(sql);
	String last = null;
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	int j=0;
	while(rst.next()) {
		String current = rst.getString(1);
		if(last!=null) {
			//ends the table tag after the last entry of the nested product table
			if(!last.equals(current))
				out.println("</table></div></td></tr>");
		}
		if(last==null||!last.equals(current)) {
			last = current;
			//starts a new row for the next order
			out.println("<tr>");
			//for loop prints order id, order date, customer id, customer name
			for(int i=1;i<5;++i)
				out.println("<td>" + rst.getString(i)+"</td>");
			//total amount printed on separate line to use currency format
			out.println("<td>" + currFormat.format(rst.getDouble(5))+"</td>");
			out.println("</tr>");
			//starts a new row for the nested product table
			out.println("<tr align=\"right\"><td colspan=\"5\">"+
					"<button data-toggle=\"collapse\" data-target=\"#demo" +
					j + "\" type=\"button\" class=\"btn btn-secondary\">Click for list of products</button>" +
					"<div id=\"demo"+(j++)+"\" class=\"collapse\">" +
					"<table class=\"table-hover\">" +
					"<thead><th>Product Id</th> <th>Quantity</th>" +
					"<th>Price</th></tr></thead>");
		}
		//prints product id, quantity and price
		out.println("<tr><td>" + rst.getString(6) + "</td><td>" + rst.getString(7)+"</td>" +
		"<td>"+currFormat.format(rst.getDouble(8))+"</td></tr>");
	}
	//ending tag for order list table
	out.println("</table>");


} catch(SQLException e) {
	System.err.println(e);
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
</div>
</body>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</html>
