<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>The Cellar Door - Product Information</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css/custom.css">
</head>
<body>

<%@ include file="header.jsp" %>
<div class="container" style="background-color: #403F3D; text-align:center;">
	<div class="row">
		<div class="col-lg-4 col-sm-12 p-5">

<%
Blob image = null;
try{
	getConnection();

// Get product name to search for
// TODO: Retrieve and display info for the product
String productId = (String)request.getParameter("id");
String sql = "select productName, productId, productPrice, productDesc," +
"productImage, productImageURL from product where productId = ?";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setString(1,productId);
ResultSet rs = pstmt.executeQuery();
//start

//end
if (rs.next()){
	if(rs.getString(4)!=null&&!rs.getString(4).equals(""))
		out.print("<img src=\"displayImage.jsp?id="+productId+"\" height=\"533\" width=\"300\">");
	if(rs.getString(6)!=null&&!rs.getString(6).equals("")&&!rs.getString(6).equals("null"))
		out.print("<img src=\""+rs.getString(6)+"\">");	
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();
	%>
	
	<%out.print("<br><a href=\"addcart.jsp?id=" +
			rs.getString(2) + "&name=" + rs.getString(1) + "&price=" +
			rs.getString(3) + "\"><h2><i class=\"fas fa-cart-plus\"></i>Add to Cart</h2></a></td>");%>
	<h2><a href="listprod.jsp">Continue shopping</a></h2>
	</div>
	<div class="col-lg-4 col-sm-12 p-5">
	<table>
		<thead>
			<tr>
				<th><%out.print(rs.getString(1));%></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><strong>Id:	</strong></td>
				<td><%out.print(rs.getString(2));%></td>
				<!--<td rowspan="3"></td>-->
			</tr>
			<tr>
				<td><strong>Price: </strong></td>
				<td><%out.print(currFormat.format(rs.getDouble(3)));%></td>
			</tr>
			<tr>
				<td colspan="2">
				<%out.print(rs.getString(4));%></td>
			</tr>
		</tbody>
	</table>
	</div>

		<%
}else{
	out.print("<h1>No product found!</h1>");
}

// TODO: If there is a productImageURL, display using IMG tag

// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.

// TODO: Add links to Add to Cart and Continue Shopping
}catch(SQLException e){

} finally {
	closeConnection();
}
%>
<br>
</div>
</div>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/e9d963041d.js" crossorigin="anonymous"></script>
</body>
</html>
