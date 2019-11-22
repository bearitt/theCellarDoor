<!DOCTYPE html>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Customer Page</title>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/custom.css">
</head>
<body>
<%@ include file="auth.jsp"%>
<%@ include file="header.jsp"%>
<div class="container" style="background-color: #403F3D;">
		<div class="row">
			<div class="col-sm-9">
<%
	String userName = (String) session.getAttribute("authenticatedUser");
// TODO: Print Customer information
try {
	getConnection();
	String sql = "Select customerId, firstName, lastName, email, phonenum, "
			+ "address, city, state, postalCode, country, userid From customer "
			+ "Where userid = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, userName); //get userId from somewhere
	ResultSet rst = pstmt.executeQuery();
	if (rst.next()) {
		out.println(
				"<table class=\"table table-hover table-borderless table-responsive-md\"><thead><tr>");
		out.println("<th>Id</th><th>First Name</th><th>Last Name</th><th>Email</th>"
				+ "<th>Phone</th><th>Address</th><th>City</th><th>State</th><th>Postal Code</th>"
				+"<th>Country</th><th>User id</th></tr></thead><tbody>");
			out.println("<tr>");
			for (int i = 1; i < 12; ++i) {
				String temp;
				if(rst.getString(i).equals("")||rst.getString(i)==null)
					temp = "NA";
				else
					temp = rst.getString(i);
	      out.println("<td>" + temp + "</td>");
			}
			out.println("</tr>");
			out.println("</tbody></table>");
		} else {
			out.println("<h1>No customer information found!");
		}


	} catch (SQLException e) {
	System.err.println(e);
} finally {
	closeConnection();
}
// Make sure to close connection
%>
</div></div></div>
	<script src="js/jquery-3.4.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
