<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>The Cellar Door - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/custom.css">
</head>
<body>

<?php
  include 'include/db_credentials.php';
  //add review to db from user form
  $userId = null;
  $reviewMessage = "<h2>We'd love to know what you think of our product!</h2>";
  $date = date("Y-m-d H:i:s");
  $rating = isset($_GET["stars"]) ? $_GET["stars"] : null;
  $productId = isset($_GET["productId"]) ? $_GET["productId"] : null;
  $review = isset($_GET["review"]) ? $_GET["review"] : null;
  $userId = isset($_GET["userId"]) ? $_GET["userId"] : null;
  $customerId = null;
  //get customerId from userId
  try {
    $pdo = new PDO($dsn, $username, $password, $options);
    $sql = "SELECT customerId FROM customer WHERE userId = ?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$userId)];
    while($row = $stmt->fetch())
      $customerId = $row['customerId'];
  } catch(\PDOException $e) {
	  echo 'Something went wrong';
	}
  if($rating!=null && $customerId!=null) {
    try {
      $pdo = new PDO($dsn, $username, $password, $options);
      $sql = <<< EOL
      INSERT INTO review(reviewRating, reviewDate, customerId, productId, reviewComment)
      VALUES(?,?,?,?,?)
      EOL;
      $stmt = $pdo->prepare($sql);
      $stmt->execute([$rating, $date, $customerId, $productId, $review]);
      $reviewMessage = "<h2>Your review has been submitted!</h2>";
    } catch(\PDOException $e) {
      echo 'Error inserting review into db';
    }
  }
  include 'header.php';
?>
<div class="container"
  style="background-color: #403F3D; text-align: center;">
  <div class="row">
    <div class="col-lg-4 col-sm-12 p-5">
<?php
// Get product name to search for
try {
  $pdo = new PDO($dsn, $username, $password, $options);
  $sql = <<<EOL
  SELECT productName, productPrice, productDesc, productImage, productImageURL
  FROM product WHERE productId = ?
  EOL;
  $stmt = $pdo->prepare($sql);
  $stmt->execute([$productId]);
  if($row = $stmt->fetch()) {
    if($row['productImage']!=null && $row['productImage']!="")
      echo "<img src=\"displayImage.jsp?id=$productId\" height=\"533\" width=\"300\">";
    if($row['productImageURL']!=null && $row['productImageURL']!="")
      echo "<img src=\"$row['[productImageURL]']\">";
    echo <<< EOL
    <br><a href=\"addcart.jsp?id=$productId&name=$row[productName]
    &price=$row[productPrice]"><h2><i class="fas fa-cart-plus"></i>Add to Cart</h2></a></td>
    EOL;
?>
<h2>
  <a href="listprod.php">Continue shopping</a>
</h2>
</div>
<div class="col-lg-4 col-sm-12 p-5">
<table>
  <thead>
    <tr><th><?php echo $row['productName'];?></th></tr>
  </thead>
  <tbody>
    <tr><td><strong>Id: </strong></td><td><?php echo $productId;?></td></tr>
    <tr><td><strong>Price: </strong></td>
      <td>$<?php echo $row['productPrice'];?></td></tr>
    <tr><td colspan="2"><?php echo $row['productDesc'];?></td></tr>
  </tbody></table>
<br>
<?php echo $reviewMessage;?>
<form action="product.php?id=<?php echo $productId;?>" method="post">
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
<?php //query db for reviews
  $sql = <<<EOL
  SELECT reviewRating, reviewDate, reviewComment, userId
  FROM  review R JOIN customer C
  ON R.customerId = C.customerId
  WHERE productId = ?
  EOL;
  $stmt = $pdo->prepare($sql);
  $stmt->execute([$productId]);
?>
<table class="table table-hover table-responsive-md">


					<?php while($row = $stmt->fetch()) {?>
					<tr>
						<td><i class="fas fa-user"></i><?php echo $row['userId'];?></td>
					</tr>
					<tr>
						<td><?php echo $row['reviewRating'];?> stars</td>
					</tr>
					<tr>
						<td><?php echo $row['reviewDate'];?></td>
					</tr>
					<tr>
						<td><?php echo $row['reviewComment'];?></td>
					</tr>
        <?php }?>
					</table>
			</div>

			<?php
      } else {
        echo "<h1>No product found!";
      }
    } catch(\PDOException $e) {
      echo "<h1>No product found!</h1>";
    }
      ?>
			<br>
		</div>
	</div>
	<script src="js/jquery-3.4.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>
</html>
