<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>The Cellar - Checkout</title>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/custom.css">
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
	<div class="container" style="background-color: #403F3D">
		<div class="col-sm-12 p-5">
			<h1>Enter your customer id to complete the transaction:</h1>
			<br>
			<div class="col-sm-9">
				<form method="get" action="order.jsp" class="form-inline">
					<div class="form-group">
						<div class="col-xs-12 col-md-4">
							<input type="text" class="form-control" id="helpProduct"
								placeholder="Enter customer id" name="customerId">
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
		</div>
	</div>
	<script src="js/jquery-3.4.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
