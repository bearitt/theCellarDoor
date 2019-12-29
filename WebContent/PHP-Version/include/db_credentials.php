<?php
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
?>
