<?php
//this works!!! use this syntax for listprod
session_start();
$servername = "sql208.epizy.com";
$username = "epiz_24952170";
$password = "ffmNfnVf3cTJ";
$dbname = "epiz_24952170_cellarDoor";

$dsn = "mysql:host=$servername;dbname=$dbname;charset=utf8mb4";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];

try {
  $pdo = new PDO($dsn,$username,$password,$options);
  echo "Connected succesfully";
  $name = 'pinot';
  $sql = "SELECT productId, productName, productPrice FROM product WHERE productName LIKE ?";
  $name = "%".$name."%";
  $stmt = $pdo->prepare($sql);
  $stmt->execute([$name]);
  //$stmt->execute(["Barret"]);
  // while($row = $stmt->fetch()) {
  //   echo '<br>id: '.$row['customerId'].' name: '.$row['firstName'].' '.$row['lastName'];
  // }
  while($row = $stmt->fetch())
    echo '<br>id: '.$row['productId'].' name: '.$row['productName'].' price: $'.$row['productPrice'];
} catch(\PDOException $e) {
  throw new \PDOException($e->getMessage(),(int)$e->getCode());
}
if (isset($_SESSION['productList'])){
	$productList = $_SESSION['productList'];
  echo("<br>");
  var_dump($productList);
  unset($productList[1]);
  echo("<br>");
  echo("<br>");
  var_dump($productList);
}
echo("<br>");
echo("<br>");
$delete = (isset($_GET['delete']) ? $_GET['delete'] : null);
echo($delete);
$someArray = array("John"=>"Malkovich");
echo <<< EOL
Beginning of heredoc test <br>
$someArray[John] <br>
End of heredoc test
EOL;
echo '<br>Begin test of curly bracket thing:';
$test = 5;
if($test < 2) {?>
<br>Ya did it!

<?php
}
echo '<br>End test of curly bracket thing';
echo '<br>Beginning of array declaration test:';
$fields=array( "", "Id", "First Name", "Last Name", "Email", "Phone", "Address",
 "City", "State", "Postal Code", "Country", "User Id" );

for($i=1;$i<12;++$i) {
  echo "<br>" . $fields[$i] ;
}
?>
