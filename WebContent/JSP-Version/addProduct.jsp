<!DOCTYPE html>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.io.*"%>
<%@ include file="jdbc.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>The Cellar Door - Add Product</title>
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
			<h1>Add New Product</h1>
				<%
					try {
						getConnection();
				%>
				<form action="addProduct.jsp" method="post">
					<div class="form-group">
						<input type="text" name="prodName" id="prodName"
							placeholder="Product Name:" class="form-control" required>
					</div>
					<div class="form-group input-group mb-3">
						<span class="input-group-text">$</span> <input type="text"
							name="prodPrice" id="prodPrice" placeholder="Product Price:"
							class="form-control"required>
					</div>
					<div class="form-group">
						<textarea name="prodDesc" id="prodDesc" rows="10" cols="30"
							placeholder="Product Description:" class="form-control" required></textarea>
					</div>
					<div class="form-group">
						<input type="text" name="catId" id="catId"
							placeholder="Category:" class="form-control" required><br>
					</div>
					<div class="custom-file">
						<input type="file" name="prodImg" class="custom-file-input"
							id="prodImg"> <label class="custom-file-label"
							for="prodImg">Upload Product Image</label>
					</div>
					<br> <br>
					<button type="submit" class="btn btn-secondary btn-sm btn-block">Submit</button>
				</form>
				<%
					if (request.getParameter("prodName") != null && !request.getParameter("prodName").equals("")) {
							String sql = "INSERT INTO product (productName, productPrice, productDesc, categoryId, productImage) "
									+ "VALUES (?,?,?,?,?)";
							PreparedStatement pstmt = con.prepareStatement(sql);
							String prodName = (String) request.getParameter("prodName");
							double prodPrice = Double.parseDouble(request.getParameter("prodPrice"));
							String prodDesc = (String) request.getParameter("prodDesc");
							int catId = Integer.parseInt(request.getParameter("catId"));

							if(request.getParameter("prodImg")!=null&&!request.getParameter("prodImg").equals("")) {
								File prodImg = new File(request.getParameter("prodImg"));
								FileInputStream input = new FileInputStream(prodImg);
								pstmt.setBinaryStream(5, input);
								input.close();
							}
							pstmt.setString(1, prodName);
							pstmt.setDouble(2, prodPrice);
							pstmt.setString(3, prodDesc);
							pstmt.setInt(4, catId);
							pstmt.executeUpdate();
							out.print("Product added!");
							
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
</body>
</html>

