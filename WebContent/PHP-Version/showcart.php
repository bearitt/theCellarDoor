<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>The Cellar Door - Your Shopping Cart</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/custom.css">
<style>
.btn-group {
	vertical-align: middle;
}
</style>
</head>
<body>
	<script>
		function update(newid, newqty) {
			window.location = "showcart.php?update=" + newid + "&newqty="
					+ newqty;
		}
	</script>
<?php	include 'header.php';?>
	<div class="container"
	style="background-color: #403F3D; text-align: center;">
		<div class="col-sm-12 p-5">
<?php
// Get the current list of products
$productList = null;

if (isset($_SESSION['productList'])){
	$productList = $_SESSION['productList'];
	//check for products to delete from list
	$delete = (isset($_GET['delete']) ? $_GET['delete'] : null);
	if($delete != null && $delete != -1)
		unset($productList[$delete]);
	//check for clear cart condition
	if($delete!=null && $delete == -1) {
		$productList = null;
		$_SESSION['productList'] = $productList;
		goto end;
	}
	//------item quantity update------//
	//check for new quantity on item
	$newqty = (isset($_GET['newqty']) ? $_GET['newqty'] : null);
	//check for which item to update
	$update = (isset($_GET['update']) ? $_GET['update'] : null);
	//update item quantity to user input
	if($update!=null) {
		$productList[$update]['quantity'] = $newqty;
	}

	//remove an item if its new quantity is 0
	if($update!=null && $newqty==0) {
		unset($productList[$update]);
	}

	//check if product list is empty and set to null if true
	if (count($productList)==0){
		$_SESSION['productList'] = null;
		//don't know if goto will work!!!
		goto end;
	}

	$_SESSION['productList'] = $productList;
	?>
	<!--Create table-->
	<h1>Your Shopping Cart</h1>
	<table class="table table-borderless table-hover table-responsive-md" style="color:#F2E8DF">
		<thead><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>
		<th>&nbsp;</th><th>Price</th><th>Subtotal</th><th>&nbsp;</th></tr>
	</thead><tbody>
		<form method="get" class="form-inline" action="showcart.php" name="form1">

	<?php $total = 0;
	$count=0;
	foreach ($productList as $id => $prod) {

		echo("<tr><td>". $prod['id'] . "</td>");
		echo("<td>" . $prod['name'] . "</td>");
		//form to change quantity
		echo("<td><input type=\"text\" name=\"newqty" . ++$count . "\" size=\"3\" value=\"");
		echo($prod['quantity'] . "\" class=\"form-control\"></td>");
		//button for update quantity
		echo("<td><input type=\"button\" onclick=\"update(" . $prod['id']);
		echo(", document.form1.newqty" . $count . ".value)\" value=\"Update Quantity\"");
		echo(" class=\"btn btn-secondary\">");
		//price and subtotal
		$price = $prod['price'];
		echo("<td align=\"right\">$" . number_format($price ,2) ."</td>");
		echo("<td align=\"right\">$" . number_format($prod['quantity']*$price, 2) . "</td>");

		//remove from cart
		echo("<td><a class=\"btn btn-secondary\" role=\"button\" href=\"showcart.php?delete=");
		echo($prod['id'] . "\">Remove from cart</a></td></tr>");


		$total = $total +$prod['quantity']*$price;
	}
	echo("<tr><td colspan=\"5\" align=\"right\"><b>Order Total</b></td><td align=\"right\">$" . number_format($total,2) ."</td><td></td></tr>");
	echo("</form></tbody></table>");
} else{
	end:
	echo("<H1>Your shopping cart is empty!</H1>");
}
?>
</div>
<div class="col-sm-12 p-5">
	<div class="btn-group btn-group-lg">
		<a href="showcart.php?delete=-1" class="btn btn-secondary"
			role="button">Clear Cart</a> <a href="order.php"
			class="btn btn-secondary" role="button">Check Out</a> <a
			href="listprod.php" class="btn btn-secondary" role="button">Continue
			Shopping</a>
	</div>
</div>
</div>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>
</html>
