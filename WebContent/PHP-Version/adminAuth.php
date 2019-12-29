<?php
  $authorized = isset($_SESSION['admin']) ? $_SESSION['admin'] : null;
  if($authorized==null) {
    $_SESSION['loginMessage'] = 'This account does not have admin privileges, try logging in with an admin account.';
    header('Location: login.php');
  }
?>
