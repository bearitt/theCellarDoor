<!DOCTYPE html>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.io.*"%>
<%@ include file="jdbc.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>The Cellar Door - Update Product</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/custom.css">
</head>
<body>
	<%@ include file="auth.jsp"%>
	<%@ include file="adminAuth.jsp"%>
	<%@ include file="header.jsp"%>
	<div class="container" style="background-color: #403F3D;">
		<div class="row">
			<div class="col-sm-6 p-5">
				<%
					try {
						getConnection();
				%>
				<form action="updateProduct.jsp" method="post">
					<div class="form-group">
						<input type="text" name="prodId" id="prodId" 
						placeholder="ID of product to update:" class="form-control">
					</div>
					<div class="form-group">
						<input type="text" name="prodName" id="prodName"
						placeholder="New Product Name:" class="form-control">
					</div>
					<div class="form-group input-group mb-3">
						<span class="input-group-text">$</span>
						<input type="text" name="prodPrice" id="prodPrice" 
						placeholder="New Product Price:" class="form-control">
					</div>
					<div class="form-group">
						<textarea name="prodDesc" id="prodDesc" rows="10" cols="30"
						placeholder="Enter New Product Description:" class="form-control"></textarea>
					</div>
					<div class="form-group">
						<input type="text" name="catId" id="catId"
						placeholder="Change Category:" class="form-control"><br>
					</div>
					<div class="custom-file">
						<input type="file" name="prodImg"
							class="custom-file-input" id="prodImg">
						<label class="custom-file-label" 
						for="prodImg">Upload new Product Image</label>
					</div>
					<br>
					<br>
					<button type="submit" class="btn btn-secondary btn-sm btn-block">Submit</button>
				</form>
				<%
					if (request.getParameter("prodId") != null && !request.getParameter("prodId").equals("")) {
							try {

								int prodId = Integer.parseInt(request.getParameter("prodId"));

								if (request.getParameter("prodName") != null && !request.getParameter("prodName").equals("")) {
									String prodName = (String) request.getParameter("prodName");
									String sqlName = "UPDATE product SET productName=? WHERE productId=?;";
									PreparedStatement pstmtName = con.prepareStatement(sqlName);
									pstmtName.setString(1, prodName);
									pstmtName.setInt(2, prodId);
									pstmtName.executeUpdate();
									out.print("<h2>Product Name updated!</h2>");
								}

								if (request.getParameter("prodPrice") != null
										&& !request.getParameter("prodPrice").equals("")) {
									double prodPrice = Double.parseDouble(request.getParameter("prodPrice"));
									String sqlPrice = "UPDATE product SET productPrice=? WHERE productId=?;";
									PreparedStatement pstmtPrice = con.prepareStatement(sqlPrice);
									pstmtPrice.setDouble(1, prodPrice);
									pstmtPrice.setInt(2, prodId);
									pstmtPrice.executeUpdate();
									out.print("<h2>Product Price updated!</h2>");
								}

								if (request.getParameter("prodDesc") != null && !request.getParameter("prodDesc").equals("")) {
									String prodDesc = (String) request.getParameter("prodDesc");
									String sqlDesc = "UPDATE product SET productDesc=? WHERE productId=?;";
									PreparedStatement pstmtDesc = con.prepareStatement(sqlDesc);
									pstmtDesc.setString(1, prodDesc);
									pstmtDesc.setInt(2, prodId);
									pstmtDesc.executeUpdate();
									out.print("<h2>Product Description updated!</h2>");
								}

								if (request.getParameter("catId") != null && !request.getParameter("catId").equals("")) {
									int catId = Integer.parseInt(request.getParameter("catId"));
									String sqlCat = "UPDATE product SET categoryId=? WHERE productId=?;";
									PreparedStatement pstmtCat = con.prepareStatement(sqlCat);
									pstmtCat.setInt(1, catId);
									pstmtCat.setInt(2, prodId);
									pstmtCat.executeUpdate();
									out.print("<h2>Category Id updated!</h2>");
								}

								if (request.getParameter("prodImg") != null && !request.getParameter("prodImg").equals("")) {
									File prodImg = new File(request.getParameter("prodImg"));
									FileInputStream input = new FileInputStream(prodImg);
									String sqlCat = "UPDATE product SET productImage=? WHERE productId=?;";
									PreparedStatement pstmtCat = con.prepareStatement(sqlCat);
									pstmtCat.setBinaryStream(1, input);
									pstmtCat.setInt(2, prodId);
									pstmtCat.executeUpdate();
									out.print("<h2>Category Id updated!</h2>");
								}

								/*
								File prodImg = new File(request.getParameter("prodImg"));
								FileInputStream input = new FileInputStream(prodImg);
								
								*/
							} catch (NumberFormatException e) {
								out.print("<h2>Invalid value entered");
							}
						} else {
							if (request.getParameter("prodId") != null)
								out.print("<h2>No product Id entered!</h2>");
						}
					} catch (SQLException e) {
						System.err.println(e);
					} finally {
						closeConnection();
					}
				%>
			</div>
		</div>
	</div>
	<script src="js/jquery-3.4.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script>
		// Script to allow file upload to show selected file
		$(".custom-file-input").on(
				"change",
				function() {
					var fileName = $(this).val().split("\\").pop();
					$(this).siblings(".custom-file-label").addClass("selected")
							.html(fileName);
				});
	</script>
</body>
</html>