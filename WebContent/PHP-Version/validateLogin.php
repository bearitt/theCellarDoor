<?php
    session_start();
    $authenticatedUser = validateLogin();

    if ($authenticatedUser != null)
        header('Location: index.php');      		// Successful login
    else
        header('Location: login.php');	             // Failed login - redirect back to login page with a message

	function validateLogin()
	{
	  $user = $_POST["username"];
	  $pw = $_POST["password"];
		$retStr = null;

		if ($user == null || $pw == null)
			return null;
		if ((strlen($user) == 0) || (strlen($pw) == 0))
			return null;

		include 'include/db_credentials.php';

		try {
		$sql = "SELECT * FROM customer WHERE userid = ? AND password = ?";
		$retStr = null;
    $fullName = null;
    //get connection
    $pdo = new PDO($dsn,$username,$password,$options);
		$stmt = $pdo->prepare($sql);
		$stmt->execute([$user, $pw]);
    //result set if any results returned from query
    while($row = $stmt->fetch()) {
      $retStr = $row['userid'];
      $fullName = $row['firstName'] . ' ' . $row['lastName'];
      if($row['admin']==1)
        $_SESSION['admin'] = true;
    }

		if ($retStr != null){
      $_SESSION["loginMessage"] = null;
     	$_SESSION["authenticatedUser"] = $user;
      $_SESSION["fullname"] = $fullName;
		}
		else
		  $_SESSION["loginMessage"] = "Could not connect to the system using that username/password.";
    } catch(\PDOException $e) {
      $_SESSION["loginMessage"] = "There was an issue connecting to the database, try again.";
  	}
		return $retStr;
	}
?>
