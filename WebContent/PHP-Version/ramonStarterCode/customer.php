<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>

<?php 
    include 'auth.php';
    include 'header.php';
    include 'include/db_credentials.php';
?>

<?php
$user = $_SESSION['authenticatedUser'];
    
// TODO: Print Customer information

// Make sure to close connection
?>
</body>
</html>