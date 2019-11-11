<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>The Cellar Door - Products</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
		
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
PreparedStatement pstmt = null;
ResultSet rst = null;
try(Connection con = DriverManager.getConnection(url,uid,pw);) {
	String sql = "SELECT productName,categoryName,productPrice " +
			"FROM product P JOIN category C ON C.categoryId=P.categoryId " +
	"WHERE productName LIKE ?";
	pstmt = con.prepareStatement(sql);
	pstmt.setString(1, "%" + name + "%");
	rst = pstmt.executeQuery();
	out.println("<table class=\"table-hover\"><thead><tr>" +
			"<th> </th><th>Product Name</th><th>Category</th><th>Price</th></tr></thead>");
	while(rst.next()) {
		out.println("<tr><td><a href=\"showcart.jsp\">This doesn't work yet</a></td>"
	+ "<td>" + rst.getString(1) + "</td><td>" + rst.getString(2) + "</td><td>" +
				rst.getString(3) + "</td></tr>");
	}
} catch(SQLException e) {
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
  <script src="js/jquery-3.4.1.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
</body>
</html>