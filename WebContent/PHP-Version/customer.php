<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>The Cellar Door - Your Information</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/custom.css">
</head>
<body>
  <?php
  include 'auth.php';
  include 'header.php';
  include 'include/db_credentials.php';
   ?>
  <div class="container" style="background-color: #403F3D;">
  		<div class="row">
  			<div class="col-sm-9 p-5">
<?php
    $user = $_SESSION['authenticatedUser'];
    try {
      $pdo = new PDO($dsn, $username, $password, $options);
      $sql = 'SELECT * FROM customer WHERE userid = ?';
      $stmt = $pdo->prepare($sql);
      $stmt->execute([$user]);
      if($row = $stmt->fetch()) {
        ?>
        <table class="table table-hover table-borderless table-responsive-md"><tbody>
        <?php
        $fields=array("Id", "First Name", "Last Name", "Email", "Phone", "Address",
         "City", "State", "Postal Code", "Country", "User Id" );
        $colNames=array('customerId','firstName','lastName','email','phonenum','address',
      'city','state','postalCode','country','userid');
        for($i=0;$i<11;++$i) {
          echo "<tr><td><strong>" . $fields[$i] . "</strong></td>";
          $temp = $row[$colNames[$i]]==null || $row[$colNames[$i]]=="" ? "NA" : $row[$colNames[$i]];
          echo "<td>" . $temp . "</td></tr>";
        }
        echo "</tbody></table>";
        ?>
        <!--TODO: create page to edit profile -->
        <a href="#" class="btn btn-secondary" role="button">Edit your profile</a>
				<a href="customerOrders.php" class="btn btn-secondary" role="button">
          Click here to view past orders</a>
        <?php
      } else {
        echo '<h1>No customer information found!</h1>';
      }
    }catch(\PDOException $e) {
      echo "Database access error.";
    }
?>
    </div>
  </div>
</div>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>
</html>
