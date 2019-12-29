<!DOCTYPE html>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>The Cellar - Order List</title>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/custom.css">
</head>
<body>
<?php include 'header.php';?>
<div class="container" style="background-color: #403F3D; text-align:center;">
  <div class="col-sm-12 p-5">
  <h1>Order List</h1>
  <p>List of all past and present orders</p>
  <br>

<?php
include 'adminAuth.php';
include 'include/db_credentials.php';
try {
  $sql = <<<EOL
  SELECT O.orderId AS orderId, orderDate, C.customerId AS customerId,
   CONCAT(firstName, ' ', lastName) AS name, totalAmount, P.productId AS productId, quantity, price
   FROM ordersummary O JOIN customer C
   ON O.customerId = C.customerId
   JOIN orderproduct P ON O.orderId = P.orderId
  EOL;
  $pdo = new PDO($dsn, $username, $password, $options);
  $stmt = $pdo->query($sql);
  $last=null;
  $j=0;

  echo "<table class=\"table table-hover table-borderless table-responsive-md\"><thead><tr>";
  echo "<th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th>";
  echo "<th>Total Amount</th></tr></thead>";

  while($row = $stmt->fetch()) {
    $current = $row['orderId'];
    if($last!=null) {
      //nested table closed for new order id
      if($last!=$current)
        echo '</table></div></td></tr>';
    }
    if($last==null||$last!=$current) {
      $last=$current;
      //new row for next order
      echo <<<EOL
      <tr><td>$row[orderId]</td><td>$row[orderDate]</td><td>$row[customerId]</td>
      <td>$row[name]</td><td>$row[totalAmount]</td></tr>
      <tr align="right"><td colspan="5"><button data-toggle="collapse" data-target="prodList$j"
       type="button" class="btn btn-secondary">Click for list of products</button>
      <div id="prodList$j" class="collapse">
      <table class="table-hover">
        <thead><th>Product Id</th><th>Quantity</th><th>Price</th></tr></thead>
      EOL;
    }
    echo <<<EOL
    <tr><td>$row[productId]</td><td>$row[quantity]</td><td>$$row[price]</td></tr>'
    EOL;
  }
  echo '</table>';
} catch(\PDOException $e) {
  echo 'Database connection error';
}
?>
</div></div>
</body>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</html>
