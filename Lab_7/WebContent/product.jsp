<%@ page import="java.util.HashMap"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.ArrayList"%>
<%@ include file="jdbc.jsp"%>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>The Cellar Door - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/custom.css">
</head>
<body>
	<%
		String userId = "";
		String reviewMessage = "<h2>We'd like to know what you think of our product!</h2>";
		Date date = new Date(System.currentTimeMillis());
		int Rating = -1;
		String id = (String) request.getParameter("id");
		String Review = request.getParameter("Review");
		int CustomerId = -1;
		String CustomerID = (String)request.getParameter("CustomerId");
		try{
			getConnection();
			//look up customerId from userId
			String sqluser = "SELECT customerId FROM customer WHERE userId = ?";
			PreparedStatement psuser = con.prepareStatement(sqluser);
			psuser.setString(1,CustomerID);
			ResultSet rsuser = psuser.executeQuery();
			while(rsuser.next()) {
				CustomerId = rsuser.getInt(1);
			}
		} catch(SQLException e) {}
		finally{closeConnection();}

		try {
			Rating = Integer.parseInt((String) request.getParameter("stars"));
		} catch (NumberFormatException e) {
		}
		if (Rating != -1 && CustomerId != -1) {
			try {
				getConnection();
				//insert review into db
				String sql = "insert into review(reviewRating, reviewDate, customerId, productId, reviewComment) Values(?,?,?,?,?)";
				PreparedStatement pstmt1 = con.prepareStatement(sql);
				pstmt1.setInt(1, Rating);
				pstmt1.setDate(2, date);
				pstmt1.setInt(3, CustomerId);
				pstmt1.setString(4, id);
				pstmt1.setString(5, Review);
				pstmt1.executeUpdate();
				reviewMessage = "<h2>Your review has been submitted!</h2>";
			} catch(SQLException e){} finally{
				closeConnection();
			}
		}
	%>

	<%@ include file="header.jsp"%>
	<div class="container"
		style="background-color: #403F3D; text-align: center;">
		<div class="row">
			<div class="col-lg-4 col-sm-12 p-5">

				<%
					Blob image = null;
					try {
						getConnection();

						// Get product name to search for
						String productId = (String) request.getParameter("id");
						String sql = "select productName, productId, productPrice, productDesc,"
								+ "productImage, productImageURL from product where productId = ?";
						PreparedStatement pstmt = con.prepareStatement(sql);
						pstmt.setString(1, productId);
						ResultSet rs = pstmt.executeQuery();
						if (rs.next()) {
							if (rs.getString(4) != null && !rs.getString(4).equals(""))
								out.print("<img src=\"displayImage.jsp?id=" + productId + "\" height=\"533\" width=\"300\">");
							if (rs.getString(6) != null && !rs.getString(6).equals("") && !rs.getString(6).equals("null"))
								out.print("<img src=\"" + rs.getString(6) + "\">");
							NumberFormat currFormat = NumberFormat.getCurrencyInstance();
				%>

				<%
					out.print("<br><a href=\"addcart.jsp?id=" + rs.getString(2) + "&name=" + rs.getString(1) + "&price="
									+ rs.getString(3) + "\"><h2><i class=\"fas fa-cart-plus\"></i>Add to Cart</h2></a></td>");
				%>
				<h2>
					<a href="listprod.jsp">Continue shopping</a>
				</h2>
			</div>
			<div class="col-lg-4 col-sm-12 p-5">
				<table>
					<thead>
						<tr>
							<th>
								<%
									out.print(rs.getString(1));
								%>
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><strong>Id: </strong></td>
							<td>
								<%
									out.print(rs.getString(2));
								%>
							</td>
						</tr>
						<tr>
							<td><strong>Price: </strong></td>
							<td>
								<%
									out.print(currFormat.format(rs.getDouble(3)));
								%>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<%
									out.print(rs.getString(4));
								%>
							</td>
						</tr>
					</tbody>
				</table>
				<br>
				<%out.print(reviewMessage); %>
				<form
					action="product.jsp?id=
	<%out.print((String) request.getParameter("id"));%>
	"
					method="post">
					<div class="form-group">
						<input type="text" name="CustomerId" placeholder="User ID"
							class="form-control" required>
					</div>
					<div class="form-group">
						<textarea name="Review" rows="10" cols="30" maxlength="1000"
							placeholder="Your review here (maximum 1000 characters)"
							class="form-control" required></textarea>
					</div>
					<div class="form-group">
						<label for="reviewStars">Your rating</label> <select
							class="form-control" id="reviewStars" name="stars">
							<option value="5">5 stars, incredible!</option>
							<option value="4">4 stars, pretty good!</option>
							<option value="3">3 stars, it was ok</option>
							<option value="2">2 stars, not so great</option>
							<option value="1">1 star, this product was garbage</option>
						</select>
					</div>
					<button type="submit" class="btn btn-secondary btn-sm btn-block">
						Submit your review</button>
				</form>
				<%
					
					String sqlReview = "SELECT reviewRating, reviewDate, reviewComment, userId"
									+ " FROM review R JOIN customer C ON R.customerId = C.customerId WHERE productId = ?";
					PreparedStatement psrev = con.prepareStatement(sqlReview);
					psrev.setString(1, id);
					ResultSet rsrev = psrev.executeQuery();
					%>
					<table class="table table-hover table-responsive-md">
					
					
					<%
					while(rsrev.next()) {
						%>
					<tr>
						<td>
						<i class="fas fa-user"></i><%out.print(" " + rsrev.getString(4));%>
						</td>
					</tr>	
					<tr>
						<td><%out.print(rsrev.getInt(1) + " stars"); %></td>
					</tr>
					<tr> 
						<td><%out.print(rsrev.getString(2)); %></td>
					</tr>
					<tr>
						<td><%out.print(rsrev.getString(3)); %></td>
					</tr>
						<%
					}
					%>
					</table>
					<%
				
				%>
			</div>

			<%
				} else {
						out.print("<h1>No product found!</h1>");
					}

				} catch (SQLException e) {

				} finally {
					closeConnection();
				}
			%>
			<br>
		</div>
	</div>
	<script src="js/jquery-3.4.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
