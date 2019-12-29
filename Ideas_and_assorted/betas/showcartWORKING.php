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
	
	<div class="container"
	style="background-color: #403F3D; text-align: center;">
		<div class="col-sm-12 p-5">
<?php
// Get the current list of products
session_start();
$productList = null;
if (isset($_SESSION['productList'])){
	$productList = $_SESSION['productList'];
	echo("<h1>Your Shopping Cart</h1>");
	echo("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
	echo("<th>Price</th><th>Subtotal</th></tr>");

	$total =0;
	foreach ($productList as $id => $prod) {
		echo("<tr><td>". $prod['id'] . "</td>");
		echo("<td>" . $prod['name'] . "</td>");

		echo("<td align=\"center\">". $prod['quantity'] . "</td>");
		$price = $prod['price'];

		echo("<td align=\"right\">$" . number_format($price ,2) ."</td>");
		echo("<td align=\"right\">$" . number_format($prod['quantity']*$price, 2) . "</td></tr>");
		echo("</tr>");
		$total = $total +$prod['quantity']*$price;
	}
	echo("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td><td align=\"right\">$" . number_format($total,2) ."</td></tr>");
	echo("</table>");

	echo("<h2><a href=\"checkout.php\">Check Out</a></h2>");
} else{
	echo("<H1>Your shopping cart is empty!</H1>");
}
?>
<h2><a href="listprod.php">Continue Shopping</a></h2>
</div></div>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>
</html>
