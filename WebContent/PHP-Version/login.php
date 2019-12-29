<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>The Cellar - Login</title>
	<link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="css/custom.css">
</head>
<body>
  <?php include 'header.php';?>
  <div class="container" style="background-color: #403F3D; text-align:center;">
  	<div class="col-sm-12 p-5">
  <div style="margin:0 auto;text-align:center;display:inline">

  <h3>Please Login to System</h3>

<?php
    if ($_SESSION['loginMessage']  != null)
        echo ("<p>" . $_SESSION['loginMessage'] . "</p>");
?>

<br>
<form name="MyForm" method=post action="validateLogin.php" class="form-inline">
	<label for="username" class="mr-sm-2">Username:</label>
	<input type="text" name="username" class="form-control mb-2 mr-sm-2" id="username">
	<label for="pwd" class="mr-sm-2">Password:</label>
	<input type="password" name="password" class="form-control mb-2 mr-sm-2" id="pwd">
	<button type="submit" class="btn btn-secondary mb-2">Submit</button>
</form>

</div></div></div>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>
</body>
</html>
