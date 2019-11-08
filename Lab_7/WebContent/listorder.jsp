<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>The Cellar Order List</title>
<style>

table.roundedCorners { 
  border: 1px solid DarkOrange;
  border-radius: 25px; 
  border-spacing: 0;
  }
table.roundedCorners td, 
table.roundedCorners th { 
  border-bottom: 1px solid DarkOrange;
  padding: 10px; 
  }
table.roundedCorners tr:last-child > td {
  border-bottom: none;
}
</style>
</head>
<body>

<h1>The Cellar Order List</h1>

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
	out.println("<table class=\"roundedCorners\"><tr>");
	out.println("<th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th>" +
	"<th>Total Amount</th></tr>");
	ResultSet rst = stmt.executeQuery(sql);
	String last = null;
	while(rst.next()) {
		String current = rst.getString(1);
		if(last!=null) {
			if(!last.equals(current))
				out.println("</table></td></tr>");
		}
		if(last==null||!last.equals(current)) {
			last = current;
			out.println("<tr>");
			for(int i=1;i<6;++i)
				out.println("<td>" + rst.getString(i)+"</td>");
			out.println("</tr>");
			out.println("<tr align=\"right\"><td colspan=\"5\"><table class=\"roundedCorners\">" +
					"<th>Product Id</th> <th>Quantity</th> <th>Price</th></tr>");
		}
		out.println("<tr><td>" + rst.getString(6) + "</td><td>" + rst.getString(7)+"</td>" +
		"<td>"+rst.getString(8)+"</td></tr>");
		//<tr><td>1</td><td>1</td><td>$18.00</td></tr>
		
		


	}
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

</body>
</html>

