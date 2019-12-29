<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>The Cellar Door - Products</title>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/custom.css">
</head>
<body>
<?php include 'header.php';?>
<div class="container" style="background-color: #403F3D;">
	<div class="row">
		<div class="col-sm-9 p-5">
			<form method="get" action="listprod.php" class="form-inline">
				<div class="form-group">
					<div class="col-xs-12 col-md-4">
						<label class="sr-only" for="helpProduct">Search for the
							products you want to buy</label> <input type="text" class="form-control"
							id="helpProduct" placeholder="Enter product name"
							name="productName">
					</div>
				</div>
				<div class="col-xs-12 col-md-8">
					<div class="btn-group">
						<button type="submit" class="btn btn-secondary">Submit</button>
						<button type="reset" class="btn btn-dark">Reset</button>
					</div>
				</div>
			</form>
		<br>

<?php
	//Get product name to search for
	//get product name if search is used
	$name = "";
	$hasParameter = false;
	if (isset($_GET["productName"])){
		$name = $_GET["productName"];
	}
	$sql = "";
	//return all rows if no search criteria, search db if get returns result
	if ($name === "") {
		echo("<h2>All Products</h2>");
		$sql = 'SELECT productName,categoryName,productPrice,productId '
					. 'FROM product P JOIN category C ON C.categoryId=P.categoryId '
					. 'ORDER BY C.categoryId ASC';
	} else {
		echo("<h2>Products containing '" . $name . "'</h2>");
		$hasParameter = true;
		$sql = 'SELECT productName,categoryName,productPrice,productId '
					. 'FROM product P JOIN category C ON C.categoryId=P.categoryId '
					. 'WHERE productName LIKE ? ORDER BY C.categoryId ASC';
		$name = "%" . $name . "%";
	}
	//db connection
	include 'include/db_credentials.php';
	try {
	  $pdo = new PDO($dsn,$username,$password,$options);
		if($hasParameter){
			$stmt = $pdo->prepare($sql);
			$stmt->execute([$name]);
		} else {
			$stmt = $pdo->query($sql);
		}
		//table header
		echo("<table class=\"table table-hover table-responsive-md table-borderless\"><thead><tr>");
		echo "<th> </th><th>Product Name</th><th>Category</th><th>Price</th></tr></thead>";
		//code for row colours by category
		$i = 0;
		$counter = 0;
		$rowColours = array("#736E6C", "#403F3D", "#262524");
		$last = null;
		while ($row = $stmt->fetch()) {
			//check for new category
			if($last===null || $last != $row['categoryName']) {
				++$i;
				$last = $row['categoryName'];
			}
			$counter = $i % 3;
			//line style
			echo("<tr style=\"background-color:" . $rowColours[$counter]."\">");
			//add to cart link
			echo("<td><a href=\"addcart.php?id=" . $row['productId'] . "&name=" . $row['productName']);
			echo("&price=" . $row['productPrice'] . "\">Add to Cart</a></td>");
			//product link
			echo("<td><a href=\"product.php?id=" .$row['productId'] . "\">". $row['productName'] . "</td>");
			echo("<td>" . $row['categoryName'] . "</td><td>$" . $row['productPrice'] . "</td></tr>");
		}
		echo("</table>");
	} catch(\PDOException $e) {
	  echo 'Something went wrong';
	}

?>
</div></div></div>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>
</html>
