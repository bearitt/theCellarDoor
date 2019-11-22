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
<%@ include file="header.jsp"%>
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
